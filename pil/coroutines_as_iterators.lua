local function printResult (a)
    for i,v in ipairs(a) do
      io.write(v, " ")
    end
    io.write("\n")
end

local function permgen (a, n)
    if n == 0 then
      printResult(a)
    else
      for i=1,n do
        -- put i-th element as the last one
        a[n], a[i] = a[i], a[n]
        -- generate all permutations of the other elements
        permgen(a, n - 1)
        -- restore i-th element
        a[n], a[i] = a[i], a[n]
      end
    end
end

-- generate all permutations of the remaining element
-- permgen({1,2,3,4}, 4)
--[[
2 3 4 1 
3 2 4 1 
3 4 2 1 
4 3 2 1 
2 4 3 1 
4 2 3 1 
4 3 1 2 
3 4 1 2 
3 1 4 2 
1 3 4 2 
4 1 3 2 
...
--]]


local function permgen2(a, n)
    if n == 0 then
      coroutine.yield(a)
    else
      for i=1,n do
        -- put i-th element as the last one
        a[n], a[i] = a[i], a[n]
        -- generate all permutations of the other elements
        permgen2(a, n - 1)
        -- restore i-th element
        a[n], a[i] = a[i], a[n]
      end
    end
end


local function perm(a)
    local n = #a
    local co = coroutine.create(function () permgen2(a, n) end)
    return function ()  -- iterator
        local code, res = coroutine.resume(co)
        return res
    end
end

-- for p in perm{"a", "b", "c"} do
--     printResult(p)
-- end
--  

local function perm2(a)
    local n = #a
    return coroutine.wrap(function () permgen(a, n) end)
end


for p in perm2{"a", "b", "c"} do
    printResult(p)
end