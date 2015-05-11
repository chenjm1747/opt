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
#include <ACN_HASH.au3>
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
for $i=0 to 50
	$mailname="qq2100803"&$i+$no
	$password=Random(100000,999999,1)
	$oie=_IECreate("http://zc.qq.com/chs/index.html?from=pt")
	_IELoadWait($oie)
	$vname=_IEGetObjById ($oie,"nick")

	$vname.value=$mailname
	$vname.focus()
	$vname=_IEGetObjById ($oie,"password")

	$vname.value="jmdjsj903291AA"
	$vname.focus()

	$vname=_IEGetObjById ($oie,"year_value")
	$vname.value=1982
;	$vname.focus()
	$vname=_IEGetObjById ($oie,"month_value")
	$vname.value=1
;	$vname.focus()
	$vname=_IEGetObjById ($oie,"day_value")
	$vname.value=1
	$vname=_IEGetObjById ($oie,"password_again")
	$vname.value="jmdjsj903291AA"
	$vname.focus()
	$vname=_IEGetObjById ($oie,"code")
	$vname.focus()
	sleep(1555)

	Local $aPos = WinGetPos("[ACTIVE]")
	$picname = @ScriptDir & "\t" & @HOUR & @MIN & @SEC&".jpg"
	_ScreenCapture_Capture($picname, $aPos[0]+643,$aPos[1]+538, $aPos[0]+643+127,$aPos[1]+538+55)
	$vname.value=imgshibie($picname)
	$vname=_IEGetObjById ($oie,"submit")
	$vname.click()
	_IELoadWait($oie)
		$vname=_IEGetObjById ($oie,"defaultUin")
msgbox(0,0,$vname.innertext)
;	WinMove("[ACTIVE]","",1000,0)
exit
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

