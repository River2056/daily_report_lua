local function startswith(inputStr, start_symbol)
    return string.sub(inputStr, 1, string.len(start_symbol)) == start_symbol
end

local file = io.open("report.txt")

contents = file:read("*a")

local t = {}
for str in string.gmatch(contents, "[^\r\n]+") do
    if not startswith(str, "#") then
        table.insert(t, str)
    end
end

local now = os.date("*t")
local month = now.month >= 10 and now.month or "0" .. now.month
local day = now.day >= 10 and now.day or "0" .. now.day

local result = {}
table.insert(result, month .. "/" .. day .. " 工作事項")
table.insert(result, "\n")

for _, workdetails in ipairs(t) do
    local details = {}
    for str in string.gmatch(workdetails, "[^;]+") do
        table.insert(details, str)
    end

    for k, v in ipairs(details) do
        if k == 1 then
            table.insert(result, "# " .. v)
        elseif k == 2 then
            if v ~= "-" then
                table.insert(result, "Progress: " .. v)
            end
        elseif k == 3 then
            table.insert(result, "Time tracking: " .. v)
        else
            if v ~= "-" then
                table.insert(result, "Details: ")
                for d in string.gmatch(v, "[^,]+") do
                    d = d:gsub("^%s+", "")
                    d = d:gsub("%s+$", "")
                    table.insert(result, "  * " .. d)
                end
            end
        end
    end
    table.insert(result, "\n")
end

local result_str = ""
for _, v in ipairs(result) do
    result_str = result_str .. v .. "\n"
end

os.execute("echo " .. result_str .. " | clip.exe")
print(result_str)
