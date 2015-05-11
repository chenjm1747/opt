#Region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=..\..\ICO\full.ico
#PRE_Outfile=license.exe
#PRE_Compression=4
#PRE_UseX64=n
#PRE_Res_Comment=可以自动将本机的网卡地址替换.dat文件中的网卡地址。
#PRE_Res_Description=自动生成Proe License文件
#PRE_Res_Fileversion=1.0.3.9
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
	脚本功能:1.更改MAC地址为当前电脑的MAC地址
	2.自动变更.dat文件为licence.dat文件。
	
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿


#include <Array.au3>
#include <ACN_NET.au3>
#include <File.au3>
Local $FileList = _FileListToArray(@ScriptDir, "*.dat")
If @error = 1 Or @error = 4 Then
	TrayTip("提示", "文件夹下没有dat类型的文件！", 5, 1)
	Sleep(5000)
	Exit
EndIf
;_ArrayDisplay($FileList, "$FileList")
For $i = 1 To $FileList[0]
	update($i)
Next

Func update($i)
	$license = FileRead(@ScriptDir & "\" & $FileList[$i])
	If @error = 1 Then
		TrayTip("提示", "License文件读取出现错误！", 5, 1)
		Sleep(5000)
		Exit
	EndIf
	$mac = StringRegExp($license, "\w{2}-\w{2}-\w{2}-\w{2}-\w{2}-\w{2}", 1)
	If @error = 1 Then
		TrayTip("提示", "获取文件中的Mac地址失败！文件夹内可能存在其他类型的.dat文件。", 5, 1)
		Sleep(5000)
		Exit
	EndIf
	$macip = StringReplace(_API_Get_NetworkAdapterMAC(@IPAddress1), ":", "-")
	$num = _ReplaceStringInFile(@ScriptDir & "\" & $FileList[$i], $mac[0], $macip)
	If $num = -1 Then
		TrayTip("提示", "更新" & $FileList[$i] & "失败,请保证该文件是可写的！", 5, 1)
		Sleep(5000)
	Else
		TrayTip("提示", "更新" & $FileList[$i] & "文件成功，共替换了文件中" & $num & "处MAC地址" & @CRLF & "原文件中的MAC地址为：" & $mac[0] & @CRLF & "更改后的MAC地址为：" & $macip, 5)
		Sleep(5000)
	EndIf
EndFunc   ;==>update