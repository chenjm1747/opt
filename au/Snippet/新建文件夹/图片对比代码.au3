#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\WINDOWS\system32\SHELL32.dll
#AutoIt3Wrapper_OutFile=ddzc12.exe
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <WinAPI.au3>
#include <WindowsConstants.au3>
$width = 1
$color = 0xFFFF
$hwnd = WinGetHandle("大家来找茬")
$p = WinGetPos($hwnd)
$Form1aa = GUICreate("Crazylisten", @DesktopWidth, 445, 100, 150, $WS_POPUP, BitOR($WS_EX_TOOLWINDOW, $WS_EX_LAYERED, $WS_EX_TOPMOST), WinGetHandle(AutoItWinGetTitle()))
GUISetBkColor(0xABCDEF)
GUISetState(@SW_SHOW)
_API_SetLayeredWindowAttributes($Form1aa, 0xABCDEF)
DllCall("user32.dll", "uint", "SetWindowLong", "hWnd", $Form1aa, "int", "-20", "uint", BitOR(DllCall("user32.dll", "uint", "GetWindowLong", "hWnd", $Form1aa, "int", "-20"), 0x80000, 0x20))
$hDC = _WinAPI_GetDC($Form1aa)
_WinAPI_SetBkColor($hDC, 0x000000)
_WinAPI_SetBkMode($hDC, $TRANSPARENT)
$hPen = _WinAPI_CreatePen($PS_SOLID, $width, $color)
$obj_orig = _WinAPI_SelectObject($hDC, $hPen)
HotKeySet("{F9}", "fu")
While 1
	Sleep(50)
WEnd

Func fu()
	$hwnd = WinGetHandle("大家来找茬")
	$p = WinGetPos($hwnd)
	_WinAPI_ReleaseDC(0, $hDC)
	_WinAPI_ReleaseDC(0, $hDC)
	_WinAPI_InvalidateRect(0, 0)
	$tRECT = 0
	GUIDelete($Form1aa)

	$Form1aa = GUICreate("Crazylisten", @DesktopWidth, @DesktopHeight, 0, 0, $WS_POPUP, BitOR($WS_EX_TOOLWINDOW, $WS_EX_LAYERED, $WS_EX_TOPMOST), WinGetHandle(AutoItWinGetTitle()))
	GUISetBkColor(0xABCDEF)
	GUISetState(@SW_SHOW)
	_API_SetLayeredWindowAttributes($Form1aa, 0xABCDEF)
	DllCall("user32.dll", "uint", "SetWindowLong", "hWnd", $Form1aa, "int", "-20", "uint", BitOR(DllCall("user32.dll", "uint", "GetWindowLong", "hWnd", $Form1aa, "int", "-20"), 0x80000, 0x20))
	$hDC = _WinAPI_GetDC($Form1aa)
	_WinAPI_SetBkColor($hDC, 0x000000)
	_WinAPI_SetBkMode($hDC, $TRANSPARENT)
	$hPen = _WinAPI_CreatePen($PS_SOLID, $width, $color)
	$obj_orig = _WinAPI_SelectObject($hDC, $hPen)
	For $j = 190 To 641 Step 1

		For $i = 6 To 505 Step 3
			$color1 = PixelGetColor($i + $p[0], $j + $p[1])
			$dm_ret = CmpColor($i + 509 + $p[0], $j + $p[1], $color1)
			If $dm_ret = 0 Then
				_WinAPI_DrawLine($hDC, $i + $p[0], $j + $p[1], $i + $p[0], $j + $p[1] + 1)
			EndIf
		Next

	Next
EndFunc   ;==>fu

Func cmpcolor($i, $j, $color)
	$colorA = PixelGetColor($i, $j)
	If $color = $colorA Then
		Return 1
	Else
		Return 0
	EndIf

EndFunc   ;==>cmpcolor

Func _API_SetLayeredWindowAttributes($hwnd, $i_transcolor, $Transparency = 255, $isColorRef = False)

	Local Const $AC_SRC_ALPHA = 1
	Local Const $ULW_ALPHA = 2
	Local Const $LWA_ALPHA = 0x2
	Local Const $LWA_COLORKEY = 0x1
	If Not $isColorRef Then
		$i_transcolor = Hex(String($i_transcolor), 6)
		$i_transcolor = Execute('0x00' & StringMid($i_transcolor, 5, 2) & StringMid($i_transcolor, 3, 2) & StringMid($i_transcolor, 1, 2))
	EndIf
	Local $Ret = DllCall("user32.dll", "int", "SetLayeredWindowAttributes", "hwnd", $hwnd, "long", $i_transcolor, "byte", $Transparency, "long", $LWA_COLORKEY + $LWA_ALPHA)
	Select
		Case @error
			Return SetError(@error, 0, 0)
		Case $Ret[0] = 0
			Return SetError(4, 0, 0)
		Case Else
			Return 1
	EndSelect
EndFunc   ;==>_API_SetLayeredWindowAttributes