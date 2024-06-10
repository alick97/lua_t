local function try_open_file()
    local file, msg
    repeat
      print "enter a file name:"
      local name = io.read()
      if not name then return end   -- no input
      file, msg = io.open(name, "r")
      if not file then print(msg) end
    until file
end

try_open_file()

-- local file = assert(io.open("no-file", "r"))
