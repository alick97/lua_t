local common = require "pil/common"

local base_dir = common.get_base_dir()
package.cpath = package.cpath .. ";" .. base_dir .."/pil/c_api/directory_iterator/?.so"

require "libdirectory_iterator"


for fname in dir(".") do
    print(fname)
end
