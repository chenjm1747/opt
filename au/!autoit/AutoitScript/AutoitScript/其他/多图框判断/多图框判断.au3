#region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=..\ico\0 (2).ico
#PRE_Outfile=AutoCAD to PDF_打印方式.exe
#PRE_Outfile_x64=cadtopdf.exe
#PRE_Compression=4
#PRE_Res_Fileversion=0.0.0.38
#PRE_Res_Fileversion_AutoIncrement=p
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
	
	Au3 版本:3.3.2
	脚本作者:chen
	电子邮件:chen2j@qq.com
	QQ/TM:361995143
	脚本版本:0.0.0.37
	脚本功能:
	11.19日增加：可以根据边框黄色，白色和红色来判断图纸大小。但会稍微增加延迟时间。
	
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#include <Array.au3>
Local $flag
Local $filename, $i
Global $single, $spit
HotKeySet("{ESC}", "esc") ;---------------------------------------------------------------------------------------ESC退出
AutoItSetOption("SendKeyDelay", 50) ;---------------------------------------------------------------------------------------设置输入文本的间隔时间，时间太快会导致输入错误，无法选择PDF保存文件夹
$pdfoutdir = @DesktopCommonDir & "\PDF_OUT"
If Not FileExists($pdfoutdir) Then DirCreate($pdfoutdir)
Global $flag = 0 ;---------------------------------------------------------------------------------------图纸为A3则flag=1；图纸为A4则flag=0
ShellExecute(@ScriptDir & "\wait.au3") ;弹窗判断脚本，会自动隐藏。
$filename = FileOpenDialog("请选择需要转换的CAD文件", "", "图形 (*.dwg)", 4) ;弹出选择文件对话框
If @error Then Exit ;如果没有选择或选择错误，则退出
$spit = StringSplit($filename, "|") ;分割文件变成数组
If @error Then
	$single = $filename ;说明选择的是单个文件
	CADtoPDF($single)
Else
	For $i = 2 To $spit[0] ;一个一个的转换PDF，直到结束。
		$single = $spit[1] & "\" & $spit[$i]
		CADtoPDF($single)
	Next
EndIf
Func CADtoPDF($single) ;自定义函数。
	Local $PID = ProcessExists("acad.exe") ;检测CAD是否已经在运行。
	If $PID Then ProcessClose($PID) ;如果存在则终止进程
	ShellExecute($single) ;运行文件,最大化无效
	MouseMove(0, 0)
	WinWait("AutoCAD 2011", "正在重生成模型") ;等待AutoCAD加载完成
	WinSetState("AutoCAD 2011", "正在重生成模型", @SW_MAXIMIZE) ;最大化CAD窗口
	;	ControlSend("AutoCAD 2011", "", 2, "z e ") ;使页面最大化
	WinActivate("AutoCAD 2011", "正在重生成模型")
	WinWaitActive("AutoCAD 2011", "正在重生成模型")
	$bing = biankuang()
;	_ArrayDisplay($bing)
	ControlSend("AutoCAD 2011", "", 2, "pagesetup ") ;并打开页面设置管理器
	WinWait("页面设置管理器") ;暂停直到打开页面设置管理器
	ControlSend("页面设置管理器", "", 4696, "!m") ;按“ALT+M”
	WinWait("页面设置 - 模型") ;暂停直到打开页面设置 - 模型
	ControlCommand("页面设置 - 模型", "", 1020, "SetCurrentSelection", 4) ;设置打印机为“Adobe PDF”
	If $flag = 1 Then
		ControlCommand("页面设置 - 模型", "", 1040, "SelectString", 'A3') ;设置图纸尺寸为“A3”
		ControlCommand("页面设置 - 模型", "", 1037, "Check", "") ;设置图形方形为“横向”，匹配A3
	Else
		ControlCommand("页面设置 - 模型", "", 1040, "SelectString", 'A4') ;设置图纸尺寸为“A4”
		ControlCommand("页面设置 - 模型", "", 1036, "Check", "") ;设置图形方形为“纵向”，匹配A4
	EndIf
	ControlCommand("页面设置 - 模型", "", 1043, "SelectString", '窗口') ;设置打印范围为“范围”
	If WinExists("页面设置 - 模型") Then ControlClick("页面设置 - 模型", "", 1061)
	MouseClick("left", $bing[1], $bing[2])
	MouseClick("left", $bing[3], $bing[4])
	
	ControlCommand("页面设置 - 模型", "", 1030, "UnCheck", "") ;设置按打印样式打印为“否”
	ControlCommand("页面设置 - 模型", "", 1030, "Check", "") ;设置按打印样式打印为“是”---防止没有勾上“打印对象线宽”
	ControlCommand("页面设置 - 模型", "", "[CLASS:Button; INSTANCE:20]", "Check", "") ;勾上“布满图纸”
	ControlCommand("页面设置 - 模型", "", 1006, "SelectString", 'monochrome') ;设置打印样式表为mochrome.ctb-----未解决弹窗问题
	ControlClick("页面设置 - 模型", "", 1) ;关闭页面设置
	WinWaitClose("页面设置 - 模型") ;等待关闭页面设置
	ControlClick("页面设置管理器", "", 2) ;关闭页面设置管理器
	While WinExists("页面设置管理器")
		ControlClick("页面设置管理器", "", 2) ;关闭页面设置管理器
		Sleep(100)
	WEnd
	WinActivate("AutoCAD 2011", "正在重生成模型")
	WinWaitActive("AutoCAD 2011", "正在重生成模型")
	ControlSend("AutoCAD 2011", "", 2, "^p") ;打开打印对话框
	While Not WinExists("打印 - 模型")
		ControlSend("AutoCAD 2011", "", 2, "^p")
		Sleep(500)
	WEnd ;有时候开不开打印窗口，做一个循环检测。
	ControlClick("打印 - 模型", "", 1) ;关闭"打印 - 模型"
	WinWaitClose("打印 - 模型")
	WinWait("另存 PDF 文件为") ;暂停直到打开“另存 PDF 文件为”
	WinActivate("另存 PDF 文件为")
	WinWaitActive("另存 PDF 文件为")
	Local $time = @YEAR & @MON & @MDAY & @HOUR & @MIN & @SEC
	ControlSend("另存 PDF 文件为", "", 1001, $pdfoutdir & "\" & $time) ;输入文件名称为日期时间
	ControlSend("另存 PDF 文件为", "", 1, "^s")
	WinWait($time) ;暂停直到打开“Adobe Acrobat Pro”
	Sleep(500)
	;-------------------------------------------------------------------------如果是A3则逆时针旋转90度。
	If $flag = 1 Then
		ControlSend($time, "", "[CLASS:AVL_AVView; INSTANCE:16]", "^+R")
		While Not WinExists("旋转页面")
			ControlSend($time, "", "[CLASS:AVL_AVView; INSTANCE:16]", "^+R")
			Sleep(100)
		WEnd
		ControlCommand("旋转页面", "", "[CLASS:ComboBox; INSTANCE:1]", "SetCurrentSelection", 0)
		ControlClick("旋转页面", "", "[CLASS:Button; INSTANCE:5]") ;关闭"打印 - 模型"
		WinWaitClose("旋转页面")
		ControlSend($time, "", "[CLASS:AVL_AVView; INSTANCE:16]", "^s")
	EndIf
	;-------------------------------------------------------------------------如果是A3则逆时针旋转90度。
	WinClose($time) ;关闭“Adobe Acrobat Pro”
	WinWaitClose($time)
	If WinExists("打印 - 模型") Then WinClose("打印 - 模型") ;有时候会出现这个窗口未关闭，导致脚本暂停。
	ControlSend("AutoCAD 2011", "", 2, "^s") ;保存CAD
	WinClose("AutoCAD 2011") ;关闭CAD
	WinWaitClose("AutoCAD 2011")
EndFunc   ;==>CADtoPDF

Func esc()
	Exit
EndFunc   ;==>esc

Func A3()
	;--------------------------------------------------------------------------------------------根据窗口大小判断是否A3还是A4
	Local $array = ControlGetPos("AutoCAD 2011", "", 59648)
	Local $xpos = (($array[3] - 26) * 420 / 297 + $array[2]) / 2 + $array[0]
	Local $se1 = 0
	Local $se2 = 0
	Local $se3 = 0
	PixelSearch($xpos - 150, $array[1] + 100, $xpos + 50, $array[1] + 150, 0xFFFF00, 20);黄色
	If @error Then
		SetError(0)
	Else
		$se1 = 1
	EndIf
	PixelSearch($xpos - 150, $array[1] + 100, $xpos + 50, $array[1] + 150, 0xFF0000, 20);红色
	If @error Then
		SetError(0)
	Else
		$se2 = 1
	EndIf
	PixelSearch($xpos - 150, $array[1] + 100, $xpos + 50, $array[1] + 150, 0xFFFFFF, 20);白色
	If @error Then
		SetError(0)
	Else
		$se3 = 1
	EndIf
	If $se1 Or $se2 Or $se3 Then $flag = 1
	;--------------------------------------------------------------------------------------------根据窗口大小判断是否A3还是A4
EndFunc   ;==>A3

Func biankuang()
	Local $array = ControlGetPos("AutoCAD 2011", "", 59648)
	Local $x, $y
	For $x = $array[0] + 10 To $array[0] + $array[2] - 60 Step 50
		For $y = $array[1] + 5 To $array[1] + $array[3] - 80 Step 50
			If PixelChecksum($x, $y, $x + 50, $y + 50) <> 1019006366 Then
				ExitLoop (2)
			EndIf
		Next
	Next
	
	Local $x1, $y1, $pos[5]
	For $x1 = $x To $x + 50
		For $y1 = $y To $y + 50
			If PixelGetColor($x1, $y1) <> 0x212830 Then
				MsgBox(0, "", "找到顶部坐标为" & $x1 & "," & $y1)
				$pos[1] = $x1
				$pos[2] = $y1
				ExitLoop (2)
			EndIf
		Next
	Next
	
	For $x2 = $x1 To $x1 + $array[2]
		If PixelGetColor($x2, $y1) = 0x212830 Then
			$pos[3] = $x2 - 1
			ExitLoop
		EndIf
	Next
	
	For $y2 = $y1 To $y1 + $array[3]
		If PixelGetColor($pos[3], $y2) = 0x212830 Then
			$pos[4] = $y2 - 1
			ExitLoop
		EndIf
	Next
	Return $pos
EndFunc   ;==>biankuang