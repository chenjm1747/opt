; *******************************************************
; Example 1 - Trap COM errors so that 'Back' and 'Forward'
;               outside of history bounds does not abort script
;               (expect COM errors to be sent to the console)
; *******************************************************
;
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <IE.au3>



$oIE = _IECreateEmbedded ()
GUICreate("Embedded Web control Test", 640, 768, _
        (@DesktopWidth - 640) / 2, (@DesktopHeight - 768) / 2, _
        $WS_OVERLAPPEDWINDOW + $WS_VISIBLE + $WS_CLIPSIBLINGS + $WS_CLIPCHILDREN)
$GUIActiveX = GUICtrlCreateObj($oIE, 10, 0, 600, 768)
$GUI_Button_Back = GUICtrlCreateButton("Back", 10, 420, 100, 30)
$GUI_Button_Forward = GUICtrlCreateButton("Forward", 120, 420, 100, 30)
$GUI_Button_Home = GUICtrlCreateButton("Home", 230, 420, 100, 30)
$GUI_Button_Stop = GUICtrlCreateButton("Stop", 340, 420, 100, 30)

GUISetState()       ;Show GUI
  Local $aArray = FileReadToArray('proxylist1.txt')
  $hFileOpen = FileOpen('proxycount.txt',0)
Local $acount = FileRead($hFileOpen)
$acount=$acount+1
FileClose($hFileOpen)
$hFileOpen = FileOpen('proxycount.txt',$FO_READ + $FO_OVERWRITE)
FileWriteLine($hFileOpen,$acount)
  FileClose($hFileOpen)

_SetIEProxy($aArray[$acount])

_IENavigate ($oIE, "http://d.onlinedown.net/topinfo_1.5.php?id=117854")
_IELinkClickByText ($oIE,"推荐")
sleep(2000)
_IENavigate ($oIE, "http://www.onlinedown.net/soft/117854.htm")
_IEQuit($oie)
_IENavigate ($oIE, "http://www.duote.com/soft/42789.html")
_IELoadWait($oIE)
_IELinkClickByText ($oIE,"顶")
sleep(1000)
_IENavigate ($oIE, "http://www.pc6.com/softview/SoftView_98439.html")
_IEQuit($oie)

; Waiting for user to close the window6
While 1
    $msg = GUIGetMsg()
    Select
        Case $msg = $GUI_EVENT_CLOSE
            ExitLoop
        Case $msg = $GUI_Button_Home
            _IENavigate ($oIE, "http://www.autoitscript.com")
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


; *******************************************************
; Example 2 - Create a browser window and navigate to a website,
;               do not wait for page load to complete before moving to next line
; *******************************************************
;
#include <IE.au3>
$oIE = _IECreate ("www.autoitscript.com", 0)
MsgBox(0, "_IENavigate()", "This code executes immediately")

Func _SetIEProxy($DLIP = "")
        RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings", "ProxyEnable", "REG_DWORD",Hex(1));开启代理
        RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings", "ProxyServer", "REG_SZ", $DLIP)
	DllCall("wininet.dll", "uint", "InternetSetOption", "ptr", 0, "dword", 39, "ptr", 0, "dword", 0);INTERNET_OPTION_SETTINGS_CHANGED
	DllCall('wininet.dll', 'uint', 'InternetSetOption', 'ptr', 0, 'dword', 37, 'ptr', 0, 'dword', 0) ; INTERNET_OPTION_REFRESH
EndFunc   ;==&gt;_SetIEProxy
