module("luci.controller.ustb", package.seeall)

function index()
        entry({"admin", "network", "ustb"}, firstchild(), _("USTB"), 100)
        entry({"admin", "network", "ustb","general"}, cbi("ustb"), _("Base Setting"), 1)
        entry({"admin", "network", "ustb", "log"},form("ustblog"), _("Log"), 2)
end