m = Map('ustb', translate('高级设置'), translate('自定义登陆配置'))
s = m:section(TypedSection, 'advance', '')

s.addremove = false
s.anonymous = true
login_ip = s:option(Value, 'login_ip', translate('登录地址'), translate('USTB校园网登录使用的地址'))
login_ip.datatype = 'ip4addr'
login_ip.default = '202.204.48.82'
test_ipv4 = s:option(Value, 'test_v4url', translate('V4测试URL'), translate('检测V4网络连通性使用的地址，注意选择地址需保证正常能够访问'))
test_ipv4.placeholder = 'https://www.baidu.com/'
test_ipv6 = s:option(Value, 'test_v6url', translate('V6测试URL'), translate('检测V6网络连通性使用的地址，注意选择地址需保证正常能够访问'))
test_ipv6.placeholder = 'https://v6.myip.la/'

button_add_nat6 = s:option(Button, '_button_add_nat6', translate('添加Nat6规则'), translate('请确保WAN6已获得V6地址'))
button_add_nat6.inputstyle = 'apply'
button_add_nat6.inputtitle = translate('点击添加')

button_del_nat6 = s:option(Button, '_button_del_nat6', translate('删除ßNat6规则'), translate('删除USTB规则'))
button_del_nat6.inputstyle = 'apply'
button_del_nat6.inputtitle = translate('点击删除')

function button_del_nat6.write(self, section, value)
    luci.sys.call('/usr/share/USTB/script/del.sh > /dev/null')
end

function button_add_nat6.write(self, section, value)
    luci.sys.call('/usr/share/USTB/script/ipv6.sh > /dev/null')
end

return m
