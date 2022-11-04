local utils = require("utils")

-- create external for libararies
utils.mkdirs("external")

-- libs
utils.addsubmodule("https://github.com/exosite/lua-yaml", "external/lua-yaml")
