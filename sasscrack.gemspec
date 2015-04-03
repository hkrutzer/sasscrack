# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.authors = ['Hans Krutzer']
  s.email = ['git@pixelspaceships.com']
  s.name = 'sasscrack'
  s.version = '0.0.0'
  s.homepage = 'https://github.com/hkrutzer/sasscrack'

  s.summary = 'Rack plugin for libsass'
  s.description = <<-EOF
    Rack plugin that executes sassc on scss files, and
    serves or writes the file.
  EOF
  s.licenses = ['MIT']

  s.date = Time.now.strftime('%Y-%m-%d')

  s.files = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.add_development_dependency 'rake', ['>= 0']
  s.add_development_dependency 'rubocop', ['>= 0']
end
