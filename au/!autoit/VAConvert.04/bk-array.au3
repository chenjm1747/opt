; ----------------------------------------------------------------------------
;
; AutoIt Version: 3.1.1
; Author:         Bernd Kemmler
;
; Script Function:
;	Arry functions
;
; ----------------------------------------------------------------------------

#include-once

#include <Constants.au3>
#include <array.au3>
#include <misc.au3>

opt("MustDeclareVars", 1)

; Rebuild the array, delete the first entry
Func _ArraySkipFirst($arrHelp)
	Local $arr[1]
	Local $int
	
	ReDim $arr[ubound($arrHelp)-1]
	For $int=1 to ubound($arrHelp)-1
		$arr[$int-1] = $arrHelp[$int]
	Next
	Return $arr
EndFunc


Func _ArrayAddOnce(Byref $arrHelp, $strValue)
	Local $int
	Local $intFound = 0
	
	For $int=0 to ubound($arrHelp)-1
		If $arrHelp[$int]=$strValue Then
			$intFound = 1
			ExitLoop
		EndIf
	Next
	If $intFound=0 Then
		If IsArray($arrHelp) Then
			_ArrayAdd($arrHelp,$strValue)
		Else
			$arrHelp = _ArrayCreate($strValue)
		EndIf
	EndIf
EndFunc
	
	
Func _Array2String($arrHelp,$strDelimiter,$intHex,$intPrecision)
	Local $int
	Local $Return = ""
	
	For $int=0 to ubound($arrHelp)-1
		$Return &= _Iif($intHex=1,Hex($arrHelp[$int],$intPrecision),StringFormat("%0" & $intPrecision & "d",$arrHelp[$int])) & _IIf($int<ubound($arrHelp)-1,$strDelimiter,"")
	Next
	Return $Return															
EndFunc


Func _ArrayAddArray(Byref $arrHelp,Byref $arr2Add, $intOnce = 1)
	Local $intCount
	
	For $intCount=0 To UBound($arr2Add)-1
		If IsArray($arrHelp) Then
			If $intOnce=1 Then
				_ArrayAddOnce($arrHelp,$arr2Add[$intCount])
			Else
				_ArrayAdd($arrHelp,$arr2Add[$intCount])
			EndIf
		Else
			$arrHelp = _ArrayCreate($arr2Add[$intCount])
		EndIf
	Next	
EndFunc


Func _ArrayDeleteEntry(Byref $arrHelp,$strEntry)
	Local $intCount
	
	For $intCount=UBound($arrHelp)-1 To 0 Step -1
		If $arrHelp[$intCount]=$strEntry Then
			_ArrayDelete($arrHelp,$intCount)
		EndIf
	Next	
EndFunc