; ----------------------------------------------------------------------------
;
; AutoIt Version: 3.1.1
; Author:         Bernd Kemmler
;
; Script Function:
;	Convert VBScript to AutoIt 3.1.1
;
; Version 0.4
; ----------------------------------------------------------------------------

#NoTrayIcon
;Options
#region Options
AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("RunErrorsFatal", 0)
AutoItSetOption("TrayIconHide", 1)
#endregion

; Variable declarations
#region Variables
Global Const $strVersion = "0.4"
Global Const $strMask = "#"
Global Const $strSpecial = ".,()<>=+-"
Global $arrVBFile
Global $arrVBFileMarked
Global $arrAU3File
Global $intMaxSteps
#endregion

; Include files
#region Includes
#include <bk-array.au3>
#include <bk-file.au3>
#include <bk-string.au3>
#include <array.au3>
#include <math.au3>
#include <GuiConstants.au3>
#endregion

Main()

Func Main()
	Local $arrIncludes
	
	If $CmdLine[0] > 0 Then
		StartConvert($CmdLine[1], StringReplace($CmdLine[1], "vbs", "au3"))
	Else
		DisplayGUI()
	EndIf
EndFunc   ;==>Main


Func StartConvert($strSourceFile, $strDestFile)
	Local $arrIncludes
	
	If StringLen($strDestFile) = 0 Then $strDestFile = StringReplace($strSourceFile, "vbs", "au3")
	ProgressOn("VBScript converter v" & $strVersion, "Read file", "", 0, 0)
	ReadVBFile($strSourceFile)
	$intMaxSteps = (UBound($arrVBFile) - 1) * 4 + 5
	RefreshProgressBar("", "Preperations")
	MarkSpecialParts()
	RefreshProgressBar("", "Replace simple commands")
	ReplaceSimpleCommands($arrIncludes)
	RefreshProgressBar("", "Replace complex commands")
	ChangeComplexStructures($arrIncludes)
	RefreshProgressBar("", "Write AU3 file")
	WriteAU3File($strDestFile, $arrIncludes)
	ProgressOff()
EndFunc   ;==>StartConvert


Func RefreshProgressBar($strSubtext, $strMain = "")
	Global $intSteps
	
	$intSteps += 1
	If StringLen($strMain) > 0 Then
		ProgressSet($intSteps / $intMaxSteps * 100, $strSubtext, $strMain)
	Else
		ProgressSet($intSteps / $intMaxSteps * 100, $strSubtext)
	EndIf
EndFunc   ;==>RefreshProgressBar


Func DisplayGUI()
	Local $intWindow
	Local $intLblSource
	Local $intLblDestination
	Local $intBtnSource
	Local $intBtnDestination
	Local $intBtnConvert
	Local $intBtnExit
	Local $intMsg
	Local $intConvert
	Local $strSource
	Local $strDest
	
	$intWindow = GUICreate("Convert VBScript to AutoIt by Bernd Kemmler v" & $strVersion, 500, 180)
	$intLblSource = GUICtrlCreateLabel("Source File", 20, 30, 400, 20)
	$intLblDestination = GUICtrlCreateLabel("Destination File", 20, 70, 400, 20)
	$intBtnSource = GUICtrlCreateButton("Select...", 410, 20, 70, 30)
	$intBtnDestination = GUICtrlCreateButton("Select...", 410, 60, 70, 30)
	$intBtnConvert = GUICtrlCreateButton("Convert", 154, 130, 70, 30)
	$intBtnExit = GUICtrlCreateButton("Exit", 264, 130, 70, 30)
	
	GUISetState()
	While 1
		$intMsg = GUIGetMsg()
		Select
			Case $intMsg = $GUI_EVENT_CLOSE Or $intMsg = $intBtnExit
				ExitLoop
			Case $intMsg = $intBtnSource
				GUICtrlSetData($intLblSource, FileOpenDialog("Select VBS Source File", ".", "VBS (*.vbs)", 3))
				GUICtrlSetData($intLblDestination,StringReplace(GUICtrlRead($intLblSource), "vbs", "au3"))
			Case $intMsg = $intBtnDestination
				GUICtrlSetData($intLblDestination, FileOpenDialog("Select Au3 Dest File", ".", "AutoIt (*.au3)"))
			Case $intMsg = $intBtnConvert
				$intConvert = 1
				ExitLoop
		EndSelect
	WEnd
	$strSource = GUICtrlRead($intLblSource)
	$strDest = GUICtrlRead($intLblDestination)
	GUIDelete($intWindow)
	If $intConvert = 1 Then StartConvert($strSource, $strDest)
EndFunc   ;==>DisplayGUI


Func ReadVBFile($strFile)
	Local $strVB
	
	$strVB = _FileReadComplete ($strFile)
	$strVB = StringReplace($strVB, Chr(160), Chr(32))
	$arrVBFile = SplitCRLF($strVB)
	$arrVBFileMarked = SplitCRLF($strVB)
	$arrAU3File = SplitCRLF($strVB)
EndFunc   ;==>ReadVBFile


Func WriteAU3File($strFile, $arrIncludes)
	Local $intLine
	Local $intFile
	
	$intFile = FileOpen($strFile, 2)
	FileWriteLine($intFile, "; ----------------------------------------------------------------------------")
	FileWriteLine($intFile, ";")
	FileWriteLine($intFile, "; VBScript to AutoIt Converter v" & $strVersion)
	FileWriteLine($intFile, ";")
	FileWriteLine($intFile, "; ----------------------------------------------------------------------------")
	FileWriteLine($intFile, "")
	For $intLine = 0 To UBound($arrIncludes) - 1
		FileWriteLine($intFile,"#include <" & $arrIncludes[$intLine] & ">")
	Next
	FileWriteLine($intFile, "")
	For $intLine = 0 To UBound($arrAU3File) - 1
		FileWriteLine($intFile, $arrAU3File[$intLine])
	Next
	FileClose($intFile)
EndFunc   ;==>WriteAU3File


Func SplitCRLF(ByRef $str)
	Local $arr
	
	$arr = _StringSplit ($str, @CRLF, 1)
	Return $arr
EndFunc   ;==>SplitCRLF


Func MarkSpecialParts()
	Local $intLine
	Local $intPos
	Local $intLen
	
	For $intLine = 0 To UBound($arrVBFileMarked) - 1
		RefreshProgressBar("Prepare internal structures")
		MarkSpecialPartsofLine($arrVBFileMarked[$intLine])
	Next
EndFunc   ;==>MarkSpecialParts


Func MarkSpecialPartsofLine(ByRef $strLine)
	Local $intPos
	Local $intLen
	
	; Replace ""
	$strLine = StringReplace($strLine, """""", $strMask & $strMask)
	; Search for text ->"
	Do
		$intPos = StringInStr($strLine, """")
		If $intPos > 0 Then
			$intLen = StringInStr(StringMid($strLine, $intPos + 1), """")
			$strLine = _stringFill ($strLine, $intPos, $intLen + 1, $strMask)
		EndIf
	Until $intPos = 0
	; Search for comments ->'
	$intPos = StringInStr($strLine, "'")
	If $intPos = 0 Then StringInStr($strLine, ";")
	If $intPos > 0 Then
		$strLine = _stringFill ($strLine, $intPos + 1, StringLen($strLine) - $intPos, $strMask)
	EndIf
EndFunc   ;==>MarkSpecialPartsofLine


Func ReadCommandsFormFile($strFile)
	Local $strCommands
	Local $arrCommands
	
	$strCommands = _FileReadComplete ($strFile)
	$strCommands = StringReplace($strCommands, @CRLF, "|")
	$arrCommands = _StringSplit ($strCommands, "|")
	Return $arrCommands
EndFunc   ;==>ReadCommandsFormFile


Func ReplaceSimpleCommands(ByRef $arrIncludes)
	Local $arrCommands
	Local $intReplace
	Local $intPos
	Local $intLine
	
	; File syntax: (the different columns are seperated through a | character
	; 1. VB command
	; 2. AutoIt command
	; 3. Use whitespace or not
	; 4. Comment complete line
	; 5. Check for parenthesis
	; 6. needed include file
	$arrCommands = ReadCommandsFormFile(@ScriptDir & "\VATable.txt")
	For $intLine = 0 To UBound($arrVBFileMarked) - 1
		RefreshProgressBar("Change simple command and comments")
		For $intReplace = 0 To UBound($arrCommands) - 1 Step 6
			$intPos = StringInStr($arrVBFileMarked[$intLine], $arrCommands[$intReplace])
			If $intPos > 0 Then
				If Number($arrCommands[$intReplace + 3]) = 1 Then ; Comment for complete line
					$arrVBFileMarked[$intLine] = ";VA " & $arrVBFileMarked[$intLine]
					$arrVBFileMarked[$intLine] = _stringFill ($arrVBFileMarked[$intLine], 2, StringLen($arrVBFileMarked[$intLine]) - 1, $strMask)
					$arrAU3File[$intLine] = ";VA " & $arrAU3File[$intLine]
					MarkSpecialPartsofLine($arrVBFileMarked[$intLine])
				Else
					$arrVBFileMarked[$intLine] = _StringReplace ($arrVBFileMarked[$intLine], $arrCommands[$intReplace], $arrCommands[$intReplace + 1], $strSpecial, Number($arrCommands[$intReplace + 2]))
					$arrAU3File[$intLine] = _StringReplace ($arrAU3File[$intLine], $arrCommands[$intReplace], $arrCommands[$intReplace + 1], $strSpecial, Number($arrCommands[$intReplace + 2]))
					If StringLen($arrCommands[$intReplace + 5]) > 0 Then
						_ArrayAddOnce ($arrIncludes, $arrCommands[$intReplace + 5])
					EndIf
					If StringInStr($arrCommands[$intReplace + 1], """") > 0 Then MarkSpecialPartsofLine($arrVBFileMarked[$intLine])
					If Number($arrCommands[$intReplace + 4]) = 1 Then ; Comment for complete line
						CheckAndSetParenthesis($intLine, StringInStr($arrVBFileMarked[$intLine], $arrCommands[$intReplace + 1]))
					EndIf
				EndIf
				
			EndIf
		Next
	Next
EndFunc   ;==>ReplaceSimpleCommands


Func ChangeComplexStructures(ByRef $arrIncludes)
	Local $arrVariables
	Local $arrFuncNames
	Local $arrCommands
	Local $intLine
	Local $intCount
	
	$arrCommands = ReadCommandsFormFile(@ScriptDir & "\VACommands.txt")
	For $intLine = 0 To UBound($arrVBFileMarked) - 1
		RefreshProgressBar("Collect variables and function names")
		; Collect variable names
		GetVariableNames($intLine, $arrVariables, $arrCommands)
		; Collect function and variable names
		GetFunctionNames($intLine, $arrFuncNames, $arrVariables)
		;Remove function names from variable list
		For $intCount = 0 To UBound($arrFuncNames) - 1
			_ArrayDeleteEntry ($arrVariables, $arrFuncNames[$intCount])
		Next
	Next
	;_ArraySort($arrVariables,1) ; endless loop at the moment
	For $intLine = 0 To UBound($arrVBFileMarked) - 1
		RefreshProgressBar("Change variables, function and structures")
		; Change Variables name (leading $)
		VBChangeVariables($intLine, $arrVariables)
		; Change functions calls and
		VBChangeFunction($intLine, $arrFuncNames)
		VBChangeSelect($intLine)
		VBRedim($intLine)
	Next
EndFunc   ;==>ChangeComplexStructures


; Collect variable names
Func GetVariableNames($intLine, ByRef $arrVariables, ByRef $arrCommands)
	Local $intPosBegin
	Local $intPosEnd
	Local $strVars
	Local $arrVars
	Local $intI
	Local $intJ
	Local $intFound
	
	; Find declared variables and constants
	If StringInStr($arrVBFileMarked[$intLine], "Dim") Or _
			StringInStr($arrVBFileMarked[$intLine], "Const") Then
		; Search for Dim
		If StringInStr($arrVBFileMarked[$intLine], "Dim") Then
			$intPosBegin = StringInStr($arrVBFileMarked[$intLine], "Dim")
			$strVars = StringStripWS(StripSpecialChars(StringMid($arrVBFileMarked[$intLine], $intPosBegin + 3), "() ;'#"), 3)
		EndIf
		; Search for Const
		If StringInStr($arrVBFileMarked[$intLine], "Const") Then
			; Search for Dim
			$intPosBegin = StringInStr($arrVBFileMarked[$intLine], "Const")
			$intPosEnd = StringInStr($arrVBFileMarked[$intLine], "=")
			$strVars = StringStripWS(StripSpecialChars(StringMid($arrVBFileMarked[$intLine], $intPosBegin + 5, $intPosEnd - $intPosBegin - 5), "() ;'#"), 3)
		EndIf
		; Strip non needed chars
		$strVars = StripSpecialChars($strVars, "() ;'")
		If StringRight($strVars, 1) = "_" Then $strVars = StringMid($strVars, 1, StringLen($strVars) - 1)
		; Add variables names to array
		$arrVars = _StringSplit ($strVars, ",")
		_ArrayAddArray ($arrVariables, $arrVars)
	EndIf
	; Search for undeclared variables
	$strVars = StringReplace($arrVBFileMarked[$intLine], "#", "")
	If StringInStr($strVars, ";") > 0 Then $strVars = StringLeft($strVars, StringInStr($strVars, ";") - 1)
	$arrVars = StringSplit(StringStripWS($strVars, 3), " (),=<>&+-/_")
	;_ArrayDisplay($arrVars,"")
	If $arrVars[1] <> "Func" Then
		For $intJ = 1 To UBound($arrVars) - 1
			$arrVars[$intJ] = StringStripWS($arrVars[$intJ], 3)
			Select
				Case StringLen(StringStripWS($arrVars[$intJ], 3)) = 0 Or _
						StringIsFloat(StringStripWS($arrVars[$intJ], 3)) Or _ 
						StringIsInt(StringStripWS($arrVars[$intJ], 3)) Or _ 
						StringLeft(StringStripWS($arrVars[$intJ], 3), 1) = "$"
					; Nothing to Do
				Case Else
					If StringInStr($arrVars[$intJ], ".") > 0 Then
						$arrVars[$intJ] = StringStripWS(StringLeft($arrVars[$intJ], StringInStr($arrVars[$intJ], ".") - 1), 3)
					EndIf
					$intFound = 0
					For $intI = 0 To UBound($arrCommands) - 1
						If StringLower($arrVars[$intJ]) = StringLower($arrCommands[$intI]) Then
							$intFound = 1
							ExitLoop
						EndIf
					Next
					If $intFound = 0 Then
						_ArrayAddOnce ($arrVariables, $arrVars[$intJ])
					EndIf
			EndSelect
		Next
	EndIf
EndFunc   ;==>GetVariableNames


; Collect function and variable names
Func GetFunctionNames($intLine, ByRef $arrFuncNames, ByRef $arrVariables)
	Local $intPosBegin
	Local $intPosEnd
	Local $strVars
	Local $arrVars
	
	If StringInStr($arrAU3File[$intLine], "Func") > 0 And StringInStr($arrAU3File[$intLine], "EndFunc") = 0 Then
		$intPosBegin = StringInStr($arrAU3File[$intLine], "(")
		$intPosEnd = StringInStr($arrAU3File[$intLine], ")")
		If $intPosEnd = 0 Then
			; continue until ')' is found
		Else
			$strVars = StringMid($arrAU3File[$intLine], $intPosBegin + 1, $intPosEnd - $intPosBegin - 1)
		EndIf
		; Strip non needed chars
		$strVars = StripSpecialChars($strVars, "() ")
		If StringRight($strVars, 1) = "_" Then $strVars = StringMid($strVars, 1, StringLen($strVars) - 1)
		; Add variables names to array
		$arrVars = _StringSplit ($strVars, ",")
		_ArrayAddArray ($arrVariables, $arrVars)
		; Get Func name
		$intPosBegin = StringInStr($arrAU3File[$intLine], "Func")
		$intPosEnd = StringInStr($arrAU3File[$intLine], "(")
		_ArrayAddOnce ($arrFuncNames, StringStripWS(StringMid($arrAU3File[$intLine], $intPosBegin + 4, $intPosEnd - $intPosBegin - 4), 3))
	EndIf
EndFunc   ;==>GetFunctionNames


; Add $ to variable name
Func VBChangeVariables($intLine, $arrVariables)
	Local $intCount
	
	For $intCount = 0 To UBound($arrVariables) - 1
		;If StringInStr($arrVBFileMarked[$intLine],$arrVariables) Then
		$arrVBFileMarked[$intLine] = _StringReplace ($arrVBFileMarked[$intLine], $arrVariables[$intCount], "$" & $arrVariables[$intCount], $strSpecial)
		$arrAU3File[$intLine] = _StringReplace ($arrAU3File[$intLine], $arrVariables[$intCount], "$" & $arrVariables[$intCount], $strSpecial)
	Next
EndFunc   ;==>VBChangeVariables


Func VBChangeFunction($intLine, $arrFuncNames)
	Global $intInsideFunc
	Global $intFuncBegin
	Global $intFuncEnd
	Global $intReturnUsed
	Local $intPosBegin
	
	If StringInStr($arrAU3File[$intLine], "EndFunc") > 0 Then
		$intInsideFunc = 0
		If $intReturnUsed = 1 Then
			$arrAU3File[$intFuncBegin] &= @CRLF & @TAB & "Local $Return"
			$arrAU3File[$intLine] = @TAB & "Return $Return" & @CRLF & $arrAU3File[$intLine]
		EndIf
	ElseIf StringInStr($arrAU3File[$intLine], "Func ") > 0 Then
		$intInsideFunc = 1
		$intFuncBegin = $intLine
		$intReturnUsed = 0
		If StringInStr($arrAU3File[$intLine], "(") = 0 Then
			$arrVBFileMarked[$intLine] &= "()"
			$arrAU3File[$intLine] &= "()"
		EndIf
	EndIf
	If StringInStr($arrAU3File[$intLine], "Func ") = 0 Then
		; Change function calls
		For $intCount = 0 To UBound($arrFuncNames) - 1
			$intPosBegin = _StringInStr ($arrAU3File[$intLine], $arrFuncNames[$intCount], $strSpecial)
			If $intPosBegin > 0 Then
				; Ignore Function headers
				$intPosBegin = StringInStr($arrAU3File[$intLine], "=")
				If $intPosBegin > 0 And _
						(StringInStr($arrAU3File[$intLine], "(") = 0 Or $intPosBegin < StringInStr($arrAU3File[$intLine], "(")) Then
					; Return values
					$intReturnUsed = 1
					$arrVBFileMarked[$intLine] = _StringReplace (StringLeft($arrVBFileMarked[$intLine], $intPosBegin - 1), $arrFuncNames[$intCount], "$Return", $strSpecial) & StringMid($arrVBFileMarked[$intLine], $intPosBegin)
					$arrAU3File[$intLine] = _StringReplace (StringLeft($arrAU3File[$intLine], $intPosBegin - 1), $arrFuncNames[$intCount], "$Return", $strSpecial) & StringMid($arrAU3File[$intLine], $intPosBegin)
				Else
					$intPosBegin = StringInStr($arrVBFileMarked[$intLine], $arrFuncNames[$intCount])
					CheckAndSetParenthesis($intLine, $intPosBegin)
					If StringInStr($arrVBFileMarked[$intLine], "(") = 0 Then
						$arrVBFileMarked[$intLine] = _StringReplace ($arrVBFileMarked[$intLine], $arrFuncNames[$intCount], $arrFuncNames[$intCount] & "(", $strSpecial)
						$arrAU3File[$intLine] = _StringReplace ($arrAU3File[$intLine], $arrFuncNames[$intCount], $arrFuncNames[$intCount] & "(", $strSpecial)
						If StringInStr($arrAU3File[$intLine], "(") > 0 Then
							$arrVBFileMarked[$intLine] &= ")"
							$arrAU3File[$intLine] &= ")"
						EndIf
					EndIf
				EndIf
			EndIf
		Next
		; Call methods with ()
		$intPosBegin = StringInStr($arrVBFileMarked[$intLine], ".")
		If $intPosBegin > 0 Then CheckAndSetParenthesis($intLine, $intPosBegin + 1)
	EndIf
EndFunc   ;==>VBChangeFunction


; Search for:
;    obj.method ""
;    Method var()
;    Method
Func CheckAndSetParenthesis($intLine, $intFuncBegin)
	Local $intSpace
	Local $intParenthesis
	Local $intComma
	Local $strCommand
	Local $intComment
	
	$strCommand = StringMid($arrVBFileMarked[$intLine], $intFuncBegin)
	$intSpace = StringInStr($strCommand, " ")
	If StringInStr($arrVBFileMarked[$intLine], "IF ") = 0 And _
			StringInStr($arrVBFileMarked[$intLine], "=") = 0 And _ 
			(StringInStr($arrVBFileMarked[$intLine], "(") > $intFuncBegin Or StringInStr($arrVBFileMarked[$intLine], "(") = 0) Then
		If $intSpace = 0 And StringInStr($arrVBFileMarked[$intLine], "(") = 0 Then ; Just add ()
			$arrVBFileMarked[$intLine] &= "()"
			$arrAU3File[$intLine] &= "()"
		Else
			$intComment = StringInStr($strCommand, ";")
			$intParenthesis = StringInStr($strCommand, "(")
			$intComma = StringInStr($strCommand, ",")
			If ($intSpace < $intParenthesis Or $intComma < $intParenthesis Or $intParenthesis = 0) Then
				If $intSpace > 0 Then
					If $intComment Then
						$arrVBFileMarked[$intLine] = StringLeft($arrVBFileMarked[$intLine], $intFuncBegin + $intSpace - 1) & "(" & StringMid($arrVBFileMarked[$intLine], $intFuncBegin + $intSpace, $intComment - $intSpace - 1) & ")" & StringMid($arrVBFileMarked[$intLine], $intFuncBegin + $intComment - 1)
						$arrAU3File[$intLine] = StringLeft($arrAU3File[$intLine], $intFuncBegin + $intSpace - 1) & "(" & StringMid($arrAU3File[$intLine], $intFuncBegin + $intSpace, $intComment - $intSpace - 1) & ")" & StringMid($arrAU3File[$intLine], $intFuncBegin + $intComment - 1)
					Else
						$arrVBFileMarked[$intLine] = StringLeft($arrVBFileMarked[$intLine], $intFuncBegin + $intSpace - 1) & "(" & StringMid($arrVBFileMarked[$intLine], $intFuncBegin + $intSpace) & ")"
						$arrAU3File[$intLine] = StringLeft($arrAU3File[$intLine], $intFuncBegin + $intSpace - 1) & "(" & StringMid($arrAU3File[$intLine], $intFuncBegin + $intSpace) & ")"
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
EndFunc   ;==>CheckAndSetParenthesis


Func VBChangeSelect($intLine)
	Global $intSideSelect
	Global $strCondition
	Local $intPos
	
	; Work on: Select case
	Select
		Case StringInStr($arrVBFileMarked[$intLine], "Select case") > 0
			$intPos = StringInStr($arrVBFileMarked[$intLine], "Select case")
			$strCondition = StringStripWS(StringMid($arrAU3File[$intLine], $intPos + 12), 3)
			$intSideSelect = 1
			$arrVBFileMarked[$intLine] = _StringReplace ($arrVBFileMarked[$intLine], "Select Case", "Select", $strSpecial)
			$arrVBFileMarked[$intLine] = StringReplace($arrVBFileMarked[$intLine], $strCondition, "")
			$arrAU3File[$intLine] = _StringReplace ($arrAU3File[$intLine], "Select Case", "Select", $strSpecial)
			$arrAU3File[$intLine] = StringReplace($arrAU3File[$intLine], $strCondition, "")
		Case StringInStr($arrVBFileMarked[$intLine], "Case") > 0 And $intSideSelect = 1 And _
				StringInStr(StringStripWS($arrVBFileMarked[$intLine], 8), "CaseElse") = 0
			$intPos = StringInStr($arrVBFileMarked[$intLine], "case") + 5
			$arrVBFileMarked[$intLine] = StringLeft($arrVBFileMarked[$intLine], $intPos - 1) & _
					$strCondition & "=" & _ 
					StringMid($arrVBFileMarked[$intLine], $intPos)
			$arrAU3File[$intLine] = StringLeft($arrAU3File[$intLine], $intPos - 1) & _
					$strCondition & "=" & _ 
					StringMid($arrAU3File[$intLine], $intPos)
			$arrVBFileMarked[$intLine] = StringReplace ($arrVBFileMarked[$intLine], ",", " and ")
			$arrAU3File[$intLine] = StringReplace ($arrAU3File[$intLine], ",", " and ")
		Case StringInStr($arrVBFileMarked[$intLine], "EndSelect") > 0
			$intSideSelect = 0
	EndSelect
EndFunc   ;==>VBChangeSelect


Func VBRedim($intLine)
	Local $intParenthesis
	Local $strReverse
	
	If StringInStr($arrVBFileMarked[$intLine], "dim") > 0 And _ 
		StringInStr($arrVBFileMarked[$intLine], "(")>0 Then
		$arrVBFileMarked[$intLine] = StringReplace($arrVBFileMarked[$intLine], "(", "[", 1)
		$arrAU3File[$intLine] = StringReplace($arrAU3File[$intLine], "(", "[", 1)
		$strReverse = _StringReverse($arrVBFileMarked[$intLine])
		$intParenthesis = StringLen($arrVBFileMarked[$intLine]) - StringInStr($strReverse, ")") + 1
		$arrVBFileMarked[$intLine] = StringLeft($arrVBFileMarked[$intLine], $intParenthesis - 1) & "]" & StringMid($arrVBFileMarked[$intLine], $intParenthesis + 1)
		$arrAU3File[$intLine] = StringLeft($arrAU3File[$intLine], $intParenthesis - 1) & "]" & StringMid($arrAU3File[$intLine], $intParenthesis + 1)
	EndIf
EndFunc   ;==>VBRedim


Func StripSpecialChars($strLine, $strSpecial)
	Local $int
	
	For $int = 1 To StringLen($strSpecial)
		$strLine = StringReplace($strLine, StringMid($strSpecial, $int, 1), "")
	Next
	Return $strLine
EndFunc   ;==>StripSpecialChars