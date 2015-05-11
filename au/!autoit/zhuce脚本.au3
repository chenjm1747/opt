; *******************************************************
; Example 1 - Trap COM errors so that 'Back' and 'Forward' 
;               outside of history bounds does not abort script 
;               (expect COM errors to be sent to the console)
; *******************************************************
;
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <IE.au3>

_IEErrorHandlerRegister ()

$oIE = _IECreateEmbedded ()
GUICreate("Embedded Web control Test", 640, 580, _
        (@DesktopWidth - 640) / 2, (@DesktopHeight - 580) / 2, _
        $WS_OVERLAPPEDWINDOW + $WS_VISIBLE + $WS_CLIPSIBLINGS + $WS_CLIPCHILDREN)
$GUIActiveX = GUICtrlCreateObj($oIE, 0, 0, 1000, 760)
$GUI_Button_Back = GUICtrlCreateButton("Back", 10, 420, 100, 30)
$GUI_Button_Forward = GUICtrlCreateButton("Forward", 120, 420, 100, 30)
$GUI_Button_Home = GUICtrlCreateButton("Home", 230, 420, 100, 30)
$GUI_Button_Stop = GUICtrlCreateButton("Stop", 340, 420, 100, 30)

GUISetState()       ;Show GUI
$telno="13858101785"
_IENavigate ($oIE, "http://www.716580.com/b2b/user/reg_checkmbno.asp")
_IELoadWait($oIE)
$sText = _IEBodyReadText($oIE)
    $array = StringRegExp($sText, ' (\d{4})', 3)
	$checkno=$array[0]

$oQ = _IEGetObjByName($oIE, "user_mb")
_IEFormElementSetValue($oQ, $telno)
$oQ = _IEGetObjByName($oIE, "checkno")
_IEFormElementSetValue($oQ, $checkno)

$oQ = _IEGetObjByName($oIE, "checkmbno")
$oQ.submit
_IELoadWait($oIE)
_IENavigate($oIE, "http://admin.716580.com")
_IELoadWait($oIE)
$oQ = _IEGetObjByName($oIE, "user_loginname")
_IEFormElementSetValue($oQ, "½¯Ã÷")
$oQ = _IEGetObjByName($oIE, "user_pwd")
_IEFormElementSetValue($oQ, "903291")
$oQ = _IEGetObjByName($oIE, "Login")
$oQ.action = "http://admin.716580.com/tbc_v5/ytt_login/check.asp"
Sleep(1000)
$oQ.submit
_IELoadWait($oIE)
_IENavigate ($oIE, "http://admin.716580.com/tbc_v5/ytt_admin/b2b_checkmbno.asp")
_IENavigate ($oIE, "http://admin.716580.com/tbc_v5/ytt_admin/user_travel.asp?id=&otype=&Kw=&Kt=&Ka=&Ks=a&Kx=&Kl=&Kr=&Kg=&Kds=2013-12-27&Kde=2014-3-7&Kdm=2014-1-6&Kn=&Kz=&zth=&page=1")
_IELoadWait($oIE)

$sText = _IEBodyReadText($oIE)
$array = StringRegExp($sText, '(.+) Tel£º(.+?-*.+)\r\nFax£º(.{3,4}-*.{7,8})(\d{11})(\d+) (.+)\r\n', 3)
for $i = 0 to UBound($array) - 1 Step 5
MsgBox(0,$array[$i],$array[$i+1]&$array[$i+2]&$array[$i+3]&$array[$i+4])
Next
_IENavigate ($oIE, "http://www.716580.com/b2b/user/reg_checkmbno_back.asp?mb="&$telno&"&checkno="&$checkno)

_IELoadWait($oIE)
$oQ = _IEGetObjByName($oIE, "checkmbno")
$oQ.submit
_IELoadWait($oIE)

$oQ = _IEGetObjByName($oIE, "user_name")
_IEFormElementSetValue($oQ, "ÐÕÃû")
;travel_name\
;travel_tel
;travel_fax
;travel_area
$oQ = _IEGetObjByName($oIE, "user_regpwdb")
_IEFormElementSetValue($oQ, StringRight($telno,6))

$oQ = _IEGetObjByName($oIE, "user_regpwd")
_IEFormElementSetValue($oQ, StringRight($telno,6))

;checkmbno
; Waiting for user to close the window
While 1
    $msg = GUIGetMsg()
    Select
        Case $msg = $GUI_EVENT_CLOSE
            ExitLoop
        Case $msg = $GUI_Button_Home

        Case $msg = $GUI_Button_Back
            _IEAction ($oIE, "back")
        Case $msg = $GUI_Button_Forward
            _IEAction ($oIE, "forward")
        Case $msg = $GUI_Button_Stop
            _IEAction ($oIE, "stop")
    EndSelect
WEnd

GUIDelete()

Exit
