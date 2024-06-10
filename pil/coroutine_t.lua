local co = coroutine.create(function ()
    print("hi")
end)

print(co)
print(coroutine.status(co))

coroutine.resume(co)
print(coroutine.status(co))
coroutine.resume(co)
print(coroutine.status(co))

co = coroutine.create(function (a, b, c)
    print("co", a,b,c) 
end)
coroutine.resume(co, 1, 2, 3)


co = coroutine.create(function ()
   print("co1", coroutine.yield()) 
end)

print("------------ with yield")
local s, v = coroutine.resume(co)
print(s, v)
coroutine.resume(co, 4, 5)
print(coroutine.status(co))
coroutine.resume(co, 4, 5, 6) -- no run

co = coroutine.create(function ()
    return 6, 7
end)
print(coroutine.resume(co))   --> true  6  7
print(coroutine.resume(co))   -- false