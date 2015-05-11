#Region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=ICO\addressbook64.ico
#PRE_Outfile=填写日志.exe
#PRE_Compression=4
#PRE_UseX64=n
#PRE_Res_Fileversion=0.0.0.7
#PRE_Res_Fileversion_AutoIncrement=p
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
$oIE = _IECreate ("http://192.188.1.24",0,0) 
$oForm = _IEFormGetObjByName ($oIE, "login")
$oQuery = _IEFormElementGetObjByName ($oForm, "LoginName")
_IEFormElementSetValue ($oQuery, "陈俊")
$oQuery = _IEFormElementGetObjByName ($oForm, "Password")
_IEFormElementSetValue ($oQuery, "112211") 
$oQuery = _IEFormElementGetObjByName ($oForm, "submit")
_IEAction($oQuery ,"click")
;_IEFormSubmit($oForm)
_IELoadWait($oIE)
_IENavigate($oIE, "http://192.188.1.24/mylog/list.asp")
WinSetState("[CLASS:IEFrame]","",@SW_MAXIMIZE)
_IEAction ($oIE, "visible")
WinFlash("Untitled - Windows Internet Explorer")