#region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=..\..\ICO\简约系统桌面图标下载22.ico
#PRE_Outfile=eMule.exe
#PRE_Compression=4
#PRE_Res_Description=eMule自动搜索下载
#PRE_Res_Fileversion=0.0.0.7
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
	
	Au3 版本:
	脚本作者:
	电子邮件:
	QQ/TM:
	脚本版本:
	脚本功能:
	
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#include <systray UDF.au3>
#include <TrayIconClick.au3>
AdlibRegister("_Quit", 1000 * 60) ;This is only for testing, so if anything go wrong, the script will exit after 1 seconds.
If ProcessExists("emule.exe") And Not WinExists("emule.exe") Then
	Local $index = _SysTrayIconIndex("emule.exe", 0, 1)
	Local $pos = _SysTrayGetButtonInfo($index, 1,3,1)  ;get the pos of emule
	Local $handle = _SysTrayGetButtonInfo($index, 1,1,1)  ;get the handle of emule
	_SysTray_ClickItem("emule", "left", 2)
;~ 	MouseClick("", $pos[0], $pos[1], 2)
;~ 	Sleep(500)
Else
	Run(@ProgramFilesDir & "\eMule\emule.exe")
	WinWait("eMule", "状态:	已连接")
EndIf

WinActivate("eMule", "状态:	已连接")
Send("!s")
ControlSetText("eMule", "搜索参数", 2183, ClipGet())
ControlClick("eMule", "搜索参数", 2189)

Func _Quit()
	TrayTip("提示", "程序已经运行1分钟了，即将自动退出！", 3000)
	Sleep(3000)
	Exit
EndFunc   ;==>_Quit
