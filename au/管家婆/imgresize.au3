#include <GDIPlus.au3>

_ImageResize("test.jpg", "Bliss.jpg", 400, 300)

Func _ImageResize($sInImage, $sOutImage, $iW, $iH)
    Local $hWnd, $hDC, $hBMP, $hImage1, $hImage2, $hGraphic, $CLSID, $i = 0

    ;OutFile path, to use later on.
    Local $sOP = StringLeft($sOutImage, StringInStr($sOutImage, "\", 0, -1))

    ;OutFile name, to use later on.
    Local $sOF = StringMid($sOutImage, StringInStr($sOutImage, "\", 0, -1) + 1)

    ;OutFile extension , to use for the encoder later on.
    Local $Ext = StringUpper(StringMid($sOutImage, StringInStr($sOutImage, ".", 0, -1) + 1))

    ; Win api to create blank bitmap at the width and height to put your resized image on.
    $hWnd = _WinAPI_GetDesktopWindow()
    $hDC = _WinAPI_GetDC($hWnd)
    $hBMP = _WinAPI_CreateCompatibleBitmap($hDC, $iW, $iH)
    _WinAPI_ReleaseDC($hWnd, $hDC)

    ;Start GDIPlus
    _GDIPlus_Startup()

    ;Get the handle of blank bitmap you created above as an image
    $hImage1 = _GDIPlus_BitmapCreateFromHBITMAP ($hBMP)

    ;Load the image you want to resize.
    $hImage2 = _GDIPlus_ImageLoadFromFile($sInImage)

    ;Get the graphic context of the blank bitmap
    $hGraphic = _GDIPlus_ImageGetGraphicsContext ($hImage1)

    ;Draw the loaded image onto the blank bitmap at the size you want
    _GDIPLus_GraphicsDrawImageRect($hGraphic, $hImage2, 0, 0, $iW, $iW)

    ;Get the encoder of to save the resized image in the format you want.
    $CLSID = _GDIPlus_EncodersGetCLSID($Ext)

    ;Generate a number for out file that doesn't already exist, so you don't overwrite an existing image.
    Do
        $i += 1
    Until (Not FileExists($sOP & $i & "_" & $sOF))

    ;Prefix the number to the begining of the output filename
    $sOutImage = $sOP & $i & "_" & $sOF

    ;Save the new resized image.
    _GDIPlus_ImageSaveToFileEx($hImage1, $sOutImage, $CLSID)

    ;Clean up and shutdown GDIPlus.
    _GDIPlus_ImageDispose($hImage1)
    _GDIPlus_ImageDispose($hImage2)
    _GDIPlus_GraphicsDispose ($hGraphic)
    _WinAPI_DeleteObject($hBMP)
    _GDIPlus_Shutdown()
EndFunc