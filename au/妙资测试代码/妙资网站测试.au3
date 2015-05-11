#include <MsgBoxConstants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GUIListBox.au3>
#include <uuapi.au3>
#include <array.au3>
#include <IE.au3>
#include <MsgBoxConstants.au3>
#include <ScreenCapture.au3>
#include <WindowsConstants.au3>
Func __GetIP()
    $oHTTP = ObjCreate("microsoft.xmlhttp")
    $oHTTP.Open("get", "http://888.caiwuhao.com?a=", False)
    $oHTTP.Send("")
    $return = $oHTTP.responsetext;BinaryToString($oHTTP.responseBody)
    $IP = StringRegExp($return, '((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)', 2)
    If Not @error Then
        Return ($IP[0])
    Else
        Return SetError(1, 0, 1)
    EndIf
EndFunc
Func _dxclear()
    $oHTTP = ObjCreate("microsoft.xmlhttp")
    $oHTTP.Open("get", "http://888.caiwuhao.com?a=", False)
    $oHTTP.Send("")
    $return = $oHTTP.responsetext;BinaryToString($oHTTP.responseBody)
    Return ($return)
EndFunc
Func _dx()
    $oHTTP = ObjCreate("microsoft.xmlhttp")
    $oHTTP.Open("get", "http://888.caiwuhao.com", False)
    $oHTTP.Send("")
    $return = $oHTTP.responsetext;BinaryToString($oHTTP.responseBody)
    Return ($return)
EndFunc


Local $softid = '2097', $softkey = 'b7ee76f547e34516bc30f6eb6c67c7db', $softcrckey = '32F1C86B-E64C-4EAF-8BC1-C142570008BC'
Local $oIE = _IECreateEmbedded()
GUICreate("Embedded Web control Test", @DesktopWidth, @DesktopHeight, 0, 0, _
        $WS_OVERLAPPEDWINDOW + $WS_CLIPSIBLINGS + $WS_CLIPCHILDREN)
GUICtrlCreateObj($oIE, 0, 20, @DesktopWidth, @DesktopHeight)
Local $login1 = GUICtrlCreateButton("登录", 0, 0, 100, 20)
Local $zhaohuimima2 = GUICtrlCreateButton("忘记密码", 100, 0, 100, 20)
Local $shouji3 = GUICtrlCreateButton("短信验证", 200, 0, 100, 20)
Local $genghuanshouji4 = GUICtrlCreateButton("更换手机", 300, 0, 100, 20)

Local $genghuanjiaoyimima5= GUICtrlCreateButton("更换交易密码", 400, 0, 100, 20)
Local $touzi6 = GUICtrlCreateButton("投资", 500, 0, 100, 20)
Local $daifukuan7 = GUICtrlCreateButton("待付款", 600, 0, 100, 20)
Local $yizhuce8 = GUICtrlCreateButton("已注册用户与手机", 700, 0, 100, 20)
Local $genghuanmima9= GUICtrlCreateButton("更换密码", 800, 0, 100, 20)

;GUICtrlSetColor(-1, 0xff0000)
;1053*459
GUISetState(@SW_SHOW) ;Show GUI
;genghuanmima()
;genghuanjiaoyimima()
;login
_IENavigate($oIE,"http://888.caiwuhao.com/")
 ;login()
;http://www.mzmoney.com/yymeq/10541.htm
; Waiting for user to close the window
While 1
    Local $iMsg = GUIGetMsg()
    Select
        Case $iMsg = $GUI_EVENT_CLOSE
            ExitLoop
		 Case $iMsg = $login1
			login()
		 Case $iMsg = $zhaohuimima2
			zhaohuimima()
		 Case $iMsg = $shouji3
			shouji()
		 Case $iMsg = $genghuanshouji4
			genghuanshouji()
		 Case $iMsg = $genghuanjiaoyimima5
			genghuanjiaoyimima()
		 Case $iMsg = $touzi6
			touzi()
		 Case $iMsg = $daifukuan7
			daifukuan()
		 Case $iMsg = $yizhuce8
			yizhuce()
		 Case $iMsg = $genghuanmima9
			genghuanmima()
		 Case $iMsg = $genghuanjiaoyimima5
			genghuanjiaoyimima()
		 Case $iMsg = $genghuanjiaoyimima5
			genghuanjiaoyimima()

    EndSelect
WEnd



func shouji()
   ;origMobile1手机验证
_IENavigate($oIE, "http://www.mzmoney.com/security/index.jspx")
_IEAction($oIE, "stop")
$oIE.document.parentWindow.origMobileForm.origMobile.focus()
$oIE.document.parentWindow.origMobileForm.origMobile.value= "13858101782"


$timer_origMobile=_IEGetObjById($oie,"timer_origMobile")
$timer_origMobile.focus()
sleep(1000)
$timer_origMobile.click()

endfunc


func yizhuce()
   ;1手机号已注册 用户已注册
_IENavigate($oIE, "http://www.mzmoney.com/register.jspx")
_IEAction($oIE, "stop")
_ScreenCapture_Capture(@TempDir&"\GDIPlus_Image2.jpg",573,437,573+80,437+34)
$oIE.document.parentWindow.jvForm.username.value="13291488404"

$oIE.document.parentWindow.jvForm.username.value= "aontimer"
$oIE.document.parentWindow.jvForm.mobile.value="13291488404"
sleep(1000)
_IELoadWait($oie)
$oIE.document.parentWindow.jvForm.timer.click()
endfunc

func genghuanshouji()
   ;1更换手机号
_IENavigate($oIE, "http://www.mzmoney.com/security/index.jspx")
_IEAction($oIE, "stop")
;修改没有id号没法测
_ScreenCapture_Capture(@TempDir&"\GDIPlus_Image2.jpg",573,437,573+80,437+34)
$oIE.document.parentWindow.jvForm.origMobile.value="13291488404"
$oIE.document.parentWindow.jvForm.username.value= "aontimer"
$oIE.document.parentWindow.jvForm.mobile.value="13291488404"
sleep(1000)
_IELoadWait($oie)
$oIE.document.parentWindow.jvForm.timer.click()

endfunc

func genghuanjiaoyimima()
_IENavigate($oIE, "http://www.mzmoney.com/security/index.jspx")
_IEAction($oIE, "stop")
$oIE.document.parentWindow.payPwdForm.origPayPassword.value="jmdjsj903291A"
$oIE.document.parentWindow.payPwdForm.payPassword.value="jmdjsj903291AA"
$oIE.document.parentWindow.payPwdForm.confirmPayPwd.value="jmdjsj903291AA"
$oIE.document.parentWindow.payPwdForm.payPwdSubmit.click()
sleep(1000)
_IELoadWait($oie)
s('找回交易密码')
_IENavigate($oIE, "http://www.mzmoney.com/security/index.jspx")
_IEAction($oIE, "stop")
$oIE.document.parentWindow.payPwdForm.origPayPassword.value="jmdjsj903291AA"
$oIE.document.parentWindow.payPwdForm.payPassword.value="jmdjsj903291A"
$oIE.document.parentWindow.payPwdForm.confirmPayPwd.value="jmdjsj903291A"
$oIE.document.parentWindow.payPwdForm.payPwdSubmit.click()
sleep(1000)
_IELoadWait($oie)
endfunc

func genghuanmima()
   _IENavigate($oIE, "http://www.mzmoney.com/security/index.jspx")
_IELoadWait($oie)
$oIE.document.parentWindow.pwdForm.origPassword.value="111111"
$oIE.document.parentWindow.pwdForm.Password.value="1111111"
$oIE.document.parentWindow.pwdForm.confirmPwd.value="1111111"
$oIE.document.parentWindow.pwdForm.pwdSubmit.click()
sleep(1000)
_IELoadWait($oie)
s('找密码')
_IENavigate($oIE, "http://www.mzmoney.com/security/index.jspx")
_IELoadWait($oie)
$oIE.document.parentWindow.pwdForm.origPassword.value="1111111"
$oIE.document.parentWindow.pwdForm.Password.value="111111"
$oIE.document.parentWindow.pwdForm.confirmPwd.value="111111"
$oIE.document.parentWindow.pwdForm.pwdSubmit.click()
sleep(1000)

EndFunc

func zhaohuimima()
   ;1找回忘记的登录密码
_IENavigate($oIE, "http://www.mzmoney.com/password/index.jspx")
_IEAction($oIE, "stop")

$oIE.document.parentWindow.jvForm.username.value="13291488404"

$xiaoqu=_IEGetObjByname($oie,"submit")
$xiaoqu.click()
sleep(1000)
_IELoadWait($oie)
$oIE.document.parentWindow.jvForm.timer.click()



endfunc
;

func touzi()
   ;1生成待付款订单
_IENavigate($oIE, "http://www.mzmoney.com/nnh6/9588.htm")
_IELoadWait($oie)
_self()
$oIE.document.parentWindow.jvForm.amount.value="1000"
$oIE.document.parentWindow.jvForm.target="_top"
$oIE.document.parentWindow.jvForm.submit.click()
MouseClick("left",993,482)
_IELoadWait($oie)
sleep(1000)
MouseClick("left",727,533)
_IELoadWait($oie)
MouseClick("left",343,533)
;$oIE.document.parentWindow.prepayForm.cardSubmit.click()
sleep(1000)
_IELoadWait($oie)
;$oIE.document.parentWindow.jvForm.bankCardNo.value=5218990177587721
;$oIE.document.parentWindow.jvForm.phone.value=13291488404

;sleep(5000)
;_IELoadWait($oie)
$oIE.document.parentWindow.payVerifyForm.payPassword.value=jmdjsj903291A
_dxclear()

$oIE.document.parentWindow.payVerifyForm.verifyCode.value=_dx()
$oIE.document.parentWindow.payVerifyForm.verifySubmit.click()
;sleep(5000)

_IELoadWait($oie)


endfunc

func daifukuan()
s('待付款删除')
_IENavigate($oIE, "http://www.mzmoney.com/part/history.jspx")
_IEAction($oIE, "stop")
s('查看详情')
_IENavigate($oIE, "http://www.mzmoney.com/part/201412011454166885.jspx")
_IEAction($oIE, "stop")

s('投资列表中查看')
_IENavigate($oIE, "http://www.mzmoney.com/part/201412011454166885.jspx")
_IEAction($oIE, "stop")

s('站内信')
_IENavigate($oIE, "http://www.mzmoney.com/member/message_list.jspx?box=0")
_IEAction($oIE, "stop")

endfunc

func login()
   ;登录

_IENavigate($oIE, "http://www.mzmoney.com/login.jspx?returnUrl=/member/index.jspx")
_IEAction($oIE, "stop")
_ScreenCapture_Capture(@TempDir&"\GDIPlus_Image2.jpg",1038,432,1038+74,432+34)
$oIE.document.parentWindow.jvForm.username.value="adao82"
$oIE.document.parentWindow.jvForm.password.value="111111"
$s=_uu_start($softid,$softkey,$softcrckey);软件初始化，_uu_start('软件ID','软件KEY'，'DLL校验KEY')
;$captcha=_bu_yb()
sleep(1000)
   $rs = _uu_recognize(@TempDir&'\GDIPlus_Image2.jpg','aontimer','jmdjsj903291A')
   $captcha=$rs[1]

$oIE.document.parentWindow.jvForm.captcha.value= $captcha
$oIE.document.parentWindow.jvForm.submit.click()
_IELoadWait($oie)
endfunc


func s($message)
   msgbox(0,0,$message)
endfunc

Func _self()
 _IELoadWait($oIE)
 $As = _IETagNameGetCollection($oIE, "a")
 For $A In $As
  $A.target = "_self"
 Next

 $Forms = _IEFormGetCollection($oIE)
 For $Form In $Forms
  $Form.target = "_self"
 Next

 $Frames = _IEFrameGetCollection($oIE)
 If $Frames <> 0 Then
  For $Frame In $Frames
   $As = _IETagNameGetCollection($Frame, "a")
   For $A In $As
    $A.target = "_self"
   Next
  Next
 EndIf
EndFunc   ;==>_self
