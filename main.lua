local yaml = require("external.lua-yaml.yaml")

local file = io.open("report.yaml")
local contents = file:read("*a")

local yaml_obj = yaml.eval(contents)

local s = yaml_obj["date"] .. " Daily Report\n\n"
for i = 1, #yaml_obj["work"] do
    local item = yaml_obj["work"][i]

    s = s .. "# " .. item["title"] .. "\n"

    if type(item["progress"]) ~= "table" and item["progress"] >= 0 then
        s = s .. "Progress: " .. item["progress"] .. "%\n"
    end

    s = s .. "Time Tracking: " .. item["time"] .. "H\n"

    if item["details"] ~= "none" then
        s = s .. "Details:\n"
        for j = 1, #item["details"] do
            local detail = item["details"][j]
            s = s .. "  * " .. detail .. "\n"
        end
    end

    s = s .. "\n"
end

print(s)

local temp_file = io.open("temp.txt", "w")
temp_file:write(s)
temp_file:close()

-- use pbcopy "XXX" [for Mac]
-- use cat ... | xclip -selection clipboard & [for linux]
os.execute('clip < "temp.txt"' )
os.remove("temp.txt")
