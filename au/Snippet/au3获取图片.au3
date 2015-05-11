#include <GDIPlus.au3>
#include <ScreenCapture.au3>

#include <IE.au3>

#include <GuiConstantsEx.au3>
#include <ClipBoard.au3>
#include <WindowsConstants.au3>


;浏览器中浏览图片
;http://books.google.com.hk/books?id=CHswO9obwk8C&pg=PR5&img=1&zoom=3&hl=zh-CN&sig=ACfU3U2fo1zQrISnmSnUuXmvCad8n9ygMA&w=1025
;另存为才142k
;这样保存却有526k
;为什么？

Opt('MustDeclareVars', 1)

Local $f = @ScriptDir & "\ask_test_1.html"
If FileExists($f) == 0 Then
        FileWrite($f, "<html> <head><title>Googlebook</title></head> <body> <img  border=1 src=http://books.google.com.hk/books?id=CHswO9obwk8C&pg=PR5&img=1&zoom=3&hl=zh-CN&sig=ACfU3U2fo1zQrISnmSnUuXmvCad8n9ygMA&w=1025  /> </body> </html>")
        Sleep(1000)
EndIf

Local $oIE = _IECreate($f)
Sleep(1000)

setClipboard()
Sleep(1000)
_Main()

Func _Main()
        Local $hBitmap, $hImage, $sCLSID, $tData, $tParams

        _GDIPlus_Startup()

        _ClipBoard_Open(0)
        $hImage = _ClipBoard_GetDataEx($CF_BITMAP);$CF_BITMAP ;$CF_METAFILEPICT
        If $hImage == 0 Then
                MsgBox(0, "", "粘贴板没找到")
        Else
                $hImage = _GDIPlus_BitmapCreateFromHBITMAP($hImage)

                $sCLSID = _GDIPlus_EncodersGetCLSID("PNG")

                Local $tt = @ScriptDir & "\GDIPlus_Image2.jpg"
                ConsoleWrite($tt & @CRLF)
                _GDIPlus_ImageSaveToFileEx($hImage, $tt, $sCLSID)

                _ClipBoard_Close()
        EndIf

        _GDIPlus_Shutdown()
EndFunc   ;==>_Main


;设置粘贴板
Func setClipboard()
        Local $oIE = _IEAttach("Googlebook")
        If @error = 0 Then
                Local $oImgs = _IEImgGetCollection($oIE)
                For $oImg In $oImgs
                        ;复制图片
                        Local $oPic = $oIE.Document.body.createControlRange()
                        $oPic.Add($oImg)
                        $oPic.execCommand("Copy")
                        MsgBox(0, "", "图片复制了", 2)

                        ExitLoop
                Next
        Else
                MsgBox(0, "", "html测试页码没找到", 2)
        EndIf
EndFunc   ;==>setClipboard