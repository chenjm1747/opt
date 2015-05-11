
Local $file = FileOpen("D:\微云网盘\2100803\1旅行社联系电话.txt", 0)
Local $file1 = FileOpen("D:\微云网盘\2100803\2旅行社联系电话.txt", 2)
; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; Read in lines of text until the EOF is reached
While 1
    $sname = FileReadLine($file)
	    If @error = -1 Then ExitLoop
	$szjl = FileReadLine($file)
	$stel = FileReadLine($file)
	$smob = FileReadLine($file)
	$sdizhi = FileReadLine($file)
	   FileWriteLine($file1,$sname&$szjl&$stel&$smob&$sdizhi)
 FileWriteLine($file1,"")
 ;   MsgBox(0, "Line read:", $line)
WEnd

FileClose($file)
FileClose($file1)