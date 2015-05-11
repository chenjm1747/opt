#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         jm

 Script Function:
	¹Ø¼ü´ÊÌí¼Ó

#ce ----------------------------------------------------------------------------
#include <IE.au3>
#include <Array.au3>

$hFileOpen = FileOpen(@ScriptName&".txt", $FO_APPEND)

$oie=_IECreate("")
#cs
$oie=_IECreate("http://cas.baidu.com/?tpl=www2&fromu=http%3A%2F%2Fwww2.baidu.com%2F")
$oIE.document.parentWindow.frameCloseBtn.click()
$oIE.document.parentWindow.entered_login.focus()
send("psÏôÏæÍøÂç")
Sleep(1000)
send("{tab}")
send("zjYC2310")
send("{tab}")
;token-img
send("")
send("")
sleep(9000)
$o=_IEGetObjById ( $oie,"submit-form")
$o.click()
#ce
_FileReadToArray(@ScriptName&".txt",$a, $FRTA_NOCOUNT)
$seach= _ArrayToString($aArray, chr(13),)

_IENavigate($oie,"http://www.baidu.com/s?tn=monline_dg&ie=utf-8&f=1&wd=²Ö¿â¹ÜÀíÈí¼þ")
_IELoadWait($oie)
$o=_IEGetObjById ( $oie,"rs")
Local $oElements = _IETagNameGetCollection($o, "table",0)
Local $aTableData = _IETableWriteToArray($oElements)

for $i=0 to UBound($aTableData)-2
	$i1=$aTableData[$i][1]
	if $i1>"" Then
		FileWriteLine($hFileOpen,$i1)
	EndIf
	$i1=$aTableData[$i][2]
	if $i1>"" Then
		FileWriteLine($hFileOpen,$i1)
	EndIf
next
_FileWriteFromArray(@ScriptName&".txt",$a)




