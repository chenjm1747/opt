
#include <IE.au3>
ShellExecute ("iexplore.exe", "about:blank")
WinWait ("空白页")
$oIE = _IEAttach ("about:blank", "url")
_IENavigate ($oIE, "http://admin.716580.com")
_IELoadWait ($oIE)

$oQ = _IEGetObjByName ($oIE,  "user_loginname")
_IEFormElementSetValue ($oQ, "蒋明")
$oQ = _IEGetObjByName ($oIE,  "user_pwd")
_IEFormElementSetValue ($oQ, "903291")
;$oQ = _IEGetObjByName ($oIE,  "chkRememberMe")
;$oQ.click
$oQ = _IEGetObjByName ($oIE,  "Login")
$oQ.action="http://admin.716580.com/tbc_v5/ytt_login/check.asp"
Sleep(1000)
$oQ.submit

_IELoadWait ($oIE)
; 这是我的第一个脚本
Sleep ( Random(0,1000*60*10, 1))
If @HOUR="08" Then _IENavigate ($oIE, "http://admin.716580.com/tbc_v5/ytt_oahotel/person.asp?xaction=z")
If @HOUR="17" Then _IENavigate ($oIE, "http://admin.716580.com/tbc_v5/ytt_oahotel/person.asp?xaction=w")
_IELoadWait ($oIE)
_IENavigate ($oIE, "http://admin.716580.com/tbc_v5/ytt_oa/daily.asp?xaction=add&daily_type=工作日志")

$oQ = _IEGetObjByName ($oIE,  "daily_type")
_IEFormElementOptionSelect ($oQ, "工作日志")
_IELoadWait ($oIE)
$oQ = _IEGetObjByName ($oIE,  "daily_title")
_IEFormElementSetValue ($oQ, "工作日志")
$oQ = _IEGetObjByName ($oIE,  "daily_demo")
_IEFormElementSetValue ($oQ, "经过3个月的工作，")
$oQ = _IEGetObjByName ($oIE,  "daily_to")
$oQ.value='小沈'

;daily_title daily_demo
;daily_type Bt1 daily_to