m = Map("ustb",translate("北科校园网登录"),translate("支持ipv6的自动登录程序"))
m:section(SimpleSection).template  = "ustb/ustb"
s = m:section(TypedSection, "login", "")
s.addremove = false
s.anonymous = true
enable = s:option(Flag, "enable", translate("启用"))
enableV6 = s:option(Flag, "enableV6", translate("开启V6"),translate("勾选添加V6 Nat6防火墙规则"))
enableV6.optional = false
enableV6:depends("enable","1")
name = s:option(Value, "username", translate("账号")，translate("你的学号"))
name.datatype="uinteger"
pass = s:option(Value, "password", translate("密码"))
pass.password = true
pass.datatype="string"

return m