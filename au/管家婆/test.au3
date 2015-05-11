Global Const $key[27]=['吖','八','擦','耷','俄','发','噶','哈','丌','丌','卡','拉','马','拿','哦','趴','七','然','撒','他','挖','挖','挖','西','丫','匝','匝']
#include <String.au3>
$server = 'www.caiwuhao.com'
$username = 'username1'
$pass = 'jmdjsj903291A'
#include <FTPEx.au3>
	$Open = _FTP_Open('MyFTP Control')
	$Conn = _FTP_Connect($Open, $server, $username, $pass)
	_FTP_Command ( $Conn, "quote opts utf8 on")
	$FilePut = _FTP_FilePut($Conn, "编写安装程序1.png", c("www/编写安装程序1.png"))
;	$FilePut = _FTP_FilePut($Conn, "编写安装程序2.png", "www/d/"&$appname[2]&"2.png")
;	$FilePut = _FTP_FilePut($Conn, "编写安装程序3.png", "www/d/"&$appname[2]&"3.png")

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