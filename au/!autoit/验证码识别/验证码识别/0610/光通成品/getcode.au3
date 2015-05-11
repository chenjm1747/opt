#include <GDIPlus.au3>
#include <array.au3>
#include <file.au3>

;~ InetGet("http://passport.cdcgames.net/VerifyCode.aspx","code.jpg",1)

Global $TempNum=0
Global $FirstNum=0
Global $SecondNum=0
Global $ThirdNum=0
Global $FourthNum=0
Global $CodeNum=""

Global $Line1
Global $Line2
Global $Line22
Global $Line3
Global $Line33
Global $Line4
Global $Line44
Global $Line5
Global $Line55
Global $Line6
Global $Line66
Global $Line7
Global $Line77
Global $Line8
Global $Line88
Global $Line9
Global $Line99
Global $Line10
Global $Line102
Global $Line11
Global $Line112
Global $Line12

Global $ZeroNums12="000000000000"
Global $ZeroNums18="000000000000000000"
Global $ZeroNums24="000000000000000000000000"
Global $ZeroNums36="000000000000000000000000000000000000"
Global $ZeroNums48="000000000000000000000000000000000000000000000000"
Global $aRecords
Global $aRray[12]

Global $Row=0     ;数组列数
Global $Cro=0      ;行数



;_ArrayDisplay($a_Image,"处理后的数组(一维数组)")

Func myArrayChangeSC($func_array, $func_sc_type=0, $func_sc=0x777777, $func_bg=0xffffff);数组中的颜色值做黑白变化
        If Not IsArray($func_array) Or $func_sc_type<1 Or $func_sc_type>3 Or $func_sc_type=0 Then Return $func_array
        If UBound($func_array,2)>0 Then;二维
                Local $i_width=UBound($func_array,1)
                Local $i_height=UBound($func_array,2)
                Local $a_return[$i_width][$i_height], $x, $y, $s
                For $y=0 To $i_height-1
                        For $x= 0 To $i_width-1
                                $a_return[$x][$y]= $func_array[$x][$y]
                                Select
                                Case $func_sc_type=1;黑白
                                        If $a_return[$x][$y]>=$func_sc Then
                                                $a_return[$x][$y]=$func_bg
                                        Else
                                                $a_return[$x][$y]=0
                                        EndIf
                                Case $func_sc_type=2;反相黑白
                                        If $a_return[$x][$y]<$func_sc Then
                                                $a_return[$x][$y]=$func_bg
                                        Else
                                                $a_return[$x][$y]=0
                                        EndIf
                                Case $func_sc_type=3;相当于=1,但黑色用原色代替(就是保留原色)
                                        If $a_return[$x][$y]>=$func_sc Then
                                                $a_return[$x][$y]=$func_bg
                                        EndIf
                                EndSelect
                        Next
                Next
        Else
                Local $i_height=UBound($func_array)
                Local $a_return[$i_height], $y
                For $y=0 To $i_height-1
                        $a_return[$y] = myChangeRegExpSC($func_array[$y], $func_sc_type, $func_sc, $func_bg);正则变化
                Next
        EndIf
        Return $a_return
EndFunc

;以下三个函数都是供myArrayChangeSC使用的,不做详细介绍了
Func myChangeRegExpSC($func_string, $func_sc_type=0, $func_sc=0xeeeeee, $func_bg=0xffffff);将串做黑白变化
        If $func_string="" Or $func_sc_type<1 Or $func_sc_type>3 Or Mod(StringLen($func_string),6)<>0 Then Return $func_string
        $func_string = StringRegExpReplace($func_string, ".{6}", "$0,")
        $func_sc = myGetRegExpSC($func_sc)
        ;ConsoleWrite($func_sc&@CRLF)
        $func_string = StringRegExpReplace($func_string,$func_sc,"______")
        Select
        Case $func_sc_type=1
                $func_string = StringRegExpReplace($func_string,"[0-9A-F]{6},","000000")
                $func_string = StringReplace($func_string,"______,",Hex($func_bg,6))
        Case $func_sc_type=2
                $func_string = StringRegExpReplace($func_string,"[0-9A-F]{6},",Hex($func_bg,6))
                $func_string = StringReplace($func_string,"______,","000000")
        Case $func_sc_type=3
                $func_string = StringReplace($func_string,"______,",Hex($func_bg,6))
                $func_string = StringReplace($func_string,",", "")
        EndSelect 
        Return $func_string
EndFunc
Func myGetRegExpSC($func_sc=0x777777);获取变化黑白临界值的正则表达式,供myChangeRegExpSC调用
        $func_sc=Hex($func_sc,6)
        Local $i,$s,$s_RegExp
        For $i=1 To 6
                $s=StringLeft($func_sc,$i)
                If StringRight($s,1)<>"F" Then
                        Select
                        Case $i=6
                                $s_RegExp &= myRegExp(StringLeft($s,5)) & myRegExp(StringRight($s,1))
                        Case $i=5
                                $s_RegExp &=myRegExp(Hex(Number("0x"&$s)+1,$i))&"[0-9A-F]|"
                        Case Else
                                $s_RegExp &=myRegExp(Hex(Number("0x"&$s)+1,$i)) & "[0-9A-F]{"&6-$i&"}|"
                        EndSelect
                EndIf
        Next
        If StringRight($s_RegExp,1)="|" Then $s_RegExp=StringTrimRight($s_RegExp,1)
        Return $s_RegExp
EndFunc
Func myRegExp($func_string);供myGetRegExpSC调用,单字符转正则
        If $func_string="" Then Return ""
        Local $s_RegExp="", $s_tmp=""
        For $i=1 To StringLen($func_string)
                $s_tmp=Number("0x"&StringMid($func_string, $i,1))
                Select
                Case $s_tmp<9
                        $s_RegExp &="["&$s_tmp &"-9A-F]"
                Case $s_tmp=9
                        $s_RegExp &="[9A-F]"
                Case $s_tmp=0xF
                        $s_RegExp &="[F]"
                Case Else
                        $s_RegExp &="["&Hex($s_tmp,1)&"-F]"
                EndSelect
        Next
        Return $s_RegExp
EndFunc

;以下为前面已经说明过的函数,将图形文件读入二维数组
;-----------------------------------------------------------------------------------------------

Func myReadImageToArray($s_ImageFile, $b_Array2d=False);成功则返回数组.失败返回0.$b_Array2d=True返回二维数组,=False返回一维数组
    Local $hBitmap, $BitmapData, $i_width, $i_height, $Scan0, $pixelData, $s_BMPData, $i_Stride
        _GDIPlus_Startup()

        $hBitmap = _GDIPlus_BitmapCreateFromFile($s_ImageFile)
        If @error Then 
                _GDIPlus_ShutDown ()
                Return 0;无效的图形文件或未找到该文件
        EndIf
        
        $i_width = _GDIPlus_ImageGetWidth($hBitmap)
        $Row=$i_width
        $i_height = _GDIPlus_ImageGetHeight($hBitmap)
        $Cro=$i_height
        
    $BitmapData = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, $i_width, $i_height, $GDIP_ILMREAD, $GDIP_PXF24RGB)
        ;MsgBox(0,$hBitmap,$BitmapData)
        ;If @error Then ......;
    $i_Stride = DllStructGetData($BitmapData, "Stride");Stride - Offset, in bytes, between consecutive scan lines of the bitmap. If the stride is positive, the bitmap is top-down. If the stride is negative, the bitmap is bottom-up.
    $Scan0 = DllStructGetData($BitmapData, "Scan0");Scan0 - Pointer to the first (index 0) scan line of the bitmap.
    $pixelData = DllStructCreate("ubyte lData[" & (Abs($i_Stride) * $i_height) & "]", $Scan0)
        ;不要使用官方论坛上提供的Abs($i_Stride) * $i_height-1,否则无法正确处理gif冗余等情形
        ;MsgBox(0,"",$pixelData)
    $s_BMPData = DllStructGetData($pixelData, "lData")
        
    $s_BMPData = StringTrimLeft($s_BMPData,2);去掉头部"0x"
    _GDIPlus_BitmapUnlockBits($hBitmap, $BitmapData)
        
    _GDIPlus_ImageDispose($hBitmap)
        _WinAPI_DeleteObject ($hBitmap)
        _GDIPlus_Shutdown()
        
        If $b_Array2d Then;要求返回二维数组
                Local $a_return[$i_width][$i_height], $x, $y, $s
                For $y=0 To $i_height-1
                        $s=StringMid($s_BMPData, $y*($i_Stride*2)+1, $i_width*6)
                        ;不要使用一些例子中提出的$s=StringMid($s_BMPData, $y*($i_width*6)+1, $i_width*6),经实际测试,该方式无法正确处理:
                        ;GIF冗余,带隐藏内容的图形文件(一种数据加密方式),或者多页图形文件,当然这些情形比较少见,下同
                        For $x= 0 To $i_width-1
                                $a_return[$x][$y]= Number("0x"&StringMid($s,$x*6+1 ,6))
                        Next
                Next
        Else;要求返回一维数组
                Local $a_return[$i_height], $y
                For $y=0 To $i_height-1
                        $a_return[$y]=StringMid($s_BMPData, $y*($i_Stride*2)+1, $i_width*6)
                        ;见上说明
                Next
        EndIf
        Return $a_return
EndFunc  ;==>myReadImageToArray

        
Func ReadFirstNum()   ;读取第一个字符

      CheckNum1()
      CheckNum2()
      CheckNum3()
      CheckNum4()
      CheckNum5()
      CheckNum6()
      CheckNum7()
      CheckNum8()
      CheckNum9()
      CheckNum0()
      $FirstNum=$TempNum
EndFunc

Func ReadSecondNum()   ;读取 第二个字符
for $m=1 to $aRecords[0] Step 1    ;将 字符数组整个左移60个字符
    $aRecords[$m]=StringTrimLeft($aRecords[$m],60)
Next

      CheckNum1()
      CheckNum2()
      CheckNum3()
      CheckNum4()
      CheckNum5()
      CheckNum6()
      CheckNum7()
      CheckNum8()
      CheckNum9()
      CheckNum0()
$SecondNum=$TempNum
EndFunc

Func ReadThirdNum()   ;读取第三个字符
for $m=1 to $aRecords[0] Step 1   ;将字符数组再次整个 左移60位
    $aRecords[$m]=StringTrimLeft($aRecords[$m],60)
Next
      CheckNum1()
      CheckNum2()
      CheckNum3()
      CheckNum4()
      CheckNum5()
      CheckNum6()
      CheckNum7()
      CheckNum8()
      CheckNum9()
      CheckNum0()
$ThirdNum=$TempNum
EndFunc

Func ReadFourthNum()  ;读取第四个字符
for $m=1 to $aRecords[0] Step 1  ;再次左移60
    $aRecords[$m]=StringTrimLeft($aRecords[$m],60)
Next
      CheckNum1()
      CheckNum2()
      CheckNum3()
      CheckNum4()
      CheckNum5()
      CheckNum6()
      CheckNum7()
      CheckNum8()
      CheckNum9()
      CheckNum0()
$FourthNum=$TempNum
EndFunc

Func ChuShiHua()   ;初始化变量
$Line1=""
$Line2=""
$Line22=""
$Line3=""
$Line33=""
$Line4=""
$Line44=""
$Line5=""
$Line55=""
$Line6=""
$Line66=""
$Line7=""
$Line77=""
$Line8=""
$Line88=""
$Line9=""
$Line99=""
$Line10=""
$Line102=""
$Line11=""
$Line112=""
$Line12=""

EndFunc


Func CheckNum1()     ;判断数字1
;特征信息;~ 1=第一行 43-54 第二行 31-54 第三 四 五 六 七 八 九 十 十一 十二行 43-54
ChuShiHua()
                $Line1=StringLeft(StringTrimLeft($aRecords[1],42),12)
                $Line2=StringLeft(StringTrimLeft($aRecords[2],30),24)                
                $Line3=StringLeft(StringTrimLeft($aRecords[3],42),12)                
                $Line4=StringLeft(StringTrimLeft($aRecords[4],42),12)                
                $Line5=StringLeft(StringTrimLeft($aRecords[5],42),12)                
                $Line6=StringLeft(StringTrimLeft($aRecords[6],42),12)                
                $Line7=StringLeft(StringTrimLeft($aRecords[7],42),12)                
                $Line8=StringLeft(StringTrimLeft($aRecords[8],42),12)                
        $Line9=StringLeft(StringTrimLeft($aRecords[9],42),12)                
                $Line10=StringLeft(StringTrimLeft($aRecords[10],42),12)                
                $Line11=StringLeft(StringTrimLeft($aRecords[11],42),12)
                $Line12=StringLeft(StringTrimLeft($aRecords[12],42),12)
;MsgBox(0,"check1",$Line1&"|"&$Line2&"|"&$Line22&"|"&$Line3&"|"&$Line33&"|"&$Line4&"|"&$Line44&"|"&$Line5&"|"&$Line55&"|"&$Line6&"|"&$Line66&"|"&$Line7&"|"&$Line77&"|"&$Line8&"|"&$Line88&"|"&$Line9&"|"&$Line99&"|"&$Line10&"|"&$Line102&"|"&$Line11&"|"&$Line112&"|"&$Line12)
                if $Line1=$ZeroNums12 And $Line3=$ZeroNums12 And $Line4=$ZeroNums12 And $Line5=$ZeroNums12 And $Line6=$ZeroNums12 And $Line7=$ZeroNums12 And $Line8=$ZeroNums12 And $Line9=$ZeroNums12 And $Line10=$ZeroNums12 And $Line11=$ZeroNums12 And $Line12=$ZeroNums12 And $Line2=$ZeroNums24 Then
                        $TempNum="1"
                EndIf

                
        EndFunc
        

Func CheckNum2()     ;判断数字2
;特征信息 ;~ 2=第一行 37-60 第二行 31-42 和 55-66 第三行 25-36 和 61-72 第四 五行 61-72 第六行 55-66 第七行 49-60 第八行 43-54 第九行 37-48 第十行 31-42 第十一行 25-36 第十二行 25-72
ChuShiHua()                
        $Line1=StringLeft(StringTrimLeft($aRecords[1],36),12)
                $Line2=StringLeft(StringTrimLeft($aRecords[2],30),12)        
                $Line22=StringLeft(StringTrimLeft($aRecords[2],54),12)
                $Line3=StringLeft(StringTrimLeft($aRecords[3],24),12)
                $Line33=StringLeft(StringTrimLeft($aRecords[3],60),12)                
                $Line4=StringLeft(StringTrimLeft($aRecords[4],60),12)                        
                $Line5=StringLeft(StringTrimLeft($aRecords[5],60),12)                        
                $Line6=StringLeft(StringTrimLeft($aRecords[6],54),12)                        
                $Line7=StringLeft(StringTrimLeft($aRecords[7],48),12)                
                $Line8=StringLeft(StringTrimLeft($aRecords[8],42),12)                
        $Line9=StringLeft(StringTrimLeft($aRecords[9],36),12)                
                $Line10=StringLeft(StringTrimLeft($aRecords[10],30),12)                
                $Line11=StringLeft(StringTrimLeft($aRecords[11],24),12)
                $Line12=StringLeft(StringTrimLeft($aRecords[12],24),48)
;MsgBox(0,"Check2",$Line1&"|"&$Line2&"|"&$Line22&"|"&$Line3&"|"&$Line33&"|"&$Line4&"|"&$Line44&"|"&$Line5&"|"&$Line55&"|"&$Line6&"|"&$Line66&"|"&$Line7&"|"&$Line77&"|"&$Line8&"|"&$Line88&"|"&$Line9&"|"&$Line99&"|"&$Line10&"|"&$Line102&"|"&$Line11&"|"&$Line112&"|"&$Line12)

                if $Line1=$ZeroNums12 And $Line2=$ZeroNums12 And $Line3=$ZeroNums12 And $Line22=$ZeroNums12 And $Line33=$ZeroNums12 And $Line4=$ZeroNums12 And $Line5=$ZeroNums12 And $Line6=$ZeroNums12 And $Line7=$ZeroNums12 And $Line8=$ZeroNums12 And $Line9=$ZeroNums12 And $Line10=$ZeroNums12 And $Line11=$ZeroNums12 And $Line12=$ZeroNums48 Then
                        $TempNum="2"
                EndIf

                
        EndFunc

Func CheckNum3()     ;判断数字3
;特征信息;~ 3=第一 十二行 37-60  第二 十一行  31-42 和 55-66 第三 十行 25-36 和 61-72  第四 八 九行 61-72 第五 七行 55-66 第六行 43-60 
ChuShiHua()
                $Line1=StringLeft(StringTrimLeft($aRecords[1],36),24)
                $Line2=StringLeft(StringTrimLeft($aRecords[2],30),12)        
                $Line22=StringLeft(StringTrimLeft($aRecords[2],54),12)
                $Line3=StringLeft(StringTrimLeft($aRecords[3],24),12)
                $Line33=StringLeft(StringTrimLeft($aRecords[3],60),12)                
                $Line4=StringLeft(StringTrimLeft($aRecords[4],60),12)                        
                $Line5=StringLeft(StringTrimLeft($aRecords[5],54),12)                        
                $Line6=StringLeft(StringTrimLeft($aRecords[6],42),18)                        
                $Line7=StringLeft(StringTrimLeft($aRecords[7],54),12)                
                $Line8=StringLeft(StringTrimLeft($aRecords[8],60),12)                        
        $Line9=StringLeft(StringTrimLeft($aRecords[9],60),12)                        
                $Line10=StringLeft(StringTrimLeft($aRecords[10],24),12)        
            $Line102=StringLeft(StringTrimLeft($aRecords[10],60),12)                
                $Line11=StringLeft(StringTrimLeft($aRecords[11],30),12)
        $Line112=StringLeft(StringTrimLeft($aRecords[11],54),12)
                $Line12=StringLeft(StringTrimLeft($aRecords[12],36),24)

;MsgBox(0,"check3",$Line1&"|"&$Line2&"|"&$Line22&"|"&$Line3&"|"&$Line33&"|"&$Line4&"|"&$Line44&"|"&$Line5&"|"&$Line55&"|"&$Line6&"|"&$Line66&"|"&$Line7&"|"&$Line77&"|"&$Line8&"|"&$Line88&"|"&$Line9&"|"&$Line99&"|"&$Line10&"|"&$Line102&"|"&$Line11&"|"&$Line112&"|"&$Line12)

                if  $Line1=$ZeroNums24 And $Line12=$ZeroNums24 And $Line2=$ZeroNums12 And $Line22=$ZeroNums12 And $Line3=$ZeroNums12 And $Line33=$ZeroNums12 And $Line4=$ZeroNums12 And $Line5=$ZeroNums12 And $Line7=$ZeroNums12 And $Line8=$ZeroNums12 And $Line9=$ZeroNums12 And $Line10=$ZeroNums12 And $Line102=$ZeroNums12 And $Line11=$ZeroNums12 And $Line112=$ZeroNums12 And $Line6=$ZeroNums18 Then
                        $TempNum="3"
                EndIf

        EndFunc

Func CheckNum4()     ;判断数字4
;特征信息;~ 4=第一行 55-66 第二 三行 49-66 第四行 43-66 第五 六行 37-48 和 55-66 第七行 31-42 和 55-66 第八行 25-36 和 55-66 第九行 25-72 第十 十一 十二行 55-66
ChuShiHua()
                $Line1=StringLeft(StringTrimLeft($aRecords[1],54),12)
                $Line2=StringLeft(StringTrimLeft($aRecords[2],48),18)        
                $Line3=StringLeft(StringTrimLeft($aRecords[3],48),18)                
                $Line4=StringLeft(StringTrimLeft($aRecords[4],42),24)                        
                $Line5=StringLeft(StringTrimLeft($aRecords[5],36),12)        
                $Line55=StringLeft(StringTrimLeft($aRecords[5],54),12)        
                $Line6=StringLeft(StringTrimLeft($aRecords[6],36),12)        
        $Line66=StringLeft(StringTrimLeft($aRecords[6],54),12)                        
                $Line7=StringLeft(StringTrimLeft($aRecords[7],30),12)        
            $Line77=StringLeft(StringTrimLeft($aRecords[7],54),12)
                $Line8=StringLeft(StringTrimLeft($aRecords[8],24),12)        
        $Line88=StringLeft(StringTrimLeft($aRecords[8],54),12)        
        $Line9=StringLeft(StringTrimLeft($aRecords[9],24),48)                
                $Line10=StringLeft(StringTrimLeft($aRecords[10],54),12)                
                $Line11=StringLeft(StringTrimLeft($aRecords[11],54),12)
                $Line12=StringLeft(StringTrimLeft($aRecords[12],54),12)

;MsgBox(0,"check4",$Line1&"|"&$Line2&"|"&$Line22&"|"&$Line3&"|"&$Line33&"|"&$Line4&"|"&$Line44&"|"&$Line5&"|"&$Line55&"|"&$Line6&"|"&$Line66&"|"&$Line7&"|"&$Line77&"|"&$Line8&"|"&$Line88&"|"&$Line9&"|"&$Line99&"|"&$Line10&"|"&$Line102&"|"&$Line11&"|"&$Line112&"|"&$Line12)

                if $Line1=$ZeroNums12 And $Line5=$ZeroNums12 And $Line55=$ZeroNums12 And $Line6=$ZeroNums12 And $Line66=$ZeroNums12 And $Line7=$ZeroNums12 And $Line77=$ZeroNums12 And $Line8=$ZeroNums12 And $Line88=$ZeroNums12 And $Line10=$ZeroNums12 And $Line11=$ZeroNums12 And $Line12=$ZeroNums12 And $Line9=$ZeroNums48 And $Line2=$ZeroNums18 And $Line3=$ZeroNums18 And $Line4=$ZeroNums24 Then
                        $TempNum="4"
                EndIf

                
        EndFunc        

Func CheckNum5()     ;判断数字5
;特征信息;~ 5=第一行 25-72 第二 三 四行 25-36 第五行 25-60 第六行 25-42 和 55-66 第七 八 九行 61-72 第十行 25-36 和 61-72 第十一行 31-42 和 55-66 第十二行 37-60
ChuShiHua()
                $Line1=StringLeft(StringTrimLeft($aRecords[1],24),48)
                $Line2=StringLeft(StringTrimLeft($aRecords[2],24),12)        
                $Line3=StringLeft(StringTrimLeft($aRecords[3],24),12)                
                $Line4=StringLeft(StringTrimLeft($aRecords[4],24),12)                        
                $Line5=StringLeft(StringTrimLeft($aRecords[5],24),36)        
                $Line6=StringLeft(StringTrimLeft($aRecords[6],24),18)        
        $Line66=StringLeft(StringTrimLeft($aRecords[6],54),12)                        
                $Line7=StringLeft(StringTrimLeft($aRecords[7],60),12)        
                $Line8=StringLeft(StringTrimLeft($aRecords[8],60),12)                
        $Line9=StringLeft(StringTrimLeft($aRecords[9],60),12)                
                $Line10=StringLeft(StringTrimLeft($aRecords[10],24),12)        
            $Line102=StringLeft(StringTrimLeft($aRecords[10],60),12)        
                $Line11=StringLeft(StringTrimLeft($aRecords[11],30),12)
                $Line112=StringLeft(StringTrimLeft($aRecords[11],54),12)        
                $Line12=StringLeft(StringTrimLeft($aRecords[12],36),24)
;MsgBox(0,"check5",$Line1&"|"&$Line2&"|"&$Line22&"|"&$Line3&"|"&$Line33&"|"&$Line4&"|"&$Line44&"|"&$Line5&"|"&$Line55&"|"&$Line6&"|"&$Line66&"|"&$Line7&"|"&$Line77&"|"&$Line8&"|"&$Line88&"|"&$Line9&"|"&$Line99&"|"&$Line10&"|"&$Line102&"|"&$Line11&"|"&$Line112&"|"&$Line12)

                if $Line6=$ZeroNums18 And $Line1=$ZeroNums48 And $Line5=$ZeroNums36 And $Line2=$ZeroNums12 And $Line3=$ZeroNums12 And $Line4=$ZeroNums12 And $Line66=$ZeroNums12 And $Line7=$ZeroNums12 And $Line102=$ZeroNums12 And $Line8=$ZeroNums12 And $Line112=$ZeroNums12 And $Line9=$ZeroNums12 And $Line10=$ZeroNums12 And $Line11=$ZeroNums12 And  $Line12=$ZeroNums24 Then
                        
                        $TempNum="5"
                EndIf
        EndFunc        

Func CheckNum6()     ;判断数字6
;特征信息;~ 6=第一 十二行 37-60  第二 十一行 31-42和 55-66 第三 七 八 九 十行 25-36 和 61-72 第四行 25-36 第五行 25-60 第六行 25-42 和 55-66
ChuShiHua()
                $Line1=StringLeft(StringTrimLeft($aRecords[1],36),24)
                $Line2=StringLeft(StringTrimLeft($aRecords[2],30),12)        
        $Line22=StringLeft(StringTrimLeft($aRecords[2],54),12)
                $Line3=StringLeft(StringTrimLeft($aRecords[3],24),12)
        $Line33=StringLeft(StringTrimLeft($aRecords[3],60),12)                
                $Line4=StringLeft(StringTrimLeft($aRecords[4],24),12)                        
                $Line5=StringLeft(StringTrimLeft($aRecords[5],24),36)        
                $Line6=StringLeft(StringTrimLeft($aRecords[6],24),18)        
        $Line66=StringLeft(StringTrimLeft($aRecords[6],54),12)                        
                $Line7=StringLeft(StringTrimLeft($aRecords[7],24),12)
        $Line77=StringLeft(StringTrimLeft($aRecords[7],60),12)        
                $Line8=StringLeft(StringTrimLeft($aRecords[8],24),12)
        $Line88=StringLeft(StringTrimLeft($aRecords[8],60),12)                        
                $Line9=StringLeft(StringTrimLeft($aRecords[9],24),12)
        $Line99=StringLeft(StringTrimLeft($aRecords[9],60),12)                
                $Line10=StringLeft(StringTrimLeft($aRecords[10],24),12)        
            $Line102=StringLeft(StringTrimLeft($aRecords[10],60),12)        
                $Line11=StringLeft(StringTrimLeft($aRecords[11],30),12)
                $Line112=StringLeft(StringTrimLeft($aRecords[11],54),12)        
                $Line12=StringLeft(StringTrimLeft($aRecords[12],36),24)
;MsgBox(0,"check6",$Line1&"|"&$Line2&"|"&$Line22&"|"&$Line3&"|"&$Line33&"|"&$Line4&"|"&$Line44&"|"&$Line5&"|"&$Line55&"|"&$Line6&"|"&$Line66&"|"&$Line7&"|"&$Line77&"|"&$Line8&"|"&$Line88&"|"&$Line9&"|"&$Line99&"|"&$Line10&"|"&$Line102&"|"&$Line11&"|"&$Line112&"|"&$Line12)

                if $Line6=$ZeroNums18 And $Line5=$ZeroNums36 And $Line2=$ZeroNums12 And $Line22=$ZeroNums12 And $Line3=$ZeroNums12 And $Line33=$ZeroNums12 And $Line4=$ZeroNums12 And $Line66=$ZeroNums12 And $Line7=$ZeroNums12 And $Line77=$ZeroNums12 And $Line8=$ZeroNums12 And $Line88=$ZeroNums12 And $Line9=$ZeroNums12 And $Line99=$ZeroNums12 And $Line10=$ZeroNums12 And $Line102=$ZeroNums12 And $Line11=$ZeroNums12 And $Line112=$ZeroNums12 And  $Line1=$ZeroNums24 And $Line12=$ZeroNums24 Then
                        $TempNum=6
                EndIf                
        EndFunc        

Func CheckNum7()     ;判断数字7
;特征信息;~ 7=第一行 25-72 第二 三行 61-72 第四 五 六行 55-66 第七 八 九行 49-60 第十 十一 十二行 43-54
ChuShiHua()
                $Line1=StringLeft(StringTrimLeft($aRecords[1],24),48)
                $Line2=StringLeft(StringTrimLeft($aRecords[2],60),12)        
                $Line3=StringLeft(StringTrimLeft($aRecords[3],60),12)                
                $Line4=StringLeft(StringTrimLeft($aRecords[4],54),12)                        
                $Line5=StringLeft(StringTrimLeft($aRecords[5],54),12)        
                $Line6=StringLeft(StringTrimLeft($aRecords[6],54),12)                        
                $Line7=StringLeft(StringTrimLeft($aRecords[7],48),12)        
                $Line8=StringLeft(StringTrimLeft($aRecords[8],48),12)                
        $Line9=StringLeft(StringTrimLeft($aRecords[9],48),12)                
                $Line10=StringLeft(StringTrimLeft($aRecords[10],42),12)        
                $Line11=StringLeft(StringTrimLeft($aRecords[11],42),12)        
                $Line12=StringLeft(StringTrimLeft($aRecords[12],42),12)
;MsgBox(0,"check7",$Line1&"|"&$Line2&"|"&$Line22&"|"&$Line3&"|"&$Line33&"|"&$Line4&"|"&$Line44&"|"&$Line5&"|"&$Line55&"|"&$Line6&"|"&$Line66&"|"&$Line7&"|"&$Line77&"|"&$Line8&"|"&$Line88&"|"&$Line9&"|"&$Line99&"|"&$Line10&"|"&$Line102&"|"&$Line11&"|"&$Line112&"|"&$Line12)

                if $Line1=$ZeroNums48 And $Line2=$ZeroNums12 And $Line3=$ZeroNums12 And $Line4=$ZeroNums12 And $Line5=$ZeroNums12 And $Line6=$ZeroNums12 And $Line7=$ZeroNums12 And $Line8=$ZeroNums12 And $Line9=$ZeroNums12 And $Line10=$ZeroNums12 And $Line11=$ZeroNums12 And $Line12=$ZeroNums12 Then
                        $TempNum="7"
                EndIf
        EndFunc        

Func CheckNum8()     ;判断数字8
;特征信息;~ 8=第一 十二行 37-60 第二 五 七 十一行 31-42 和 55-66 第三 四 八 九 十行 25-36 和 61-72 第六行 37-60 
ChuShiHua()
                $Line1=StringLeft(StringTrimLeft($aRecords[1],36),24)
                $Line2=StringLeft(StringTrimLeft($aRecords[2],30),12)        
                $Line22=StringLeft(StringTrimLeft($aRecords[2],54),12)
                $Line3=StringLeft(StringTrimLeft($aRecords[3],24),12)        
                $Line33=StringLeft(StringTrimLeft($aRecords[3],60),12)        
                $Line4=StringLeft(StringTrimLeft($aRecords[4],24),12)        
                $Line44=StringLeft(StringTrimLeft($aRecords[4],60),12)                        
                $Line5=StringLeft(StringTrimLeft($aRecords[5],30),12)
                $Line55=StringLeft(StringTrimLeft($aRecords[5],54),12)
                $Line6=StringLeft(StringTrimLeft($aRecords[6],36),24)                        
                $Line7=StringLeft(StringTrimLeft($aRecords[7],30),12)        
                $Line77=StringLeft(StringTrimLeft($aRecords[7],54),12)
                $Line8=StringLeft(StringTrimLeft($aRecords[8],24),12)                
                $Line88=StringLeft(StringTrimLeft($aRecords[8],60),12)        
        $Line9=StringLeft(StringTrimLeft($aRecords[9],24),12)        
                $Line99=StringLeft(StringTrimLeft($aRecords[9],60),12)
                $Line10=StringLeft(StringTrimLeft($aRecords[10],24),12)        
                $Line102=StringLeft(StringTrimLeft($aRecords[10],60),12)
                $Line11=StringLeft(StringTrimLeft($aRecords[11],30),12)
                $Line112=StringLeft(StringTrimLeft($aRecords[11],54),12)
                $Line12=StringLeft(StringTrimLeft($aRecords[12],36),24)
;MsgBox(0,"check8",$Line1&"|"&$Line2&"|"&$Line22&"|"&$Line3&"|"&$Line33&"|"&$Line4&"|"&$Line44&"|"&$Line5&"|"&$Line55&"|"&$Line6&"|"&$Line66&"|"&$Line7&"|"&$Line77&"|"&$Line8&"|"&$Line88&"|"&$Line9&"|"&$Line99&"|"&$Line10&"|"&$Line102&"|"&$Line11&"|"&$Line112&"|"&$Line12)

                if $Line1=$ZeroNums24 And $Line12=$ZeroNums24 And $Line6=$ZeroNums24 And $Line9=$ZeroNums12 And $Line2=$ZeroNums12 And $Line22=$ZeroNums12 And $Line3=$ZeroNums12 And $Line33=$ZeroNums12 And $Line4=$ZeroNums12 And $Line44=$ZeroNums12 And $Line5=$ZeroNums12 And $Line55=$ZeroNums12 And $Line7=$ZeroNums12 And $Line77=$ZeroNums12 And $Line8=$ZeroNums12 And $Line88=$ZeroNums12 And $Line9=$ZeroNums12 And $Line10=$ZeroNums12 And $Line102=$ZeroNums12 And $Line11=$ZeroNums12 And $Line112=$ZeroNums12 Then
                        $TempNum="8"
                EndIf
        EndFunc        

Func CheckNum9()     ;判断数字7
;特征信息;~ 9=第一 十二行 37-60 第二 十一行 31-42 和 55-66 第三 四 五 六 十行 25-36 和 61-72 第七行 31-42 和 55-72 第八行 37-72 第九行 61-72
ChuShiHua()
                $Line1=StringLeft(StringTrimLeft($aRecords[1],36),24)
                $Line2=StringLeft(StringTrimLeft($aRecords[2],30),12)        
                $Line22=StringLeft(StringTrimLeft($aRecords[2],54),12)
                $Line3=StringLeft(StringTrimLeft($aRecords[3],24),12)        
                $Line33=StringLeft(StringTrimLeft($aRecords[3],60),12)        
                $Line4=StringLeft(StringTrimLeft($aRecords[4],24),12)        
                $Line44=StringLeft(StringTrimLeft($aRecords[4],60),12)                        
                $Line5=StringLeft(StringTrimLeft($aRecords[5],24),12)                
            $Line55=StringLeft(StringTrimLeft($aRecords[5],60),12)                
                $Line6=StringLeft(StringTrimLeft($aRecords[6],24),12)                        
                $Line66=StringLeft(StringTrimLeft($aRecords[6],60),12)                
                $Line7=StringLeft(StringTrimLeft($aRecords[7],30),12)        
                $Line77=StringLeft(StringTrimLeft($aRecords[7],54),18)        
                $Line8=StringLeft(StringTrimLeft($aRecords[8],36),36)                
        $Line9=StringLeft(StringTrimLeft($aRecords[9],60),12)                
                $Line10=StringLeft(StringTrimLeft($aRecords[10],24),12)        
                $Line102=StringLeft(StringTrimLeft($aRecords[10],60),12)                
                $Line11=StringLeft(StringTrimLeft($aRecords[11],30),12)                
                $Line112=StringLeft(StringTrimLeft($aRecords[11],54),12)
                $Line12=StringLeft(StringTrimLeft($aRecords[12],36),24)
;MsgBox(0,"check9",$Line1&"|"&$Line2&"|"&$Line22&"|"&$Line3&"|"&$Line33&"|"&$Line4&"|"&$Line44&"|"&$Line5&"|"&$Line55&"|"&$Line6&"|"&$Line66&"|"&$Line7&"|"&$Line77&"|"&$Line8&"|"&$Line88&"|"&$Line9&"|"&$Line99&"|"&$Line10&"|"&$Line102&"|"&$Line11&"|"&$Line112&"|"&$Line12)

                if $Line8=$ZeroNums36 And $Line1=$ZeroNums24 And $Line12=$ZeroNums24 And $Line77=$ZeroNums18 And $Line2=$ZeroNums12 And $Line22=$ZeroNums12 And $Line3=$ZeroNums12 And $Line33=$ZeroNums12 And $Line4=$ZeroNums12 And $Line44=$ZeroNums12 And $Line5=$ZeroNums12 And $Line55=$ZeroNums12 And $Line6=$ZeroNums12 And $Line66=$ZeroNums12 And $Line7=$ZeroNums12 And $Line9=$ZeroNums12 And $Line10=$ZeroNums12 And $Line102=$ZeroNums12 And $Line11=$ZeroNums12 And $Line112=$ZeroNums12 Then
                        $TempNum="9"
                EndIf
        EndFunc        

Func CheckNum0()     ;判断数字0
;特征信息;~ 0=第一 十二行 37-60  第二 三 十 十一行  31-42 和 55-66  第四 五 六 七 八 九行 25-36 和 61-72 
ChuShiHua()
                $Line1=StringLeft(StringTrimLeft($aRecords[1],36),24)
                $Line2=StringLeft(StringTrimLeft($aRecords[2],30),12)        
                $Line22=StringLeft(StringTrimLeft($aRecords[2],54),12)
                $Line3=StringLeft(StringTrimLeft($aRecords[3],30),12)        
                $Line33=StringLeft(StringTrimLeft($aRecords[3],54),12)        
                $Line4=StringLeft(StringTrimLeft($aRecords[4],24),12)        
                $Line44=StringLeft(StringTrimLeft($aRecords[4],60),12)                        
                $Line5=StringLeft(StringTrimLeft($aRecords[5],24),12)
                $Line55=StringLeft(StringTrimLeft($aRecords[5],60),12)
                $Line6=StringLeft(StringTrimLeft($aRecords[6],24),12)        
                $Line66=StringLeft(StringTrimLeft($aRecords[6],60),12)                        
                $Line7=StringLeft(StringTrimLeft($aRecords[7],24),12)
                $Line77=StringLeft(StringTrimLeft($aRecords[7],60),12)
                $Line8=StringLeft(StringTrimLeft($aRecords[8],24),12)                
                $Line88=StringLeft(StringTrimLeft($aRecords[8],60),12)        
        $Line9=StringLeft(StringTrimLeft($aRecords[9],24),12)        
                $Line99=StringLeft(StringTrimLeft($aRecords[9],60),12)
                $Line10=StringLeft(StringTrimLeft($aRecords[10],30),12)        
                $Line102=StringLeft(StringTrimLeft($aRecords[10],54),12)
                $Line11=StringLeft(StringTrimLeft($aRecords[11],30),12)
                $Line112=StringLeft(StringTrimLeft($aRecords[11],54),12)
                $Line12=StringLeft(StringTrimLeft($aRecords[12],36),24)
;MsgBox(0,"check0",$Line1&"|"&$Line2&"|"&$Line22&"|"&$Line3&"|"&$Line33&"|"&$Line4&"|"&$Line44&"|"&$Line5&"|"&$Line55&"|"&$Line6&"|"&$Line66&"|"&$Line7&"|"&$Line77&"|"&$Line8&"|"&$Line88&"|"&$Line9&"|"&$Line99&"|"&$Line10&"|"&$Line102&"|"&$Line11&"|"&$Line112&"|"&$Line12)

                if $Line1=$ZeroNums24 And $Line12=$ZeroNums24 And $Line2=$ZeroNums12 And $Line22=$ZeroNums12 And $Line3=$ZeroNums12 And $Line33=$ZeroNums12 And $Line4=$ZeroNums12 And $Line44=$ZeroNums12 And $Line5=$ZeroNums12 And $Line55=$ZeroNums12 And $Line6=$ZeroNums12 And $Line66=$ZeroNums12 And $Line7=$ZeroNums12 And $Line77=$ZeroNums12 And $Line8=$ZeroNums12 And $Line88=$ZeroNums12 And $Line9=$ZeroNums12 And $Line99=$ZeroNums12 And $Line10=$ZeroNums12 And $Line102=$ZeroNums12 And $Line11=$ZeroNums12 And $Line112=$ZeroNums12 Then
                        $TempNum="0"
                EndIf
        EndFunc        
;~ StartReadCode();主函数
;真正起执行的代码---开始
Func StartReadCode()

$a_Image = myReadImageToArray("code.jpg")
$a_Image = myArrayChangeSC($a_Image, 1, 0x777777, 0xffffff)


if FileExists("code.txt") Then                
        FileDelete("code.txt")
EndIf

for $line=5 to $Cro-4 Step 1

FileWriteLine("code.txt",$a_Image[$line])

Next

If Not _FileReadToArray("code.txt",$aRecords) Then
   MsgBox(4096,"Error", " Error reading log to Array     error:" & @error)
   Exit
EndIf

ReadFirstNum()
ReadSecondNum()
ReadThirdNum()
ReadFourthNum()
$CodeNum=$FirstNum&$SecondNum&$ThirdNum&$FourthNum
Return $CodeNum
EndFunc

;真正起执行的代码---结束
;~ 60，120，180


;特征信息
;~ [阿拉伯数字]
;~ 1=第一行 43-54 第二行 31-54 第三 四 五 六 七 八 九 十 十一 十二行 43-54
;~ 2=第一行 37-60 第二行 31-42 和 55-66 第三行 25-36 和 61-72 第四 五行 61-72 第六行 55-66 第七行 49-60 第八行 43-54 第九行 37-48 第十行 31-42 第十一行 25-36 第十二行 25-72
;~ 3=第一 十二行 37-60  第二 十一行  31-42 和 55-66 第三 十行 25-36 和 61-72  第四 八 九行 61-72 第五 七行 55-66 第六行 43-60 
;~ 4=第一行 55-66 第二 三行 49-66 第四行 43-66 第五 六行 37-48 和 55-66 第七行 31-42 和 55-66 第八行 25-36 和 55-66 第九行 25-72 第十 十一 十二行 55-66
;~ 5=第一行 25-72 第二 三 四行 25-36 第五行 25-60 第六行 25-42 和 55-66 第七 八 九行 61-72 第十行 25-36 和 61-72 第十一行 31-42 和 55-66 第十二行 37-60
;~ 6=第一 十二行 37-60  第二 十一行 31-42和 55-66 第三 七 八 九 十行 25-36 和 61-72 第四行 25-36 第五行 25-60 第六行 25-42 和 55-66
;~ 7=第一行 25-72 第二 三行 61-72 第四 五 六行 55-66 第七 八 九行 49-60 第十 十一 十二行 43-54
;~ 8=第一 十二行 37-60 第二 五 七 十一行 31-42 和 55-66 第三 四 八 九 十行 25-36 和 61-72 第六行 37-60 
;~ 9=第一 十二行 37-60 第二 十一行 31-42 和 55-66 第三 四 五 六 十行 25-36 和 61-72 第七行 31-42 和 55-72 第八行 37-72 第九行 61-72
;~ 0=第一 十二行 37-60  第二 三 十 十一行  31-42 和 55-66  第四 五 六 七 八 九行 25-36 和 61-72
