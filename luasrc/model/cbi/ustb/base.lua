m = Map("ustb")
m.title = translate("北科校园网登录")
m.description = translate("支持ipv6的自动登录程序")

m:section(SimpleSection).template = "ustb/ustb_status"

s = m:section(TypedSection, "login")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("启用"))

enableV6 = s:option(Flag, "enableV6", translate("使用V6"))
enableV6.description = translate("勾选使用IPV6检测网络连接")
enableV6.optional = false
enableV6:depends("enable", "1")

name = s:option(Value, "username", translate("账号"))
name.description = translate("你的学号")
name.datatype = "uinteger"

pass = s:option(Value, "password", translate("密码"))
pass.password = true
pass.datatype = "string"

return m
