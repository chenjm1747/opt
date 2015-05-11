While 1
	#NoTrayIcon
	tanchuang("问题", "是(&Y)", 6)
	tanchuang("AutoCAD", "是否将改动保存到", 6)
	tanchuang("AutoCAD 警告", "准备重生成 -- 是否继续？", 1)
	tanchuang("代理信息", "", 1)
	tanchuang("Adobe Acrobat", "要在关闭前保存对", "[CLASS:Button; INSTANCE:2]")
	
	If WinExists("图形修复管理器") Then WinClose("图形修复管理器")
	
	If Not ProcessExists("AutoIt3.exe") Then Exit
	Sleep(100)
WEnd

Func tanchuang($biaoti, $wenzi, $anniu)
	If WinExists($biaoti, $wenzi) Then ControlClick($biaoti, $wenzi, $anniu)
EndFunc   ;==>tanchuang