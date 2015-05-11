#region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=..\ICO\pencil64.ico
#PRE_Outfile=CAD标注样式设置.exe
#PRE_Compression=4
#PRE_UseX64=n
#PRE_Res_Description=CAD字体及标注样式标准化
#PRE_Res_Fileversion=0.0.0.18
#PRE_Res_Fileversion_AutoIncrement=y
#PRE_Res_LegalCopyright=chen
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

If Not ProcessExists("acad.exe") Then
	TrayTip("警告！", "没有检测到运行中的AutoCAD，请重试！", 3000)
	Sleep(3000)
	Exit
EndIf

Global $flag = MsgBox(262144 + 64 + 3, "请选择", "选择是，将添加仿宋体标注样式；" & @CRLF & "选择否，将添加Romans标注样式。") ;设为6即是仿宋体,设为7为romans;
Global $name,$number,$scale

If $flag = 6 Then
	TrayTip("提示！", "你选择了仿宋体！", 3000)
	$name="__" & "FangSong-GB2312-" & Random(10, 100, 1)
	$number=426
ElseIf $flag = 7 Then
	TrayTip("提示！", "你选择了Romans！", 3000)
	$name="__" & "Romans-" & Random(10, 100, 1)
	$number=315
Else
	TrayTip("警告！", "你没有选择，程序即将退出！", 3000)
	Sleep(3000)
	Exit
EndIf
$scale=InputBox("提示","请输入标注特征全局比例","1")

MouseMove(0, 0)
wenziyangshi()
biaozhuyangshi()

Func wenziyangshi()
	WinActivate("AutoCAD 2011")
	ControlSend("AutoCAD 2011", "", 2, "style{enter}")
	WinWait("文字样式")
	ControlClick("文字样式", "", "[CLASS:Button; INSTANCE:12]")
	Sleep(200)
	If WinExists("AutoCAD", "当前样式已被修改") Then ControlClick("AutoCAD", "当前样式已被修改", "[CLASS:Button; INSTANCE:2]")
	WinWait("新建文字样式")
	ControlSetText("新建文字样式", "", "[CLASS:Edit; INSTANCE:1]", $name)
	ControlClick("新建文字样式", "", "[CLASS:Button; INSTANCE:1]")
	Sleep(200)
	If WinExists("文字样式 - 名称已经存在") Then
		WinClose("文字样式 - 名称已经存在")
		WinClose("新建文字样式")
		WinClose("文字样式")
	Else
		WinWaitClose("新建文字样式")
		ControlCommand("文字样式", "", "[CLASS:ComboBox; INSTANCE:2]", "SetCurrentSelection", $number) ;仿宋顺序号
		ControlCommand("文字样式", "", "[CLASS:Button; INSTANCE:3]", "UnCheck", "")
		ControlSetText("文字样式", "", "[CLASS:Edit; INSTANCE:1]", "0")
		
		If $flag = 6 Then
			ControlSetText("文字样式", "", "[CLASS:Edit; INSTANCE:2]", "1")
		Else
			ControlSetText("文字样式", "", "[CLASS:Edit; INSTANCE:2]", "0.66") ;文字比例
		EndIf
		
		ControlClick("文字样式", "", "[CLASS:Button; INSTANCE:14]")
		WinClose("文字样式")
	EndIf
EndFunc   ;==>wenziyangshi

Func biaozhuyangshi()
	WinActivate("AutoCAD 2011")
	ControlSend("AutoCAD 2011", "", 2, "dimstyle{enter}")
	WinWait("标注样式管理器")
	ControlClick("标注样式管理器", "", "[CLASS:Button; INSTANCE:4]")
	WinWait("创建新标注样式")
	ControlSetText("创建新标注样式", "", "[CLASS:Edit; INSTANCE:1]", $name)
	ControlClick("创建新标注样式", "", "[CLASS:Button; INSTANCE:2]")
;~ 	Sleep(1000)
;~ 字体设置部分完成
	WinWait("新建标注样式:")
	WinActivate("新建标注样式:", "")
	Local $taptext ;每个选项卡下面的可见文字不同。
;~ 线 选项卡

	$taptext = "固定长度的延伸线"
	While Not WinExists("新建标注样式:", $taptext)
		Send("^{TAB}")
	WEnd
	Sleep(100)
	ControlCommand("新建标注样式:", $taptext, 2517, "SetCurrentSelection", 0)
	ControlCommand("新建标注样式:", $taptext, 2522, "SetCurrentSelection", 0)
	ControlCommand("新建标注样式:", $taptext, 2518, "SetCurrentSelection", 0)
	ControlSetText("新建标注样式:", $taptext, 2501, "1.25")
	ControlClick("新建标注样式:", $taptext, 2501)
	ControlSetText("新建标注样式:", $taptext, 2503, "0")
	ControlClick("新建标注样式:", $taptext, 2503)
;~ 	Sleep(1000)
;~ 符号和箭头 选项卡
	$taptext = "线性折弯标注"
	While Not WinExists("新建标注样式:", $taptext)
		Send("^{TAB}")
	WEnd
	Sleep(100)
	ControlCommand("新建标注样式:", $taptext, 2527, "SetCurrentSelection", 0)
	ControlCommand("新建标注样式:", $taptext, 2528, "SetCurrentSelection", 0)
	ControlCommand("新建标注样式:", $taptext, 2677, "SetCurrentSelection", 0)
	ControlSetText("新建标注样式:", $taptext, 2529, "3")
	ControlClick("新建标注样式:", $taptext, 2529)
;~ 	Sleep(1000)
;~ 文字 选项卡
	$taptext = "绘制文字边框"
	While Not WinExists("新建标注样式:", $taptext)
		Send("^{TAB}")
	WEnd
	Sleep(100)
	ControlCommand("新建标注样式:", $taptext, 2515, "SetCurrentSelection", 0)
	ControlCommand("新建标注样式:", $taptext, 2645, "SetCurrentSelection", 0)
	ControlCommand("新建标注样式:", $taptext, 2692, "SetCurrentSelection", 0)
	ControlSetText("新建标注样式:", $taptext, 2508, "3")
	ControlClick("新建标注样式:", $taptext, 2508)
	ControlCommand("新建标注样式:", $taptext, 2502, "SetCurrentSelection", 1)
	ControlCommand("新建标注样式:", $taptext, 2510, "SetCurrentSelection", 0)
	ControlCommand("新建标注样式:", $taptext, 2729, "SetCurrentSelection", 0)
	ControlSetText("新建标注样式:", $taptext, 2516, "1")
	ControlClick("新建标注样式:", $taptext, 2516)
	ControlCommand("新建标注样式:", $taptext, 2680, "Check", "")
;~ 	Sleep(1000)
;~ 调整 选项卡
	$taptext = "若箭头不能放在延伸线内"
	While Not WinExists("新建标注样式:", $taptext)
		Send("^{TAB}")
	WEnd
	Sleep(100)
	ControlCommand("新建标注样式:", $taptext, 2688, "Check", "")
	ControlCommand("新建标注样式:", $taptext, 2729, "SetCurrentSelection", 0)
	ControlCommand("新建标注样式:", $taptext, 2723, "UnCheck", "")
	ControlCommand("新建标注样式:", $taptext, 2682, "Check", "")
	ControlSetText("新建标注样式:", $taptext, 2533, $scale)
	ControlClick("新建标注样式:", $taptext, 2533)
	ControlCommand("新建标注样式:", $taptext, 2686, "UnCheck", "")
	ControlCommand("新建标注样式:", $taptext, 2687, "Check", "")
;~ 	Sleep(1000)
;~ 主单位 选项卡
	$taptext = "比例因子"
	While Not WinExists("新建标注样式:", $taptext)
		Send("^{TAB}")
	WEnd
	Sleep(100)
	ControlCommand("新建标注样式:", $taptext, 2534, "SetCurrentSelection", 1)
	ControlCommand("新建标注样式:", $taptext, 2512, "SetCurrentSelection", 2)
	ControlSetText("新建标注样式:", $taptext, 2509, "1")
	ControlClick("新建标注样式:", $taptext, 2509)
	ControlCommand("新建标注样式:", $taptext, 2652, "UnCheck", "")
	ControlCommand("新建标注样式:", $taptext, 2653, "Check", "")
	ControlCommand("新建标注样式:", $taptext, 2659, "UnCheck", "")
	ControlCommand("新建标注样式:", $taptext, 2661, "Check", "")
;~ 	Sleep(1000)
;~ 换算单位 选项卡
	$taptext = "显示换算单位"
	While Not WinExists("新建标注样式:", $taptext)
		Send("^{TAB}")
	WEnd
	Sleep(100)
	ControlCommand("新建标注样式:", $taptext, 2546, "UnCheck", "")
;~ 	Sleep(1000)
;~ 公差 选项卡
	$taptext = "公差格式"
	While Not WinExists("新建标注样式:", $taptext)
		Send("^{TAB}")
	WEnd
	Sleep(100)
	ControlCommand("新建标注样式:", $taptext, 2504, "SetCurrentSelection", 0)
;~ 	Sleep(1000)
	;选项卡设置完毕！
	
	ControlClick("新建标注样式:", "", 1)
	WinWaitClose("新建标注样式:")
	ControlClick("标注样式管理器", "", 1)

	Sleep(500)

	If WinExists("AutoCAD 警告", "") Then ControlClick("AutoCAD 警告", "", "[CLASS:Button; INSTANCE:1]")

	TrayTip("恭喜！", "AutoCAD新的标注样式新建完成，但是比例值需要根据图纸修改！", 3000)
	Sleep(3000)
EndFunc   ;==>biaozhuyangshi




