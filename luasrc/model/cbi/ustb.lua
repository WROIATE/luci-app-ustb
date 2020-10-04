m = Map("ustb",translate("北科校园网登录"),translate("支持ipv6的自动登录程序"))
s = m:section(TypedSection, "login", "")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("启用"))
enableV6 = s:option(Flag, "enableV6", translate("开启V6"))
name = s:option(Value, "username", translate("账号"))
pass = s:option(Value, "password", translate("密码"))
pass.password = true

local apply = luci.http.formvalue("cbi.apply")
if apply then
     io.popen("/etc/init.d/ustb restart")
end
return m