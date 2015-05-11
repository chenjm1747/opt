; ----------------------------------------------------------------------------
;
; AutoIt Version: 3.1.1
; Author:         Bernd Kemmler
;
; Script Function:
;	Functions to read files
;
; ----------------------------------------------------------------------------

#include-once

#include <Constants.au3>

opt("MustDeclareVars", 1)

; Read contents of file in variable
Func _FileReadComplete($strFilename)
	
	Return FileRead($strFilename,FileGetSize($strFilename))
EndFunc