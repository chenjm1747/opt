; Script Start - Add your code below here
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         jim

 Script Function:
	百度知道关注提醒

#ce ----------------------------------------------------------------------------
;696
; Script Start - Add your code below here
#include <FTPEx.au3>
#include <GUIConstants.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>
#include <IE.au3>
#include <File.au3>
#include <ScreenCapture.au3>
#include <Clipboard.au3>
msgbox(0,0,@ScriptDir&"\"& @ScriptName)
#PRE_UseX64=n
$softid = IniRead("para.ini","set","softId","-1")		;软件ID，请修改para.ini文件对应参数
$softKey  = IniRead("para.ini","set","softKey","-1")	;软件KEY，请修改para.ini文件对应参数
$softcrcKey  = IniRead("para.ini","set","softcrcKey","-1")	;软件KEY，请修改para.ini文件对应参数
$user  = IniRead("para.ini","set","user","-1")			;用户名，请修改para.ini文件对应参数
$pwd  = IniRead("para.ini","set","pwd","-1")			;密码，请修改para.ini文件对应参数
$DLL = DllOpen("UUWiseHelper.dll")
DllCall($DLL,"none","uu_setSoftInfoW","long",$softid,"wstr",$softKey)
$result = DllCall($DLL,"long","uu_loginW", "wstr",$user , "wstr",$pwd)
If IsArray($result) Then
	If $result[0]>0 Then
		ConsoleWrite("登录成功" & $result[0] & @CRLF);登录成功
;		MsgBox(4096,"成功","登陆成功")
	Else
		ConsoleWrite("登录失败" & $result[0] & @CRLF);登录成功
;		MsgBox(4096,"错误","登录失败,错误码：" & $result[0])
		Exit
	EndIf
Else
;	MsgBox(4096,"错误","失败" )
	Exit
EndIf

$oie=_IECreate("")
$asks=readask()
ProcessClose ("iexplore.exe")
	for $i=1 to $asks[0]
		$oie=_IECreate("")
		$ask1s=StringSplit($asks[$i], ";;",1)
		$question=$ask1s[2]
		$answer=$ask1s[3]
		sogoulogin("qq210080372@iigogo.com","903291")
		;读取问题id
		$url=sogouask($question)
		$Result=StringRegExp($url,'\d+',3)
		$url=$Result[0]
		ProcessClose ("iexplore.exe")
	next

func imgshibie($imgpath11 )
$imgpath = StringReplace($imgpath11,"\","\\")
;MsgBox(0,0,$imgpath)
$getResult = DllCall($DLL,"long","uu_recognizeByCodeTypeAndPathW", "wstr", $imgpath , "long",1004,"wstr","")
$string = StringSplit($getResult[3],"_",1)
If @error = 1 Then
	MsgBox(4096,"未发现分割符,程序2秒后退出","",2)
	Exit
ElseIf $string[1]=="" Or $string[2]=="" Then
	MsgBox(4096,"加密字符串错误or返回验证码错误,程序2秒后退出","",2)
	Exit
EndIf
	return $string[2]
EndFunc

func sogoulogin($n,$p)
	_IENavigate($oie,"http://i.360.cn/login?src=pcw_so&destUrl=http://wenda.so.com/index/ask/")
	_IELoadWait($oie)

	$vname=_IEGetObjById ($oie,"loginAccount")
	$vname.value=$n
	$vname.focus()
	$vname=_IEGetObjById ($oie,"lpassword")
	$vname.value=$p
	$vname.focus()
	$vname=_IEGetObjById ($oie,"loginSubmit")
	Sleep(1000)
	$vname.click()
	Sleep(1000)
	_IELoadWait($oie)
	EndFunc
Func sogouask($question)
	_IENavigate($oie,"http://wenda.so.com/index/ask/")
	_IELoadWait($oie)
	$vname=_IEGetObjById ($oie,"ask_title")
	$vname.value=$question
	$imgfound=0
    While $imgfound=0
	$vname=_IEGetObjById ($oie,"submit")
	$vname.click()
	sleep(1000)
	_IELoadWait($oie)

	Local $oInputs = _IETagNameGetCollection($oIE, "img")
	For $oInput In $oInputs
		if StringInStr($oInput.src,"http://captcha.so.com/image.php")>0 then
			FileDelete(@ScriptName&".gif")
			$iVerifyPic = $oInput
			$iVerifyPics = $oIE.Document.body.createControlRange()
			$iVerifyPics.add($iVerifyPic)
			$iVerifyPics.Select ()
			$iVerifyPics.execCommand('Copy')
			Sleep(500)
			_ClipBoard_Open(0)
			$iVerifyPics = _ClipBoard_GetDataEx($CF_BITMAP)
			_ScreenCapture_SaveImage(@ScriptName&".gif", $iVerifyPics)
			_ClipBoard_Close()
			$imgfound=1
	    endif
    Next
	WEnd

	$vname=_IEGetObjById ($oie,"ask_title")
	$vname.focus()
	sleep(5000)
	$vname=_IEGetObjByname ($oie,"captcha")
	$vname.value=imgshibie(@ScriptName&".gif")
	sleep(10000)
	$vname=_IEGetObjById ($oie,"submit")
	$vname.click()
	sleep(1000)
	_IELoadWait($oie)
	sleep(10000)
	$url=_IEPropertyGet($oIE,"locationurl")
	$Result=StringRegExp($url,'\d+',3)
	$url=$Result[0]
	Local $hFileOpen = FileOpen(@ScriptName&".txt", $FO_APPEND)
	FileWriteLine($hFileOpen,$url)
	FileClose($hFileOpen)
	$Open = _FTP_Open('MyFTP Control')
	$Conn = _FTP_Connect($Open, "www.caiwuhao.com","root","jmdjsj903291A")
	$FilePut = _FTP_FilePut($Conn, @ScriptName&".txt", @ScriptName&".txt")
	_FTP_Close($Open)

EndFunc


Func getimgbyid($iVerifyPic)
$iVerifyPics = $Oie.Document.body.createControlRange()
$iVerifyPics.add($iVerifyPic)
$iVerifyPics.Select ()
$iVerifyPics.execCommand('Copy')

Sleep(500)
_ClipBoard_Open(0)
_ScreenCapture_SaveImage(@ScriptDir & "\aaa.gif", $iVerifyPics)
_ClipBoard_Close()
EndFunc

func readask()
	_IENavigate($oie,"http://www.caiwuhao.com/s1")
	_IELoadWait($oie)
$keyword=StringSplit($oie.document.title, ";;;",1)
return $keyword
EndFunc
func logout()
	_IENavigate($oie,"http://wenwen.sogou.com/z/LLogout.e?sp=13&sp=584245116&g_tk=cd24e40979c45b438240000ab8c34cd08081c2c1c4c31c133b891f14f0732322")
	_IELoadWait($oie)

endfunc
func answer($answer,$url)
	_IENavigate($oie,"http://wenwen.sogou.com/z/q"&$url&".htm")
	_IELoadWait($oie)
	$oFrame2 = _IEFrameGetCollection($oie, 0)
	_IEPropertySet($oFrame2, "innertext", $answer)
	sleep(15000)
		$vname=_IEGetObjById ($oie,"answerSubmit")
	$vname.click()
	EndFunc
