#Region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=..\..\ICO\简约系统桌面图标下载24.ico
#PRE_Outfile=CAD样式设置助手.exe
#PRE_Compression=4
#PRE_Res_Description=CAD字体及标注样式标准化
#PRE_Res_Fileversion=0.0.0.10
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
HotKeySet("{ESC}", "tuichu")
Func tuichu()
	Exit
EndFunc   ;==>tuichu

If Not ProcessExists("acad.exe") Then Exit
Local $iniread = IniRead(@TempDir & "\CAD样式设置助手.ini", "字体", "顺序", 0)
WinActivate("AutoCAD 2011")
MouseMove(0, 0)
ControlSend("AutoCAD 2011", "", 2, "style{enter}")
WinWait("文字样式")
ControlClick("文字样式", "", "[CLASS:Button; INSTANCE:12]")
WinWait("新建文字样式")
ControlSetText("新建文字样式", "", "[CLASS:Edit; INSTANCE:1]", "__romans" & Random(10, 50, 1))
ControlClick("新建文字样式", "", "[CLASS:Button; INSTANCE:1]")
Sleep(200)
WinWaitClose("新建文字样式")
If $iniread = 0 Then
	romans()
Else
	ControlCommand("文字样式", "", "[CLASS:ComboBox; INSTANCE:2]", "SetCurrentSelection", $iniread)
EndIf
ControlCommand("文字样式", "", "[CLASS:Button; INSTANCE:3]", "UnCheck", "")
ControlSetText("文字样式", "", "[CLASS:Edit; INSTANCE:1]", "0")
ControlSetText("文字样式", "", "[CLASS:Edit; INSTANCE:2]", "0.66")
ControlClick("文字样式", "", "[CLASS:Button; INSTANCE:14]")
WinClose("文字样式")


WinActivate("AutoCAD 2011")
ControlSend("AutoCAD 2011", "", 2, "dimstyle{enter}")
WinWait("标注样式管理器")
ControlClick("标注样式管理器", "", "[CLASS:Button; INSTANCE:4]")
WinWait("创建新标注样式")
ControlSetText("创建新标注样式", "", "[CLASS:Edit; INSTANCE:1]", "__romans_style" & Random(10, 50, 1))
ControlClick("创建新标注样式", "", "[CLASS:Button; INSTANCE:2]")

;~ 字体设置部分完成

WinWait("新建标注样式:")
If Not WinActivate("新建标注样式:", "") Then WinActivate("新建标注样式:", "")
WinWaitActive("新建标注样式:", "")
$WinPosArray = WinGetPos("新建标注样式:")
$WinPosArray = WinGetPos("新建标注样式:")
$TNewCheckListBoxArray = ControlGetPos("新建标注样式:", "", "[CLASS:SysTabControl32; INSTANCE:1]")
$Width = $WinPosArray[0] + $TNewCheckListBoxArray[0]
$Height = $WinPosArray[1] + $TNewCheckListBoxArray[1]

;~ 线 选项卡
MouseClick("left", $Width + 20, $Height + 40)

MouseClick("left", $Width + 180, $Height + 80)
MouseClick("left", $Width + 180, $Height + 100)
MouseClick("left", $Width + 180, $Height + 330)
MouseClick("left", $Width + 180, $Height + 350) ;线的颜色

MouseClick("left", $Width + 480, $Height + 330)
Send("^a")
Send("1.5")
MouseClick("left", $Width + 480, $Height + 360)
Send("^a")
Send("0")

;~ 符号和箭头 选项卡
MouseClick("left", $Width + 80, $Height + 40)
MouseClick("left", $Width + 60, $Height + 225)
Send("^a")
Send("3.5")

;~ 文字 选项卡
MouseClick("left", $Width + 150, $Height + 40)
MouseClick("left", $Width + 170, $Height + 85) ;选择字体样式
MouseWheel("up", 20)
MouseClick("left", $Width + 170, $Height + 100)

MouseClick("left", $Width + 170, $Height + 120)
MouseClick("left", $Width + 170, $Height + 140) ;选择字体颜色

MouseClick("left", $Width + 240, $Height + 175)
Send("^a")
Send("3.5") ;选择字体高度
MouseClick("left", $Width + 200, $Height + 285)
MouseClick("left", $Width + 200, $Height + 310)
MouseClick("left", $Width + 200, $Height + 315)
MouseClick("left", $Width + 200, $Height + 325)
MouseClick("left", $Width + 240, $Height + 375)
Send("^a")
Send("1")
MouseClick("left", $Width + 340, $Height + 340)

;~ 调整 选项卡
MouseClick("left", $Width + 195, $Height + 40)
MouseClick("left", $Width + 70, $Height + 140)
MouseClick("left", $Width + 350, $Height + 365)
MouseClick("left", $Width + 490, $Height + 365)
Send("^a")
Send("1")

SetError(0)
PixelSearch($Width + 305, $Height + 410, $Width + 325, $Height + 430, 0x4B6097, 50)
If Not @error Then
	MouseClick("left", $Width + 350, $Height + 415)
	SetError(0)
EndIf ;在延伸线之间绘制尺寸线判断

SetError(0)
PixelSearch($Width + 305, $Height + 430, $Width + 325, $Height + 450, 0x4B6097, 50)
If @error Then
	MouseClick("left", $Width + 350, $Height + 435)
	SetError(0)
EndIf ;在延伸线之间绘制尺寸线判断

;~ 主单位 选项卡
MouseClick("left", $Width + 250, $Height + 40)
MouseClick("left", $Width + 200, $Height + 105)
MouseClick("left", $Width + 200, $Height + 145)
MouseClick("left", $Width + 220, $Height + 275)
Send("^a")
Send("1")

SetError(0)
PixelSearch($Width + 175, $Height + 320, $Width + 200, $Height + 340, 0x4B6097, 50)
If @error Then
	MouseClick("left", $Width + 190, $Height + 335)
	SetError(0)
EndIf ;后续 判断

;~ 公差 选项卡
MouseClick("left", $Width + 350, $Height + 40)
MouseClick("left", $Width + 200, $Height + 80)
MouseClick("left", $Width + 200, $Height + 100)

ControlClick("新建标注样式:", "", 1)
WinWaitClose("新建标注样式:")
ControlClick("标注样式管理器", "", 1)

Func romans()
	$WinPosArray = WinGetPos("文字样式")
	$TNewCheckListBoxArray = ControlGetPos("文字样式", "", "[CLASS:Button; INSTANCE:1]")
	$Width = $WinPosArray[0] + $TNewCheckListBoxArray[0]
	$Height = $WinPosArray[1] + $TNewCheckListBoxArray[1]
;~ 	MouseMove($Width + 20, $Height + 30)
;~ 	MouseMove($Width + $TNewCheckListBoxArray[2] - 10, $Height + $TNewCheckListBoxArray[3])
;~ 	$s = ControlCommand("文字样式", "", "[CLASS:ComboBox; INSTANCE:2]", "GetCurrentSelection", "")
;~ 			Sleep(500)
;~ 	$color = PixelChecksum($Width + 20, $Height + 30, $Width + $TNewCheckListBoxArray[2] - 10, $Height + $TNewCheckListBoxArray[3])
;~ 	MsgBox(0,"",$color)
	
	Local $i
	For $i = 1 To 1000
		ControlCommand("文字样式", "", "[CLASS:ComboBox; INSTANCE:2]", "SetCurrentSelection", $i)
		$s = ControlCommand("文字样式", "", "[CLASS:ComboBox; INSTANCE:2]", "GetCurrentSelection", "")
		Sleep(100)
		$color = PixelChecksum($Width + 20, $Height + 30, $Width + $TNewCheckListBoxArray[2] - 10, $Height + $TNewCheckListBoxArray[3])
		If $color = 1358578069 Then
			IniWrite(@TempDir & "\CAD样式设置助手.ini", "字体", "顺序", $i)
			ExitLoop
		EndIf
	Next
EndFunc   ;==>romans