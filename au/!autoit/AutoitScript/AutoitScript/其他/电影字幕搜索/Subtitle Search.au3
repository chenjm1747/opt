#Region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=..\..\ICO\简约系统桌面图标下载22.ico
#PRE_Outfile=找字幕.exe
#PRE_UseUpx=n
#PRE_UseX64=n
#PRE_Res_Comment=自动找字幕程序
#PRE_Res_Description=取视频文件中的中文名字找字幕，自动将原视频文件名复制到剪贴板。
#PRE_Res_Fileversion=0.0.0.6
#PRE_Res_Fileversion_AutoIncrement=y
#PRE_Res_LegalCopyright=ZaoKi
#PRE_Res_requestedExecutionLevel=None
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#Include <Array.au3>
Local $gongfu[21],$a
Local $flag=0
Local $filename = FileOpenDialog("请选择需要添加字幕的视频文件", "", "视频文件 (*.mkv;*.avi;*.mov;*.mpg;*.mp4)") ;弹出选择文件对话框
If @error Then Exit ;如果没有选择或选择错误，则退出
Local $array = StringSplit($filename, "\")
Local $name = $array[$array[0]]
Local $i = StringRegExp($name, "[\x{4e00}-\x{9fff}]+\d?", 3)
If @error Then
	ShellExecute("http://www.shooter.cn")
	TrayTip("提示", "文件名中没有中文，请手动搜索！", 5)
	Sleep(5000)
	Exit
EndIf
For $a=1 To 20
	$gongfu[$a]=IniRead(@ScriptDir&"\Subtitle Search.ini","忽略关键词","关键词"&$a,"电影")
Next
;_ArrayDisplay($gongfu)
For $a=1 To 20
	If $i[0]=$gongfu[$a] Then $flag=1
Next

If $flag Then
	ShellExecute("http://www.shooter.cn/search/" & $i[1])
Else
	ShellExecute("http://www.shooter.cn/search/" & $i[0])
EndIf
ClipPut(StringLeft($name, StringLen($name) - 4))