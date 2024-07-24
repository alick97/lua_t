local complex = require "pil.complex"
-- require "pil.complex"

local c = complex.add(complex.i, complex.new(10, 20))
print(c.r, c.i)