#include <MsgBoxConstants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GUIListBox.au3>
#include <array.au3>
#include <ie.au3>
#include <MsgBoxConstants.au3>
#include <ScreenCapture.au3>
#include <WindowsConstants.au3>
$sFilePath = @TempDir & "\FileRead.txt"
$stuiguangchengxu= @ScriptDir&"\58推广程序.au3"
$stuiguangchengxusave= @ScriptDir&"\58推广程序.au3.save"
Local $oIE = _IECreateEmbedded()
GUICreate("批量生成推广程序", @DesktopWidth, @DesktopHeight, 0, 0, _
        $WS_OVERLAPPEDWINDOW + $WS_CLIPSIBLINGS + $WS_CLIPCHILDREN)
GUICtrlCreateObj($oIE, 0, 20, @DesktopWidth, @DesktopHeight)

Global $g_idError_Message = GUICtrlCreateLabel("", 100, 500, 500, 30)
GUICtrlSetColor(-1, 0xff0000)
GUISetState(@SW_SHOW) ;Show GUI
InetGet("http://dx.caiwuhao.com:3000/azufangs.json", $sFilePath, 1)
Local $hFileOpen = FileOpen($sFilePath, 0)
If $hFileOpen = -1 Then
    MsgBox(0, "", "无法获取服务器参数。检查网络")
    Return False
EndIf
$json = FileRead($hFileOpen)
FileClose($hFileOpen)
FileDelete($sFilePath)
$aArray = StringRegExp($json, '(\d+).json"}]', 1)
$zufangcount=$aarray[0]
ConsoleWrite ($zufangcount)
For $i = $zufangcount To 1 Step -1
;循环
   InetGet("http://dx.caiwuhao.com:3000/azufangs/"&$i&".json", $sFilePath, 1)
   Local $hFileOpen = FileOpen($stuiguangchengxu, 0)
   Local $hFilewrite = FileOpen($stuiguangchengxusave, 2)
   If $hFileOpen = -1 or  $hFilewrite= -1 Then
	   MsgBox(0, "", "An error occurred when reading the file.")
	   Return False
   EndIf
   $au3file = FileRead($hFileOpen)
   $au3file=StringReplace($au3file,"""$replace""",""""&$i&"""")
   FileWrite($hFilewrite, $au3file)
   FileClose($hFileOpen)
   FileClose($hFilewrite)
   Runwait('"C:\Program Files (x86)\AutoIt3\Aut2Exe/aut2exe.exe" /in "C:\Users\aonti_000\SkyDrive\autoit自制程序\58推广程序.au3.save" /out d:\1a\'&$i&'.exe')
next
   Runwait(@ScriptDir&'/upx.exe -9 d:\1a\*')