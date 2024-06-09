local function list_iter(t)
    local i = 0
    local n = #t
    return function ()
        i = i + 1
        if i <= n then return t[i] end
    end
end

local t = {10, 20, 30}
iter = list_iter(t)
while true do
    local element = iter()
    if element == nil then break end
    print(element)
end

-- not for when has nil value,eg: {nil, 1, 2}
print("----")
for element in list_iter(t) do
    print(element)
end


local function allwords ()
    local line = io.read()  -- current line
    local pos = 1           -- current position in the line
    return function ()      -- iterator function
      while line do         -- repeat while there are lines
        local s, e = string.find(line, "%w+", pos)
        if s then           -- found a word?
          pos = e + 1       -- next position is after this word
          return string.sub(line, s, e)     -- return the word
        else
          line = io.read()  -- word not found; try next line
          pos = 1           -- restart from first position
        end
      end
      return nil            -- no more lines: end of traversal
    end
end

for word in allwords() do
    print(word)
end