#include <INet.au3>
$filename="5272-5301"
$filename1="社会科学.txt"
$file = FileOpen("r:\"&$filename&$filename1, 2)

If $file = -1 Then
	MsgBox(0, "错误", "不能打开文件.")
	Exit
EndIf

For $i1 = 1 To 862
	;http://e.jd.com/products/5272-10846-0-1-861.html
	$s_URL = 'http://e.jd.com/products/'&$filename&'-0-1-' & $i1 & '.html'
	$sText = _INetGetSource($s_URL)
	$aarray = StringSplit($sText, "<div class=""p-img bookimg"">", 1)
	For $i = 2 To $aarray[0]
		If StringInStr($aarray[$i], 'class="go-down"></a>') Then

			$sshuming = strmid($aarray[$i], 'height="130" width="130" alt="', '"/>')
			$szuozhe = strmid($aarray[$i], '&key=', """")
;			$sinfo = strmid($aarray[$i], 'e-info">　　', "<font class=dot>")
			$simg=strmid($aarray[$i], '<img data-img="1"  src="', """")
;			FileWriteLine($file,$i1&"::"& $sshuming & "::" & $szuozhe &"::" & $Sinfo &"::" & $simg)
			FileWriteLine($file,$i1&"::"& $sshuming & "::" & $szuozhe &"::" &  $simg)
		EndIf
	Next
Next
Func strmid($ssrc, $sstart, $send)
	$istart = StringInStr($ssrc, $sstart)
	$ssrc = StringMid($ssrc, $istart + StringLen($sstart), StringLen($ssrc))
	$iend = StringInStr($ssrc, $send)
	$ssrc = StringLeft($ssrc, $iend - 1)
	Return $ssrc
EndFunc   ;==>strmid