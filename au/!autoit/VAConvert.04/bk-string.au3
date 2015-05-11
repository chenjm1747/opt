; ----------------------------------------------------------------------------
;
; AutoIt Version: 3.1.1
; Author:         Bernd Kemmler
;
; Script Function:
;	String functions
;
; ----------------------------------------------------------------------------

#include-once

#include <array.au3>
#include <string.au3>
#include <misc.au3>

AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("RunErrorsFatal", 0)


; Read from registry the current user name
Func _StringFill($str2Fill,$intStart,$intLen,$strChar)
	Local $strFill 
	Local $strHelp
	
	If $intStart>0 and $intLen>0 Then
		$strFill = _StringRepeat("#",$intLen)
		$strHelp = _Iif($intStart>1,StringLeft($str2Fill,$intStart-1),"") & _ 
		           $strFill & _ 
					  _Iif(StringLen($str2Fill)>$intStart+$intLen-1,StringMid($str2Fill,$intStart+$intLen),"") 
	Else
		$strHelp = $str2Fill
	EndIf
	Return $strHelp
EndFunc


Func _StringReplace($strText,$strSearch,$strReplace,$strSpecialChars = "",$intIgnoreWS = 0)
	Local $intPos
	Local $intFound
	Local $strCharLeft
	Local $strCharRight
	Local $strHelp

	Do 
		$intPos = StringInStr($strText,$strSearch)
		$intFound = 0
		If $intPos>0 Then
			$strCharLeft =  StringMid($strText,$intPos-1,1)
			$strCharRight = StringMid($strText,$intPos+StringLen($strSearch),1)
			$strHelp &= StringLeft($strText,$intPos-1)  
			If (_StringIsWS($strCharLeft,$strSpecialChars)=1 And _StringIsWS($strCharRight,$strSpecialChars)=1) Or $intIgnoreWS=1 Then
				$strHelp &= $strReplace 
			Else
				$strHelp &= StringMid($strText,$intPos,StringLen($strSearch)) 
			EndIf
			$strText = StringMid($strText,$intPos+StringLen($strSearch))
			$intFound = 1
		EndIf
	Until $intFound=0
	Return $strHelp & $strText
EndFunc


Func _StringInStr($strText,$strSearch,$strSpecialChars = "",$intIgnoreWS = 0)
	Local $intPos
	Local $strCharLeft
	Local $strCharRight
	Local $Return 

	$intPos = StringInStr($strText,$strSearch)
	If $intPos>0 Then
		$strCharLeft =  StringMid($strText,$intPos-1,1)
		$strCharRight = StringMid($strText,$intPos+StringLen($strSearch),1)
		If (_StringIsWS($strCharLeft,$strSpecialChars)=1 And _StringIsWS($strCharRight,$strSpecialChars)=1) Or $intIgnoreWS=1 Then
			$Return = $intPos
		EndIf
	EndIf
	Return $Return
EndFunc


Func _StringIsWS($strText,$strSpecialChars = "")
	Local $Return = 0
	
	Select
	Case $strText=" " Or _ 
		  $strText=@CR Or _ 
		  $strText=@LF Or _ 
		  $strText="" Or _ 
		  $strText=@TAB Or _ 
		  StringInstr($strSpecialChars,$strText)>0
		$Return = 1
	EndSelect
	Return $Return
EndFunc


Func _StringSplit($strHelp, $strDelimiter, $intFlag = 0)
	Local $arrHelp
	
	$arrHelp = StringSplit($strHelp,$strDelimiter,$intFlag)
	_ArrayDelete($arrHelp,0)
	Return $arrHelp
EndFunc	
	
	
Func _GetAscValuesOfString($strHelp)
	Local $intCount
	Local $strAsc
	
	For $intCount=1 to StringLen($strHelp)
		$strAsc &= String(Asc(StringMid($strHelp,$intCount,1))) & _Iif($intCount<StringLen($strHelp),",","")
	Next
	Return $strAsc
EndFunc