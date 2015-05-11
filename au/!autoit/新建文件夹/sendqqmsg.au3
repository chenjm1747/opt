#include <Array.au3> ; Required only for _ArrayDisplay(), but not the UDF!
#include <Constants.au3>
#include <GUIConstantsEx.au3>
#Include <WinAPI.au3>
$sClassName="TXGuiFoundation"
$sWindowName="QQ2013"
$sHandle=""
$sHandle=_WinAPI_FindWindow($sClassName, $sWindowName)
;MsgBox(0,'',$sHandle)

WinActivate("[TITLE:QQ2013;CLASS:TXGuiFoundation]")
;SendKeepActive("[TITLE:QQ2013;CLASS:TXGuiFoundation]")
For $i = 1 to 10
	Send("{tab}{tab}")
	Send("{NumPadMult}")
    Sleep(500)
    Send("{DOWN}{enter}")
	$i1=0
	$i2=0
	Sleep(1000)
	WinWaitClose("[TITLE:œµÕ≥…Ë÷√;CLASS:TXGuiFoundation]")
	
	Send("^v^w")

Next
