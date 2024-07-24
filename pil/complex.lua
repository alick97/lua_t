-- complex = {}
-- 
-- function complex.new (r, i) return {r=r, i=i} end
-- 
-- -- defines a constant `i'
-- complex.i = complex.new(0, 1)
-- 
-- function complex.add (c1, c2)
--   return complex.new(c1.r + c2.r, c1.i + c2.i)
-- end
-- 
-- function complex.sub (c1, c2)
--   return complex.new(c1.r - c2.r, c1.i - c2.i)
-- end
-- 
-- function complex.mul (c1, c2)
--   return complex.new(c1.r*c2.r - c1.i*c2.i,
--                      c1.r*c2.i + c1.i*c2.r)
-- end
-- 
-- function complex.inv (c)
--   local n = c.r^2 + c.i^2
--   return complex.new(c.r/n, -c.i/n)
-- end
-- 
-- return complex

local P = {}
complex = P

-- package privacy function by use local
local function checkComplex (c)
    if not ((type(c) == "table") and
       tonumber(c.r) and tonumber(c.i)) then
      error("bad complex number", 3)
    end
end


function P.new (r, i) return {r=r, i=i} end

-- defines a constant `i'
P.i = P.new(0, 1)

function P.add (c1, c2)
    checkComplex(c1)
    checkComplex(c2)
  return P.new(c1.r + c2.r, c1.i + c2.i)
end

function P.sub (c1, c2)
  return P.new(c1.r - c2.r, c1.i - c2.i)
end

function P.mul (c1, c2)
  return P.new(c1.r*c2.r - c1.i*c2.i,
                     c1.r*c2.i + c1.i*c2.r)
end

function P.inv (c)
  local n = c.r^2 + c.i^2
  return P.new(c.r/n, -c.i/n)
end

return complex