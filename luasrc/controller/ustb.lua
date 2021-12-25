module("luci.controller.ustb", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/ustb") then
		return
	end

	entry({"admin", "services", "ustb"}, alias("admin", "services", "ustb", "base"), _("USTB"), 100).dependent = true
	entry({"admin", "services", "ustb", "base"}, cbi("ustb/base"), _("基本设置"), 1).leaf = true
	entry({"admin", "services", "ustb", "advance"}, cbi("ustb/advance"), _("高级设置"), 2).leaf = true
	entry({"admin", "services", "ustb", "log"}, form("ustb/log"), _("日志"), 3).leaf = true
	entry({"admin", "services", "ustb", "status"}, call("act_status")).leaf = true
end

function act_status()
	local e = {}
	e.running = luci.sys.call("ps -w | grep link.sh | grep -v grep >/dev/null") == 0
	e.fee = luci.sys.exec("/usr/share/ustb/script/fee.sh")
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end
