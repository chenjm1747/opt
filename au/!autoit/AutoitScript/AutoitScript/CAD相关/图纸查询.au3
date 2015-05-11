#region ACN预处理程序参数(常用参数)
#PRE_Icon= 										;图标,支持EXE,DLL,ICO
#PRE_OutFile=									;输出文件名
#PRE_OutFile_Type=exe							;文件类型
#PRE_Compression=4								;压缩等级
#PRE_UseUpx=y 									;使用压缩
#PRE_Res_Comment= 								;程序注释
#PRE_Res_Description=							;详细信息
#PRE_Res_Fileversion=							;文件版本
#PRE_Res_FileVersion_AutoIncrement=p			;自动更新版本
#PRE_Res_LegalCopyright= 						;版权
#PRE_Change2CUI=N                   			;修改输出的程序为CUI(控制台程序)
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
#include <String.au3>

$file = FileOpenDialog("请选择需要查询的图纸", "", "CAD文件 (*.dwg)")
If @error Then Exit

Dim $szDrive, $szDir, $szFName, $szExt
_PathSplit($file, $szDrive, $szDir, $szFName, $szExt)

If StringLeft($szFName, 1) = "F" Then
	$filename = _StringInsert($szFName, ".", 4)
	$filename = _StringInsert($filename, ".", 8)
Else
	$filename = _StringInsert($szFName, ".", 3)
	$filename = _StringInsert($filename, ".", 7)
EndIf
$filename = StringUpper($filename)
;~ MsgBox(0,"",$filename)

Run("C:\Program Files (x86)\软件图纸查询系统\图纸软件档案检索系统.exe")
;~ WinWait("登录窗口")
;~ While WinExists("登录窗口") 
;~ 	ControlClick("登录窗口", "", 4)
;~ 	Sleep(500)
;~ WEnd
WinWait("图纸软件档案检索系统V2.0", "")
ControlCommand("图纸软件档案检索系统V2.0", "", 27, "Check", "")
ControlSetText("图纸软件档案检索系统V2.0", "", 28, $filename)
ControlClick("图纸软件档案检索系统V2.0", "", 21)