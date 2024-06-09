names = {"Peter", "Paul", "Mary"}
grades = {Mary = 10, Paul = 7, Peter = 8}
local function sortbygrade (names, grades)
	table.sort(names, function (n1, n2)
		return grades[n1] > grades[n2]    -- compare the grades
	end)
end

sortbygrade(names, grades)
for _, n in pairs(names) do
	print(n)
end

local function newCounter ()
	local i = 0
	return function ()   -- anonymous function
			 i = i + 1
			 return i
		   end
end

local c1 = newCounter()
print(c1())
print(c1())