local M = {}

function M.mkdirs(path)
	local path_exists, _ = M.isdir(path)
	if not path_exists then
		os.execute("mkdir " .. path)
	end
end

function M.exists(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			return true
		end
	end
	return ok, err
end

function M.isdir(path)
	return M.exists(path .. "/")
end

function M.addsubmodule(url, dest)
	local path_exists = M.isdir(dest)
	if not path_exists then
		os.execute("git submodule add " .. url .. " " .. dest)
	end
end

return M
