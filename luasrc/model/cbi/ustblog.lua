local fs = require "nixio.fs"
local conffile = "/tmp/ustb.log"

f = SimpleForm("logview")

t = f:field(TextValue, "conf")
t.rmempty = true
t.rows = 20
function t.cfgvalue()
  luci.sys.exec("cat /usr/share/USTB/link.log > /tmp/ustb.log")
	return fs.readfile(conffile) or ""
end
t.readonly="readonly"

return f