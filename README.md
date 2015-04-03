SasscRack
=========
[![Build Status](https://travis-ci.org/hkrutzer/sasscrack.svg)](https://travis-ci.org/hkrutzer/sasscrack)

Hacky Rack plugin that runs sassc on scss files before their corresponding css
file is loaded. Libsass and sassc are required.

# Example usage
```
require "sassc_rack"

use SasscRack,
    :write_file => false,
    :static_path => "html",
    :loadpaths => ["html/stylesheets"]
```
