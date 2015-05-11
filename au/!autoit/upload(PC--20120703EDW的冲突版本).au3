upload()
Func upload()
   $CmdLin1="选择要"
   WinWaitActive($CmdLin1,'',10)
   WinActivate($CmdLin1,'')
   ControlSetText($CmdLin1,'',1148,$CmdLine[1])
   Send("!o")
EndFunc
Func upload1()
   $CmdLin1="选择要加载的文件"
   WinWaitActive($CmdLin1,'',10)
   WinActivate($CmdLin1,'')
   ControlSetText($CmdLin1,'',1148,$CmdLine[1])
   Send("!o")
EndFunc