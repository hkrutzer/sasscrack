# Rack plugin that intercepts requests to css files and calls sassc on the
# corresponding scss file if there is one.
class SasscRack
  # @param [Hash] options Configuration options
  # @option options [String] :static_path Path from where static files
  #   are served
  # @option options [Array[String]] :loadpaths Additional paths for sassc to
  #   look in
  # @option options [Boolean] :write_file Compile and write file to disk
  #   instead of capturing sassc output and serving this directly
  def initialize(app, options = {})
    detect_sassc

    @app = app

    @options = {
      static_path: "public",
      loadpaths: [],
      write_file: true,
    }.update(options)

    sass_loadpaths = (Sass.load_paths | @options[:loadpaths]).join(":")
    @sass_command = 'sassc -I "' + sass_loadpaths + '" '
  end

  def detect_sassc
    detect = system("sassc -v")
    fail "SasscRack could not find sassc." unless detect
  end

  def call(env)
    if env["PATH_INFO"].end_with? ".css"
      writepath = @options[:static_path] + env["PATH_INFO"]
      scssfile = writepath[0..-4] + "scss"

      if File.exist? scssfile
        if @options[:write_file]
          compile_write(scssfile, writepath)
        else
          compile_serve(env, scssfile)
        end
      else
        @app.call(env)
      end
    else
      @app.call(env)
    end
  end

  def compile_serve(env, filepath)
    _, headers, _ = @app.call(env)

    exec = @sass_command + filepath
    response_body = `#{exec}`

    headers["Content-Length"] = response_body.length.to_s

    [200, headers, [response_body]]
  end

  def compile_write(env, filepath, writepath)
    system(@sass_command + filepath + " " + writepath)
    @app.call(env)
  end
end
