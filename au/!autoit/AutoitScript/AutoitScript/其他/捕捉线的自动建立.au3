#Region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=ICO\1.ico
#PRE_Outfile=捕捉线的自动建立.exe
#PRE_Compression=4
#PRE_UseX64=n
#PRE_Res_Description=捕捉线的自动建立
#PRE_Res_Fileversion=0.0.0.4
#PRE_Res_Fileversion_AutoIncrement=y
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
	脚本功能:需要在Proe上将打开捕捉线设为快捷键F11
	
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
Opt("WinTitleMatchMode",2)
If WinExists("- Pro/ENGINEER Wildfire 5.0") Then
	TrayTip("提示","检测到绘图窗口",3000)
Else
	TrayTip("提示","没有检测到绘图窗口，程序退出！",3000)
	Sleep(3000)
	Exit
EndIf

WinActivate("- Pro/ENGINEER Wildfire 5.0")
Sleep(500)
Send("^a")
Sleep(200)
Send("{F11}")
Local $pos = WinGetPos("- Pro/ENGINEER Wildfire 5.0")
Local $x = ControlGetPos("- Pro/ENGINEER Wildfire 5.0", "", "[CLASS:PGL_MOGL_WN_CLASS; INSTANCE:1]")
$x[0] = $x[0] + $pos[0]
$x[1] = $x[1] + $pos[1]
;~ MouseMove($x[0],$x[1])
;~ Sleep(500)
;~ MouseMove($x[0]+$x[2],$x[1]+$x[3])
Local $a = 50
Local $b = 50
Local $flag = 0

While $a < $x[2]
	$b = 50
	While $b < $x[3]

		$array = PixelSearch($x[0] + $a, $x[1] + $b, $x[0] + $a + 50, $x[1] + $b + 50, 0x3366FF)
		If Not @error Then
				Send("{CTRLDOWN}")
				MouseClick("", $array[0]+10, $array[1])
				MouseClick("", $array[0], $array[1]+10)
				Send("{CTRLUP}")
				MouseMove($array[0]-50, $array[1])
				Sleep(200)
		EndIf
;~ 		MouseMove($x[0]+$a-50,$x[1]+$b-50)
		$b = $b + 50
;~ 		TrayTip($a,$b,2000)
;~ 		Sleep(2000)
		SetError(0)
		$flag = 0
	WEnd
	$a = $a + 50
WEnd

MouseClick("middle",($x[0] +$x[2])/2,($x[1] +$x[3])/2)
Sleep(200)
Send("6")
MouseClick("middle",($x[0] +$x[2])/2,($x[1] +$x[3])/2)
Sleep(200)
Send("3")
MouseClick("middle",($x[0] +$x[2])/2,($x[1] +$x[3])/2)
Sleep(200)
Send("6")
MouseClick("middle",($x[0] +$x[2])/2,($x[1] +$x[3])/2,3)

TrayTip("提示","捕捉线都建立好了！",3000)
Sleep(3000)