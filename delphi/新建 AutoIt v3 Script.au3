#RequireAdmin
#Region ;**** 参数创建于 AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=D:\图标\3.ico
#AutoIt3Wrapper_outfile=vpn连接创建程序.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=宽带连接创建程序
#AutoIt3Wrapper_Res_Description=宽带连接创建程序
#AutoIt3Wrapper_Res_Fileversion=1.0.0.2
#AutoIt3Wrapper_Res_LegalCopyright=GCH
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
;#NoTrayIcon
Opt("WinWaitDelay", 100)
Opt("WinTitleMatchMode", 4)
Opt("WinDetectHiddenText", 1)
Opt("MouseCoordMode", 0)
Opt("WinSearchChildren", 1)
Opt("WinTextMatchMode", 2)

If WinExists("网络配置", "") Then
ProcessClose("rundll32.exe")
TrayTip("", "VPN连接已存在！", 15, 1)
Sleep(1000)
Exit
EndIf

Run("rundll32.exe netshell.dll,StartNCW")
WinWait("新建连接向导", "欢迎使用新建连接向导")
WinSetState("新建连接向导", "欢迎使用新建连接向导", @SW_SHOW)
ControlClick("[LAST]", "", 12324)
WinWait("新建连接向导", "连接到我的工作场所")
ControlClick("[LAST]", "", 22126)
ControlClick("[LAST]", "", 12324)
WinWait("新建连接向导", "虚拟专用网络连接")
ControlClick("[LAST]", "", 22119)
ControlClick("[LAST]", "", 12324)
WinWait("新建连接向导", "公司名")
ControlSetText("[LAST]", "", 1680, "gongsi")
ControlClick("[LAST]", "", 12324)
If winwait("新建连接向导", "不拨初始连接") then
ControlClick("[LAST]", "", 1509)
ControlClick("[LAST]", "", 12324)
EndIf
WinWait("新建连接向导", "输入您正连接的")
ControlSetText("[LAST]", "", 1433, "60.60.60.8")
ControlClick("[LAST]", "", 12324)
WinWait("新建连接向导", "在我的桌面上添加一个")
ControlClick("[LAST]", "", 21005)
ControlClick("[LAST]", "", 12325)
Sleep(500)
AdlibDisable()
WinWait("连接", "用户名")
ControlSetText("[LAST]", "", 1104, "zhou")
ControlSetText("[LAST]", "", 1103, "zhou")
ControlClick("[LAST]", "", 1101)
ControlClick("[LAST]", "", 1623)
ControlClick("[LAST]", "", 1590)
ProcessClose("rundll32.exe")
TrayTip("", "VPN连接已成功创建！", 15, 1)
Sleep(2000)
FileMove(@AppDataCommonDir & "\Microsoft\Network\Connections\Pbk\rasphone.pbk", @AppDataCommonDir & "\Microsoft\Network\Connections\Pbk\rasphone.ini", 9)
IniWrite(@AppDataCommonDir & "\Microsoft\Network\Connections\Pbk\rasphone.ini", "chinaunicom", "AuthRestrictions", "856")
Sleep(50)
FileMove(@AppDataCommonDir & "\Microsoft\Network\Connections\Pbk\rasphone.ini", @AppDataCommonDir & "\Microsoft\Network\Connections\Pbk\rasphone.pbk", 9)
RegWrite ('HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Cached',"{2559A1F4-21D7-11D4-BDAF-00C04F60B9F0} {000214E6-0000-0000-C000-000000000046} 0x401","REG_BINARY",'0000000031003000B0C5021CD0F3C801')
RegWrite ('HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Cached',"{2559A1F5-21D7-11D4-BDAF-00C04F60B9F0} {000214E6-0000-0000-C000-000000000046} 0x401","REG_BINARY",'00000000310030009C26241CD0F3C801')
Sleep(50)
Exit

