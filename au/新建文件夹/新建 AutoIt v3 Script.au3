#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <IE.au3>

Local $oIE = _IECreateEmbedded()
GUICreate("Embedded Web control Test", 1040, 880, _
        (@DesktopWidth - 1040) / 2, (@DesktopHeight - 880) / 2, _
        $WS_OVERLAPPEDWINDOW + $WS_CLIPSIBLINGS + $WS_CLIPCHILDREN)
GUICtrlCreateObj($oIE, 10, 40, 1000, 860)
Global $GUI_Button_Back = GUICtrlCreateButton("Back", 10, 420, 100, 30)
Global $GUI_Button_Forward = GUICtrlCreateButton("Forward", 120, 420, 100, 30)
Global $GUI_Button_Home = GUICtrlCreateButton("Home", 230, 420, 100, 30)
Global $GUI_Button_Stop = GUICtrlCreateButton("Stop", 340, 420, 100, 30)

Global $GUI_Error_Message = GUICtrlCreateLabel("", 100, 500, 500, 30)
GUICtrlSetColor(-1, 0xff0000)

GUISetState(@SW_SHOW) ;Show GUI

_IENavigate($oIE, "http://www.17ce.com")
_IELoadWait($oIE)
              ;找到表单form1
$o_form = _IEFormGetObjByName($oIE, "form1")
$o_txtuser = _IEFormElementGetObjByName($o_form, "url") ;找到表单中的用户名
$o_txtpass = _IEFormElementGetObjByName($o_form, "curl") ;找到表单中的 密码
While 1
_IEFormElementSetValue($o_txtuser, "http://www.716580.com/b2b/adv/1"&Random(1, 4, 1)&".jpg?"&Random(1, 600, 1))                ;你的登录帐号
_IEFormElementSetValue($o_txtpass, "http://www.716580.com/b2b/adv/1"&Random(1, 4, 1)&".jpg?"&Random(1, 600, 1))
$oIE.document.parentWindow.execscript("show_tip();set_nocache(1);submit_query_form();showindex();ajax_check('content','','')")
;RunWait("RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2")
Sleep(8000)
wend
; Waiting for user to close the window
While 1
    Local $msg = GUIGetMsg()
    Select
        Case $msg = $GUI_EVENT_CLOSE
            ExitLoop
        Case $msg = $GUI_Button_Home
            _IENavigate($oIE, "http://www.17ce.com")
            _IEAction($oIE, "stop")
            _IEAction($oIE, "back")
            CheckError("Home", @error, @extended)
        Case $msg = $GUI_Button_Back
            _IEAction($oIE, "back")
            CheckError("Back", @error, @extended)
        Case $msg = $GUI_Button_Forward
            _IEAction($oIE, "forward")
            CheckError("Forward", @error, @extended)
        Case $msg = $GUI_Button_Stop
            _IEAction($oIE, "stop")
            CheckError("Stop", @error, @extended)
    EndSelect
WEnd

GUIDelete()

Exit

Func CheckError($sMsg, $error, $extended)
    If $error Then
        $sMsg = "Error using " & $sMsg & " button (" & $extended & ")"
    Else
        $sMsg = ""
    EndIf
    GUICtrlSetData($GUI_Error_Message, $sMsg)
EndFunc   ;==>CheckError

