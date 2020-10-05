module("luci.controller.ustb", package.seeall)

function index()
        if not nixio.fs.access("/etc/config/ustb") then
		return
	end
        entry({"admin", "services", "ustb"}, firstchild(), _("USTB"), 100)
        entry({"admin", "services", "ustb","general"}, cbi("ustb"), _("Base Setting"), 1)
        entry({"admin", "services", "ustb", "log"},form("ustblog"), _("Log"), 2)
        entry({"admin","services","ustb","status"},call("act_status")).leaf=true
end

function act_status()
        local e={}
        e.running=luci.sys.call("ps -w | grep link.sh | grep -v grep >/dev/null")==0
        luci.http.prepare_content("application/json")
        luci.http.write_json(e)
end