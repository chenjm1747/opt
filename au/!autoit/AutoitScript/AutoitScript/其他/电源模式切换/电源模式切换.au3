#Region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=..\..\..\ICO\1.ico
#PRE_Outfile=电源模式切换.exe
#PRE_Compression=4
#PRE_Res_Description=电源模式切换
#PRE_Res_Fileversion=0.0.0.1
#PRE_Res_Fileversion_AutoIncrement=y
#PRE_Res_LegalCopyright=zaoki
#PRE_Res_requestedExecutionLevel=None
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#Region ACN预处理程序参数(常用参数)
;#PRE_Res_Field=AutoIt Version|%AutoItVer%		;自定义资源段
;#PRE_Run_Tidy=                   				;脚本整理
;#PRE_Run_Obfuscator=      						;代码迷惑
;#PRE_Run_AU3Check= 							;语法检查
;#PRE_Run_Before= 								;运行前
;#PRE_Run_After=								;运行后
;#PRE_UseX64=n									;使用64位解释器
;#PRE_Compile_Both								;进行双平台编译
#EndRegion ACN预处理程序参数设置完成
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

 Au3 版本: 
 脚本作者: 
 电子邮件: 
	QQ/TM: 
 脚本版本: 
 脚本功能: 

#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

Run('control.exe Powercfg.cpl')
WinWait("电源选项","电源计划有助于最大化计算机的性能或者节能")
If ControlCommand("电源选项","电源计划有助于最大化计算机的性能或者节能","[CLASS:Button; INSTANCE:1]","IsChecked", "") Then
	ControlCommand("电源选项","电源计划有助于最大化计算机的性能或者节能","[CLASS:Button; INSTANCE:3]","Check", "")
	TrayTip("提示","成功切换到省电模式！",3000)
Else
	ControlCommand("电源选项","电源计划有助于最大化计算机的性能或者节能","[CLASS:Button; INSTANCE:1]","Check", "")
	TrayTip("提示","成功切换到高性能模式！",3000)
EndIf
WinClose("电源选项","电源计划有助于最大化计算机的性能或者节能")
Sleep(3000)

