#Region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=..\..\ICO\简约系统桌面图标下载26.ico
#PRE_Outfile=手机FTP连接.exe
#PRE_Compression=4
#PRE_Res_Description=打开WIFI远程管理的手机FTP站点
#PRE_Res_Fileversion=0.0.0.15
#PRE_Res_Fileversion_AutoIncrement=y
#PRE_Res_LegalCopyright=zaoki
#PRE_Res_requestedExecutionLevel=None
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
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
#include <FTPEx.au3>
#include <Process.au3>
;~ #Include <Array.au3>
HotKeySet("{ESC}", "tuichu")
Local $i, $Conn, $Open, $iniread ,$memory
Global $fa,$start,$end
$Open = _FTP_Open('手机FTP连接')
$iniread = IniRead(@ScriptDir & "\config.ini", "记忆FTP", "地址", "ftp://192.188.29.0:2121")
$start=IniRead(@ScriptDir & "\config.ini", "记忆FTP", "开始号段", 0)
$end=IniRead(@ScriptDir & "\config.ini", "记忆FTP", "结束号段", 256)
Local $array = StringSplit($iniread, ".")
$fa = $array[1] & "." & $array[2] & "." & $array[3] & "."
$memory=StringReplace($array[1],"ftp://","") & "." & $array[2] & "." & $array[3] & "." & StringReplace($array[4],":2121","")
;~ MsgBox(0,"",$memory)
Local $Conn = _FTP_Connect($Open, $memory, "", "", 0, "2121")
If @error <> 0 Then
	SetError(0)
	all()
Else
	_RunDOS("explorer " & $iniread)
EndIf

Func all()
	For $i = $start To $end
		Local $Conn = _FTP_Connect($Open, StringReplace($fa,"ftp://","") & $i, "", "", 0, "2121")
		If @error <> 0 Then
			SetError(0)
			TrayTip("连接（ID：" & $i & "）超时","正在尝试连接  " & $fa & $i+1 & ":2121", 5)
		Else			
			IniWrite(@ScriptDir & "\config.ini", "记忆FTP", "地址", $fa & $i & ":2121")
			IniWrite(@ScriptDir & "\config.ini", "记忆FTP", "开始号段", $start)
			IniWrite(@ScriptDir & "\config.ini", "记忆FTP", "结束号段", $end)
			_RunDOS("explorer " & $fa & $i & ":2121")
			Exit
		EndIf
	Next
	TrayTip("提示", "找不到可以连接的移动设备！", 5)
	Sleep(5000)
	Exit
EndFunc   ;==>all

Func tuichu()
	Exit
EndFunc   ;==>tuichu