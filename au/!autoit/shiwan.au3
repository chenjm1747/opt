#Include <Date.au3>
#include <IE.au3>
#include <FTPEx.au3>  
#include <SQLite.au3>  
#include <SQLite.dll.au3>  
_IELoadWaitTimeout (3000)
ShellExecute ("iexplore.exe", "about:blank")
WinWait ("about:blank")
$oIE = _IEAttach ("about:blank", "url")
_IELoadWait ($oIE)
_IENavigate ($oIE, "http://www.shiwan.com/user/login")
$oForm = _IEFormGetObjByName ($oIE, "login_form")
$oQ = _IEGetObjByName ($oIE,  "username")
_IEFormElementSetValue ($oQ, "ajim522")
$oQ = _IEGetObjByName ($oIE,  "password")
_IEFormElementSetValue ($oQ, "903291")
_IEFormSubmit ($oForm, 0)
_IELoadWait($oIE)
;~ _IENavigate ($oIE, "http://www.shiwan.com/playstory/index/gameid/18206/template/default/featureId/0/page/2")
_IENavigate($oIE,"http://www.shiwan.com/z/starcraft2/type/account_comment")

$oIE = _IEAttach ("http://www.shiwan.com/z/starcraft2/type/account_comment", "url")

_IELoadWait($oIE)

$oq = _IEGetObjById ($oIE, "cost_money")
$oq.value="18"
$oq = _IEGetObjById ($oIE, "170")
$oq.click

$oinputs = $oIE.document.getElementsBytagName("a")
For $oInput In $oInputs	
	If( $oInput.title="8" )Then 
	$oInput.click
	EndIf
Next

_SQLite_Startup()
_SQLite_Open("shiwan.db")
_SQLite_Exec(-1,"Create table d (d);")
$ospans = $oIE.document.getElementsBytagName("span")
For $ospan In $ospans
$sq=$ospan.innertext
$len=StringLen ( $sq)
If $len>100 Then 
	_SQLite_Exec(-1, "Insert into d (d) values ('"&$sq&"');")  
EndIf
Next
$amax=_SQLite_LastInsertRowID() 
$arandom=Random(0,$amax,1)
;~ MsgBox(0,"",$arandom)
$d = _SQLite_Exec(-1,"Select * From d limit 1 offset "&$arandom,"_cb")

Func _cb($aRow)
	For $s In $aRow
		$otexts = $oIE.document.getElementsBytagName("textarea")
			For $otext In $otexts	
				If $otext.rows='6' Then $otext.innerText=$s
			Next
	Next
EndFunc
;~ comment_post_btn
$oq = _IEGetObjById ($oIE, "comment_post_btn")
$oq.click

_IELoadWait($oIE)

_IENavigate ($oIE, "http://www.shiwan.com/z/starcraft2/type/ba")
_IELoadWait($oIE)
$osafe = _IEGetObjById ($oIE, "get_card")
$osafe.click
