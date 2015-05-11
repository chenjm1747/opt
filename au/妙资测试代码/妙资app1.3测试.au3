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
$wintitle="5554"
Local $softid = '2097', $softkey = 'b7ee76f547e34516bc30f6eb6c67c7db', $softcrckey = '32F1C86B-E64C-4EAF-8BC1-C142570008BC'
Local $oIE = _IECreateEmbedded()
GUICreate("Embedded Web control Test", @DesktopWidth, @DesktopHeight, 0, 0, _
        $WS_OVERLAPPEDWINDOW + $WS_CLIPSIBLINGS + $WS_CLIPCHILDREN)
GUICtrlCreateObj($oIE, 0, 20, @DesktopWidth, @DesktopHeight)
Local $login1 = GUICtrlCreateButton("登录", 200, 0, 100, 20)
Local $zhaohuimima2 = GUICtrlCreateButton("忘记密码短信验证", 300, 0, 100, 20)
Local $shouji3 = GUICtrlCreateButton("短信验证", 400, 200, 100, 20)
Local $genghuanmima3= GUICtrlCreateButton("更换密码", 400, 0, 100, 20)
Local $genghuanshouji4 = GUICtrlCreateButton("更换手机", 500, 0, 100, 20)
Local $genghuanjiaoyimima5= GUICtrlCreateButton("更换交易密码", 600, 0, 100, 20)
Local $touzi6 = GUICtrlCreateButton("投资", 700, 0, 100, 20)
Local $daifukuan7 = GUICtrlCreateButton("待付款", 900, 0, 100, 20)
Local $yizhuce8 = GUICtrlCreateButton("已注册用户与手机", 1000, 0, 100, 20)
Local $genghuanmima9= GUICtrlCreateButton("更换密码", 1100, 0, 100, 20)
;GUICtrlSetColor(-1, 0xff0000)
;1053*459
GUISetState(@SW_SHOW) ;Show GUI
;genghuanmima()
;genghuanjiaoyimima()
;login
MsgBox(0, 0, __GetIP())

Func __GetIP()
    $oHTTP = ObjCreate("microsoft.xmlhttp")
    $oHTTP.Open("get", "http://www.newhua.com/ajax_ip.php", False)
    $oHTTP.Send("")
    $return = $oHTTP.responsetext;BinaryToString($oHTTP.responseBody)
    $IP = StringRegExp($return, '((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)', 2)
    If Not @error Then
        Return ($IP[0])
    Else
        Return SetError(1, 0, 1)
    EndIf
EndFunc

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
		 Case $iMsg = $genghuanmima3
			genghuanmima()
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
		 Case $iMsg = $genghuanjiaoyimima5
			genghuanjiaoyimima()
		 Case $iMsg = $genghuanjiaoyimima5
			genghuanjiaoyimima()

    EndSelect
WEnd



func shouji()

endfunc
;登录
func login()
start()
mClick(153,332)
send("adao82")
mclick(122,145)
send("111111")
mclick(117,182)
sleep(5000)
mclick(127,235)
endfunc
;1找回忘记的登录密码
func zhaohuimima()
start()
MouseClick("left",153,332)
sleep(1000)
;点击忘记密码
mouseclick("left",202,240)
sleep(2000)
send("13858101782")
mouseclick("left",126,160)
;点击下一步
sleep(1000)
mouseclick("left",176,157)
sleep(5000)
;点击验证码
mouseclick("left",74,150)
sleep(1000)
sleep(1000)
;点击验证码输入框
mouseclick("left",123,210)
sleep(1000)
;点击确定
endfunc
;1找回忘记的登录密码

func touzi()
start()
;1生成待付款订单
MClick(94,321)
;投资列表
MClick(130,130)
;点击第一个列表
MClick(180,320)
send(1000)
MClick(180,213)
;点击购买
MClick(160,255)
send("jmdjsj903291A{esc}")
;点击支付密码框
sleep(1000)
MClick(160,278)
;点击购买
send("yanzheng{esc}")
MClick(172,277)
endfunc


func genghuanshouji()
start()
MouseClick("left",153,332)
;我的妙资
sleep(1000)
MouseClick("left",80,190)
;安全
sleep(1000)
MouseClick("left",80,240)
endfunc


func genghuanmima()
start()
MClick(153,332)
;我的妙资
MClick(80,190)
;安全
MClick(80,240)
send("111111")
MClick(80,150)
send("1111111{esc}")
MClick(80,224)
send("1111111{esc}")
MClick(80,280)
;点击修改提交
MClick(153,332)
;我的妙资
MClick(80,190)
;安全
MClick(80,240)
send("1111111")
MClick(80,150)
send("111111{esc}")
MClick(80,224)
send("111111{esc}")
MClick(80,280)

endfunc


func genghuanjiaoyimima()
start()
Mclick(153,332)
;我的妙资
Mclick(80,190)
;安全
Mclick(80,110)
;找回交易密码
send("jmdjsj903291A")
MClick(80,150)
send("jmdjsj{esc}")
MClick(80,224)
send("jmdjsj{esc}")
MClick(80,280)
;点击修改提交
Mclick(153,332)
;我的妙资
MClick(80,190)
;安全
Mclick(80,110)
send("jmdjsj")
MClick(80,150)
send("jmdjsj903291A{esc}")
MClick(80,224)
send("jmdjsj903291A{esc}")
MClick(80,280)
;点击修改提交
endfunc
;已注册
func yizhuce()
start()
Mclick(153,332)
Mclick(220,60)
send("13858101782")
Mclick(180,160)
Mclick(80,160)
send("yanzheng")
Mclick(80,200)
;点击注册按钮
endfunc



func daifukuan()
start()
Mclick(153,332)
endfunc

func mclick($x,$y)
   sleep(1000)
   MouseClick("left",$x,$y)
   sleep(1000)
EndFunc

func s($message)
   msgbox(0,0,$message)
endfunc
func start()
$hWnd=WinActivate ("5554")
WinMove ($hWnd, "", 0, 0 )
EndFunc