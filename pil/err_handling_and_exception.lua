local status, err = pcall(function () error({code=121}) end)
if not status then
    if err then
        print(err.code)  -->  121
    end
end

status, err = pcall(function () a = "a"+1 end)
print(err)
print("-- show stack traceback")
print(debug.traceback())