-- function setDefault (t, d)
-- local mt = {__index = function () return d end}
-- setmetatable(t, mt)
-- end
-- 
-- tab = {x=10, y=20}
-- print(tab.x, tab.z)     --> 10   nil
-- setDefault(tab, 0)
-- print(tab.x, tab.z)     --> 10   0
-- 

-- example 2
-- local mt = {__index = function (t) return t.___ end}
-- function setDefault (t, d)
--   t.___ = d
--   setmetatable(t, mt)
-- end
-- tab = {x=10, y=20}
-- print(tab.x, tab.z)     --> 10   nil
-- setDefault(tab, 0)
-- print(tab.x, tab.z)     --> 10   0

-- -- example 3
-- local key = {}    -- unique key
-- local mt = {__index = function (t) return t[key] end}
-- function setDefault (t, d)
--   t[key] = d
--   setmetatable(t, mt)
-- end
-- tab = {x=10, y=20}
-- print(tab.x, tab.z)     --> 10   nil
-- setDefault(tab, 0)
-- print(tab.x, tab.z)     --> 10   0

-- -- example4 use weaktable weak key
-- local defaults = {}
-- setmetatable(defaults, {__mode = "k"})
-- local mt = {__index = function (t) return defaults[t] end}
-- function setDefault (t, d)
--   defaults[t] = d
--   setmetatable(t, mt)
-- end
-- tab = {x=10, y=20}
-- print(tab.x, tab.z)     --> 10   nil
-- setDefault(tab, 0)
-- print(tab.x, tab.z)     --> 10   0
-- 
-- example5 use weaktable weak value for perf
local metas = {}
setmetatable(metas, {__mode = "v"})
function setDefault (t, d)
  local mt = metas[d]
  if mt == nil then
    mt = {__index = function () return d end}
    metas[d] = mt     -- memoize
  end
  setmetatable(t, mt)
end
tab = {x=10, y=20}
print(tab.x, tab.z)     --> 10   nil
setDefault(tab, 0)
print(tab.x, tab.z)     --> 10   0
