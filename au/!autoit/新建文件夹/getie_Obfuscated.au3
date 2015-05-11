Global Const $tagPOINT = "long X;long Y"
Global Const $HGDI_ERROR = Ptr(-1)
Global Const $INVALID_HANDLE_VALUE = Ptr(-1)
Global Const $KF_EXTENDED = 0x0100
Global Const $KF_ALTDOWN = 0x2000
Global Const $KF_UP = 0x8000
Global Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 8)
Global Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 8)
Global Const $LLKHF_UP = BitShift($KF_UP, 8)
Func _INetGetSource($s_URL, $bString = True)
Local $sString = InetRead($s_URL, 1)
Local $nError = @error, $nExtended = @extended
If $bString Then $sString = BinaryToString($sString)
Return SetError($nError, $nExtended, $sString)
EndFunc
For $i1 = 1 To 861
$s_URL = 'http://e.jd.com/products/5272846-0-' & $i1 & '-861.html'
$sText = _INetGetSource($s_URL)
$file = FileOpen("r:\test.txt", 2)
If $file = -1 Then
MsgBox(0, "错误", "不能打开文件.")
Exit
EndIf
$aarray = StringSplit($sText, "<div class=""p-img bookimg"">", 1)
For $i = 2 To $aarray[0]
If StringInStr($aarray[$i], 'class="go-down"></a>') Then
$sshuming = strmid($aarray[$i], 'height="130" width="130" alt="', '"/>')
$szuozhe = strmid($aarray[$i], '&key=', """")
FileWriteLine($file, $sshuming & "::" & $szuozhe)
EndIf
Next
Next
Func strmid($ssrc, $sstart, $send)
$istart = StringInStr($ssrc, $sstart)
$ssrc = StringMid($ssrc, $istart + StringLen($sstart), StringLen($ssrc))
$iend = StringInStr($ssrc, $send)
$ssrc = StringLeft($ssrc, $iend - 1)
Return $ssrc
EndFunc
