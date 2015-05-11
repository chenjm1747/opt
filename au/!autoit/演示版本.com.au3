#Include <Date.au3>
#include <IE.au3>
#include <FTPEx.au3>  
#include <SQLite.au3>  
#include <SQLite.dll.au3>  
ShellExecute ("iexplore.exe", "about:blank")
WinWait ("about:blank")
$oIE = _IEAttach ("about:blank", "url")
_IENavigate ($oIE, "http://demo.716580.com")
_IELoadWait ($oIE)

$oQ = _IEGetObjByName ($oIE,  "user_loginname")
_IEFormElementSetValue ($oQ, "jm")
$oQ = _IEGetObjByName ($oIE,  "user_pwd")
_IEFormElementSetValue ($oQ, "123456")
;$oQ = _IEGetObjByName ($oIE,  "chkRememberMe")
;$oQ.click
$oQ = _IEGetObjByName ($oIE,  "Login")
$oQ.action="http://demo.716580.com/tbc_v5/ytt_login/check.asp"
Sleep(1000)
$oQ.submit
_IELoadWait ($oIE)
_IENavigate ($oIE, "http://admin.716580.com/tbc_v5/ytt_oa/daily.asp?xaction=add&daily_type=工作日志")
$oTables = _IETableGetCollection ($oIE, 1)
$oElements = _IETagNameAllGetCollection ($oIE)
For $oTable In $oTables
	$aTableData = _IETableWriteToArray ($oTable, True)
    _ArrayDisplay($aTableData)
Next
