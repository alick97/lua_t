Set = {}
Set.mt = {} -- metatable for sets
function Set.new(t)
    local set = {}
    setmetatable(set, Set.mt)
    for _, l in ipairs(t) do set[l] = true end
    return set
end

function Set.union(a, b)
    if getmetatable(a) ~= Set.mt or
         getmetatable(b) ~= Set.mt then
        error("attempt to `add' a set with a non-set value", 2)
    end
    local res = Set.new {}
    for k in pairs(a) do res[k] = true end
    for k in pairs(b) do res[k] = true end
    return res
end

function Set.intersection(a, b)
    local res = Set.new {}
    for k in pairs(a) do
        res[k] = b[k]
    end
    return res
end

function Set.tostring(set)
    local s = "{"
    local sep = ""
    for e in pairs(set) do
        s = s .. sep .. e
        sep = ", "
    end
    return s .. "}"
end

function Set.print(s)
    print(Set.tostring(s))
end


s1 = Set.new{10, 20, 30, 50}
s2 = Set.new{30, 1}
print(getmetatable(s1))
print(getmetatable(s2))


Set.mt.__add = Set.union
Set.mt.__mul = Set.intersection

s3 = s1 + s2
Set.print(s3)  -- {1, 10, 20, 30, 50}
Set.print((s1 + s2) * s1)  -- {10, 20, 30, 50}


-- error value type
s = Set.new{1,2,3}
local status, err = pcall(function() s = s + 8 end)
if not status then
    print("error: ", err)
end