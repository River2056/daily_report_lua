local yaml = require("external.lua-yaml.yaml")
local s = [[
date: 11/04
work:
  - title: ACM-6847
    progress: 95
    time: 4
    details:
      - refactor according to suggestions
      - discuss and confirm some questions with colleagues
  - title: extras
    progress: -1
    time: 3
    details:
      - help investigate issues regarding ACM-8502, ACM-4795
      - confirm with PM about details on on above mentioned tickets
      - confirm questions from QA regarding test cases on ACM-6847
  - title: Promotion Team meeting
    progress: -1
    time: 0.5
    details:
      discuss and clear questions
  - title: daily standup
    progress: -1
    time: 0.5
    details: none
]]

local t = yaml.eval(s)

local function print_yaml(obj)
	for k, v in pairs(obj) do
		if type(v) == "table" then
			print_yaml(v)
		end
		print(type(v), k, v)
	end
end

print_yaml(t)
