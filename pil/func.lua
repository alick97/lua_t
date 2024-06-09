-- There is a special case to this rule:
-- If the function has one single argument and this argument is either 
-- a literal string or a table constructor, then the parentheses are optional
local function show(s)
    print("show: "..s)
end
show "hello1"
show("hello2")

local function f(a, b) return a or b end
print(f(3))
print(f(nil, 4))
print(f(nil, 4, 5)) -- 5 is discarded  

local function eraseTerminal ()
  io.write("\27[2J")
end
-- writes an `*' at column `x' , row `y'
local function mark (x,y)
  -- green
  -- https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit
  io.write("\27[32m")
  io.write(string.format("\27[%d;%dH.", y, x))
  io.write("\27[0m")
end
-- Terminal size
local TermSize = {w = 80, h = 24}

-- plot a function
-- (assume that domain and image are in the range [-1,1])
local function plot (f)
  eraseTerminal()
  for i=1,TermSize.w do
     local x = (i/TermSize.w)*2 - 1
     local y = math.floor((f(x) + 1)/2 * TermSize.h)
     mark(i, y)
  end
  io.read()  -- wait before spoiling the screen
end

-- show sin
plot(function (x) return math.sin(x*2*math.pi) end)