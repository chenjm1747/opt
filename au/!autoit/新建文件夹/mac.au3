#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_Icon=..\ico\34.ICO
#AutoIt3Wrapper_Outfile=D:\局域网查看工具.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Description=局域网查看工具
#AutoIt3Wrapper_Res_Fileversion=1.2.0.0
#AutoIt3Wrapper_Res_LegalCopyright=crwmart@163.com http://crwmart.blogbus.com
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <Process.au3>
#include <inet.au3>
#include <NetShare.au3>
#include <GuiListView.au3>
#include <GUIConstantsEx.au3>

#Region ### START Koda GUI section ### Form=
Local $Win = GUICreate("局域网查看工具v1.2", 500, 212, -1, 224)
Local $IPView = GUICtrlCreateListView("序|      计算机名   |   IP  地  址  |     MAC  地  址  ", 8, 8, 332, 170)
GUICtrlSetCursor(-1, 0)
Local $ShareView = GUICtrlCreateListView("序|       共享目录   ", 350, 8, 140, 170)
GUICtrlSetCursor(-1, 0)
Local $Label = GUICtrlCreateLabel("DvEeit.5d6d.com  crwmart      正在访问数据...", 8, 190, 332, 14)
GUICtrlSetColor(-1, 0x808080)
GUICtrlSetCursor(-1, 0)
Local $Button = GUICtrlCreateButton("刷新列表", 350, 185, 80, 20)
Local $Button1 = GUICtrlCreateButton("退出", 440, 185, 50, 20)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
_BackIPMACName()
While 1
 _GetPos()
 $nMsg = GUIGetMsg()
 Switch $nMsg
  Case $GUI_EVENT_CLOSE, $Button1
   Exit
  Case $Button
   GUICtrlSetData($Label, "DvEeit.5d6d.com  crwmart      正在访问数据...")
   _GUICtrlListView_DeleteAllItems($IPView)
   _GUICtrlListView_DeleteAllItems($ShareView)
   _BackIPMACName()
  Case $Label
   _RunDOS("start http://dvedit.5d6d.com")
 EndSwitch
WEnd

Func _BackIPMACName()
 Local $sNumber = 0, $sLine = 1, $sFile, $sNETIP, $s_IP, $BAT, $PCName
 _RunDOS("net view >" & @WindowsDir & "\temp\net.dat")
 TCPStartup();开始 TCP 服务
 $sFile = FileOpen(@WindowsDir & "\temp\net.dat", 0)
 While 1
  $sNETIP = FileReadLine($sFile, $sLine)
  If @error = -1 Then
   FileClose($sFile)
   FileDelete(@WindowsDir & "\temp\net.dat")
   ExitLoop
  EndIf
  If StringLeft($sNETIP, 2) = "\\" Then
   $PCName = StringTrimLeft(StringStripWS($sNETIP, 2), 2)
   $s_IP = TCPNameToIP($PCName)
   If $s_IP <> "" Then
    $sNumber += 1
    GUICtrlCreateListViewItem($sNumber & "-|" & $PCName & "|" & $s_IP & "|" & _GetMAC($s_IP), $IPView)
   EndIf
  EndIf
  $sLine += 1
 WEnd
 If $sNumber <> 0 Then
  _GUICtrlListView_ClickItem($IPView, 0, "left", False, 1)
  $sShareDir = StringSplit(GUICtrlRead(GUICtrlRead($IPView)), "|", 1)
  _Get_Share($sShareDir[2])
  GUICtrlSetData($Label, "DvEeit.5d6d.com  crwmart      数据刷新完毕...")
 EndIf
 TCPShutdown();关闭 TCP/UDP 服务
EndFunc   ;==>_BackIPMACName

Func _GetMAC($sIP)
 Local $MAC, $MACSize, $i, $s, $r, $iIP
 $MAC = DllStructCreate("byte[6]")
 $MACSize = DllStructCreate("int")
 DllStructSetData($MACSize, 1, 6)
 $r = DllCall("Ws2_32.dll", "int", "inet_addr", "str", $sIP)
 $iIP = $r[0]
 $r = DllCall("iphlpapi.dll", "int", "SendARP", "int", $iIP, "int", 0, "ptr", DllStructGetPtr($MAC), "ptr", DllStructGetPtr($MACSize))
 $s = ""
 For $i = 0 To 5
  If $i Then $s = $s & ":"
  $s = $s & Hex(DllStructGetData($MAC, 1, $i + 1), 2)
 Next
 Return $s
EndFunc   ;==>_GetMAC

Func _Get_Share($PCName);$s_IP = ""为检测本机共享文件
 Local $sShare, $sLine = 1, $sFile, $sShare, $sNumber = 0
 _RunDOS("net view " & $PCName & ">" & @WindowsDir & "\temp\net.dat")
 $sFile = FileOpen(@WindowsDir & "\temp\net.dat", 0)
 While 1
  $sShare = FileReadLine($sFile, $sLine)
  If @error = -1 Then
   FileClose($sFile)
   FileDelete(@WindowsDir & "\temp\net.dat")
   ExitLoop
  EndIf
  If $sShare <> "" And StringInStr($sShare, "共享资源") = 0 And StringInStr($sShare, "注释") = 0 And StringInStr($sShare, "命令") = 0 And StringInStr($sShare, "--") = 0 Then
   $sShare = StringSplit($sShare, " ", 1)
   $sNumber += 1
   GUICtrlCreateListViewItem(GUICtrlRead($IPView) & "." & $sNumber & "|" & $sShare[1], $ShareView)
  EndIf
  $sLine += 1
 WEnd
EndFunc   ;==>_Get_Share

Func _GetPos()
 Local $sShareIP, $sSplit, $nDrive, $sDrive, $sShareDir
 $a = GUIGetCursorInfo($Win)
 If GUICtrlRead($IPView) <> 0 And $a[2] = 1 And $a[4] = $IPView Then
  _GUICtrlListView_DeleteAllItems($ShareView)
  $sShareDir = StringSplit(GUICtrlRead(GUICtrlRead($IPView)), "|", 1)
  _Get_Share($sShareDir[2])
 ElseIf GUICtrlRead($IPView) <> 0 And $a[3] = 1 And $a[4] = $IPView Then
  $sShareDir = StringSplit(GUICtrlRead(GUICtrlRead($IPView)), "|", 1)
  ShellExecute("\\" & $sShareDir[3])
 ElseIf GUICtrlRead($ShareView) <> 0 And $a[2] = 1 And $a[4] = $ShareView Then
  $sShareDir = StringSplit(GUICtrlRead(GUICtrlRead($ShareView)), "|", 1)
  $sSplit = StringSplit($sShareDir[1], ".", 1)
  $sShareIP = StringSplit(GUICtrlRead($sSplit[1]), "|", 1)
  ShellExecute("\\" & $sShareIP[3] & "\" & $sShareDir[2])
 ElseIf GUICtrlRead($ShareView) <> 0 And $a[3] = 1 And $a[4] = $ShareView Then
  $sDrive = DriveGetDrive("all")
  If Not @error Then
   For $i = 67 To 90
    If $sDrive[$sDrive[0]] = Chr($i) & ":" Then 
    $nDrive = Chr($i + 1)
    ExitLoop
    EndIf
   Next
  EndIf
  $sShareDir = StringSplit(GUICtrlRead(GUICtrlRead($ShareView)), "|", 1)
  $sSplit = StringSplit($sShareDir[1], ".", 1)
  $sShareIP = StringSplit(GUICtrlRead($sSplit[1]), "|", 1)
  MsgBox(1, "映射驱动器", "  您确定映射该目录到本地驱动器吗?  ")
  Select
   Case 6
    DriveMapAdd($nDrive & ":", "\\" & $sShareIP[3] & "\" & $sShareDir[2])
  EndSelect
 EndIf
EndFunc   ;==>_GetPos
