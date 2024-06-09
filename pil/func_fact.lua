-- func
local function fact(n)
  if n == 0 then
    return 1
  else
    return n * fact(n-1)
  end
end

print("enter a number:")
local a = io.read("n")  -- read a number
if a < 0 then
  return
end
print(fact(a))