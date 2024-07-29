function traceback ()
    local level = 1
    while true do
      local info = debug.getinfo(level, "Sl")
      if not info then break end
      if info.what == "C" then   -- is a C function?
        print(level, "C function")
      else   -- a Lua function
        print(string.format("[%s]:%d",
                            info.short_src, info.currentline))
      end
      level = level + 1
    end
end


traceback()

function show()
   print("in func show") 
   traceback()
end
show()


function foo (a,b)
    print("accessing local variables")
    local x
    do local c = a - b end
    local a = 1
    while true do
      local name, value = debug.getlocal(1, a)
      if not name then break end
      print(name, value)
      a = a + 1
    end
end
  
foo(10, 20)

debug.sethook(print, "l")
print(1) --> line 42
function trace (event, line)
    local s = debug.getinfo(2).short_src
    print(s .. ":" .. line)
end
debug.sethook(trace, "l")
print(2)