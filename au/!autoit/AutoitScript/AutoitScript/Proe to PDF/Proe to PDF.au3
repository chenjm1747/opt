#Region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=..\..\ICO\简约系统桌面图标下载16.ico
#PRE_Outfile=Proe to PDF.exe
#PRE_Compression=4
#PRE_Res_Comment=Proe to cad to pdf全自动
#PRE_Res_Description=可以将Proe转换完成的CAD文件自动改格式，并自动批量转换成PDF文件。
#PRE_Res_Fileversion=2.8.3.81
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
	
	Au3 版本:3.3.2
	脚本作者:chen
	电子邮件:chen2j@qq.com
	QQ/TM:361995143
	脚本版本:0.0.0.37
	脚本功能:
	11.19日增加：可以根据边框黄色，白色和红色来判断图纸大小。但会稍微增加延迟时间。
	
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#include <File.au3>
#include <WinAPIEx.au3>
Local $filename, $i, $nextcindex, $single, $spit
Local $log[5]
Global $print = 0
HotKeySet("{ESC}", "esc") ;---------------------------------------------------------------------------------------ESC退出
HotKeySet("^1", "printyes") ;---------------------------------------------------------------------------------------pdf打印模式
HotKeySet("^2", "printno") ;---------------------------------------------------------------------------------------PDF转换模式

Local $my_Version = "proetopdf_zaoki.com"
AutoItWinSetTitle($my_Version) ;写入文件标题，供弹窗点击程序识别。

SendKeepActive("AutoCAD 2011")

FileInstall("PopupWindowClick.exe", @TempDir & "\PopupWindowClick.exe", 1)
ShellExecute(@TempDir & "\PopupWindowClick.exe") ;弹窗点击程序，会自动隐藏。

$filename = FileOpenDialog("请选择需要转换的CAD文件", "", "图形 (*.dwg)", 4) ;弹出选择文件对话框
If @error Then Exit ;如果没有选择或选择错误，则退出

Local $hTimer = TimerInit() ; 开始计时

$spit = StringSplit($filename, "|") ;分割文件变成数组
If @error Then
	$single = $filename ;说明选择的是单个文件
	If FileExists(StringReplace($single, ".dwg", "_dwg__out.log") & ".?") Then
		$nextcindex = ProetoCad($single)
	Else
		$nextcindex = $single
	EndIf
	CADtoPDF($nextcindex)
	$spit[0] = 2
Else
	For $i = 2 To $spit[0] ;一个一个的转换PDF，直到结束。
		$single = $spit[1] & "\" & $spit[$i]
		If FileExists(StringReplace($single, ".dwg", "_dwg__out.log.1")) Then
			$nextcindex = ProetoCad($single)
		Else
			$nextcindex = $single
		EndIf
		CADtoPDF($nextcindex)
		TrayTip("提示", "共有" & $spit[0] - 1 & "个文件需要转换，已完成第" & $i - 1 & "个文件。", 5)
	Next
EndIf
TrayTip("提示", "转换成功！共计转换了" & $spit[0] - 1 & "个文件，用时" & jishi(TimerDiff($hTimer)) & "。", 5)
_PathSplit($single, $log[1], $log[2], $log[3], $log[4])
FileRecycle($log[1] & $log[2] & "plot.log")
ControlSend("Program Manager", "", 1, "{F5}") ;~ 	刷新桌面
Sleep(5000)

Func ProetoCad($single) ;自定义函数。
	Local $PID = ProcessExists("acad.exe") ;检测CAD是否已经在运行。
	If $PID Then ProcessClose($PID) ;如果存在则终止进程
	ShellExecute($single) ;运行文件
	MouseMove(0, 0)
	WinWait("AutoCAD 2011", "正在重生成模型") ;等待AutoCAD加载完成
	WinSetState("AutoCAD 2011", "正在重生成模型", @SW_MAXIMIZE)
	ControlClick("快速选择", "", 1) ;关闭页面设置
	WinWaitClose("快速选择") ;等待关闭页面设置
	WinMenuSelectItem("AutoCAD 2011", "", "文件", "图形实用工具", "清理") ;调用清理
	WinWait("清理") ;等待出现清理窗口
	ControlClick("清理", "", 1031) ;关闭页面设置
	WinWait("清理 - 确认清理") ;等待出现清理确认窗口
	Send("!a") ;确定
	ControlClick("清理", "", 1) ;关闭清理
	While WinExists("清理")
		ControlClick("清理", "", 1) ;关闭清理
	WEnd
	ControlSend("AutoCAD 2011", "", 2, "proe{enter}") ;调用PROE
;~ 		WinMenuSelectItem("AutoCAD 2011", "", "工具", "动作录制器","播放","proe")
	WinWait("Layer") ;暂停直到打开页面设置管理器
	WinClose("Layer")
	While WinExists("Layer", "反转过滤器(&I)")
		WinClose("Layer", "反转过滤器(&I)") ;关闭清理
	WEnd
	WinMenuSelectItem("AutoCAD 2011", "", "视图", "缩放", "范围") ;使页面最大化并打开页面设置管理器
	WinMenuSelectItem("AutoCAD 2011", "", "工具", "快速选择")
	WinWait("快速选择")
	ControlCommand("快速选择", "", 1011, "SelectString", '线型')
	ControlCommand("快速选择", "", 1023, "SelectString", 'center')
	ControlCommand("快速选择", "", 1013, "Check", "")
	ControlCommand("快速选择", "", 1036, "Check", "")
	ControlClick("快速选择", "", 1) ;关闭页面设置
	WinWaitClose("快速选择") ;等待关闭页面设置
	ControlSend("AutoCAD 2011", "", 2, "chprop{enter}")
	
;~ 开始判断前面是不是选择了什么东西
	While 1
		Local $xuanze = 0
		If WinExists("AutoCAD 2011", "选择对象") Then
			$xuanze = 10
			ExitLoop
		EndIf
		If WinExists("AutoCAD 2011", "输入要更改的特性") Then
			$xuanze = 20
			ExitLoop
		EndIf
		Sleep(500)
	WEnd
;~ 结束判断前面是不是选择了什么东西

	If $xuanze = 10 Then
		ControlSend("AutoCAD 2011", "", 2, "{ESC}")
	Else
		WinWait("AutoCAD 2011", "输入要更改的特性")
		ControlSend("AutoCAD 2011", "", 2, "la{enter}")
		WinWait("AutoCAD 2011", "输入新图层名")
		ControlSend("AutoCAD 2011", "", 2, "__________center{enter}")
		Sleep(200)
		ControlSend("AutoCAD 2011", "", 2, "c{enter}")
		WinWait("AutoCAD 2011", "新颜色")
		ControlSend("AutoCAD 2011", "", 2, "ByLayer{enter}")
		Sleep(200)
		ControlSend("AutoCAD 2011", "", 2, "lt{enter}")
		WinWait("AutoCAD 2011", "输入新线型名")
		ControlSend("AutoCAD 2011", "", 2, "ByLayer{enter}")
		Sleep(200)
		ControlSend("AutoCAD 2011", "", 2, "lw{enter}")
		WinWait("AutoCAD 2011", "输入新线宽")
		ControlSend("AutoCAD 2011", "", 2, "ByLayer{enter}{enter}")
		ControlSend("AutoCAD 2011", "", 2, "{ESC}")
	EndIf
	ControlSend("AutoCAD 2011", "", 2, "qselect ")
	WinWait("快速选择")
	ControlCommand("快速选择", "", 1020, "SelectString", '白')
	ControlClick("快速选择", "", 1) ;关闭页面设置
	WinWaitClose("快速选择") ;等待关闭页面设置
	ControlSend("AutoCAD 2011", "", 2, "qselect ")
	WinWait("快速选择")
	ControlCommand("快速选择", "", 1020, "SelectString", '绿')
	ControlClick("快速选择", "", 1) ;关闭页面设置
	WinWaitClose("快速选择") ;等待关闭页面设置
	ControlSend("AutoCAD 2011", "", 2, "chprop{enter}")

;~ 开始判断前面是不是选择了什么东西
	While 1
		$xuanze = 0
		If WinExists("AutoCAD 2011", "选择对象") Then
			$xuanze = 10
			ExitLoop
		EndIf
		If WinExists("AutoCAD 2011", "输入要更改的特性") Then
			$xuanze = 20
			ExitLoop
		EndIf
		Sleep(500)
	WEnd
;~ 结束判断前面是不是选择了什么东西


	If $xuanze = 10 Then
		ControlSend("AutoCAD 2011", "", 2, "{ESC}")
	Else

		WinWait("AutoCAD 2011", "输入要更改的特性")
		ControlSend("AutoCAD 2011", "", 2, "la{enter}")
		WinWait("AutoCAD 2011", "输入新图层名")
		ControlSend("AutoCAD 2011", "", 2, "__________cu{enter}")
		Sleep(200)
		ControlSend("AutoCAD 2011", "", 2, "c{enter}")
		WinWait("AutoCAD 2011", "新颜色")
		ControlSend("AutoCAD 2011", "", 2, "ByLayer{enter}")
		Sleep(200)
		ControlSend("AutoCAD 2011", "", 2, "lt{enter}")
		WinWait("AutoCAD 2011", "输入新线型名")
		ControlSend("AutoCAD 2011", "", 2, "ByLayer{enter}")
		Sleep(200)
		ControlSend("AutoCAD 2011", "", 2, "lw{enter}")
		WinWait("AutoCAD 2011", "输入新线宽")
		ControlSend("AutoCAD 2011", "", 2, "ByLayer{enter}{enter}")
		ControlSend("AutoCAD 2011", "", 2, "{ESC}")
	EndIf
	Local $cindexpos = cindexpos()
	MouseClick("left", $cindexpos[4], $cindexpos[5], 1)
;~ 开始复制图号
	MouseMove(0, 0)
	WinMenuSelectItem("AutoCAD 2011", "", "帮助", "自定义表格单元格式")
	WinWait("表格单元格式")
	ClipPut(ControlGetText("表格单元格式", "", 1021))
	WinClose("表格单元格式")
	WinWaitClose("表格单元格式")
;~ 	Sleep(500)
;~ 结束复制图号
;~ 	WinMenuSelectItem("AutoCAD 2011", "", "修改", "旋转")
;~ 	MouseClick("left", $cindexpos[2], $cindexpos[3])   ;点击右下角
;~ 	MouseClick("left", $cindexpos[4], $cindexpos[3])	;点击
;~ 	MouseClick("left", $cindexpos[2] * 3 / 2 - $cindexpos[0] / 2, $cindexpos[3])
;~ 	WinMenuSelectItem("AutoCAD 2011", "", "修改", "移动")
;~ 	MouseClick("left", $cindexpos[2], $cindexpos[3])
;~ 	MouseMove($cindexpos[0]+10, $cindexpos[1]+10)
;~ 	MouseClick("left", $cindexpos[0], $cindexpos[1])
	MouseMove(0, 0)
	WinActivate("AutoCAD 2011", "正在重生成模型")
	WinWaitActive("AutoCAD 2011", "正在重生成模型")
	WinMenuSelectItem("AutoCAD 2011", "", "文件", "保存")
	WinMenuSelectItem("AutoCAD 2011", "", "文件", "退出")
	While WinExists("AutoCAD 2011")
		WinClose("AutoCAD 2011")
		Sleep(500)
	WEnd
	FileRecycle(StringReplace($single, ".dwg", "_dwg__out.log.1"))
	If FileExists(StringReplace($single, ".dwg", "_dwg__out.log.2")) Then FileRecycle(StringReplace($single, ".dwg", "_dwg__out.log.2"))
	If FileExists(StringReplace($single, ".dwg", "_dwg__out.log.3")) Then FileRecycle(StringReplace($single, ".dwg", "_dwg__out.log.3"))
;~ 开始更改文件名字
	Local $cindex = ClipGet()
	If $cindex = "样例文字" Or $cindex = " " Or $cindex = "" Then
		$cindex = "无图号文件_" & @MSEC
	Else
		$cindex = StringReplace($cindex, ".", "", 2)   ;得到  8SF352623.1~2.dwg
	EndIf
	
	If StringInStr($cindex,"/") Then $cindex=StringReplace($cindex,"/","-")  ;替换类似  8SF352623.1/2.dwg  得到  8SF352623.1-2.dwg
	
	Local $newcindex = @DesktopDir & "\" & $cindex & ".dwg"	   ;定义新的CAD文件的长路径
	Local $tuhao = FileMove($single, $newcindex)

	Local $count = 1     ;开始判断是不是有重名现象
	While Not $tuhao
		$tuhao = FileMove($single, @DesktopDir & "\" & $cindex & "文件重名_" & $count & ".dwg")
		$newcindex = @DesktopDir & "\" & $cindex & "文件重名_" & $count & ".dwg"
		$count = $count + 1
	WEnd   				;结束判断是不是有重名现象

;~ 结束更改文件名字
	Return $newcindex ;返回新的文件名字
EndFunc   ;==>ProetoCad

Func CADtoPDF($single) ;自定义函数。
	Local $PID = ProcessExists("acad.exe") ;检测CAD是否已经在运行。
	If $PID Then ProcessClose($PID) ;如果存在则终止进程
	ShellExecute($single) ;运行文件,最大化无效
	MouseMove(0, 0)
	WinWait("AutoCAD 2011", "正在重生成模型") ;等待AutoCAD加载完成
	WinSetState("AutoCAD 2011", "正在重生成模型", @SW_MAXIMIZE) ;最大化CAD窗口
	WinMenuSelectItem("AutoCAD 2011", "", "视图", "缩放", "范围") ;使页面最大化
	WinActivate("AutoCAD 2011", "正在重生成模型")
	WinWaitActive("AutoCAD 2011", "正在重生成模型")
	Local $a3ora4 = A3A4()
	ControlSend("AutoCAD 2011", "", 2, "pagesetup{enter}") ;并打开页面设置管理器
	WinWait("页面设置管理器") ;暂停直到打开页面设置管理器
	ControlSend("页面设置管理器", "", 4696, "!m") ;按“ALT+M”
	WinWait("页面设置 - 模型") ;暂停直到打开页面设置 - 模型
	ControlCommand("页面设置 - 模型", "", 1020, "SetCurrentSelection", 4) ;设置打印机为“Adobe PDF”
	If $a3ora4 = 1 Then
		ControlCommand("页面设置 - 模型", "", 1040, "SelectString", 'A3') ;设置图纸尺寸为“A3”
		ControlCommand("页面设置 - 模型", "", 1037, "Check", "") ;设置图形方形为“横向”，匹配A3
	Else
		ControlCommand("页面设置 - 模型", "", 1040, "SelectString", 'A4') ;设置图纸尺寸为“A4”
		ControlCommand("页面设置 - 模型", "", 1036, "Check", "") ;设置图形方形为“纵向”，匹配A4
	EndIf
	ControlCommand("页面设置 - 模型", "", 1043, "SelectString", '范围') ;设置打印范围为“范围”
	ControlCommand("页面设置 - 模型", "", 1030, "UnCheck", "") ;设置按打印样式打印为“否”
	ControlCommand("页面设置 - 模型", "", 1030, "Check", "") ;设置按打印样式打印为“是”---防止没有勾上“打印对象线宽”
	ControlCommand("页面设置 - 模型", "", 1053, "Check", "") ;设置布满图纸
	ControlCommand("页面设置 - 模型", "", 1046, "Check", "") ;设置居中打印
;~ 	ControlCommand("页面设置 - 模型", "", 1006, "SelectString", 'monochrome') ;设置打印样式表为mochrome.ctb
;~ 	Sleep(500)
	Local $monochrome = ControlCommand("页面设置 - 模型", "", 1006, "GetCurrentSelection", '')
	While StringCompare("monochrome.ctb", $monochrome)
		ControlCommand("页面设置 - 模型", "", 1006, "SelectString", 'monochrome') ;设置打印样式表为mochrome.ctb
		Sleep(500)
		$monochrome = ControlCommand("页面设置 - 模型", "", 1006, "GetCurrentSelection", '')
	WEnd
	
	ControlCommand("页面设置 - 模型", "", 1053, "Check", "") 
	ControlCommand("页面设置 - 模型", "", 1046, "Check", "") ;重复设置一下
	
	While ControlCommand("页面设置 - 模型", "", "[CLASS:Button; INSTANCE:10]", "IsEnabled", "")
		Send("!E")
		Sleep(500)
	WEnd

	ControlClick("页面设置 - 模型", "", 1) ;关闭页面设置
	WinWaitClose("页面设置 - 模型") ;等待关闭页面设置
	ControlClick("页面设置管理器", "", 2) ;关闭页面设置管理器
	While WinExists("页面设置管理器")
		ControlClick("页面设置管理器", "", 2) ;关闭页面设置管理器
		Sleep(100)
	WEnd
	WinActivate("AutoCAD 2011", "正在重生成模型")
	WinWaitActive("AutoCAD 2011", "正在重生成模型")
	If $print = 1 Then
		ControlSend("AutoCAD 2011", "", 2, "print{enter}") ;打开打印对话框
		WinWait("打印 - 模型")
		ControlClick("打印 - 模型", "", 1) ;点击打印
		WinWaitClose("打印 - 模型")
		WinWait("另存 PDF 文件为") ;暂停直到打开“另存 PDF 文件为”
		Local $pdfname = ControlGetText("另存 PDF 文件为", "", 1001)
		While @error
			SetError(0)
			$pdfname = ControlGetText("另存 PDF 文件为", "", 1001)
			Sleep(200)
		WEnd
		While WinExists("另存 PDF 文件为")
			ControlClick("另存 PDF 文件为", "", "[CLASS:Button; INSTANCE:1]")
			Sleep(500)
		WEnd
		WinWait($pdfname) ;暂停直到打开“Adobe Acrobat Pro”
		;-------------------------------------------------------------------------如果是A3则逆时针旋转90度。
		If $a3ora4 = 1 Then
			ControlSend($pdfname, "", "[CLASS:AVL_AVView; INSTANCE:16]", "^+R")
			While Not WinExists("旋转页面")
				ControlSend($pdfname, "", "[CLASS:AVL_AVView; INSTANCE:16]", "^+R")
				Sleep(100)
			WEnd
			ControlCommand("旋转页面", "", "[CLASS:ComboBox; INSTANCE:1]", "SetCurrentSelection", 0)
			ControlClick("旋转页面", "", "[CLASS:Button; INSTANCE:5]") ;关闭"打印 - 模型"
			WinWaitClose("旋转页面")
		EndIf
		;-------------------------------------------------------------------------如果是A3则逆时针旋转90度。
		Local $pdfdir = _WinAPI_GetProcessCommandLine(WinGetProcess($pdfname))
		$pdfdir = StringReplace($pdfdir, """", "")
		
		ControlSend($pdfname, "", "[CLASS:AVL_AVView; INSTANCE:16]", "^s")
		WinClose($pdfname) ;关闭“Adobe Acrobat Pro”
		ControlSend("AutoCAD 2011", "", 2, "{esc}") ;保存CAD
		ControlSend("AutoCAD 2011", "", 2, "qsave{enter}") ;保存CAD
		WinClose("AutoCAD 2011") ;关闭CAD
		While WinExists("AutoCAD 2011")
			WinClose("AutoCAD 2011")
			Sleep(500)
		WEnd
		;-------------------------------------------------------------------------还是改成图号的名字吧o(∩_∩)o
		Local $number = StringSplit($single, "\")
		Local $cindex = $number[$number[0]]     ;得到类似  8SF326236.1~2.dwg
		$cindex = StringTrimRight($cindex, 4)   ;得到类似  8SF326236.1~2
		Local $rename = FileMove($pdfdir, @DesktopDir & "\PDF Convert\" & $cindex & ".pdf", 9)
		While Not $rename
			$rename = FileMove($pdfdir, @DesktopDir & "\PDF Convert\" & $cindex & ".pdf", 9)
			Sleep(500)
		WEnd
;~ 	;-------------------------------------------------------------------------还是改成图号的名字吧o(∩_∩)o
	Else
		ControlSend("AutoCAD 2011", "", 2, "exportpdf{enter}") ;打开打印对话框
		WinWait("另存为 PDF") ;暂停直到打开"打印 - 模型"
		WinActivate("另存为 PDF")
		WinWaitActive("另存为 PDF")
		ControlCommand("另存为 PDF", "", 13001, "SelectString", '桌面') ;设置打印范围为“范围”
		ControlCommand("另存为 PDF", "", 4214, "SelectString", '范围') ;设置打印范围为“范围”
		Local $cindex_convert = ControlGetText("另存为 PDF", "", 1001)
		ControlClick("另存为 PDF", "", "[CLASS:Button; INSTANCE:16]")
		While WinExists("另存为 PDF")
			ControlClick("另存为 PDF", "", "[CLASS:Button; INSTANCE:16]")
			Sleep(200)
		WEnd
		ControlSend("AutoCAD 2011", "", 2, "{ESC}") ;保存CAD
		WinMenuSelectItem("AutoCAD 2011", "", "文件", "保存")
		WinMenuSelectItem("AutoCAD 2011", "", "文件", "退出")
		While WinExists("AutoCAD 2011")
			WinClose("AutoCAD 2011")
			Sleep(500)
		WEnd
		FileMove(@DesktopDir & "\" & $cindex_convert, @DesktopDir & "\PDF Convert\" & $cindex_convert, 9)
	EndIf
EndFunc   ;==>CADtoPDF

Func esc()
	Exit
EndFunc   ;==>esc

Func printyes()
	$print = 1
	TrayTip("提示", "切换到PDF打印模式", 5)
EndFunc   ;==>printyes

Func printno()
	$print = 0
	TrayTip("提示", "切换到PDF转换模式", 5)
EndFunc   ;==>printno

Func A3A4()
	;--------------------------------------------------------------------------------------------根据窗口大小判断是否A3还是A4
	Local $flag = 0
	Local $array = ControlGetPos("AutoCAD 2011", "", 59648)
	Local $xpos = (($array[3] - 26) * 420 / 297 + $array[2]) / 2 + $array[0]
	Local $se = 0
	;--------------------------------------------------------------------------------------------颜色搜索结束
	PixelSearch($xpos - 150, $array[1] + 100, $xpos + 50, $array[1] + 110, 0xFFFF00, 20);黄色
	If @error Then
		SetError(0)
	Else
		$se = 1
	EndIf
	PixelSearch($xpos - 150, $array[1] + 100, $xpos + 50, $array[1] + 110, 0xFF0000, 20);红色
	If @error Then
		SetError(0)
	Else
		$se = 1
	EndIf
	PixelSearch($xpos - 150, $array[1] + 100, $xpos + 50, $array[1] + 110, 0xFFFFFF, 20);白色
	If @error Then
		SetError(0)
	Else
		$se = 1
	EndIf
	PixelSearch($xpos - 150, $array[1] + 100, $xpos + 50, $array[1] + 110, 0x00FF00, 20);绿色
	If @error Then
		SetError(0)
	Else
		$se = 1
	EndIf
	;--------------------------------------------------------------------------------------------颜色搜索结束
	If $se Then $flag = 1
	Return $flag
	;--------------------------------------------------------------------------------------------根据窗口大小判断是否A3还是A4
EndFunc   ;==>A3A4

Func jishi($iDiff)
	Local $time[4]
	Local $say
	$time[0] = Floor($iDiff / 1000)
	If $time[0] < 60 Then
		$time[1] = $time[0]
		$say = $time[1] & "秒"
	Else
		If $time[0] >= 60 And $time[0] < 3600 Then
			$time[2] = Floor($time[0] / 60)
			$time[1] = $time[0] - $time[2] * 60
			$say = $time[2] & "分" & $time[1] & "秒"
		Else
			$time[3] = Floor($time[0] / 3600)
			$time[2] = Floor(($time[0] - $time[3] * 3600) / 60)
			$time[1] = $time[0] - $time[2] * 60 - $time[3] * 3600
			$say = $time[3] & "时" & $time[2] & "分" & $time[1] & "秒"
		EndIf
	EndIf
	Return $say
EndFunc   ;==>jishi

Func cindexpos()
	WinMenuSelectItem("AutoCAD 2011", "", "视图", "缩放", "范围")
	Sleep(500)
	Local $cpos[6]
	Local $pos1 = ControlGetPos("AutoCAD 2011", "", 59648)   ;采样到窗口坐标
	Local $pos2 = PixelSearch($pos1[0], $pos1[1], $pos1[0] + $pos1[2], $pos1[1] + $pos1[3], 0xFF0000) ;采样到图框中央竖线坐标
	Local $pos3 = PixelSearch($pos1[0], $pos1[1], $pos2[0] - 5, $pos1[1] + $pos1[3], 0xFF0000) ;采样到图框左上角坐标
	Local $pos4 = PixelSearch($pos3[0] + 5, $pos3[1] + 5, $pos1[0] + $pos1[2], $pos1[1] + $pos1[3], 0xFF0000) ;右下角X坐标
	Local $pos5 = PixelSearch($pos3[0] + 5, $pos3[1] + 5, $pos4[0] - 5, $pos1[1] + $pos1[3], 0xFF0000) ;右下角Y坐标
	$cpos[0] = $pos3[0]
	$cpos[1] = $pos3[1]
	$cpos[2] = $pos4[0]
	$cpos[3] = $pos5[1]
	$cpos[4] = ($cpos[0] + $cpos[2]) / 2 ;中心X坐标
	$cpos[5] = ($cpos[1] + $cpos[3]) / 2 ;中心Y坐标
	Return $cpos
EndFunc   ;==>cindexpos