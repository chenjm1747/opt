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

AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("RunErrorsFatal", 0)


; Read from registry the current user name
Func _CurrentUser()
	Return RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DefaultUserName")
EndFunc
