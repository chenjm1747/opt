; ----------------------------------------------------------------------------
;
; AutoIt Version: 3.1.1
; Author:         Bernd Kemmler
;
; Script Function:
;	Create and write a log file
;
; ----------------------------------------------------------------------------

#include-once

#include <Constants.au3>
#include <Misc.au3>
#include <Date.au3>
#include <bk-account.au3>

AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("RunErrorsFatal", 0)

Global $intLogFile

; Create log file
Func _OpenLogFile($strPath="",$strFilename="",$strHeader="",$strInfos="")
	If StringLen($strPath)=0 Then $strPath = @ScriptDir
	If StringLen($strFilename)=0 Then $strFilename = StringReplace(StringReplace(@ScriptName,"exe","log"),"au3","log")
	DirCreate($strPath)
	$intLogFile = FileOpen($strPath & "\" & $strFilename, 2)
	If StringLen($strHeader)>0 Then
		FileWriteLine($intLogFile, $strHeader)
		FileWriteLine($intLogFile, "Computer:        " & @Computername)
		FileWriteLine($intLogFile, "CPU:             " & StringStripWS(regRead("HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\CentralProcessor\0", "processornamestring"),3))
		FileWriteLine($intLogFile, "OS:              " & @OSVersion)
		FileWriteLine($intLogFile, "OS Language:     " & @OSLang)
		FileWriteLine($intLogFile, "OS Version:      " & @OSBuild & "." & @OSServicePack)
		FileWriteLine($intLogFile, "Logon Domain:    " & @LogonDomain & " (" & @LogonDNSDomain & ")")
		FileWriteLine($intLogFile, "Logon Server:    " & @LogonServer)
		FileWriteLine($intLogFile, "System dir:      " & @SystemDir)
		FileWriteLine($intLogFile, "Total memory MB: " & TotalMemory())
		FileWriteLine($intLogFile, "User:            " & _CurrentUser())
		FileWriteLine($intLogFile, "Admin rights:    " & _iif (IsAdmin() = 1, "yes", "no"))
		FileWriteLine($intLogFile, "Profile dir:     " & @UserProfileDir)
		FileWriteLine($intLogFile, "Date:            " & _NowDate())
		FileWriteLine($intLogFile, "Time:            " & StringFormat("%02d:%02d:%02d", @HOUR, @MIN, @SEC))
		FileWriteLine($intLogFile, $strInfos)
		FileWriteLine($intLogFile, "")
		FileWriteLine($intLogFile, "Log file:")
	EndIf
EndFunc   ;==>OpenLogFile


Func TotalMemory()
	Local $arrMemory
	
	$arrMemory = MemGetStats()
	Return Round(($arrMemory[1] / 1024) + 0.5, 0)
EndFunc   ;==>TotalMemory


; Write Message into exporer windows and into the Log
Func _WriteLog($strLogMessage="", $intEmptyLine=0)
	Local $strSeperator
	
	If $intLogFile=0 Then _OpenLogFile()
	If StringLeft($strLogMessage, 1) <> ">" Then $strSeperator = "- "
	FileWriteLine($intLogFile, $strSeperator & $strLogMessage & _iif($intEmptyLine=1,@CRLF,""))
EndFunc   ;==>WriteLog


; Close log file
Func _CloseLogFile()
	FileClose($intLogFile)
EndFunc   ;==>CloseLogFile