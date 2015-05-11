;验证码图形文件预处理初步(七)简单的Y轴分离

;使用的au3版本: 3.3

#include <GDIPlus.au3>
#include <array.au3>

;步骤1,分析.略
$CodeNum=1  ;1个数字 组成一个验证码,虽然是4个验证码组成,但今天我们要拆成一个个来处理
$CodeWidth=8 ;验证码宽度为8个点
$i_left=0 ;左边先定为0,因为它的Y轴是可变的,我们后面要做处理
$i_mid=0 ;中间先定为0,因为它的Y轴是可变的,我们后面要做处理
$i_top=0 ;上方先定为0,因为它的Y轴是可变的,我们后面要做处理
$i_bottom=0 ;下方先定为0,因为它的Y轴是可变的,我们后面要做处理

FileInstall("codefont.txt",@tempdir&"\",1)
$s_FontFile = @TempDir&"\CodeFont.txt"

;步骤2: 学习所有出现的字符
#cs
$s_FontFile = @ScriptDir&"\CodeFont.txt"
FileDelete($s_FontFile)

$search = FileFindFirstFile(@ScriptDir&"\codetest\*.bmp")  

; Check if the search was successful
If $search = -1 Then
    MsgBox(0, "Error", "No files/directories matched the search pattern")
    Exit
EndIf

While 1
    $file = FileFindNextFile($search) 
    If @error Then ExitLoop
    
    ConsoleWrite("File:"&$file&","&StringLeft($file,stringinstr($file,".bmp")-1)&@CRLF)
	$a_Image = myReadImageToArray(@ScriptDir&"\codetest\"&$file, False, 1, 0xcccccc);
	myArrarOCR($s_FontFile, $a_Image, 0, $CodeNum, $CodeWidth, StringLeft($file,stringinstr($file,".bmp")-1), $i_left, $i_mid, $i_top, $i_bottom)
WEnd

; Close the search handle
FileClose($search)
#ce

;ConsoleWrite("识别")
$a_Image = myReadImageToArray(@ScriptDir&"\img.png", True, 2, 0xd0d0d0);
$a_Image = myArrayClearBG($a_Image)
$s_code=""
For $i=1 To 4
	$a = myGetArrayYisSpace($a_Image)
	If UBound($a,1)>8 Then;粘连
		For $x_=Int(UBound($a)/2) To UBound($a)-1
			For $y_=0 To UBound($a,2)-1
				$a[$x_][$y_]=0xffffff
			Next
		Next
	EndIf
	
	$a_Image = myArrayXORarray($a_Image, $a)
	$a_Image = myArrayClearBG($a_Image)
	$a = myArrayClearBG($a)
	If UBound($a,1)<8 Then
		Local $a_temp[8][UBound($a,2)]
		$a_temp = myArrayInit($a_temp)
		$a=myArrayXORarray($a_temp,$a,0xffffff,False);相叠加
	EndIf
	
	$s_code_string = myArrarOCR($s_FontFile, $a, 1, $CodeNum, $CodeWidth, "", $i_left, $i_mid, $i_top, $i_bottom)
	ConsoleWrite($s_code_string)
	$s_code &= $s_code_string
Next
MsgBox(4096,"完成","识别结果:"&$s_code)
Exit

Func myArrayInit($func_array, $func_bg=0xffffff);将数组初始化为底色
	If Not IsArray($func_array) Then Return 0
	Local $x,$y
	For $y = 0 To UBound($func_array,2)-1
		For $x = 0 To UBound($func_array,1)-1
			$func_array[$x][$y]=$func_bg;初始化为底色
		Next
	Next;数组初始化
	Return $func_array
EndFunc


;$Ocr=0 表示学习, 为1表示识别, 此函数用于学习和识别固定位置的字符
Func myArrarOCR($s_code_file, $func_array, $Ocr, $CodeNum, $CodeWidth, $CurrValue="", $func_left=0, $func_mid=0, $func_top=0, $func_bottom=0)
	If ($CodeNum<=0) Or $s_code_file="" Or Not IsArray($func_array) Then Return ""
	Local $a_Code, $i, $s_code, $s
	Local $s_file = FileRead($s_code_file);只能用于英文验证码处理,中文处理FileRead函数对Pwin有BUG要修正
	If $Ocr Then
		Local $a_file = StringRegExp($s_file, "(.*)(?:\r\n)", 3)
		If Not IsArray($a_file) Then Return "";没有识别库
		Local $j, $i_code, $i_code_temp, $s_code_string=""
	EndIf
	Local $a_msg[3]
	If UBound($func_array,2)>0 Then 
		$a_msg[0]=2;二维
		$a_msg[1]=UBound($func_array,1)
		$a_msg[2]=UBound($func_array,2)
	Else
		$a_msg[0]=1;一维
		$a_msg[1]=StringLen($func_array[0])/6
		$a_msg[2]=UBound($func_array)
	EndIf
	Local $i_Ext
	For $i = 1 To $CodeNum
		$a_Code = myArrayDelBox($func_array, $func_left+($i-1)*($CodeWidth+$func_mid), $a_msg[1]-$func_left-$i*$CodeWidth-($i-1)*$func_mid, $func_top, $func_bottom)
		;$a_Code = myArrayClearBG($a_Code, False, False, True, True, 0xffffff)
		;_ArrayDisplay($a_code,"",1,UBound($a_code,2));查看这句,可以较深刻理解myArrayClearBG函数
		$s = myArrayToString($a_code,False)
		StringReplace($s,"1"," ")
		$i_Ext = @extended ;为1个数,即点的数量
		If $Ocr Then;识别
			$i_code = $CodeWidth*($a_msg[2]-$func_top-$func_bottom)
			For $j = 0 To UBound($a_file)-1
				If Abs($i_Ext-Number(StringTrimLeft($a_file[$j],2)))>80 Then ContinueLoop;误差n(如50,此值待确定)个点以上的当做不对
				$i_code_temp = OcrCompStr($s, StringTrimLeft($a_file[$j], StringInStr($a_file[$j],"|") ) )
				If $i_code_temp<$i_code Then 
					$i_code = $i_code_temp
					$s_code = StringLeft($a_file[$j], 1)
					If $i_code<=0 Then ExitLoop
				EndIf
			Next
			$s_code_string &= $s_code
		Else;学习
			If $CurrValue="" Or StringLen($CurrValue)<>$CodeNum Then
				$s_code=""
				Do
					$s_code = InputBox("验证码学习","请输入你所看到的验证码"&@CRLF&myArrayToString($a_code,True), "", "", @DesktopWidth/2, @DesktopHeight-100)
				Until StringLen($s_code)=1
			Else
				$s_code = StringMid($CurrValue, $i, 1)
			EndIf
			;$s = $s_code & "," & $CodeWidth & "," & $a_msg[2]-$func_top-$func_bottom & "," & myArrayToString($a_code,False)
			$s = myArrayToString($a_code,False)
			StringReplace(StringTrimLeft($s,stringinstr($s,"|")),"1"," ")
			$s = $s_code & "," & @extended & "|" & $s
			If StringInStr($s_file, $s)=0 Then;未写过
				;ConsoleWrite($s&","&@CRLF)
				FileWriteLine($s_code_file, $s)
				$s_file &= $s & @CRLF
			EndIf
		EndIf
	Next
	If $Ocr Then 
		Return $s_code_string
	Else
		Return 1
	EndIf
EndFunc

Func OcrCompStr($string1, $string2);返回多少个不同
	#cs
	If StringLen($string1)<> StringLen($string2) Then
		If StringLen($string1)< StringLen($string2) Then
			Return StringLen($string2)
		Else
			Return StringLen($string1)
		EndIf
	EndIf
	#ce
	If $string1=$string2 Then Return 0
	Local $i_return=0, $i
	For $i = 1 To StringLen($string1)
		If StringMid($string1, $i, 1)<> StringMid($string2,$i,1) Then $i_return += 1
	Next
	Return $i_return	
EndFunc

;去除数组上下左右为底色的整行或整列元素,使数组缩小
Func myArrayClearBG($func_array, $func_left=True, $func_right=True, $func_top=True, $func_bottom=True, $func_bg=0xffffff)
	Local $a_msg = myGetArrayMessage($func_array, $func_bg)
	If Not IsArray($a_msg) Or $a_msg[7]=1 Then Return $func_array;$func_array不用判断是否数组了,因为myGetArrayMessage函数返回的值已经说明问题了
	If Not $func_left Then $a_msg[3]=0
	If Not $func_right Then $a_msg[4]=0
	If Not $func_top Then $a_msg[5]=0
	If Not $func_bottom Then $a_msg[6]=0
	If $a_msg[0]=2 Then
		Local $a_return[$a_msg[1]-$a_msg[3]-$a_msg[4]][$a_msg[2]-$a_msg[5]-$a_msg[6]]
	Else
		Local $a_return[$a_msg[2]-$a_msg[5]-$a_msg[6]]
	EndIf
	Local $x,$y
	For $y= $a_msg[5] To $a_msg[2]-$a_msg[6]-1
		If $a_msg[0]=2 Then
			For $x=$a_msg[3] To $a_msg[1]-$a_msg[4]-1
				$a_return[$x-$a_msg[3]][$y-$a_msg[5]]=$func_array[$x][$y]
			Next
		Else
			$a_return[$y-$a_msg[5]]=StringMid($func_array[$y], 6*$a_msg[3]+1, 6*($a_msg[1]-$a_msg[3]-$a_msg[4]))
		EndIf
	Next
	Return $a_return
EndFunc

Func myGetArrayMessage($func_array, $func_bg=0xffffff);获取数组周边全为底色的信息,错误时返回非数组
	If UBound($func_array)=0 Then Return $func_array
	Local $time=TimerInit()
	Local $a_return[11]
	If UBound($func_array,2)=0 Then 
		Local $i_height=UBound($func_array)
		Local $i_width=StringLen($func_array[0])/6
		$a_return[0]=1;一维
	Else
		Local $i_height=UBound($func_array,2)
		Local $i_width=UBound($func_array,1)
		$a_return[0]=2;二维
	EndIf
	Local $x, $y, $s, $s1, $i_top=0, $i_bottom=$i_height, $i_left=-1, $i_right=$i_width, $i_tmp, $s_all=""
	$func_bg = Hex($func_bg,6)
	For $y=0 To $i_height-1
		If $a_return[0]=1 Then
			$s = $func_array[$y]
		Else
			$s=""
			For $x=0 To $i_width-1
				$s &= Hex($func_array[$x][$y],6)
			Next
		EndIf
		$s_all &= $s
		;左空几个位置
		If $i_left<>0 Then;=0说明有一行左边第一个不为空,所以不用再找了
			$s1 = StringRegExpReplace($s, "^("&$func_bg&"){1,}","")
			If $i_left= -1 Or $i_left>(StringLen($s)-StringLen($s1))/6 Then $i_left=(StringLen($s)-StringLen($s1))/6
		EndIf
		;ConsoleWrite($s&','&$i_left&@crlf)
		;右空几个位置,经测试,用正则来做时,大文件极慢,所以不用正则
		$i_tmp=0
		Do
			$i_tmp +=1
			$s1=StringRight($s,6*$i_tmp)
		Until StringLeft($s1,6)<>$func_bg Or $i_tmp>$i_right
		If $i_right>$i_tmp-1 Then $i_right=$i_tmp-1
	
		$s=StringReplace($s,$func_bg,"")
		If $s="" Then
			If $i_bottom = $i_height Then $i_bottom=$y;下面第几行开始空
			If $i_top=$y Then $i_top +=1;上面有几行空
		Else
			$i_bottom= $i_height
		EndIf
	Next
	$i_bottom= $i_height - $i_bottom;变化为结果,下空几行
	$a_return[1]=$i_width;宽
	$a_return[2]=$i_height;高
	$a_return[3]=$i_left;左空几个
	$a_return[4]=$i_right;右空几个
	$a_return[5]=$i_top;上空几个
	$a_return[6]=$i_bottom;下空几个
	$a_return[7]=0;0不超界
	If $i_width<=$i_left Or $i_height<=$i_top Then $a_return[7]=1;1超界
	$a_return[8]=0;彩色
	If StringReplace(StringReplace($s_all,"FFFFFF",""),"000000","")="" Then $a_return[8]=1;1黑白
	$a_return[9]=$s_all;点阵串
	$a_return[10]=TimerDiff($time);运行时间多少毫秒
	;ConsoleWrite($i_width&','&$i_height&','&$i_left&','&$i_right&','&$i_top&','&$i_bottom&@CRLF)
	Return $a_return
EndFunc

Func myArrayToString($func_array, $show=False)
	Local $a_msg[3]
	If UBound($func_array,2)>0 Then 
		$a_msg[0]=2;二维
		$a_msg[1]=UBound($func_array,1)
		$a_msg[2]=UBound($func_array,2)
	Else
		$a_msg[0]=1;一维
		$a_msg[1]=StringLen($func_array[0])/6
		$a_msg[2]=UBound($func_array)
	EndIf
	Local $y, $x, $s=""
	For $y = 0 To $a_msg[2]-1
		If $a_msg[0]=2 Then
			For $x = 0 To $a_msg[1]-1
				$s &= Hex($func_array[$x][$y],6)
			Next
		Else
			$s &= $func_array[$y]
		EndIf
		If $show Then $s &= @CRLF
	Next
	If $show Then
		$s = StringReplace($s, "FFFFFF",ChrW(0x3000))
		$s = StringReplace($s, "000000", ChrW(0x3002))
	Else
		$s = StringReplace($s, "000000", "1")
		$s = StringReplace($s, "FFFFFF", "0")
	EndIf
	Return $s
EndFunc

Func myArrayDelBox($func_array, $func_left=0, $func_right=0, $func_top=0, $func_bottom=0)
	If Not IsArray($func_array) Then Return $func_array;
	Local $a_msg[8]
	If UBound($func_array,2)>0 Then 
		$a_msg[0]=2;二维
		$a_msg[1]=UBound($func_array,1)
		$a_msg[2]=UBound($func_array,2)
	Else
		$a_msg[0]=1;一维
		$a_msg[1]=StringLen($func_array[0])/6
		$a_msg[2]=UBound($func_array)
	EndIf
	$a_msg[3]=$func_left
	$a_msg[4]=$func_right
	$a_msg[5]=$func_top
	$a_msg[6]=$func_bottom
	If $a_msg[1]<=$a_msg[3]+$a_msg[4] Or $a_msg[2]<=$a_msg[5]+$a_msg[6] Then Return $func_array;超界
		
	If $a_msg[0]=2 Then
		Local $a_return[$a_msg[1]-$a_msg[3]-$a_msg[4]][$a_msg[2]-$a_msg[5]-$a_msg[6]]
	Else
		Local $a_return[$a_msg[2]-$a_msg[5]-$a_msg[6]]
	EndIf
	Local $x,$y
	For $y= $a_msg[5] To $a_msg[2]-$a_msg[6]-1
		If $a_msg[0]=2 Then
			For $x=$a_msg[3] To $a_msg[1]-$a_msg[4]-1
				$a_return[$x-$a_msg[3]][$y-$a_msg[5]]=$func_array[$x][$y]
			Next
		Else
			$a_return[$y-$a_msg[5]]=StringMid($func_array[$y], 6*$a_msg[3]+1, 6*($a_msg[1]-$a_msg[3]-$a_msg[4]))
		EndIf
	Next
	Return $a_return
EndFunc

Func myArrayNoDrop($func_array, $func_drop=1, $func_bg=0xffffff);去干扰
	If Not IsArray($func_array) Then Return 0
	Local $x,$y,$i,$startx,$endx,$starty,$endy,$a,$b, $a_msg[3], $bg=Hex($func_bg,6)
	If UBound($func_array,2)>0 Then 
		$a_msg[0]=2;二维
		$a_msg[1]=UBound($func_array,1)
		$a_msg[2]=UBound($func_array,2)
	Else
		$a_msg[0]=1;一维
		$a_msg[1]=StringLen($func_array[0])/6
		$a_msg[2]=UBound($func_array)
	EndIf
	For $y = 0 To $a_msg[2] -1
		For $x = 0 To $a_msg[1] -1
			If $a_msg[0]=2 Then 
				If $func_array[$x][$y]=$func_bg Then ContinueLoop;底色,不处理
			Else
				If StringMid($func_array[$y], $x*6+1, 6)=$bg Then ContinueLoop;底色,不处理
			EndIf
			$startx=$x-1
			If $startx<0 Then $startx=0
			$endx=$x+1
			If $endx>$a_msg[1]-1 Then $endx=$a_msg[1]-1
			$starty=$y-1
			If $starty<0 Then $starty=0
			$endy=$y+1
			If $endy>$a_msg[2]-1 Then $endy=$a_msg[2]-1
			$i=0
			For $a=$startx To $endx
				For $b=$starty to $endy
					If $a_msg[0]=2 And $func_array[$a][$b]<>$func_bg Then $i +=1;该点非底色
					If $a_msg[0]=1 And StringMid($func_array[$b], $a*6+1, 6)<>$bg Then $i +=1;该点非底色
				Next
			Next
			If $i>0 And $i<=$func_drop Then;
				If $a_msg[0]=2 Then
					$func_array[$x][$y] = $func_bg
				Else
					$func_array[$y] = StringLeft($func_array[$y], $x*6) & $bg & StringRight($func_array[$y], ($a_msg[1]-$x-1)*6)
				EndIf
			EndIf
		Next
	Next
	Return $func_array
EndFunc

;完善后的图形文件读入数组的函数,可在读入时就做颜色变化
Func myReadImageToArray($s_ImageFile, $b_Array2d=False, $func_sc_type=0, $func_sc=0xeeeeee, $func_bg=0xffffff)
    Local $hBitmap, $BitmapData, $i_width, $i_height, $Scan0, $pixelData, $s_BMPData, $i_Stride
	_GDIPlus_Startup()

	$hBitmap = _GDIPlus_BitmapCreateFromFile($s_ImageFile)
	If @error Then 
		_GDIPlus_ShutDown ()
		Return 0;无效的图形文件或未找到该文件
	EndIf
	
	$i_width = _GDIPlus_ImageGetWidth($hBitmap)
	$i_height = _GDIPlus_ImageGetHeight($hBitmap)
	
    $BitmapData = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, $i_width, $i_height, $GDIP_ILMREAD, $GDIP_PXF24RGB)
	;If @error Then ......;
    $i_Stride = DllStructGetData($BitmapData, "Stride");Stride - Offset, in bytes, between consecutive scan lines of the bitmap. If the stride is positive, the bitmap is top-down. If the stride is negative, the bitmap is bottom-up.
    $Scan0 = DllStructGetData($BitmapData, "Scan0");Scan0 - Pointer to the first (index 0) scan line of the bitmap.
    $pixelData = DllStructCreate("ubyte lData[" & (Abs($i_Stride) * $i_height) & "]", $Scan0)
	;不要使用官方论坛上提供的Abs($i_Stride) * $i_height-1,否则无法正确处理gif冗余等情形
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
				Case $func_sc_type=3;类似=1,但黑色用原色代替
					If $a_return[$x][$y]>=$func_sc Then
						$a_return[$x][$y]=$func_bg
					EndIf
				EndSelect
			Next
		Next
	Else;要求返回一维数组
		Local $a_return[$i_height], $y
		For $y=0 To $i_height-1
			$a_return[$y]=StringMid($s_BMPData, $y*($i_Stride*2)+1, $i_width*6)
			$a_return[$y] = myChangeRegExpSC($a_return[$y], $func_sc_type, $func_sc, $func_bg);颜色变化
		Next
	EndIf
	Return $a_return
EndFunc  ;==>myReadImageToArray

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
				Case $func_sc_type=3;类似=1,但黑色用原色代替(就是保留原色)
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

Func myArrayXORarray($func_array, $func_array2, $func_bg=0xffffff, $func_type=True);用数组1加减数组2,得到一个新数组,数组2<=数组1
	If Not IsArray($func_array) Then Return 0
	If Not IsArray($func_array2) Then Return 0
	If UBound($func_array,1)< UBound($func_array2,1) Then Return 0
	If UBound($func_array,2)< UBound($func_array2,2) Then Return 0	
	Local $x,$y
	For $x = 0 To UBound($func_array2,1)-1
		For $y=0 To UBound($func_array2,2)-1
			If $func_array2[$x][$y]<> $func_bg Then
				If $func_type Then
					$func_array[$x][$y] = $func_bg;
				Else
					$func_array[$x][$y] = $func_array2[$x][$y] ;BitXOR( $func_array2[$x][$y], $func_bg)
				EndIf
			EndIf
		Next
	Next
	Return $func_array
EndFunc


Func myGetArrayNewX($func_array, $func_lenX, $func_startX=0);取出图形的一部分(按X取部分,Y全取)
	If $func_lenX<=0 Or (Not IsArray($func_array)) Then Return 0
	Local $x,$y, $a_return[$func_lenX][UBound($func_array,2)]
	For $x= $func_startX To $func_startX+$func_lenX-1
		For $y = 0 To UBound($func_array,2)-1
			$a_return[$X-$func_startX][$y]=$func_array[$x][$y]
		Next
	Next
	Return $a_return
EndFunc
Func myGetArrayYisSpace($func_array,$func_bg=0xffffff);找出Y轴全为底色的第一部分象素组,数组$func_array在送入前应该先去左空
	;这里不用先去左边空,不然返回数组和原数组不好比对.数组进入前必须去空吧? 
	;$func_array = myArray2NoSpace($func_array,$func_bg,True,False,False,False);将数组左边为底色的去除
	If Not IsArray($func_array) Then Return 0
	Local $x,$y,$i, $a_return
	For $x = 0 To UBound($func_array,1)-1
		$i=0
		For $y = 0 To UBound($func_array,2)-1
			If $func_array[$x][$y]<>$func_bg Then 
				$i=1
				ExitLoop
			EndIf
		Next
		If $i=0 Then ExitLoop
	Next
	If $i=0 Or ($i=1 And $x>UBound($func_array,1)-1) Then;x值的该Y轴全为底色
		$a_return = myGetArrayNewX($func_array, $x, 0)
		Return $a_return
	Else
		Return 0;不成功
	EndIf
EndFunc


