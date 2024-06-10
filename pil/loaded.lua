require "pil/str"
print("---------- loaded:")
for k, v in pairs(package.loaded) do
    print(k, v)
end
