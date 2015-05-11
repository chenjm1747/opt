#include <Word.au3>

Local $sPath = @ScriptDir & "\"
Local $search = FileFindFirstFile($sPath & "*.jpg")

; 检查搜索是否成功
If $search = -1 Then
	MsgBox(4096, "Error", "No images found")
	Exit
EndIf

Local $oWordApp = _WordCreate()
Local $oDoc = _WordDocGetCollection($oWordApp, 0)

While 1
	Local $file = FileFindNextFile($search)
	If @error Then ExitLoop
	Local $oShape = _WordDocAddPicture($oDoc, $sPath & $file, 0, 1)
	If Not @error Then $oShape.Range.InsertAfter(@CRLF)
WEnd
$odoc.Range.InsertAfter( "旅贸通电子票" & @CRLF _
						 & "取票验证码：" & @CRLF _
						 & "必须" & @MON & "月" & @MDAY & "日前使用有效")
; 关闭搜索句柄
FileClose($search)