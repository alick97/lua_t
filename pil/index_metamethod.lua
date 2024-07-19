-- create a namespace
Window = {}
-- create the prototype with default values
Window.prototype = {x=0, y=0, width=100, height=100, }
-- create a metatable
Window.mt = {}
-- declare the constructor function
function Window.new (o)
  setmetatable(o, Window.mt)
  return o
end


Window.mt.__index = function (table, key)
    return Window.prototype[key]
end

w = Window.new{x=10, y=20}
print(w.width)    --> 100



-- example 2
-- create a namespace
Window1 = {}
-- create the prototype with default values
Window1.prototype = {x=0, y=0, width=100, height=100, }
-- create a metatable
Window1.mt = {}
-- declare the constructor function
function Window1.new (o)
  setmetatable(o, Window1.mt)
  return o
end


-- which is a table. Consequently,
-- Lua repeats the access in this table, that is, it executes Window1.prototypeWindow.prototype["width"]
-- Window1.mt.__index = Window1.prototype
w1 = Window1.new{x=10, y=20}
print(w1.width)    --> 100


-- rawget not access __index
status, result = pcall(rawget, w1, "width")
print(status, result)   --> nil
status, result = pcall(rawget, w1, "x")
print(status, result)