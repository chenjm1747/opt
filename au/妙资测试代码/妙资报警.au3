#include <MsgBoxConstants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GUIListBox.au3>
#include <uuapi.au3>
#include <array.au3>
#include <IE.au3>
#include <MsgBoxConstants.au3>
#include <ScreenCapture.au3>
#include <WindowsConstants.au3>
GUICreate("网站报警系统", @DesktopWidth, @DesktopHeight, 0, 0, _
        $WS_OVERLAPPEDWINDOW + $WS_CLIPSIBLINGS + $WS_CLIPCHILDREN)
Local $login1 = GUICtrlCreateButton("无法访问", 0, 0, @DesktopWidth, @DesktopHeight)
Const $sFont = "Comic Sans Ms"
GUICtrlSetFont(-1,160, 400, 4, $sFont) ; Set the font of the previous control.



While _mzbaojing()<>1
   sleep (5000)
WEnd

GUISetState(@SW_SHOW) ;Show GUI

Func _mzbaojing()
    $oHTTP = ObjCreate("microsoft.xmlhttp")
    $oHTTP.Open("get", "http://www.mzmoney.com/?"& Random(1, 6, 0) , False)
    $oHTTP.Send("")
   $return= $oHTTP.responsetext;BinaryToString($oHTTP.responseBody)
    $IP = StringRegExp($return, '<title>妙资财富', 2)
    If Not @error Then
        Return ($IP[0])
    Else
        Return SetError(1, 0, 1)
    EndIf

EndFunc

While 1
    Local $iMsg = GUIGetMsg()
    Select
        Case $iMsg = $GUI_EVENT_CLOSE
            ExitLoop
    EndSelect
WEnd

