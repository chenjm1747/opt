#Region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=..\..\ICO\简约系统桌面图标下载8.ico
#PRE_Outfile=D:\GoogleCode\AutoitScript\手机FTP连接\AVPlayer传输.exe
#PRE_Compression=4
#PRE_UseX64=n
#PRE_Res_Description=AVPlayer电影传输
#PRE_Res_Fileversion=0.0.0.4
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
#include <IE.au3> 
Local $i,$flag
For $i=0 To 9
	Local $oIE = _IECreate("http://192.168.1.10"&$i&":8080",0,0)
	$s=_IEBodyReadHTML ($oIE)
	If StringInStr($s,"AVPlayer's Folder") Or StringInStr($s,"Index of") Then 
		$flag=1
		ExitLoop
	EndIf	
	_IEQuit($oIE)
Next
If $flag=1 Then
	_IECreate("http://192.168.1.10"&$i&":8080",0,1)
	WinSetState("AVPlayer's Folder","",@SW_MAXIMIZE)
Else
	TrayTip("警告","你似乎还没有打开AVPlayer并打开WIFI传输",5000)
	Sleep(5000)
EndIf

