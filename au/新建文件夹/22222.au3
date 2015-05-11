#include <IE.au3>
#include <GUIConstants.au3>
#include <ClipBoard.au3>
#include <GDIPlus.au3>
#include <Winapi.au3>
#include <ScreenCapture.au3>
#include <Clipboard.au3>
$oIE = _IECreate("http://wenda.so.com/index/ask/")
	Local $oInputs = _IETagNameGetCollection($oIE, "img")
	For $oInput In $oInputs
	if StringInStr($oInput.src,"http://captcha.so.com/image.php")>0 then $iVerifyPic=$oInput
	next

$iVerifyPic = _IEGetObjById($OpenPage,"TANGRAM__PSP_4__verifyCodeImg")
$iVerifyPics = $oIE.Document.body.createControlRange()
$iVerifyPics.add($iVerifyPic)
$iVerifyPics.Select ()
$iVerifyPics.execCommand('Copy')
Sleep(500)
_ClipBoard_Open(0)
$iVerifyPics = _ClipBoard_GetDataEx($CF_BITMAP)
_ScreenCapture_SaveImage(@ScriptDir & "\aaa.gif", $iVerifyPics)
_ClipBoard_Close()
GUICreate("VerifyPic", 150, 150, -1, -1, -1)
GUISetBkColor(0xFFFFFF)
GUISetState()
$Img = GUICtrlCreatePic(@TempDir & "\VerifyPic.bmp", 10, 20, _GDIPlus_ImageGetWidth($iVerifyPics), _GDIPlus_ImageGetHeight($iVerifyPics))
_GDIPlus_BitmapDispose($iVerifyPics)
_GDIPlus_Shutdown()

While 1
        $msg = GUIGetMsg()
        If $msg = $GUI_EVENT_CLOSE Then
                GUIDelete()
                ExitLoop
        EndIf
WEnd