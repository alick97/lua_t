local socket = require "socket"
local logging = require "logging"
print(socket._VERSION)
local logger = logging.new(function(self, level, message)
    print(level, message)
    return true
end)
-- apt install luarocks
-- luarocks install luasocket --local
-- luarocks install lualogging --local


logger:setLevel(logging.DEBUG)

local HOST = "127.0.0.1"
local PORT = 9999

-- local function receive(connection)
--     return connection:receive(2^10)
-- end

local function receive(connection)
   connection:settimeout(0) -- do not block 
   local s, status = connection:receive(2^10)
   if status == 'timeout' then
       logger:debug("connection: "..tostring(connection).." ,status: "..tostring(status))
       coroutine.yield(connection)
   end
   logger:debug("receive: " .. tostring(status))
   return s, status
end

local function download(host, file)
    local c = assert(socket.connect(host, PORT))
    local count = 0 -- counts number of bytes read
    s = "GET "..file.." HTTP/1.1\r\n"..
       "User-Agent: curl/7.81.0\r\n"..
       "Host: www.w3.org\r\n"..
       "Accept: */*\r\n"..
       "\r\n"
    c:send(s)
    while true do
        local s, status = receive(c)
        logger:debug("file: "..file..",count: "..tostring(count)..", c: "..tostring(c)..", status: "..tostring(status))
        if s ~= nil then
            count =  count + string.len(s)
        end
        if status == "closed" then break end
    end
    c:close()
    print(file, count)
end


local threads = {}

local function get(host, file)
    -- create coroutine
    local co = coroutine.create(function ()
        download(host, file)
    end)
    -- insert it in the list
    table.insert(threads, co)
end

local function dispatcher()
    while true do
       local n = #threads
       if n == 0 then break end
       for i=1,n do
           local status, res = coroutine.resume(threads[i])
           logger:debug("resume thread "..tostring(i)..",status: "..tostring(status)..", res: "..tostring(res))
           if not status then  -- thread finished its task?
               table.remove(threads, i)
               break
           end
       end
    end
end

get(HOST, "/a.txt")
get(HOST, "/b.txt")
get(HOST, "/c.txt")

dispatcher() -- main loop

-- gen data
-- make -C pil/gen_sample_http_server_data

-- run server
-- make run -C pil/gen_sample_http_server_data

-- clean data
-- make clean -C pil/gen_sample_http_server_data
