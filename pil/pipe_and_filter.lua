local function receive(prod)
    local status, value = coroutine.resume(prod, "dummay send get val")
    return value
end

local function send(x)
  -- yield get value from resume and resum get val from yield, yield link resume
  print("send get param: ", coroutine.yield(x))
end

local function producer()
   return coroutine.create(function()
       while true do
           local x = io.read()
           send(x)
       end
   end)
end

local function consumer(prod)
    while true do
        local x = receive(prod)
        io.write(x, "\n")
    end
end

local function filter(prod)
    return coroutine.create(function()
        local line = 1
        while true do
            local x = receive(prod)
            x = string.format("%5d %s", line, x)
            send(x)
            line = line + 1
        end 
    end)
end

p = producer()
f = filter(p)
consumer(f)
