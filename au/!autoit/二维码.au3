#include <Word.au3>
#include <IE.au3>
#include <MsgBoxConstants.au3>

DllCall("quricol32.dll","none", "GeneratePNG","str", @ScriptDir & "\GDIPlus_Image.png", "str","http://www.163.com","int",1,"int",10)

$return = DllCall("quricol32.dll","HANDLE", "GetHBitmap", "str",  "http://www.163.com","int",1,"int",10)

Global $oWord = _Word_Create()
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocPictureAdd Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open the test document
Global $oDoc = _Word_DocOpen($oWord, @ScriptDir & "a4menpiao.doc", Default, Default, false)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocPictureAdd Example", _
		"Error opening '.\Extras\Test.doc'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)


$oRangeFound = _Word_DocFind($oDoc, "line", -1)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocFind Example", _
		"Error locating the specified text in the document." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Mark the line number as bold. Create a new range moved one word to the right
$oRangeText = _Word_DocRangeSet($oDoc, $oRangeFound, Default, 1, Default, 1)

;$oRangeText=""

_Word_DocPictureAdd($oDoc, @ScriptDir & "\GDIPlus_Image.png", Default, Default, $oRangeText)


If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocPictureAdd Example", _
		"Error adding the picture to the document" & @CRLF & " @error = " & @error & ", @extended = " & @extended)
_Word_DocPrint($oDoc)