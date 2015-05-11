#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GDIPlus.au3>
#include <winapi.au3>
opt("CaretCoordMode",2)
_GDIPlus_Startup()

Local $msg
$MouseISUP = False
Global Const $STM_SETIMAGE = 0x0172
;Global Const $IMAGE_BITMAP = 0

$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & '\test.jpg')

$iX_ImageDisplay = _GDIPlus_ImageGetWidth($hImage)
$iY_ImageDisplay = _GDIPlus_ImageGetHeight($hImage)
ConsoleWrite($iX_ImageDisplay & " x " & $iY_ImageDisplay & @CRLF)

$iFactor_ImageDisplay = 1

If $iX_ImageDisplay > @DesktopWidth Or $iY_ImageDisplay > @DesktopHeight Then
        $iX_ImageDisplay = $iX_ImageDisplay * (@DesktopHeight / $iY_ImageDisplay)
        $iFactor_ImageDisplay = @DesktopHeight / $iY_ImageDisplay
        $iY_ImageDisplay = @DesktopHeight
        If $iX_ImageDisplay > @DesktopWidth Then
                $iY_ImageDisplay = $iY_ImageDisplay * (@DesktopWidth / $iX_ImageDisplay)
                $iFactor_ImageDisplay = @DesktopWidth / $iX_ImageDisplay
                $iX_ImageDisplay = @DesktopWidth
        EndIf
EndIf
$iX_ImageDisplay = Int($iX_ImageDisplay)
$iY_ImageDisplay = Int($iY_ImageDisplay)
$guiX = $iX_ImageDisplay
$GUIY = $iY_ImageDisplay
$gui_image_display = GUICreate("My GUI", $iX_ImageDisplay, $iY_ImageDisplay, Default, Default, $WS_OVERLAPPEDWINDOW); will create a dialog box that when displayed is centered
$pic_image_display = GUICtrlCreatePic("", 0, 0, $iX_ImageDisplay, $iY_ImageDisplay)
GUICtrlSetState(-1, $GUI_DISABLE)
;If $iFactor_ImageDisplay <> 1 Then
;   $hGraphic = _GDIPlus_GraphicsCreateFromHWND(GUICtrlGetHandle($pic_image_display))
;   _GDIPlus_GraphicsDrawImageRect($hGraphic, $hImage, 0, 0, $iX_ImageDisplay, $iY_ImageDisplay)
ConsoleWrite($iX_ImageDisplay & @TAB & $iY_ImageDisplay & @CRLF)
;EndIf

$hBMP = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
_WinAPI_DeleteObject(GUICtrlSendMsg($pic_image_display, $STM_SETIMAGE, $IMAGE_BITMAP, $hBMP))
;$aBmp = DllCall("user32.dll", "hwnd", "SendMessage", "hwnd", GUICtrlGetHandle($pic_image_display), "int", $STM_SETIMAGE, "int", $IMAGE_BITMAP, "int", $hBMP)
;_WinAPI_RedrawWindow($gui_image_display, "", "", BitOR($RDW_INVALIDATE, $RDW_UPDATENOW, $RDW_FRAME))

;If $aBmp[0] <> 0 Then _WinAPI_DeleteObject($aBmp[0])

_GDIPlus_ImageDispose($hImage)
_WinAPI_DeleteObject($hBMP)

;If $iFactor_ImageDisplay <> 1 Then
;   _GDIPlus_GraphicsDispose($hGraphic)
;EndIf

_GDIPlus_Shutdown()

GUICtrlSetPos($pic_image_display, 0, 0, $iX_ImageDisplay, $iY_ImageDisplay)


GUIRegisterMsg(522, "_ResizePic"); WM_MOUSEWHEEL
GUIRegisterMsg(0x0201, "_movePic");
GUIRegisterMsg(0x0202, "_EndmovePic");

GUISetState(@SW_SHOW); will display an empty dialog box

; Run the GUI until the dialog is closed
While 1
        $msg = GUIGetMsg()

        If $msg = $GUI_EVENT_CLOSE Then ExitLoop
WEnd


GUIDelete()


Func _ResizePic($hWnd, $iMsg, $wParam, $lParam)
        If BitShift($wParam, 16) > 0 Then
                $iX_ImageDisplay *= 1.1
                $iY_ImageDisplay *= 1.1
        Else
                $iX_ImageDisplay /= 1.1
                $iY_ImageDisplay /= 1.1
        EndIf
        GUICtrlSetPos($pic_image_display, $guiX / 2 - $iX_ImageDisplay / 2, $GUIY / 2 - $iY_ImageDisplay / 2, $iX_ImageDisplay, $iY_ImageDisplay)
EndFunc   ;==>_ResizePic

Func _movePic()
        $xy = GUIGetCursorInfo()
        If $xy[4] = $pic_image_display Then
        $MouseISUP = False
        GUISetCursor(9)
        $x0=$xy[0]
        $y0=$xy[1]
                While Not $MouseISUP
                        Sleep(10)
                        $xy = GUIGetCursorInfo()
                        $Lx=$XY[0]-$x0
                        $Ly=$XY[1]-$y0
                        If $Lx<>0 Or $Ly<>0  Then
                                $x0=$XY[0]
                                $y0=$XY[1]
                                $Pxy=ControlGetPos($gui_image_display,"",$pic_image_display)
                                GUICtrlSetPos($pic_image_display,$Pxy[0]+$Lx,$Pxy[1]+$Ly)
                        EndIf
                WEnd
                GUISetCursor(2)
        EndIf
EndFunc   ;==>_movePic

Func _EndmovePic()
        $MouseISUP = True
EndFunc   ;==>_EndmovePic