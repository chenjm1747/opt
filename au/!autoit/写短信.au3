
#include <IE.au3>
ShellExecute ("iexplore.exe", "about:blank")
WinWait ("空白页")
$oIE = _IEAttach ("about:blank", "url")
_IEPropertySet ($oIE, "left", 8000) ;设置ie宽800像素
_IEPropertySet ($oIE, "top", 6000) ;设置ie高600像素
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
_IENavigate ($oIE, "http://admin.716580.com/tbc_v5/ytt_oa/sms_send.asp")
$oQ = _IEGetObjByName ($oIE,  "telNo")
_IEFormElementSetValue ($oQ, "13291488304")
$oQ = _IEGetObjByName ($oIE,  "tre_Note_Content")
$oQ.innerHtml="感谢您的致电，我们本着真诚合作，携手共进的宗旨，愿与你供创未来【杭州旅贸通旅游管理软件】蒋明"
$oQ = _IEGetObjByName ($oIE,  "imageField")
$oQ.click()
_IEQuit($oIE )
