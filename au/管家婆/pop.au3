#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <Array.au3>
#include <_pop3.au3>

; Just example
Global $MyPopServer = "pop.exmail.qq.com"
Global $MyLogin = "a@iigogo.com"
Global $MyPasswd = "jmdjsj903291A"

; Connecting to POP3
_pop3Connect($MyPopServer, $MyLogin, $MyPasswd)
If @error Then
    MsgBox(16, "Error. Code " & @error, "Unable to connect to " & $MyPopServer)
    Exit
Else
    ConsoleWrite("Connected to server pop3 " & $MyPopServer & @CR)
EndIf
; Downloading letter #1
Local $retr = _Pop3Retr(1)
If Not @error Then
    $aParsedLetter = _ParseEmail ($retr); sends downloaded letter for parsing
Else
    ConsoleWrite("Retr commande failed" & @CR)
    Exit
EndIf
; Closing connection
ConsoleWrite(_Pop3Quit() & @CRLF)
; End of the example


_ArrayDisplay ($aParsedLetter)

Func _ParseEmail ($sReadFile)
    Dim $aLetter[1]
    _AddToLetterArray (StringRegExp($sReadFile, '(?im)^From: +(.*)(?: |<)(?:.*?<|)(.*?)(?:>|)\r\n', 1), $aLetter)
    _AddToLetterArray (StringRegExp($sReadFile, '(?im)^To: +(.*)(?: |<)(?:.*?<|)(.*?)(?:>|)\r\n', 1), $aLetter)
    _AddToLetterArray (StringRegExp($sReadFile, '(?im)^Subject: +(.*)\r\n', 1), $aLetter)
    _AddToLetterArray (StringRegExp($sReadFile, '(?i) charset="?(.*?)(?:"|\r\n)', 1), $aLetter)
#cs
    $aSplit = StringSplit ($sReadFile, @CRLF, 1)
    $iFirstBoundaryString = _ArraySearch ($aSplit, "boundary=", 0, 0, 0, 1)
    $iBoundary = $aSplit[$iFirstBoundaryString]
    $iBoundary_startpos = StringInStr ($iBoundary, '"')
    $iBoundary_endpos = StringInStr ($iBoundary, '"', 0, 2)
    $boundary = StringMid ($iBoundary, $iBoundary_startpos+1, $iBoundary_endpos-$iBoundary_startpos-1)
    $boundary1 = _ArraySearch ($aSplit, $boundary, $iFirstBoundaryString+1, 0, 1, 1)
    $boundary2 = _ArraySearch ($aSplit, $boundary, $boundary1+1, 0, 1, 1)
    $message = ""
    $Write = False
    For $i=$boundary1 To $boundary2-1
        If $aSplit[$i] = "" Then $Write = True
        If $Write = True Then $message &= $aSplit[$i] & @CRLF
    Next
    _AddToLetterArray ($message, $aLetter)
#ce
    _AddToLetterArray (StringRegExp($sReadFile, '(?ims) filename="?(.*?)(?:"|\r).*?\n\r\n(.*?)\r\n^-+', 3), $aLetter)

    Return $aLetter
EndFunc; ==> _ParseEmail

Func _AddToLetterArray ($aContents, ByRef $afLetter)
   If IsArray($aContents) Then
        For $t = 0 to UBound ($aContents) - 1
            _ArrayAdd ($afLetter, $aContents[$t])
        Next
    Else
        _ArrayAdd ($afLetter, $aContents)
    EndIf
    Return $afLetter
EndFunc;==>_AddToLetterArray