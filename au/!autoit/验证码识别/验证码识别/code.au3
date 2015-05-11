; A Real Captcha ( hidden text for security ) ...Really Sharp!

; Author - Malkey


#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <GDIPlus.au3>
#include <WinAPI.au3>
#include<Color.au3>

Opt("GUIOnEventMode", 1) ;0=disabled, 1=OnEvent mode enabled

Global $aFonts[4] = ["MS Sans Serif", "Arial", "Times New Roman", "Lucida Console"]
Global $charList = StringSplit("abcdefghijkmnpqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ23456789", "")
Global $aColours[4] = [0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFFFFF00]
Global $ApW = 250, $ApH = 250
Global $Button[1], $Pic, $sCode, $hImage
Global Const $iPI = 3.1415926535897932384626433832795

$hGui = GUICreate("GDIPlus Graphics on Picture Control - OnEvent Mode", $ApW, $ApH)
GUISetOnEvent(-3, "_Quit")
GUISetBkColor(0xffA0A0, $hGui)

$Pic = GUICtrlCreatePic("", 20, 20, 45, 40, $SS_SUNKEN, BitOR($WS_EX_CLIENTEDGE, $WS_EX_STATICEDGE, $WS_EX_DLGMODALFRAME))
GUICtrlSetState(-1, $GUI_DISABLE)

$Captcha_Input = GUICtrlCreateInput("", 20, 170, 70, 20)
$Generate_Button = GUICtrlCreateButton("Generate", 20, 200, 70, 20)
GUICtrlSetOnEvent($Generate_Button, "PicSetGraphics")
$SaveCaptcha_Button = GUICtrlCreateButton("Save to file...", 120, 200, 120, 20)
GUICtrlSetOnEvent($SaveCaptcha_Button, "Save")

_GDIPlus_Startup()
PicSetGraphics(); <-- Draw GDIPlus graphics on Picture control.

GUISetState(@SW_SHOW, $hGui)

While 1
    Sleep(10)
WEnd
_GDIPlus_Shutdown()

Func PicSetGraphics()
    Local Const $STM_SETIMAGE = 0x0172
    Local Const $IMAGE_BITMAP = 0
    Local $hWnd, $hBitmap, $hGraphic, $hBrush, $hBrush1, $hbmp, $aBmp
    Local $iW = 150, $iH = 100, $sCode = ""
   
    $hWnd = GUICtrlGetHandle($Pic)
    If $hImage > 0 Then _GDIPlus_ImageDispose($hImage)
   
    ;Buffer
    $hBitmap = _WinAPI_CreateSolidBitmap($hGui, 0x8FAAAAAA, $iW, $iH) ;
    $hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)
    $hGraphic = _GDIPlus_ImageGetGraphicsContext($hImage)
   
    ;----->  All Graphics Here
   
    ;Rainbow background
    For $x = 0 To $iW
        $hue = Color_SetHSL(Int($x / 2))
        $hPen1 = _GDIPlus_PenCreate("0x80" & Hex($hue, 6), 1) ; Slightly transparent
        _GDIPlus_GraphicsDrawLine($hGraphic, $x, 0, $x, $ApH, $hPen1)
        _GDIPlus_PenDispose($hPen1)
    Next
   
    For $x = 0 To 3
       
        ;Draw random Lines 
        $hPen1 = _GDIPlus_PenCreate("0x" & Hex($aColours[Random(0, 3, 1)], 8), Random(1, 3, 1))
        _GDIPlus_GraphicsDrawLine($hGraphic, Random(0, $iW, 1), Random(0, 5, 1), Random(0, $iW, 1), _
                                                                    Random($iH - 5, $iH, 1), $hPen1)
        $hPen1 = _GDIPlus_PenCreate("0x" & Hex($aColours[Random(0, 3, 1)], 8), Random(1, 3, 1))
        _GDIPlus_GraphicsDrawLine($hGraphic, Random(0, 5, 1), Random(0, $iH, 1), Random($iW - 5, $iW, 1), _
                                                                                Random(0, $iH, 1), $hPen1)
        _GDIPlus_PenDispose($hPen1)
       
        ; Draw a character
        $sLetter = $charList[Random(1, $charList[0], 1)]
        GUISetFont(Random(14, 26, 1), 400, 0, $aFonts[Random(0, UBound($aFonts) - 1, 1)])
        $iBy = $x * ($iW / 4)
        GDIPlus_SetAngledText($hGraphic, $sLetter, Random($iBy + 15, $iBy + ($iW / 4) - 15, 1), _
        Random(($iH / 2) - 15, ($iH / 2) + 5, 1), Random(-30, 30, 1), "", 16, "0x" & Hex($aColours[Random(0, 3, 1)], 8))
        $sCode &= $sLetter
       
    Next
   
    ; -----> End of all Graphics
   
    GUICtrlSetData($Captcha_Input, $sCode) 
   
    ; Keeps all GDIPlus graphics visible
    $hbmp = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
    $aBmp = DllCall("user32.dll", "hwnd", "SendMessage", "hwnd", $hWnd, "int", $STM_SETIMAGE, "int", $IMAGE_BITMAP, "int", $hbmp)
    _WinAPI_RedrawWindow($hGui, "", "", BitOR($RDW_INVALIDATE, $RDW_UPDATENOW, $RDW_FRAME))
   
    If $aBmp[0] <> 0 Then _WinAPI_DeleteObject($aBmp[0])
   
    _GDIPlus_BrushDispose($hBrush)
    _GDIPlus_PenDispose($hPen1)
    _GDIPlus_GraphicsDispose($hGraphic)
    _WinAPI_DeleteObject($hbmp)
    _WinAPI_DeleteObject($hBitmap) 
EndFunc   ;==>PicSetGraphics


Func Save()
    $sCaptcha_File = FileSaveDialog("Save Captcha as...", "", "Image Files (*.png;*.jpg;*.bmp)", 18, "Captcha.jpg", $hGui)
    If @error Then Return
   
    If Not StringRegExp($sCaptcha_File, ".*\.png|\.jpg|\.bmp$") Then $sCaptcha_File &= ".jpg"
    ConsoleWrite(" Saved  " & $sCaptcha_File & @CRLF)
    _GDIPlus_ImageSaveToFile($hImage, $sCaptcha_File)
    _GDIPlus_ImageDispose($hImage)
EndFunc   ;==>Save

; #FUNCTION# ================================================================
; Name...........: GDIPlus_SetAngledText
; Description ...: Adds text to a graphic object at any angle.
; Syntax.........: GDIPlus_SetAngledText($hGraphic, $nText, [$iCentreX, [$iCentreY, [$iAngle , [$nFontName , _
;                              [$nFontSize, [$iARGB, [$iAnchor]]]]]]] )
; Parameters ....: $hGraphic   - The Graphics object to receive the added text.
;                  $nText      - Text string to be displayed
;                  $iCentreX       - Horizontal coordinate of horixontal centre of the text rectangle        (default =  0 )
;                  $iCentreY        - Vertical coordinate of vertical centre of the text rectangle             (default = 0 )
;                  $iAngle     - The angle which the text will be place in degrees.         (default = "" or blank = 0 )
;                  $nFontName  - The name of the font to be used                      (default = "" or Blank = "Arial" )
;                  $nFontSize  - The font size to be used                                  (default = "" or Blank = 12 )
;                  $iARGB      - Alpha(Transparency), Red, Green and Blue color (0xAARRGGBB) (Default= "" = random color
;                                                                                      or Default = Blank = 0xFFFF00FF )
;                  $iAnchor    - If zero (default) positioning $iCentreX, $iCentreY values refer to centre of text string.
;                                If not zero positioning $iCentreX, $iCentreY values refer to top left corner of text string.
; Return values .: 1
; Author ........: Malkey
; Modified.......:
; Remarks .......: Call _GDIPlus_Startup() before starting this function, and call _GDIPlus_Shutdown()after function ends.
;                  Can enter calculation for Angle Eg. For incline, -ATan($iVDist / $iHDist) * 180 / $iPI , where
;               $iVDist is Vertical Distance,  $iHDist is Horizontal Distance, and, $iPI is Pi, (an added Global Const).
;               When used with other graphics, call this function last. The MatrixRotate() may affect following graphics.
; Related .......: _GDIPlus_Startup(), _GDIPlus_Shutdown(), _GDIPlus_GraphicsDispose($hGraphic)
; Link ..........;
; Example .......; Yes
; ========================================================================================
Func GDIPlus_SetAngledText($hGraphic, $nText, $iCentreX = 0, $iCentreY = 0, $iAngle = 0, $nFontName = "Arial", _
        $nFontSize = 12, $iARGB = 0xFFFF00FF, $iAnchor = 0)
    Local $x, $y, $iX, $iY, $iWidth, $iHeight
    Local $hMatrix, $iXt, $iYt, $hBrush, $hFormat, $hFamily, $hFont, $tLayout
   
    ; Default values
    If $iAngle = "" Then $iAngle = 0
    If $nFontName = "" Or $nFontName = -1 Then $nFontName = "Arial" ; "Microsoft Sans Serif"
    If $nFontSize = "" Then $nFontSize = 12
    If $iARGB = "" Then ; Randomize ARGB color
        $iARGB = "0xFF" & Hex(Random(0, 255, 1), 2) & Hex(Random(0, 255, 1), 2) & Hex(Random(0, 255, 1), 2)
    EndIf
   
    $hFormat = _GDIPlus_StringFormatCreate(0)
    $hFamily = _GDIPlus_FontFamilyCreate($nFontName)
    $hFont = _GDIPlus_FontCreate($hFamily, $nFontSize, 1, 3)
    $tLayout = _GDIPlus_RectFCreate($iCentreX, $iCentreY, 0, 0)
    $aInfo = _GDIPlus_GraphicsMeasureString($hGraphic, $nText, $hFont, $tLayout, $hFormat)
    $iWidth = Ceiling(DllStructGetData($aInfo[0], "Width"))
    $iHeight = Ceiling(DllStructGetData($aInfo[0], "Height"))
   
    ;Later calculations based on centre of Text rectangle.
    If $iAnchor = 0 Then ; Reference to middle of Text rectangle
        $iX = $iCentreX
        $iY = $iCentreY
    Else ; Referenced centre point moved to top left corner of text string.
        $iX = $iCentreX + (($iWidth - Abs($iHeight * Sin($iAngle * $iPI / 180))) / 2)
        $iY = $iCentreY + (($iHeight + Abs($iWidth * Sin($iAngle * $iPI / 180))) / 2)
    EndIf
   
    ;Rotation Matrix
    $hMatrix = _GDIPlus_MatrixCreate()
    _GDIPlus_MatrixRotate($hMatrix, $iAngle, 1)
    _GDIPlus_GraphicsSetTransform($hGraphic, $hMatrix)
   
    ;x, y are display coordinates of center of width and height of the rectanglular text box.
    ;Top left corner coordinates rotate in a circular path with radius = (width of text box)/2.
    ;Parametric equations for a circle, and adjustments for centre of text box
    $x = ($iWidth / 2) * Cos($iAngle * $iPI / 180) - ($iHeight / 2) * Sin($iAngle * $iPI / 180)
    $y = ($iWidth / 2) * Sin($iAngle * $iPI / 180) + ($iHeight / 2) * Cos($iAngle * $iPI / 180)
   
    ;Rotation of Coordinate Axes formulae - To display at x and y after rotation, we need to enter the
    ;x an y position values of where they rotated from. This is done by rotating the coordinate axes.
    ;Use $iXt, $iYt in  _GDIPlus_RectFCreate. These x, y values is the position of the rectangular
    ;text box point before rotation. (before translation of the matrix)
    $iXt = ($iX - $x) * Cos($iAngle * $iPI / 180) + ($iY - $y) * Sin($iAngle * $iPI / 180)
    $iYt = -($iX - $x) * Sin($iAngle * $iPI / 180) + ($iY - $y) * Cos($iAngle * $iPI / 180)
   
    $hBrush = _GDIPlus_BrushCreateSolid($iARGB)
    $tLayout = _GDIPlus_RectFCreate($iXt, $iYt, $iWidth, $iHeight)
    _GDIPlus_GraphicsDrawStringEx($hGraphic, $nText, $hFont, $tLayout, $hFormat, $hBrush)
   
    ; Clean up resources
    _GDIPlus_MatrixDispose($hMatrix)
    _GDIPlus_FontDispose($hFont)
    _GDIPlus_FontFamilyDispose($hFamily)
    _GDIPlus_StringFormatDispose($hFormat)
    _GDIPlus_BrushDispose($hBrush)
    $tLayout = ""
    Return 1
EndFunc   ;==>GDIPlus_SetAngledText


Func Color_SetHSL($iHue, $Saturation = 180, $Brightness = 160)
    If IsArray($iHue) Then
        $aInput = $iHue
    Else
        Local $aInput[3] = [$iHue, $Saturation, $Brightness]
    EndIf
    Local $aiRGB = _ColorConvertHSLtoRGB($aInput)
    Return "0x" & Hex(Round($aiRGB[0]), 2) & Hex(Round($aiRGB[1]), 2) & Hex(Round($aiRGB[2]), 2)
EndFunc   ;==>Color_SetHSL


Func _Quit()
    If $hImage > 0 Then _GDIPlus_ImageDispose($hImage)
    _GDIPlus_Shutdown()
    Exit
EndFunc   ;==>_Quit