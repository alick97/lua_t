local request = require("http.request")
-- sudo apt install luajit
-- luarocks install http --local
local host = "www.w3.org"
local path = "/TR/2018/SPSD-html32-20180315/"

local headers, stream = assert(request.new_from_uri("https://"..host..path):go())
print(headers:get ":status")
local body = assert(stream:get_body_as_string())
print(body)