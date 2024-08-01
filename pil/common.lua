local function get_base_dir()
    local info = debug.getinfo(1, "S")
    local source = info.source:sub(2)
    local dir = source:match("(.*)%/pil%/")
    if not dir then
        return "."
    end
    return dir
end

return {
    get_base_dir = get_base_dir
}
