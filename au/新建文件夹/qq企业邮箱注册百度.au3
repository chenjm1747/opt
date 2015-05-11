; Script Start - Add your code below here
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         jim

 Script Function:
	百度知道关注提醒

#ce ----------------------------------------------------------------------------
;696
; Script Start - Add your code below here
#include <SQLite.au3>
#include <SQLite.dll.au3>
#include <IE.au3>
#include <File.au3>
#include <Clipboard.au3>
#Include <ScreenCapture.au3>
;#include <ACN_HASH.au3>
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
$no=0
$zhidaowentis = FileReadToArray("知道问题库.txt")
Local $mailname[199]
for $i=28 to 50
	$mailname="qq2100803"&$i+$no&"@iigogo.com"
	$password=Random(100000,999999,1)
	$oie=_IECreate("https://passport.baidu.com/v2/?reg&regType=1&tpl=mn&u=http%3A%2F%2Fwww.baidu.com%2F")
	_IELoadWait($oie)
	$oIE.document.parentWindow.TANGRAM__PSP_4__form.account.value=$mailname
	$oIE.document.parentWindow.TANGRAM__PSP_4__form.password.value="jmdjsj903291AA"
	$oImg =_IEGetObjById($oie,"TANGRAM__PSP_4__verifyCodeImg")
;	WinMove("[ACTIVE]","",1000,0)
	Local $aPos = WinGetPos("[ACTIVE]")
	$picname = @ScriptDir & "\t" & @HOUR & @MIN & @SEC&".jpg"
	_ScreenCapture_Capture($picname, $aPos[0]+324,$aPos[1]+380, $aPos[0]+324+100,$aPos[1]+380+40)
	$ovalue=_IEGetObjById($oie,"verifyCode")
	$oIE.document.parentWindow.TANGRAM__PSP_4__form.verifyCode.focus()
send(imgshibie($picname))
	sleep(1000)
	$oIE.document.parentWindow.TANGRAM__PSP_4__form.TANGRAM__PSP_4__submit.click()
	sleep(1000)
	_IELoadWait($oie)
	ProcessClose ("iexplore.exe")
	;	_IEQuit($oie)
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
;$md5key = _md5key()
;If $string[1]==$md5key Then
	return $string[2]
;	MsgBox(4096,"成功","识别到图片["&  $string[2]& "]")

EndFunc




;_FileWriteFromArray ( "BizmailGroup_Export.csv", $mailname)

