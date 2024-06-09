-- More precisely, a construction like
-- 
--     for var_1, ..., var_n in explist do block end
-- is equivalent to the following code:
--     do
--       local _f, _s, _var = explist
--       while true do
--         local var_1, ... , var_n = _f(_s, _var)
--         _var = var_1
--         if _var == nil then break end
--         block
--       end
--     end
-- 

-- stateless iterators
local a = {"one", "two", "three"}
for i, v in ipairs(a) do
    print(i, v)
end

local function iter(a, i)
    i = i + 1
    local v = a[i]
    if v then
        return i, v
    end
end

local function my_ipairs(a)
    return iter, a, 0
end

for i, v in my_ipairs(a) do
    print(i, v)
end

local function my_pairs(t)
   return next, t, nil
end

for k, v in next, a do
   print("next: ", k, v)
end

for k, v in my_pairs(a) do
    print("pairs: ", k, v)
end

print("iterators with complex state")

local iter_f
local function allwords_1()
    local state = {line = io.read(), pos=1}
    return iter_f, state
end

local function iterator(state)
    while state.line do
        local s, e = string.find(state.line, "%w+", state.pos)
        if s then
            state.pos = e + 1
            return string.sub(state.line, s, e)
        else
            state.line = io.read()
            state.pos = 1
        end
    end
end

iter_f = iterator
-- for w in allwords_1() do
--     print("state: ", w)
-- end


print("true iterators")
local function allwords_2(f)
    for l in io.lines() do
        if l == "exit" then return end
        for w in string.gmatch(l, "%w+") do
            f(w)
        end
    end
end
-- allwords_2(print)

local count = 0
allwords_2(function (w)
    if w == "hello" then count = count + 1 end
end)
print(count)