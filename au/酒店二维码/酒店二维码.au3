#include <Word.au3>
#include <IE.au3>

 Local $sAnswer = InputBox("Question", "输入编号", "140422", "",- 1, -1, 0, 0)
Local $sname = InputBox("Question", "输名称","", "", - 1, -1, 0, 0)
$surl="http://www.716580.com/b2b/wap/index.asp?tid="&$sAnswer
 Local $sshuliang = InputBox("Question", "输入数量","2", "", - 1, -1, 0, 0)

DllCall("quricol32.dll","none", "GeneratePNG","str", @ScriptDir & "\GDIPlus_Image.png", "str",$surl,"int",0,"int",10)

$return = DllCall("quricol32.dll","HANDLE", "GetHBitmap", "str",  $surl,"int",0,"int",10)

Global $oWord = _Word_Create(false)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocPictureAdd Example", _
		"Error creating a new Word application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Open the test document
Global $oDoc = _Word_DocOpen($oWord, @ScriptDir & "酒店二维码.doc", Default, Default, true)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocPictureAdd Example", _
		"Error opening '.\Extras\Test.doc'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)


$oRangeFound = _Word_DocFind($oDoc, ".", -1)
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocFind Example", _
		"Error locating the specified text in the document." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Mark the line number as bold. Create a new range moved one word to the right
$oRangeText = _Word_DocRangeSet($oDoc, $oRangeFound, Default, 1, Default, 1)

;$oRangeText=""

_Word_DocPictureAdd($oDoc, @ScriptDir & "\GDIPlus_Image.png", Default, Default, $oRangeText)
$oRangeFound = _Word_DocFind($oDoc, ",", -1)
$oRangeFound.Delete
$oRangeFound.InsertAfter($sname)

If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Word UDF: _Word_DocPictureAdd Example", _
		"Error adding the picture to the document" & @CRLF & " @error = " & @error & ", @extended = " & @extended)

For $i = 1 To $sshuliang

_Word_DocPrint($oDoc)
next
;_Word_Quit($oWord,$WdDoNotSaveChanges,$WdWordDocument,true)
sleep(1000)
_Word_Quit($oWord)
