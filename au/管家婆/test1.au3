#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         jm

 Script Function:
	自动编译安装程序并上传到down文件夹

#ce ----------------------------------------------------------------------------
Global Const $key[27]=['吖','八','擦','耷','俄','发','噶','哈','丌','丌','卡','拉','马','拿','哦','趴','七','然','撒','他','挖','挖','挖','西','丫','匝','匝']
$server = 'www.caiwuhao.com'
$username = 'username1'
$pass = 'jmdjsj903291A'
#include <GDIPlus.au3>
#include <Inet.au3>
#include <IE.au3>
#include <File.au3>
#include <FTPEx.au3>
#include <Date.au3>
#include <Word.au3>
	png3("管家婆软件免费版")
	png1("管家婆软件免费版")
Func createword($name)
	if FileExists ( "{app}/"&$name&".doc")=1 Then
	else
	Local $oWord = _Word_Create(false)
	Local $oDoc = _Word_DocOpen($oWord, @ScriptDir & "\{app}\说明书.doc", Default, Default, True)
	_Word_DocFindReplace($oDoc, "致胜管家", $name)
	_Word_DocSaveAs($oDoc, @ScriptDir & "\{app}\"&$name&".doc")
	_Word_Quit($oWord)
	endif
;修改word
EndFunc
Func _ImageResize($sInImage, $sOutImage, $iW, $iH)
    Local $hWnd, $hDC, $hBMP, $hImage1, $hImage2, $hGraphic, $CLSID, $i = 0
    $hWnd = _WinAPI_GetDesktopWindow()
    $hDC = _WinAPI_GetDC($hWnd)
    $hBMP = _WinAPI_CreateCompatibleBitmap($hDC, $iW, $iH)
    _WinAPI_ReleaseDC($hWnd, $hDC)
    _GDIPlus_Startup()
    $hImage1 = _GDIPlus_BitmapCreateFromHBITMAP ($hBMP)
    ;Load the image you want to resize.
    $hImage2 = _GDIPlus_ImageLoadFromFile($sInImage)
    ;Get the graphic context of the blank bitmap
    $hGraphic = _GDIPlus_ImageGetGraphicsContext ($hImage1)
    ;Draw the loaded image onto the blank bitmap at the size you want
    _GDIPLus_GraphicsDrawImageRect($hGraphic, $hImage2, 0, 0, $iW, $iW)
    ;Get the encoder of to save the resized image in the format you want.
    ;$CLSID = _GDIPlus_EncodersGetCLSID($Ext)
    ;Generate a number for out file that doesn't already exist, so you don't overwrite an existing image.
    ;Do
;        $i += 1
 ;   Until (Not FileExists($sOP & $i & "_" & $sOF))
    ;Prefix the number to the begining of the output filename
;    $sOutImage = $sOP & $i & "_" & $sOF
    ;Save the new resized image.
    _GDIPlus_ImageSaveToFileEx($hImage1, $sOutImage, $CLSID)
    ;Clean up and shutdown GDIPlus.
    _GDIPlus_ImageDispose($hImage1)
    _GDIPlus_ImageDispose($hImage2)
    _GDIPlus_GraphicsDispose ($hGraphic)
    _WinAPI_DeleteObject($hBMP)
    _GDIPlus_Shutdown()

EndFunc
Func png3($string1)
    Local $hBitmap1, $hBitmap2, $hImage1, $hImage2, $hGraphic, $width, $height
    _GDIPlus_Startup() ;初始化Microsoft Windows GDI+

    $hImage1 = _GDIPlus_BitmapCreateFromFile("编写安装程序0003.png");
    $hGraphic = _GDIPlus_ImageGetGraphicsContext($hImage1) ;获取图像的图形场景 $hImage1---图像对象句柄
    $hBrush = _GDIPlus_BrushCreateSolid (0xFFffffff) ;创建实心画刷对象
    $hFormat = _GDIPlus_StringFormatCreate () ;创建字符串格式对象
    $hFamily = _GDIPlus_FontFamilyCreate ("宋体") ;创建字体族对象 Times New Roman--------字体族名称
    $hFont = _GDIPlus_FontCreate ($hFamily, 12, 1) ;创建字体对象 ($hFamily字样对象的句柄, 50由$iUnit参数指定的单位衡量的字体大小, 0正常字体)
    $tLayout = _GDIPlus_RectFCreate (20, 6, 0,0) ;创建$tagGDIPRECTF结构 (350矩形左上角X坐标, 45矩形左上角Y坐标, 0矩形宽度, 0矩形高度)
    $aInfo = _GDIPlus_GraphicsMeasureString ($hGraphic, $String1, $hFont, $tLayout, $hFormat) ;测量字符串尺寸 ($hGraphic图形对象句柄, $String1要绘制的字符串, $hFont绘制字符串使用的字体的句柄, $tLayout绑定字符串的$tagGDIPRECTF结构, $hFormat绘制字符串的字符串格式句柄)
    $hMatrix = _GDIPlus_MatrixCreate() ;创建并初始化用以代表矩阵的Matrix对象
    $nAngle = 0
    _GDIPlus_MatrixRotate($hMatrix, $nAngle, "False") ;旋转矩阵 ($hMatrix--Matrix对象句柄, $nAngle--旋转的角度. 整数指定时钟方向旋转., "False"--True - 指定旋转矩形位于左侧)
    _GDIPlus_GraphicsSetTransform($hGraphic, $hMatrix) ;获取Graphics对象的设备场景的句柄 ($hGraphic--图形对象句柄, $hMatrix--指定世界坐标空间的矩阵对象的句柄)
    _GDIPlus_GraphicsDrawStringEx ($hGraphic, $string1, $hFont, $aInfo[0], $hFormat, $hBrush) ;绘制字符串($hGraphic图形对象句柄, $string1将被绘制的字符串, $hFont绘制字符串使用的字体的句柄, $aInfo[0]绑定字符串的$tagGDIPRECTF结构, $hFormat绘制字符串的字符串格式句柄, $hBrush绘制字符串的画刷句柄)
	    $hBrush = _GDIPlus_BrushCreateSolid (0xFF000000) ;创建实心画刷对象
    $hFormat = _GDIPlus_StringFormatCreate () ;创建字符串格式对象
    $hFamily = _GDIPlus_FontFamilyCreate ("微软雅黑") ;创建字体族对象 Times New Roman--------字体族名称
    $hFont = _GDIPlus_FontCreate ($hFamily, 50, 1) ;创建字体对象 ($hFamily字样对象的句柄, 50由$iUnit参数指定的单位衡量的字体大小, 0正常字体)
    $tLayout = _GDIPlus_RectFCreate (260+25*(11-5), 556, 0,0) ;创建$tagGDIPRECTF结构 (350矩形左上角X坐标, 45矩形左上角Y坐标, 0矩形宽度, 0矩形高度)
    $aInfo = _GDIPlus_GraphicsMeasureString ($hGraphic, $String1, $hFont, $tLayout, $hFormat) ;测量字符串尺寸 ($hGraphic图形对象句柄, $String1要绘制的字符串, $hFont绘制字符串使用的字体的句柄, $tLayout绑定字符串的$tagGDIPRECTF结构, $hFormat绘制字符串的字符串格式句柄)
    $hMatrix = _GDIPlus_MatrixCreate() ;创建并初始化用以代表矩阵的Matrix对象
    $nAngle = 0
    _GDIPlus_MatrixRotate($hMatrix, $nAngle, "False") ;旋转矩阵 ($hMatrix--Matrix对象句柄, $nAngle--旋转的角度. 整数指定时钟方向旋转., "False"--True - 指定旋转矩形位于左侧)
    _GDIPlus_GraphicsSetTransform($hGraphic, $hMatrix) ;获取Graphics对象的设备场景的句柄 ($hGraphic--图形对象句柄, $hMatrix--指定世界坐标空间的矩阵对象的句柄)
    _GDIPlus_GraphicsDrawStringEx ($hGraphic, $string1, $hFont, $aInfo[0], $hFormat, $hBrush) ;绘制字符串($hGraphic图形对象句柄, $string1将被绘制的字符串, $hFont绘制字符串使用的字体的句柄, $aInfo[0]绑定字符串的$tagGDIPRECTF结构, $hFormat绘制字符串的字符串格式句柄, $hBrush绘制字符串的画刷句柄)
	;_GDIPLus_GraphicsDrawImageRect($hGraphic, $hImage2, 0, 0, 500, 320)
	$hImage1 = _GDIPlus_ImageResize($hImage1, 500,320) ;resize image
	;500 347
	_GDIPlus_ImageSaveToFile($hImage1, "编写安装程序3.png")
    _GDIPlus_ImageDispose($hImage1)
    _GDIPlus_ImageDispose($hImage2)
    _WinAPI_DeleteObject($hBitmap1)
    _WinAPI_DeleteObject($hBitmap2)
    _GDIPlus_Shutdown()
	;_ImageResize("编写安装程序13.png", "编写安装程序3.png", 500, 420)
EndFunc ;==>_Main

Func png1($string1)
    Local $hBitmap1, $hBitmap2, $hImage1, $hImage2, $hGraphic, $width, $height
    _GDIPlus_Startup() ;初始化Microsoft Windows GDI+

    $hImage1 = _GDIPlus_BitmapCreateFromFile("编写安装程序.png");
    $hGraphic = _GDIPlus_ImageGetGraphicsContext($hImage1) ;获取图像的图形场景 $hImage1---图像对象句柄
    $hBrush = _GDIPlus_BrushCreateSolid (0xFFffffff) ;创建实心画刷对象
    $hFormat = _GDIPlus_StringFormatCreate () ;创建字符串格式对象
    $hFamily = _GDIPlus_FontFamilyCreate ("宋体") ;创建字体族对象 Times New Roman--------字体族名称
    $hFont = _GDIPlus_FontCreate ($hFamily, 11, 1) ;创建字体对象 ($hFamily字样对象的句柄, 50由$iUnit参数指定的单位衡量的字体大小, 0正常字体)
    $tLayout = _GDIPlus_RectFCreate (20, 6, 0,0) ;创建$tagGDIPRECTF结构 (350矩形左上角X坐标, 45矩形左上角Y坐标, 0矩形宽度, 0矩形高度)
    $aInfo = _GDIPlus_GraphicsMeasureString ($hGraphic, $String1, $hFont, $tLayout, $hFormat) ;测量字符串尺寸 ($hGraphic图形对象句柄, $String1要绘制的字符串, $hFont绘制字符串使用的字体的句柄, $tLayout绑定字符串的$tagGDIPRECTF结构, $hFormat绘制字符串的字符串格式句柄)
    $hMatrix = _GDIPlus_MatrixCreate() ;创建并初始化用以代表矩阵的Matrix对象
    $nAngle = 0
    _GDIPlus_MatrixRotate($hMatrix, $nAngle, "False") ;旋转矩阵 ($hMatrix--Matrix对象句柄, $nAngle--旋转的角度. 整数指定时钟方向旋转., "False"--True - 指定旋转矩形位于左侧)
    _GDIPlus_GraphicsSetTransform($hGraphic, $hMatrix) ;获取Graphics对象的设备场景的句柄 ($hGraphic--图形对象句柄, $hMatrix--指定世界坐标空间的矩阵对象的句柄)
    _GDIPlus_GraphicsDrawStringEx ($hGraphic, $string1, $hFont, $aInfo[0], $hFormat, $hBrush) ;绘制字符串($hGraphic图形对象句柄, $string1将被绘制的字符串, $hFont绘制字符串使用的字体的句柄, $aInfo[0]绑定字符串的$tagGDIPRECTF结构, $hFormat绘制字符串的字符串格式句柄, $hBrush绘制字符串的画刷句柄)
	$hImage1 = _GDIPlus_ImageResize($hImage1, 500,347) ;resize image
	;500 347

	_GDIPlus_ImageSaveToFile($hImage1, "编写安装程序1.png")
    _GDIPlus_ImageDispose($hImage1)
    _GDIPlus_ImageDispose($hImage2)
    _WinAPI_DeleteObject($hBitmap1)
    _WinAPI_DeleteObject($hBitmap2)
    _GDIPlus_Shutdown()
EndFunc ;==>_Main
Func png2($string1)
    Local $hBitmap1, $hBitmap2, $hImage1, $hImage2, $hGraphic, $width, $height
    _GDIPlus_Startup() ;初始化Microsoft Windows GDI+
    $hImage1 = _GDIPlus_BitmapCreateFromFile("编写安装程序02.png");
    $hGraphic = _GDIPlus_ImageGetGraphicsContext($hImage1) ;获取图像的图形场景 $hImage1---图像对象句柄
    $hBrush = _GDIPlus_BrushCreateSolid (0xFFffffff) ;创建实心画刷对象
    $hFormat = _GDIPlus_StringFormatCreate () ;创建字符串格式对象
    $hFamily = _GDIPlus_FontFamilyCreate ("宋体") ;创建字体族对象 Times New Roman--------字体族名称
    $hFont = _GDIPlus_FontCreate ($hFamily, 7, 1) ;创建字体对象 ($hFamily字样对象的句柄, 50由$iUnit参数指定的单位衡量的字体大小, 0正常字体)
    $tLayout = _GDIPlus_RectFCreate (10, 0, 0,0) ;创建$tagGDIPRECTF结构 (350矩形左上角X坐标, 45矩形左上角Y坐标, 0矩形宽度, 0矩形高度)
    $aInfo = _GDIPlus_GraphicsMeasureString ($hGraphic,""&$String1, $hFont, $tLayout, $hFormat) ;测量字符串尺寸 ($hGraphic图形对象句柄, $String1要绘制的字符串, $hFont绘制字符串使用的字体的句柄, $tLayout绑定字符串的$tagGDIPRECTF结构, $hFormat绘制字符串的字符串格式句柄)
    $hMatrix = _GDIPlus_MatrixCreate() ;创建并初始化用以代表矩阵的Matrix对象
    $nAngle = 0
    _GDIPlus_MatrixRotate($hMatrix, $nAngle, "False") ;旋转矩阵 ($hMatrix--Matrix对象句柄, $nAngle--旋转的角度. 整数指定时钟方向旋转., "False"--True - 指定旋转矩形位于左侧)
    _GDIPlus_GraphicsSetTransform($hGraphic, $hMatrix) ;获取Graphics对象的设备场景的句柄 ($hGraphic--图形对象句柄, $hMatrix--指定世界坐标空间的矩阵对象的句柄)
    _GDIPlus_GraphicsDrawStringEx ($hGraphic, ""&$string1, $hFont, $aInfo[0], $hFormat, $hBrush) ;绘制字符串($hGraphic图形对象句柄, $string1将被绘制的字符串, $hFont绘制字符串使用的字体的句柄, $aInfo[0]绑定字符串的$tagGDIPRECTF结构, $hFormat绘制字符串的字符串格式句柄, $hBrush绘制字符串的画刷句柄)
	$hBrush = _GDIPlus_BrushCreateSolid (0xFF000000) ;创建实心画刷对象
    $hFormat = _GDIPlus_StringFormatCreate () ;创建字符串格式对象
    $hFamily = _GDIPlus_FontFamilyCreate ("宋体") ;创建字体族对象 Times New Roman--------字体族名称
    $hFont = _GDIPlus_FontCreate ($hFamily, 12, 1) ;创建字体对象 ($hFamily字样对象的句柄, 50由$iUnit参数指定的单位衡量的字体大小, 0正常字体)
    $tLayout = _GDIPlus_RectFCreate (162, 36, 0,0) ;创建$tagGDIPRECTF结构 (350矩形左上角X坐标, 45矩形左上角Y坐标, 0矩形宽度, 0矩形高度)
    $aInfo = _GDIPlus_GraphicsMeasureString ($hGraphic, "欢迎使用"&$string1, $hFont, $tLayout, $hFormat) ;测量字符串尺寸 ($hGraphic图形对象句柄, $String1要绘制的字符串, $hFont绘制字符串使用的字体的句柄, $tLayout绑定字符串的$tagGDIPRECTF结构, $hFormat绘制字符串的字符串格式句柄)
    $hMatrix = _GDIPlus_MatrixCreate() ;创建并初始化用以代表矩阵的Matrix对象
    $nAngle = 0
    _GDIPlus_MatrixRotate($hMatrix, $nAngle, "False") ;旋转矩阵 ($hMatrix--Matrix对象句柄, $nAngle--旋转的角度. 整数指定时钟方向旋转., "False"--True - 指定旋转矩形位于左侧)
    _GDIPlus_GraphicsSetTransform($hGraphic, $hMatrix) ;获取Graphics对象的设备场景的句柄 ($hGraphic--图形对象句柄, $hMatrix--指定世界坐标空间的矩阵对象的句柄)
    _GDIPlus_GraphicsDrawStringEx ($hGraphic, "欢迎使用"&$string1, $hFont, $aInfo[0], $hFormat, $hBrush) ;绘制字符串($hGraphic图形对象句柄, $string1将被绘制的字符串, $hFont绘制字符串使用的字体的句柄, $aInfo[0]绑定字符串的$tagGDIPRECTF结构, $hFormat绘制字符串的字符串格式句柄, $hBrush绘制字符串的画刷句柄)
	_GDIPlus_ImageSaveToFile($hImage1, "编写安装程序2.png")
    _GDIPlus_ImageDispose($hImage1)
    _GDIPlus_ImageDispose($hImage2)
    _WinAPI_DeleteObject($hBitmap1)
    _WinAPI_DeleteObject($hBitmap2)
    _GDIPlus_Shutdown()
EndFunc

Func changeMainbmp($string1)
    Local $hBitmap1, $hBitmap2, $hImage1, $hImage2, $hGraphic, $width, $height
    _GDIPlus_Startup() ;初始化Microsoft Windows GDI+
    $hImage1 = _GDIPlus_BitmapCreateFromFile("管店婆(免费)\back1.BMP");
    $hGraphic = _GDIPlus_ImageGetGraphicsContext($hImage1) ;获取图像的图形场景 $hImage1---图像对象句柄
    $hBrush = _GDIPlus_BrushCreateSolid (0xFF000000) ;创建实心画刷对象
    $hFormat = _GDIPlus_StringFormatCreate () ;创建字符串格式对象
    $hFamily = _GDIPlus_FontFamilyCreate ("微软雅黑") ;创建字体族对象 Times New Roman--------字体族名称
    $hFont = _GDIPlus_FontCreate ($hFamily, 50, 1) ;创建字体对象 ($hFamily字样对象的句柄, 50由$iUnit参数指定的单位衡量的字体大小, 0正常字体)
    $tLayout = _GDIPlus_RectFCreate (260+25*(11-5), 476, 0,0) ;创建$tagGDIPRECTF结构 (350矩形左上角X坐标, 45矩形左上角Y坐标, 0矩形宽度, 0矩形高度)
    $aInfo = _GDIPlus_GraphicsMeasureString ($hGraphic, $String1, $hFont, $tLayout, $hFormat) ;测量字符串尺寸 ($hGraphic图形对象句柄, $String1要绘制的字符串, $hFont绘制字符串使用的字体的句柄, $tLayout绑定字符串的$tagGDIPRECTF结构, $hFormat绘制字符串的字符串格式句柄)
    $hMatrix = _GDIPlus_MatrixCreate() ;创建并初始化用以代表矩阵的Matrix对象
    $nAngle = 0
    _GDIPlus_MatrixRotate($hMatrix, $nAngle, "False") ;旋转矩阵 ($hMatrix--Matrix对象句柄, $nAngle--旋转的角度. 整数指定时钟方向旋转., "False"--True - 指定旋转矩形位于左侧)
    _GDIPlus_GraphicsSetTransform($hGraphic, $hMatrix) ;获取Graphics对象的设备场景的句柄 ($hGraphic--图形对象句柄, $hMatrix--指定世界坐标空间的矩阵对象的句柄)
    _GDIPlus_GraphicsDrawStringEx ($hGraphic, $string1, $hFont, $aInfo[0], $hFormat, $hBrush) ;绘制字符串($hGraphic图形对象句柄, $string1将被绘制的字符串, $hFont绘制字符串使用的字体的句柄, $aInfo[0]绑定字符串的$tagGDIPRECTF结构, $hFormat绘制字符串的字符串格式句柄, $hBrush绘制字符串的画刷句柄)

	_GDIPlus_ImageSaveToFile($hImage1, "管店婆(免费)\back.bmp")
    _GDIPlus_ImageDispose($hImage1)
    _GDIPlus_ImageDispose($hImage2)
    _WinAPI_DeleteObject($hBitmap1)
    _WinAPI_DeleteObject($hBitmap2)
    _GDIPlus_Shutdown()
EndFunc ;==>_Main

func C($str)
For $i = 1 To StringLen($str)
Local $L
	Switch Dec(StringTrimLeft(StringToBinary(StringMid($str,$i,1)),2))
        Case 32 To 127
                $L&=StringMid($str,$i,1)
        Case 33095 To 62289
                $L&=Chr(97+_C(StringMid($str,$i,1),0,26))
    EndSwitch
Next
Return $l
endfunc
Func _C($s,$f,$e)                                ;改进的中值法
                Local $mid=Int(($e-$f)/2)+$f
                If $mid=$f Then Return $f
            If StringCompare($s,$key[$mid])=0 Then
                    Return $mid
            ElseIf StringCompare($s,$key[$mid])>0 Then
                Return _C($s,$mid,$e)
            ElseIf StringCompare($s,$key[$mid])<0 Then
                Return _C($s,$f,$mid)
                EndIf
EndFunc