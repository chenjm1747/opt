#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
 #NoTrayIcon
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_Icon=kview.ico
#AutoIt3Wrapper_Outfile=取色工具.exe
#AutoIt3Wrapper_Res_Description=取色,图片格式转换
#AutoIt3Wrapper_Res_Fileversion=1.3.0.0
#AutoIt3Wrapper_Res_LegalCopyright=cnsnc
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include-once
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <SliderConstants.au3>
#include <WindowsConstants.au3>
#include <GDIPlus.au3>
#include <StaticConstants.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
Opt("GUIOnEventMode", 1)
;Opt("OnExitFunc", "Quit")
Global $form[3], $Input[3], $Label[10], $Button[6], $Slider[4], $hPen, $_colorB, $_colorG, $_colorR
Global $G_Switch = 1, $PicFormat = ".JPG", $G_times = 22, $penwidth = 1, $colorFORMAT = 1, $pen_switch = 0, $Is_loop = $G_Switch
Local $tempfile = @TempDir & "/mycolor_text.txt", $temppic = @TempDir & "/MyScreenCap13-56-57.JPG", $HotKeyused = "f"
;FileInstall("MyScreenCap13-56-57.JPG", $temppic, 1)
$form[1] = GUICreate("取色工具", 373, 366, -1, -1, -1, BitOR($WS_EX_ACCEPTFILES, $WS_EX_WINDOWEDGE))
$filemenu = GUICtrlCreateMenu("文件(&F)")
$fileitem1 = GUICtrlCreateMenuItem("窗口置顶", $filemenu)
GUICtrlSetOnEvent(-1, 'menu')
$fileitem2 = GUICtrlCreateMenuItem("取消置顶", $filemenu)
GUICtrlSetOnEvent(-1, 'menu')
GUICtrlCreateMenuItem("", $filemenu)
$about = GUICtrlCreateMenuItem("关于", $filemenu)
GUICtrlSetOnEvent(-1, 'menu')
$fileitem3 = GUICtrlCreateMenuItem("退出", $filemenu)
GUICtrlSetOnEvent(-1, 'menu')
$glassmenu = GUICtrlCreateMenu("放大镜(&G)")
$glassitem1 = GUICtrlCreateMenuItem("打开", $glassmenu)
GUICtrlSetOnEvent(-1, 'menu')
$glassitem2 = GUICtrlCreateMenuItem("停止", $glassmenu)
GUICtrlSetOnEvent(-1, 'menu')
GUICtrlCreateMenuItem("", $glassmenu)
$glassitem3 = GUICtrlCreateMenu("放大", $glassmenu)
$glassitem3_1 = GUICtrlCreateMenuItem("放大3倍", $glassitem3, 1, 1)
GUICtrlSetOnEvent(-1, 'menu')
$glassitem3_2 = GUICtrlCreateMenuItem("放大9倍", $glassitem3, 2, 1)
GUICtrlSetOnEvent(-1, 'menu')
$glassitem3_3 = GUICtrlCreateMenuItem("不放大", $glassitem3, 3, 1)
GUICtrlSetOnEvent(-1, 'menu')
$glassitem4 = GUICtrlCreateMenu("标靶", $glassmenu)
$glassitem4_1 = GUICtrlCreateMenuItem("放大", $glassitem4, 1, 1)
GUICtrlSetOnEvent(-1, 'menu')
$glassitem4_2 = GUICtrlCreateMenuItem("不放大", $glassitem4, 2, 1)
GUICtrlSetOnEvent(-1, 'menu')
$picmenu = GUICtrlCreateMenu("图片转换(&P)")
$picitem1 = GUICtrlCreateMenuItem("转换图片", $picmenu)
GUICtrlSetOnEvent(-1, 'menu')
GUICtrlCreateMenuItem("", $picmenu)
$picitem2 = GUICtrlCreateMenuItem("JPG 格式", $picmenu, 3, 1)
GUICtrlSetOnEvent(-1, 'menu')
$picitem3 = GUICtrlCreateMenuItem("PNG 格式", $picmenu, 4, 1)
GUICtrlSetOnEvent(-1, 'menu')
$picitem4 = GUICtrlCreateMenuItem("BMP 格式", $picmenu, 5, 1)
GUICtrlSetOnEvent(-1, 'menu')
$picitem5 = GUICtrlCreateMenuItem("GIF 格式", $picmenu, 6, 1)
GUICtrlSetOnEvent(-1, 'menu')
$hotkeymenu = GUICtrlCreateMenu("取色热键:CTRL+F")
$hotkeyitem = GUICtrlCreateMenuItem("设置", $hotkeymenu)
GUICtrlSetOnEvent(-1, 'menu')
$Graphic1 = GUICtrlCreateGraphic(12, 5, 137, 137, $SS_blackFRAME);,BitOR($SS_blackFRAME,$SS_CENTERIMAGE,$SS_SUNKEN,$WS_CLIPSIBLINGS))
$ListView1 = GUICtrlCreateListView("颜色|坐标", 162, 4, 202, 126, BitOR($LVS_NOCOLUMNHEADER, $LVS_SINGLESEL));$LVS_NOCOLUMNHEADER,
GUICtrlSetOnEvent(-1, 'gui')
_GUICtrlListView_SetColumnWidth($ListView1, 0, 115)
_GUICtrlListView_SetColumnWidth($ListView1, 1, 60)
$lv_Menu = GUICtrlCreateContextMenu($ListView1)
$lv_Menuitem1 = GUICtrlCreateMenuItem("复制", $lv_Menu)
GUICtrlSetOnEvent(-1, "menu")
$lv_Menuitem3 = GUICtrlCreateMenuItem("删除", $lv_Menu)
GUICtrlSetOnEvent(-1, "menu")
$lv_Menuitem2 = GUICtrlCreateMenuItem("清空", $lv_Menu)
GUICtrlSetOnEvent(-1, "menu")
$Label[1] = GUICtrlCreateLabel("", 13, 144, 132, 17, $SS_CENTER)
$Label[2] = GUICtrlCreateLabel("", 13, 160, 132, 17, $SS_CENTER)
$Combo1 = GUICtrlCreateCombo("", 272, 132, 89, 25, 0x0003)
GUICtrlSetData(-1, 'RGB HEX|RGB|HTML|DELPHI', 'RGB HEX')
GUICtrlSetOnEvent(-1, "gui")
$Input[1] = GUICtrlCreateInput("", 162, 132, 105, 21)
$Button[1] = GUICtrlCreateButton("转换(&O)", 174, 160, 62, 25, 0)
$checkbox = GUICtrlCreateCheckbox("调色板显示该色", 253, 162, 120, 20)
GUICtrlSetState(-1, 1)
$Label[3] = GUICtrlCreateLabel("", 7, 194, 360, 2, $WS_CLIPSIBLINGS, $WS_EX_STATICEDGE)
$Group1 = GUICtrlCreateGroup("调色板", 160, 204, 209, 138)
$Label[4] = GUICtrlCreateLabel("", 224, 220, 138, 33)
GUICtrlSetBkColor(-1, 0x379BFF)
$Button[3] = GUICtrlCreateButton("复制", 168, 224, 51, 25, 0)
$Slider[1] = GUICtrlCreateSlider(165, 258, 202, 20, BitOR($TBS_NOTICKS, $TBS_ENABLESELRANGE))
$Slider[2] = GUICtrlCreateSlider(165, 280, 202, 20, BitOR($TBS_NOTICKS, $TBS_ENABLESELRANGE))
$Slider[3] = GUICtrlCreateSlider(165, 302, 202, 20, BitOR($TBS_NOTICKS, $TBS_ENABLESELRANGE))
$Label[5] = GUICtrlCreateLabel("R:55", 165, 323, 40, 17)
$Label[6] = GUICtrlCreateLabel("G:155", 250, 323, 40, 17)
$Label[7] = GUICtrlCreateLabel("B:255", 320, 323, 40, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Pic1 = GUICtrlCreatePic($temppic, 26, 224, 108, 108, -1, BitOR($WS_EX_CLIENTEDGE, $WS_EX_STATICEDGE))
GUICtrlSetTip($Pic1, "设置格式后将图片" & @CRLF & "拖到框内,默认JPG");,"",1,1
GUICtrlSetState($Pic1, $GUI_DROPACCEPTED)
$Group2 = GUICtrlCreateGroup("图片格式转换", 8, 204, 145, 138)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
GUISetOnEvent(-3, "gui")
GUISetOnEvent(-4, "gui")
GUISetOnEvent(-5, "gui")
GUISetOnEvent($GUI_EVENT_DROPPED, "gui")
GUISetOnEvent(-7, "gui")
GUISetOnEvent(-8, "gui")
For $i = 1 To 3
 GUICtrlSetOnEvent($Button[$i], "gui")
 GUICtrlSetLimit($Slider[$i], 255, 0)
 GUICtrlSetData($Slider[$i], 55 + 100 * ($i - 1))
Next
HotKeySet("^f", "pickcolor")
While 1
 While $G_Switch
  _GDIPlus_Startup()
  $hPen = _GDIPlus_PenCreate(0xFFFF0000, $penwidth)
  $hGraphic = _GDIPlus_GraphicsCreateFromHWND($form[1])
  $MyHDC = DllCall("user32.dll", "int", "GetDC", "hwnd", $form[1])
  If @error Then ExitLoop
  $DeskHDC = DllCall("user32.dll", "int", "GetDC", "hwnd", 0)
  If @error Then ExitLoop
  While $G_Switch
   $coordinate = MouseGetPos()
   GUICtrlSetData($Label[1], $coordinate[0] & "," & $coordinate[1])
   $hexcolor = Hex(PixelGetColor($coordinate[0], $coordinate[1]), 6)
   GUICtrlSetData($Label[2], hextocolor($hexcolor))
   Sleep(20)
   DllCall("gdi32.dll", "int", "StretchBlt", "int", $MyHDC[0], "int", 1, "int", 1, "int", 135, "int", 135, "int", $DeskHDC[0], "int", _
     $coordinate[0] - $G_times, "int", $coordinate[1] - $G_times, "int", $G_times * 2 + 1, "int", $G_times * 2 + 1, "long", 0x00CC0020)
   _GDIPlus_GraphicsDrawLine($hGraphic, 1, 68, 136, 68, $hPen)
   _GDIPlus_GraphicsDrawLine($hGraphic, 68, 1, 68, 136, $hPen)
   Sleep(120)
  WEnd
  DllCall("user32.dll", "int", "ReleaseDC", "int", $DeskHDC[0], "hwnd", 0)
  DllCall("user32.dll", "int", "ReleaseDC", "int", $MyHDC[0], "hwnd", $form[1])
  _GDIPlus_GraphicsDispose($hGraphic)
  _GDIPlus_PenDispose($hPen)
  _GDIPlus_Shutdown()
 WEnd
 Sleep(100)
WEnd

Func GUI()
 Switch @GUI_CtrlId
  Case - 8
   AdlibUnRegister("setcolor1")
   AdlibUnRegister("setcolor2")
   AdlibUnRegister("setcolor3")
  Case - 7
   Local $focusID = ControlGetFocus($form[1])
   Switch $focusID
    Case 'SysListView321'
     If $focusID = 'SysListView321' Then
      Local $index = _GUICtrlListView_GetSelectedIndices($ListView1)
      If $index <> "" Then GUICtrlSetData($Input[1], _GUICtrlListView_GetItemText($ListView1, Int($index)))
     EndIf
    Case 'msctls_trackbar321'
     $_colorG = Hex(GUICtrlRead($Slider[2]), 2)
     $_colorB = Hex(GUICtrlRead($Slider[3]), 2)
     AdlibRegister("setcolor1", 80)
    Case 'msctls_trackbar322'
     $_colorR = Hex(GUICtrlRead($Slider[1]), 2)
     $_colorB = Hex(GUICtrlRead($Slider[3]), 2)
     AdlibRegister("setcolor2", 80)
    Case 'msctls_trackbar323'
     $_colorR = Hex(GUICtrlRead($Slider[1]), 2)
     $_colorG = Hex(GUICtrlRead($Slider[2]), 2)
     AdlibRegister("setcolor3", 80)
   EndSwitch
  Case - 3
   Exit
  Case - 4
   $Is_loop = $G_Switch
   $G_Switch = 0
  Case - 5
   If $Is_loop = 1 Then $G_Switch = 1
  Case $Button[1]
   Local $_hexcolor = colortohex()
   If Not $_hexcolor = "" Then
    GUICtrlSetData($Input[1], hextocolor($_hexcolor))
    If GUICtrlRead($checkbox) = 1 Then
     GUICtrlSetBkColor($Label[4], '0x' & $_hexcolor)
     Local $R = Dec(StringMid($_hexcolor, 1, 2))
     Local $G = Dec(StringMid($_hexcolor, 3, 2))
     Local $B = Dec(StringMid($_hexcolor, 5, 2))
     GUICtrlSetData($Slider[1], $R)
     GUICtrlSetData($Slider[2], $G)
     GUICtrlSetData($Slider[3], $B)
     GUICtrlSetData($Label[5], 'R:' & $R)
     GUICtrlSetData($Label[6], "G:" & $G)
     GUICtrlSetData($Label[7], 'B:' & $B)
    EndIf
   EndIf
  Case $Button[3]
   ClipPut(GUICtrlRead($Slider[1]) & ',' & GUICtrlRead($Slider[2]) & ',' & GUICtrlRead($Slider[3]))
  Case $GUI_EVENT_DROPPED
   _tranpicformat(@GUI_DragFile)
  Case $Combo1
   Switch GUICtrlRead($Combo1)
    Case "RGB"
     $colorFORMAT = 2
    Case 'RGB HEX'
     $colorFORMAT = 1
    Case 'HTML'
     $colorFORMAT = 3
    Case 'DELPHI'
     $colorFORMAT = 4
   EndSwitch
 EndSwitch
EndFunc   ;==>GUI

Func menu()
 Switch @GUI_CtrlId
  Case $fileitem1
   WinSetOnTop($form[1], "", 1)
  Case $fileitem2
   WinSetOnTop($form[1], "", 0)
  Case $fileitem3
   Exit
  Case $glassitem1
   $G_Switch = 1
  Case $glassitem2
   $G_Switch = 0
   GUICtrlSetBkColor($Graphic1, 0xFFFFFF)
   Sleep(500)
   GUICtrlSetBkColor($Graphic1, 0xFFFFFF)
  Case $glassitem3_1
   $G_times = 22
   pensetwidth()
  Case $glassitem3_2
   $G_times = 7
   pensetwidth()
  Case $glassitem3_3
   $G_times = 67
   pensetwidth()
  Case $glassitem4_1
   $pen_switch = 1
   pensetwidth()
  Case $glassitem4_2
   $pen_switch = 0
   $penwidth = 1
   _GDIPlus_PenDispose($hPen)
   $hPen = _GDIPlus_PenCreate(0xFFFF0000, 1)
  Case $picitem1
   GUISetState(@SW_HIDE, $form[1])
   Local $filearray, $i
   Local $file = FileOpenDialog("打开图像文件(可多选)", @MyDocumentsDir, "图片(*.BMP;*.JPG;*.PNG;*.GIF;*.TIFF;*.ICO)|所有文件(*.*)", 5)
   GUISetState(@SW_SHOW, $form[1])
   If StringInStr($file, "|") = 0 Then
    _tranpicformat($file)
   Else
    $filearray = StringSplit($file, "|")
    For $i = 1 To $filearray[0]
     _tranpicformat($filearray[$i])
    Next
   EndIf
  Case $picitem2
   $PicFormat = ".JPG"
  Case $picitem3
   $PicFormat = ".PNG"
  Case $picitem4
   $PicFormat = ".BMP"
  Case $picitem5
   $PicFormat = ".GIF"
  Case $lv_Menuitem1
   Local $index = _GUICtrlListView_GetSelectedIndices($ListView1)
   If $index <> "" Then ClipPut(_GUICtrlListView_GetItemText($ListView1, Int($index)))
  Case $lv_Menuitem2
   _GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($ListView1))
   FileDelete($tempfile)
  Case $lv_Menuitem3
   Local $index = _GUICtrlListView_GetSelectedIndices($ListView1)
   If $index <> "" Then _GUICtrlListView_DeleteItem(GUICtrlGetHandle($ListView1), Int($index))
  Case $hotkeyitem
   GUISetState(@SW_DISABLE, $form[1])
   $form[2] = GUICreate("设置热键", 153, 78, -1, -1)
   WinSetOnTop($form[2], "", 1)
   $Input[2] = GUICtrlCreateInput("", 88, 22, 30, 19)
   GUICtrlSetLimit(-1, 1)
   $Label[8] = GUICtrlCreateLabel("请输入数字或字母", 24, 4, 108, 16, $SS_CENTER)
   $Label[9] = GUICtrlCreateLabel("CTRL +", 40, 26, 44, 17)
   $Button[4] = GUICtrlCreateButton("确认", 12, 48, 50, 20, 0)
   GUICtrlSetOnEvent(-1, "children")
   $Button[5] = GUICtrlCreateButton("取消", 90, 48, 50, 20, 0)
   GUICtrlSetOnEvent(-1, "children")
   GUISetState(@SW_SHOW)
   GUISetOnEvent(-3, "children")
  Case $about
   GUISetState(@SW_DISABLE, $form[1])
   $form[0] = GUICreate("关于", 251, 161, -1, -1)
   WinSetOnTop($form[0], "", 1)
   GUISetOnEvent(-3, "children")
   $Label[0] = GUICtrlCreateLabel("", 16, 16, 220, 153)
   GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
   GUICtrlSetData(-1, "版本:1.3" & @CRLF & "作者:cnsnc" & @CRLF & "Q Q:462258375" & @CRLF _
      & @CRLF & @CRLF & @CRLF & @CRLF & @TAB & @TAB & '    2009-3-12')
   GUISetState(@SW_SHOW)
 EndSwitch
EndFunc   ;==>menu
Func children()
 Switch @GUI_CtrlId
  Case - 3
   GUISetState(@SW_ENABLE, $form[1])
   GUIDelete(@GUI_WinHandle)
  Case $Button[4]
   Local $hotkey = StringLower(GUICtrlRead($Input[2]))
   If StringRegExp($hotkey, "^[a-z0-9]$") Then
    HotKeySet("^" & $HotKeyused)
    HotKeySet("^" & $hotkey, "pickcolor")
    $HotKeyused = $hotkey
    GUISetState(@SW_ENABLE, $form[1])
    GUIDelete($form[2])
    GUICtrlSetData($hotkeymenu, "取色热键:CTRL+" & StringUpper($hotkey))
   Else
    MsgBox(48, "提示", "该热键无效")
   EndIf
  Case $Button[5]
   GUISetState(@SW_ENABLE, $form[1])
   GUIDelete($form[2])
 EndSwitch
EndFunc   ;==>children
Func pensetwidth()
 If $pen_switch = 1 Then
  $penwidth = 135 / ($G_times * 2 + 1)
  If $G_Switch = 1 Then
   _GDIPlus_PenDispose($hPen)
   $hPen = _GDIPlus_PenCreate(0xFFFF0000, $penwidth)
  EndIf
 EndIf
EndFunc   ;==>pensetwidth
Func pickcolor()
 Local $j, $i = 1
 Local $coord = MouseGetPos()
 Local $color = Hex(PixelGetColor($coord[0], $coord[1]), 6)
 $hImage = _GUIImageList_Create()
 If FileExists($tempfile) Then
  While 1
   $tempcolor = FileReadLine($tempfile, $i)
   If @error Then ExitLoop
   _GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($ListView1, $tempcolor, 16, 16))
   $i += 1
  WEnd
 EndIf
 _GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($ListView1, '0x' & $color, 16, 16))
 _GUICtrlListView_SetImageList($ListView1, $hImage, 1)
 $j = _GUICtrlListView_GetItemCount($ListView1)
 _GUICtrlListView_AddItem($ListView1, hextocolor($color), $i - 1)
 _GUICtrlListView_AddSubItem($ListView1, $j, $coord[0] & "," & $coord[1], 1)
 FileWriteLine($tempfile, '0x' & $color)
EndFunc   ;==>pickcolor

Func colortohex()
 Local $color_ = GUICtrlRead($Input[1]), $colorarray, $hexstring = ""
 Select
  Case StringRegExp($color_, "^/d{1,3},/d{1,3},/d{1,3}$") = 1
   $colorarray = StringSplit($color_, ",")
   If $colorarray[1] < 256 And $colorarray[2] < 256 And $colorarray[3] < 256 Then
    $hexstring = Hex($colorarray[1], 2) & Hex($colorarray[2], 2) & Hex($colorarray[3], 2)
   EndIf
  Case StringRegExp($color_, "^0x[a-f0-9A-F]{6}$") = 1
   $hexstring = StringTrimLeft($color_, 2)
  Case StringRegExp($color_, "^#[a-f0-9A-F]{6}$") = 1
   $hexstring = StringTrimLeft($color_, 1)
  Case StringRegExp($color_, "^/$00[a-f0-9A-F]{6}$") = 1
   $hexstring = StringMid($color_, 8, 2) & StringMid($color_, 6, 2) & StringMid($color_, 4, 2)
 EndSelect
 Return $hexstring
EndFunc   ;==>colortohex
Func hextocolor($hexstring)
 Local $colorstring = ""
 If StringRegExp($hexstring, "^[a-f0-9A-F]{6}$") Then
  Switch $colorFORMAT
   Case 1;rgbhex
    $colorstring = '0x' & $hexstring
   Case 2 ;rgb
    Local $color_R = StringMid($hexstring, 1, 2)
    Local $color_G = StringMid($hexstring, 3, 2)
    Local $color_B = StringMid($hexstring, 5, 2)
    $colorstring = Dec($color_R) & ',' & Dec($color_G) & ',' & Dec($color_B)
   Case 3 ;html
    $colorstring = '#' & $hexstring
   Case 4;delphi
    Local $color_R = StringMid($hexstring, 1, 2)
    Local $color_G = StringMid($hexstring, 3, 2)
    Local $color_B = StringMid($hexstring, 5, 2)
    $colorstring = '$00' & $color_B & $color_G & $color_R
  EndSwitch
 EndIf
 Return $colorstring
EndFunc   ;==>hextocolor

Func _tranpicformat($fullname)
 Local $trimname = StringRegExp($fullname, "(/w.+)/./w{3,4}$", 3)
 If IsArray($trimname) Then
  _GDIPlus_Startup()
  Local $hImage = _GDIPlus_ImageLoadFromFile($fullname)
  If @error Then
   MsgBox(48, '无法处理该文件', $fullname)
   Return 0
  EndIf
  _GDIPlus_ImageSaveToFile($hImage, $trimname[0] & @MIN & '-' & @SEC & $PicFormat)
  _GDIPlus_ImageDispose($hImage)
  _GDIPlus_Shutdown()
 EndIf
EndFunc   ;==>_tranpicformat
Func setcolor1()
 Local $colorR = GUICtrlRead($Slider[1])
 Local $BKcolor = "0x" & Hex($colorR, 2) & $_colorG & $_colorB
 GUICtrlSetBkColor($Label[4], $BKcolor)
 GUICtrlSetData($Label[5], 'R:' & $colorR)
EndFunc   ;==>setcolor1
Func setcolor2()
 Local $colorG = GUICtrlRead($Slider[2])
 Local $BKcolor = "0x" & $_colorR & Hex($colorG, 2) & $_colorB
 GUICtrlSetBkColor($Label[4], $BKcolor)
 GUICtrlSetData($Label[6], 'G:' & $colorG)
EndFunc   ;==>setcolor2
Func setcolor3()
 Local $colorB = GUICtrlRead($Slider[3])
 Local $BKcolor = "0x" & $_colorR & $_colorG & Hex($colorB, 2)
 GUICtrlSetBkColor($Label[4], $BKcolor)
 GUICtrlSetData($Label[7], 'B:' & $colorB)
EndFunc   ;==>setcolor3
Func Quit()
 FileDelete($tempfile)
 FileDelete($temppic)
EndFunc   ;==>Quit