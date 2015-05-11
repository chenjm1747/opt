#Include <Date.au3>
#include <IE.au3>
;~ #comments-start 
ShellExecute ("iexplore.exe", "about:blank")
WinWait ("about:blank")
$oIE = _IEAttach ("about:blank", "url")
_IELoadWait ($oIE)
_IENavigate ($oIE, "https://login.taobao.com/member/login.jhtml?f=top&redirectURL=http%3A%2F%2Fwww.taobao.com%2Findex_global.php")
$oForm = _IEFormGetObjByName ($oIE, "J_StaticForm")
_IEFormElementCheckboxSelect ($oForm, "J_SafeLoginCheck", "", 0, "byValue")
$osafe = _IEGetObjById ($oIE, "J_SafeLoginCheck")
$osafe.click
$oQ = _IEGetObjByName ($oIE,  "TPL_username")
_IEFormElementSetValue ($oQ, "xrjk2000")
$oQ = _IEGetObjByName ($oIE,  "TPL_password")
_IEFormElementSetValue ($oQ, "jmdjsjz.0329")
_IEFormSubmit ($oForm, 0)
_IELoadWait($oIE)
_IENavigate ($oIE, "http://wuliu.taobao.com/user/order_list_new.htm")

$oIE = _IEAttach ("http://wuliu.taobao.com/user/order_list_new.htm", "url")
;$oPiliang.click

$oO = _IEGetObjByName ($oIE,  "beginDate")
 $sdate = _NowDate()
;$sdate=StringFormat("%04d-%02d-%02d", $sd[2], $sd[0], $sd[1]) 
_IEFormElementSetValue ($oo,$sdate )
$oForm = _IEFormGetObjByName ($oIE, "form1")
_IEFormSubmit ($oForm, 0)
_IELoadWait($oIE)
$oinputs = $oIE.document.getElementsBytagName("input")
For $oInput In $oInputs
	If $oInput.type="checkbox" Then  $oInput.click
Next
$tag=0
For $oInput In $oInputs
	If( $oInput.value="批量打印发货单" )Then 
	$oInput.click
	EndIf
Next
$oIE = _IEAttach ("http://wuliu.taobao.com/user/normal_print_tickets.htm", "url")
$sText = _IEBodyReadText ($oIE)
FileOpen("c:\2.txt",2)
FileWrite("c:\2.txt",$sText)
FileClose("c:\2.txt")
_IEQuit ($oIE)
$oIE = _IEAttach ("http://wuliu.taobao.com/user/normal_print_tickets.htm", "url")
_IEQuit ($oIE)


;~ #comments-end 
