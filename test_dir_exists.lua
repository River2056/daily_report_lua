local utils = require("utils")

local external_isdir, _ = utils.isdir("external")

-- create external directory
if not external_isdir then
	os.execute("mkdir external")
end

local is_lib_exists, _ = utils.isdir("external/lua-yaml")
print("is_lib_exists: ", is_lib_exists)

if not is_lib_exists then
	os.execute("git submodule add https://github.com/exosite/lua-yaml external/lua-yaml")
end
