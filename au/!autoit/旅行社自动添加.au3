#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <IE.au3>

_IEErrorHandlerRegister()

Local $oIE = _IECreateEmbedded()
GUICreate("Embedded Web control Test", 1000, 580, 0, 0, _
		$WS_OVERLAPPEDWINDOW + $WS_VISIBLE + $WS_CLIPSIBLINGS + $WS_CLIPCHILDREN)
GUICtrlCreateObj($oIE, 0, 40, 1000, 560)
Local $GUI_Button_Back = GUICtrlCreateButton("Back", 10, 420, 100, 30)
Local $GUI_Button_Forward = GUICtrlCreateButton("Forward", 120, 420, 100, 30)
Local $GUI_Button_Home = GUICtrlCreateButton("Home", 230, 420, 100, 30)
Local $GUI_Button_Stop = GUICtrlCreateButton("Stop", 340, 420, 100, 30)
GUISetState() ;Show GUI
_IENavigate($oIE, "http://716580.com/b2b/")
_IELoadWait($oIE)
$ouname = _IEGetObjById($oIE, "user_id")
$ouname.value = "13858101783"
$ouname = _IEGetObjById($oIE, "user_pwd")
$ouname.value = "903291"
$ouname = _IEGetObjById($oIE, "login")
$ouname.click
Sleep(500)
_IELoadWait($oIE)

Local $file = FileOpen("D:\微云网盘\2100803\1旅行社联系电话.txt", 0)
If $file = -1 Then
	MsgBox(0, "Error", "Unable to open file.")
	Exit
EndIf
While 1
	$sname = FileReadLine($file)
	If @error = -1 Then ExitLoop
	$szjl = FileReadLine($file)
	$stel = FileReadLine($file)
	$smob = FileReadLine($file)
	$sdizhi = FileReadLine($file)
	_IENavigate($oIE, "http://716580.com/b2b/duanqiao/admin_company.asp?xaction=zj")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "travel_name")
	$ouname.value = $sname
	$ouname = _IEGetObjById($oIE, "travel_pro")
	$ouname.value = "浙江"
	$ouname = _IEGetObjById($oIE, "travel_city")
	$ouname.value = "杭州"
	$ouname = _IEGetObjById($oIE, "travel_address")
	$ouname.value = $sdizhi
	$ouname = _IEGetObjById($oIE, "travel_linkman")
	$ouname.value = $szjl
	$ouname = _IEGetObjById($oIE, "travel_linkmb")
	$ouname.value = $smob
	$ouname = _IEGetObjById($oIE, "travel_tel")
	$ouname.value = $stel
	$ouname = _IEGetObjById($oIE, "travel_vest")
	$ouname.value = $smob
	$ouname = _IEGetObjById($oIE, "login")
	$ouname.click
	Sleep(500)
	_IELoadWait($oIE)
WEnd
; Waiting for user to close the window
; Waiting for user to close the window
While 1
	Local $msg = GUIGetMsg()
	Select
		Case $msg = $GUI_EVENT_CLOSE
			ExitLoop
		Case $msg = $GUI_Button_Home
			_IENavigate($oIE, "http://e.jd.com/30083135.html")
			Sleep(10000)
			_IENavigate($oIE, "lebk://Bought/")
		Case $msg = $GUI_Button_Back
			_IEAction($oIE, "back")
		Case $msg = $GUI_Button_Forward
			_IEAction($oIE, "forward")
		Case $msg = $GUI_Button_Stop
			_IEAction($oIE, "stop")
	EndSelect
WEnd

GUIDelete()

Exit