#region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_icon=SVN提交.exe|-1
#PRE_Outfile=SVN提交.exe
#PRE_Compression=4
#PRE_Res_Description=SVN自动提交更新
#PRE_Res_Fileversion=1.0.0.19
#PRE_Res_Fileversion_AutoIncrement=y
#PRE_Res_requestedExecutionLevel=None
#endregion ;**** 参数创建于 ACNWrapper_GUI ****
#region ACN预处理程序参数(常用参数)
;#PRE_Res_Field=AutoIt Version|%AutoItVer%		;自定义资源段
;#PRE_Run_Tidy=                   				;脚本整理
;#PRE_Run_Obfuscator=      						;代码迷惑
;#PRE_Run_AU3Check= 							;语法检查
;#PRE_Run_Before= 								;运行前
;#PRE_Run_After=								;运行后
;#PRE_UseX64=n									;使用64位解释器
;#PRE_Compile_Both								;进行双平台编译
#endregion ACN预处理程序参数(常用参数)
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	
	Au3 版本:
	脚本作者:
	电子邮件:
	QQ/TM:
	脚本版本:
	脚本功能:
	
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

#include <Process.au3>
Opt("WinTitleMatchMode", 2)
Opt("SendKeyDelay", 50)
AdlibRegister("_Quit", 1000 * 60) ;This is only for testing, so if anything go wrong, the script will exit after 1 seconds.
Global $path = IniRead("SVN-Config.ini", "SVN信息", "地址", "error")
Global $goagent = IniRead("SVN-Config.ini", "SVN信息", "打开代理", "No")
Global $flag = IniRead(@TempDir & "\SVN-Config.ini", "SVN信息", "代理状态", "Unkown")
If $goagent = "Unkown" Or $goagent <> $flag Then daili() ;如果ini设置了使用代理，则给我打开代理！
commit()

Func daili()
	Local $SVNpath = @ProgramFilesDir & "\TortoiseSVN\bin\TortoiseProc.exe"
	Local $sCommand = "TortoiseProc.exe /command:settings /path:" & $SVNpath & " /closeonend:2"
	Run(@ComSpec & " /c " & $sCommand, "", @SW_HIDE)
	WinWait(" - TortoiseSVN")
	WinActivate(" - TortoiseSVN")
	Sleep(500)
	While Not WinExists(" - TortoiseSVN", "代理服务器设置")
		Send("^{TAB}")
		Sleep(100)
	WEnd
;~ 	Local $WinPosArray = WinGetPos(" - TortoiseSVN")
;~ 	Local $TNewCheckListBoxArray = ControlGetPos(" - TortoiseSVN", "", 32494)
;~ 	Local $Width = $WinPosArray[0] + $TNewCheckListBoxArray[0]
;~ 	Local $Height = $WinPosArray[1] + $TNewCheckListBoxArray[1]
;~ 	MouseClick("left", $Width + 50, $Height + 170)
;~ 	Send("^{TAB 8}")
;~ 	Sleep(500)
	If $goagent = "Yes" Then
		ControlCommand(" - TortoiseSVN", "", "[CLASS:Button; INSTANCE:1]", "Check", "")
		IniWrite(@TempDir & "\SVN-Config.ini", "SVN信息", "代理状态", "Yes")
	ElseIf $goagent = "No" Then
		ControlCommand(" - TortoiseSVN", "", "[CLASS:Button; INSTANCE:1]", "unCheck", "")
		IniWrite(@TempDir & "\SVN-Config.ini", "SVN信息", "代理状态", "No")
	Else
		TrayTip("警告！", "打开代理请选择“Yes”或“No”这两个值，其他值无效！", 3000)
		Sleep(3000)
	EndIf
	ControlClick(" - TortoiseSVN", "", 1)
EndFunc   ;==>daili

Func commit()
	Local $sCommand = "TortoiseProc.exe /command:commit /path:" & $path & " /closeonend:3"
	Run(@ComSpec & " /c " & $sCommand, "", @SW_HIDE)
	WinWait($path)
	WinActivate($path)
	ControlClick($path,"",1505)
 	Send("!a")
	If ControlCommand($path, "", 1, "IsEnabled", "") Then
		ControlClick($path, "", 1)
	Else
		WinClose($path)
	EndIf
EndFunc   ;==>commit

Func update()
	If IniRead("SVN-Config.ini", "SVN更新", "打开文件夹", "error") = "Yes" Then ShellExecute($path, "", "", "", @SW_MAXIMIZE) ;如果需要打开SVN文件夹，请打开这一行！
	Local $sCommand = "TortoiseProc.exe /command:update /path:" & $path & " /closeonend:2"
	_RunDOS($sCommand)
EndFunc   ;==>update

Func _Quit()
	TrayTip("提示", "程序已经运行1分钟了，即将自动退出！", 3000)
	Sleep(3000)
	Exit
EndFunc   ;==>_Quit