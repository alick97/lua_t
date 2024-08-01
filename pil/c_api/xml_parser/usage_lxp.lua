local common = require "pil/common"

local base_dir = common.get_base_dir()
package.cpath = package.cpath .. ";" .. base_dir .."/pil/c_api/xml_parser/?.so"

local lxp = require "liblxp"

local count = 0
    
local callbacks = {
    StartElement = function (parser, tagname)
      io.write("+ ", string.rep("  ", count), tagname, "\n")
      count = count + 1
    end,
    
    EndElement = function (parser, tagname)
      count = count - 1
      io.write("- ", string.rep("  ", count), tagname, "\n")
    end,
}

local p = lxp.new(callbacks)
p:parse("<to> <yes/> </to>")
-- + to
-- +   yes
-- -   yes
-- - to
p:close()
