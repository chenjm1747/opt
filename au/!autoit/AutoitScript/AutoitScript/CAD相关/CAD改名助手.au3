#region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=..\ICO\简约系统桌面图标下载0.ico
#PRE_Outfile=CAD Namechange.exe
#PRE_Compression=4
#PRE_Res_Comment=Proe to cad to pdf全自动
#PRE_Res_Description=可以将CAD文件自动改名字，前提是框是红色的。
#PRE_Res_Fileversion=2.8.3.58
#PRE_Res_Fileversion_AutoIncrement=y
#PRE_Res_LegalCopyright=zaoki
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
#include <File.au3>
#include <WinAPIEx.au3>
AdlibRegister("tanchuang")
Func tanchuang()
	ControlClick("AutoCAD", "是否将改动保存到", "[CLASS:Button; INSTANCE:1]")
EndFunc
Global $filename, $i, $single, $spit
HotKeySet("{ESC}", "esc") ;---------------------------------------------------------------------------------------ESC退出

$filename = FileOpenDialog("请选择需要转换的CAD文件", "", "图形 (*.dwg)", 4) ;弹出选择文件对话框
If @error Then Exit ;如果没有选择或选择错误，则退出

Local $hTimer = TimerInit() ; 开始计时

$spit = StringSplit($filename, "|") ;分割文件变成数组
If @error Then
	$single = $filename ;说明选择的是单个文件
	$i=2
	$spit[0]=2
	tuhao($single)
Else
	For $i = 2 To $spit[0] ;一个一个的转换PDF，直到结束。
		$single = $spit[1] & "\" & $spit[$i]
		tuhao($single)
	Next
EndIf
Sleep(5000)
TrayTip("提示", "更改完成！共计" & $spit[0] - 1 & "个文件，用时" & jishi(TimerDiff($hTimer)) & "。", 5)
Sleep(5000)

Func tuhao($single) ;自定义函数。
	Local $PID = ProcessExists("acad.exe") ;检测CAD是否已经在运行。
	If $PID Then ProcessClose($PID) ;如果存在则终止进程
	ShellExecute($single) ;运行文件
	MouseMove(0, 0)
	WinWait("AutoCAD 2011", "正在重生成模型") ;等待AutoCAD加载完成
	WinSetState("AutoCAD 2011", "正在重生成模型", @SW_MAXIMIZE)
	Local $cindexpos=cindexpos()
	MouseClick("left", $cindexpos[4], $cindexpos[5], 1)
	MouseClick("left", $cindexpos[4]+20, $cindexpos[5], 2)
;~ 开始复制图号
	ClipPut("")
	MouseMove(0, 0)
	Send("^a")
	Send("^c")
	Sleep(500)
	ControlSend("AutoCAD 2011", "", 2, "{esc}{esc}{esc}")
;~ 结束复制图号

	WinClose("AutoCAD 2011")
	
	WinWaitClose("AutoCAD 2011")
;~ 开始更改文件名字
	Local $cindex = ClipGet()
	If $cindex = "样例文字" Or $cindex = " " Or $cindex = "" Then
		$cindex = "获取图号出错_" & @MSEC
	Else
		$cindex = StringReplace($cindex, ".", "", 2)
		$cindex = StringReplace($cindex, @CRLF, "")
;~ 		MsgBox(0,"",$cindex&"QQ")
	EndIf
	
	Local $szDrive, $szDir, $szFName, $szExt
	$TestPath = _PathSplit($single, $szDrive, $szDir, $szFName, $szExt)
	$newtuhao = $szDrive & $szDir & $cindex & ".dwg"
;~ 	MsgBox(0,"",$newtuhao)
	Local $tuhao = FileMove($single, $newtuhao)
	Local $count=1
	If $tuhao=0 Then 
;~ 		TrayTip( $i - 1 & "/" & $spit[0] - 1,"重命名失败，已经存在文件名 " & $cindex & ".dwg！",5)
		While Not $tuhao
			$cindex = $cindex & "_" & $count
			$newtuhao = $szDrive & $szDir & $cindex &".dwg"
			$tuhao = FileMove($single, $newtuhao)
			$count=$count+1
		WEnd
	EndIf
	If $tuhao=1 Then TrayTip( $i - 1 & "/" & $spit[0] - 1,$szFName & $szExt & " 已经已经重命名为 " & $cindex & ".dwg",5)
EndFunc   ;==>ProetoCad

Func esc()
	Exit
EndFunc   ;==>esc

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
	WinMenuSelectItem("AutoCAD 2011", "", "视图", "缩放","范围")
	Sleep(500)
	Local $cpos[6]
	Local $pos1 = ControlGetPos("AutoCAD 2011", "", 59648)
	Local $pos2 = PixelSearch($pos1[0], $pos1[1], $pos1[0] + $pos1[2], $pos1[1] + $pos1[3], 0xFF0000)  ;采样到图框中央竖线坐标
	Local $pos3 = PixelSearch($pos1[0], $pos1[1], $pos2[0] - 5, $pos1[1] + $pos1[3], 0xFF0000)		;采样到图框左上角坐标
	Local $pos4 = PixelSearch($pos3[0] + 5, $pos3[1] + 5, $pos1[0] + $pos1[2], $pos1[1] + $pos1[3], 0xFF0000) ;右下角X坐标
	Local $pos5 = PixelSearch($pos3[0] + 5, $pos3[1] + 5, $pos4[0] - 5, $pos1[1] + $pos1[3], 0xFF0000) ;右下角Y坐标
	$cpos[0]=$pos3[0]
	$cpos[1]=$pos3[1]
	$cpos[2]=$pos4[0]
	$cpos[3]=$pos5[1]
	$cpos[4]=($cpos[0]+$cpos[2])/2  ;中心X坐标
	$cpos[5]=($cpos[1]+$cpos[3])/2  ;中心Y坐标
	Return $cpos
EndFunc
