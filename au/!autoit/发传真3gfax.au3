#Include <Date.au3>
#include <IE.au3>
;#include <FTPEx.au3>  
;#include <SQLite.au3>  
;#include <SQLite.dll.au3>  
Global  $sname1="【名称】"
HotKeySet("{F5}", "captureEsc")
While 1
    Sleep(500)
WEnd

Func captureEsc()
$file = FileOpen("发传真.txt", 0)
If $file = -1 Then
	MsgBox(0, "错误", "不能打开文件.")
	Exit
EndIf
$stitle=WinGetTitle("[active]") 
$i=0
; 每次读取一行文本,直到文件结束.
While 1
	$line = FileReadLine($file)
	If @error = -1 Then ExitLoop
$i=$i+1	
$as=StringSplit($line, ",",1)
$afax=$as[2]
$sname=$as[1]
$as=StringSplit($afax, "-",1)
$sfaxquhao=$as[1]
$sfax=$as[2]

If $i>1000 Then 
	$i=0
	MsgBox(0,"","")
EndIf
WinActivate ($stitle)
WinWait ($stitle)
Send("{home}")
Send("^h")
WinWait ("查找和替换")
Send($sname1);
Send("{TAB}");
Send("【"&$sname&"】");
$sname1="【"&$sname&"】";
Send("!a")
WinWait ("Microsoft Office Word")
Send("{esc}")
Send("{esc}")
Send("{esc}")
If WinExists("AOFAX传真发送") Then
	WinActivate ("AOFAX传真发送")
	Sleep(500)
Send("!{f4}")
WinActivate ($stitle)
WinWait ($stitle)
Sleep(500)
EndIf

Send("^p")
WinWait ("打印")
Send("{enter}")
WinWait ("AOFAX传真发送")
Send("{TAB}")
Send("{TAB}")
Send("{TAB}")
Send("{TAB}")
Send("{TAB}")
Send("{TAB}")
Send($sfaxquhao)
Send("{TAB}")
Send($sfax)
Send("!s")
Wend

FileClose($file)
EndFunc


