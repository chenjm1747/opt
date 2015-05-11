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
#include <Array.au3>

$filename = FileOpenDialog("请选择需要查询的图纸", "", "图形 (*.dwg)", 4)
$spit = StringSplit($filename, "|") ;分割文件变成数组
Global $flag[100]
Local $i
Global $count = 1
$flag[0] = 0

If @error Then
	zhunbei()
	$single = $filename ;说明选择的是单个文件
	chaxun($single)
	$spit[0] = 2
Else
	zhunbei()
	For $i = 2 To $spit[0] ;一个一个的转换PDF，直到结束。
		$single = $spit[1] & "\" & $spit[$i]
		chaxun($single)
	Next
EndIf

If $flag[0] = 0 Then
	TrayTip("提示", "检查完成，没有发现文件号冲突！", 5)
	Sleep(5000)
Else
	_ArrayDisplay($flag, "冲突图号列表")
EndIf

WinClose("图纸软件档案检索系统V2.0", "")


Func zhunbei()
	If ProcessExists("图纸软件档案检索系统.exe") Then ProcessClose("图纸软件档案检索系统.exe")
	Run("C:\Program Files (x86)\软件图纸查询系统\图纸软件档案检索系统.exe")
	WinWait("图纸软件档案检索系统V2.0", "")
	ControlCommand("图纸软件档案检索系统V2.0", "", 27, "Check", "")
EndFunc   ;==>zhunbei

Func chaxun($file)
	Local $szDrive, $szDir, $szFName, $szExt
	_PathSplit($file, $szDrive, $szDir, $szFName, $szExt)
	$filename = _StringInsert($szFName, ".", 3)
	$filename = _StringInsert($filename, ".", 7)
	$filename = StringUpper($filename)
	
	ControlSetText("图纸软件档案检索系统V2.0", "", 28, $filename)
	ControlClick("图纸软件档案检索系统V2.0", "", 21)
	Sleep(500)
	ControlClick("图纸软件档案检索系统V2.0", "", 6)
	Sleep(500)
	
	WinWait("详细信息","导入信息")
	If WinExists("详细信息",".dwg") Then
		$flag[0] = 1
		$flag[$count] = $filename & ".dwg"
		$count = $count + 1
	EndIf
	WinClose("详细信息","导入信息")

EndFunc   ;==>chaxun