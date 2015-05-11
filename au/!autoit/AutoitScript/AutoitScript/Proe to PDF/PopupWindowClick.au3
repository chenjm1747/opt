#NoTrayIcon
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_icon=PopupWindowClick.exe|-1
#PRE_Outfile=PopupWindowClick.exe
#PRE_Res_Comment=弹窗自动点击程序
#PRE_Res_Description=弹窗自动点击程序
#PRE_Res_Fileversion=1.2.0.8
#PRE_Res_Fileversion_AutoIncrement=y
#PRE_Res_LegalCopyright=zaoki
#PRE_Res_requestedExecutionLevel=None
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
While 1
	tanchuang("问题", "是(&Y)", 6)
	tanchuang("AutoCAD", "是否将改动保存到", 6)
	tanchuang("AutoCAD 警告", "准备重生成 -- 是否继续？", 1)
	tanchuang("代理信息", "", 1)
	tanchuang("Adobe Acrobat", "要在关闭前保存对", "[CLASS:Button; INSTANCE:2]")
	tanchuang("确认另存为", "", "[CLASS:Button; INSTANCE:1]")
	tanchuang("参照 - 未融入的参照文件", "", "[CLASS:Button; INSTANCE:1]")
	tanchuang("AutoCAD 警告", "无法使用此绘图仪配置", "[CLASS:Button; INSTANCE:1]")
	tanchuang("另存为 PDF", "是(&Y)", "[CLASS:Button; INSTANCE:1]")
	If WinExists("图形修复管理器") Then WinClose("图形修复管理器")
	If WinExists("外部参照") Then WinClose("外部参照")	
	If WinExists("图形修复管理器") Then WinClose("图形修复管理器")
	
	If Not WinExists("proetopdf_zaoki.com") Then Exit ;判断是否存在主进程
	Sleep(100)
WEnd

Func tanchuang($biaoti, $wenzi, $anniu)
	If WinExists($biaoti, $wenzi) Then ControlClick($biaoti, $wenzi, $anniu)
EndFunc   ;==>tanchuang