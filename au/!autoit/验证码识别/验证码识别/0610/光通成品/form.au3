#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include "getCODE.au3"
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=
$Form = GUICreate("Test", 116, 132, 192, 114)
GUISetOnEvent($GUI_EVENT_CLOSE, "FormClose")
$CodePic = GUICtrlCreatePic("", 3, 4, 109, 44)
$CodeEdit = GUICtrlCreateInput("", 3, 60, 109, 21,$ES_CENTER)
$Ref = GUICtrlCreateButton("Ref", 16, 96, 75, 25)
GUICtrlSetOnEvent(-1, "RefClick")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
While 1
	Sleep(10000)
WEnd

Func FormClose()
	Exit
EndFunc
Func RefClick()
	InetGet("http://passport.cdcgames.net/VerifyCode.aspx","code.jpg",1)
	$code=StartReadCode()
	GUICtrlSetImage($CodePic,"code.jpg")
	GUICtrlSetData($CodeEdit,$code)
;~ 	FileDelete("code.*")
EndFunc