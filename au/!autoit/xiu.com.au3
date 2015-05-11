#Include <Date.au3>
#include <IE.au3>
#include <FTPEx.au3>  
#include <SQLite.au3>  
#include <SQLite.dll.au3>  

;$oQ = _IEGetObjByName ($oIE,  "chkRememberMe")
;$oQ.click
;addressName 江民
;address 塘苗路1８号华星产业园c座208 旅贸通
;zip 310000
;mobile 13858101782
;button
$Fid = FileOpen("xiuid.txt", 1)
$file = FileOpen("xiu.txt", 0)
If $file = -1 Then
	MsgBox(0, "错误", "不能打开文件.")
	Exit
EndIf
$sMb = FileReadLine($file)
$random=FileReadLine($file)
$sMb =$sMb +1
FileClose($file)
While 1
$oIE1 = _IEAttach ("http://portal.xiu.com/business/ConfirmOrder?", "url")
If $oie1<> 0 Then XiuDizhi($oIE1)

$oIE1 = _IEAttach ("https://login.xiu.com/reg", "url")
If $oie1 <> 0 Then Xiureg($oIE1)

$oIE1 = _IEAttach ("http://item.xiu.com/product", "url")
If $oie1 <> 0 Then Xiu19($oIE1)

$oIE1 = _IEAttach ("http://portal.xiu.com/business/XOrderItemDisplayCmd?langId=", "url")
If $oie1 <> 0 Then XiuBuy($oIE1)

$oIE1 = _IEAttach ("https://pbank.95559.com.cn/netpay/MerPayB2C", "url")
If $oie1 <> 0 Then jt($oIE1)

Sleep(100)
WEnd
Func jt($oIE)
_IELoadWait ($oIE)
$oIframe = _IEFrameGetObjByName ($oIE, "main") 
$oQ = _IEGetObjByName ($oIframe,  "agreeOrder")

If $oQ<>0 Then
	$oQ.click
Sleep(500)
$oQ = _IEGetObjByName ($oIframe,  "bocomPageInputCard")
$oQ.value="5218990170543226"
Sleep(5000)
EndIf
$oQ = _IEGetObjByName ($oIframe,  "lastMobileNo")
If $oQ<>0 Then
$oQ.value="782"
EndIf
$oQ = _IEGetObjByName ($oIframe,  "cardExpDate1")
If $oQ<>0 Then
$oQ.value="0114"
$oQ = _IEGetObjByName ($oIframe,  "cvvId")
$oQ.value="720"
;$oQ = _IEGetObjByName ($oIframe,  "tranPass1")
;$oQ.value="903291"
EndIf

EndFunc
;/netpay/py0101_pay_first_in.jsp

;lastMobileNo 782
;cardExpDate1 0114
;cvvId 720
;tranPass1 903291

Func XiuDizhi($oIE)
$sMb=$sMb+1
_IELoadWait ($oIE)
Sleep(3000)
$oinput =_IEGetObjByName ($oIE,  "name")
$oinput.value='江明明'
$oinput =_IEGetObjByName ($oIE,  "address")
$random=$random+1
$oinput.value='13858101782塘苗路十八号华星产业园Ｃ座208旅贸通'&$random
$oinput =_IEGetObjByName ($oIE,  "mobile")
$oinput.value=$sMb
$oinput =_IEGetObjByName ($oIE,  "zip")
$oinput.value='310000'
;province setupDistribution
$oinput =_IEGetObjByName ($oIE,  "province")
;$oinput.options['11'].selected = true;  
_IEFormElementOptionSelect ($oinput, "330000")
;_IEHeadInsertEventScript ($oIE, "document", "onclick", "document.all.tranPass1.province.options[0].value ='330000';document.all.province.options[0].text ='浙江省';document.all.province.value ='330000';")
Sleep(1000)
$oinput =_IEGetObjByName ($oIE,  "city")
_IEFormElementOptionSelect ($oinput, "330100")
Sleep(1000)
$oinput =_IEGetObjByName ($oIE,  "area")
_IEFormElementOptionSelect ($oinput, "330106")
$oinput =_IEGetObjByName ($oIE,  "createBt")
$oinput.click
Sleep(2900)
$oinput =_IEGetObjByName ($oIE,  "setupDistribution")
$oinput.click
Sleep(1900)
;r_bank_d10
$oinput =_IEGetObjByName ($oIE,  "r_bank_d10")
$oinput.click
Sleep(1000)
$oinput =_IEGetObjByName ($oIE,  "confirmPay2")
$oinput.click
Sleep(1900)
$oinput =_IEGetObjByName ($oIE,  "couponCodeInput")
$oinput.value='0926169'
$oinput =_IEGetObjByName ($oIE,  "id_couponSubmit")
$oinput.click
Sleep(1900)
$oinput =_IEGetObjByName ($oIE,  "couponRow")
$oinput.click
Sleep(900)
$oinput =_IEGetObjByName ($oIE,  "id_useCoupon")
$oinput.click
Sleep(900)
$oinput =_IEGetObjByName ($oIE,  "submit_order_btn")
$file = FileOpen("xiu.txt", 2)
FileWriteLine ( $file, $sMb)
FileClose($file)
$oinput =_IEGetObjByName ($oIE,  "loginZone")

FileWriteLine ( $Fid, $oinput.innerText)
FileWriteLine ( $Fid, $random)
;$oinput.click

;submit_order_btn
;couponCodeInput
;id_couponSubmit

;$oinput.value='330101'
;confirmPay2
;330100;area
EndFunc

Func Xiureg($oIE)
_IELoadWait ($oIE)
$oQ = _IEGetObjByName ($oIE,  "emailAddr")
_IEFormElementSetValue ($oQ, "q"&$sMb&"@qq.com")
$oQ = _IEGetObjByName ($oIE,  "cfmPassWord")
_IEFormElementSetValue ($oQ, "903291")
$oQ = _IEGetObjByName ($oIE,  "PassWord")
_IEFormElementSetValue ($oQ, "903291")
EndFunc
Func Xiu19($oIE)
_IELoadWait ($oIE)
$oinput =_IEGetObjByName ($oIE,  "7000000000000009191")
If $oinput<>0 Then $oinput.click
Sleep(500)
$oinput =_IEGetObjByName ($oIE,  "user_buy_btn")
If $oinput<>0 Then $oinput.click
EndFunc
Func XiuBuy($oIE)
_IELoadWait ($oIE)
$oinput =_IEGetObjByName ($oIE,  "toBalanceLink")
If $oinput<>0 Then $oinput.click
EndFunc