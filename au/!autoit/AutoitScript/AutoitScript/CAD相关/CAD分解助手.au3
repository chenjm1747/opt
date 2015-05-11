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
If WinExists("CAD分解助手") Then
		TrayTip("提示","CAD分解助手已经在运行啦！",5)
		Sleep(5000)
		Exit
EndIf

Local $my_Version = "CAD分解助手"
AutoItWinSetTitle($my_Version) ;写入文件标题，供弹窗点击程序识别。

HotKeySet("^{down}", "new")
HotKeySet("^{up}", "tuichu")
Global $i=1
TrayTip("提示","在CAD中选中图形后按 Ctrl+↓",5)

While 1
	Sleep(100)
WEnd

Func tuichu()
	TrayTip("提示","CAD分解助手即将关闭！",5)
	Sleep(5000)
	Exit
EndFunc

Func new()
	WinActivate("AutoCAD 2011")
	WinMenuSelectItem("AutoCAD 2011", "", "编辑", "复制")
	WinMenuSelectItem("AutoCAD 2011", "", "文件", "新建")
	WinWait("选择样板")
	ControlClick("选择样板", "", "[CLASS:Button; INSTANCE:10]")
	While WinExists("选择样板")
		ControlClick("选择样板", "", "[CLASS:Button; INSTANCE:10]")
		Sleep(100)
	WEnd
	WinMenuSelectItem("AutoCAD 2011", "", "编辑", "粘贴到原坐标")
	WinMenuSelectItem("AutoCAD 2011", "", "视图", "缩放","范围")
	WinMenuSelectItem("AutoCAD 2011", "", "文件", "另存为")
	WinWait("图形另存为")
	ControlCommand("图形另存为", "", "[CLASS:ComboBox; INSTANCE:1]", "SelectString", '桌面')
	ControlSetText("图形另存为", "", "[CLASS:Edit; INSTANCE:1]", StringFormat("%03s",$i))
	ControlCommand("图形另存为","","[CLASS:ComboBox; INSTANCE:3]","SetCurrentSelection", 3)
	ControlClick("图形另存为", "", "[CLASS:Button; INSTANCE:10]")
	While WinExists("图形另存为")
		ControlClick("图形另存为", "", "[CLASS:Button; INSTANCE:10]")
		Sleep(100)
	WEnd
	WinMenuSelectItem("AutoCAD 2011", "", "文件", "关闭")
	
	TrayTip("提示","成功在桌面创建新文件 " & StringFormat("%03s",$i) & ".dwg" ,5)
	$i=$i+1
	
EndFunc   ;==>new






