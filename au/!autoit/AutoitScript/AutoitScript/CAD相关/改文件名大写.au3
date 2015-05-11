#Region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=..\..\ICO\简约系统桌面图标下载2.ico
#PRE_Outfile=改文件名大写.exe
#PRE_Compression=4
#PRE_UseX64=n
#PRE_Res_Comment=可以自动过滤非CAD文件
#PRE_Res_Description=将文件夹下的CAD文件名自动改为大写字母
#PRE_Res_Fileversion=0.0.0.13
#PRE_Res_Fileversion_AutoIncrement=y
#PRE_Res_LegalCopyright=chen
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

#include <File.au3>
#include <Array.au3>
Local $i, $uppername, $name,$memory
$memory=IniRead(@TempDir&"\改文件名大写.ini","记忆目录","目录",@DesktopCommonDir)
Local $caddir = FileSelectFolder("请选择一个文件夹", "", 2,$memory)
If @error Then Exit
IniWrite(@TempDir&"\改文件名大写.ini","记忆目录","目录",$caddir)
Local $FileList = _FileListToArray($caddir,"*.dwg")
If @error = 1 Or @error=4 Then
	MsgBox(4096, "", "没有找到CAD文件！")
	Exit
EndIf
;_ArrayDisplay($FileList, "$FileList")

For $i = 1 To $FileList[0]
	$name = StringTrimRight($FileList[$i],4)
	$uppername = StringUpper($name)
	FileMove($caddir & "\" & $FileList[$i], $caddir & "\" & $uppername & ".dwg", 9)
Next
TrayTip("提示", "更改成功！共计更改了"&$FileList[0]&"个文件。", 5)
Sleep(5000)