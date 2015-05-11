#include <GUIConstants.au3>
MsgBox(16,"警告","配置过程将自动重启1次，请保存好未做完的工作")
RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\IPSEC", "AssumeUDPEncapsulationContextOnSendRule", "REG_DWORD", "1")

Opt("SendKeyDelay",20)


GUICreate("CKG VPN拨号连接初始化设置", 220, 200)
GUICtrlCreateLabel ("CKG VPN拨号名称：CKGVpn",  10, 10)

GUICtrlCreateLabel ("请输入用户名：",  10, 60)
$username = GUICtrlCreateInput ("", 10,  75, 200, 20)
GUICtrlCreateLabel ("请输入密码：",  10, 110)
$password = GUICtrlCreateInput ("", 10,  125, 200, 20, $ES_PASSWORD)
$Button_1 = GUICtrlCreateButton ("应用(&C)",  20, 160, 50)
$Button_2 = GUICtrlCreateButton ("关闭(&E)",  80, 160, 50)
$topname = "CKGVpn"
$VpnIP = "202.101.98.56"
$ShareKey = "CKG4321"

GUISetState (@SW_SHOW)
While 1
    $msg = GUIGetMsg()
    Select
        Case $msg = $GUI_EVENT_CLOSE
            Exit
        Case $msg = $Button_1
   if $topname<>"" then
    if GUICtrlRead($username)<>"" then
     if GUICtrlRead($password)<>"" then
              GUISetState (@SW_HIDE)
              Run('RUNDLL32 netshell.dll,StartNCW')
              winwaitactive("新建连接向导","新建连接向导")
              winactivate("新建连接向导","新建连接向导")
              send("!N")
              winwaitactive("新建连接向导","连接到我的工作场所的网络(&O)")
              winactivate("新建连接向导","连接到我的工作场所的网络(&O)")
              send("!O")
              send("!N")

              winwaitactive("新建连接向导","虚拟专用网络连接(&V)")
              winactivate("新建连接向导","虚拟专用网络连接(&V)")
              send("!V")
              send("!N")
              winwaitactive("新建连接向导","在下面框中输入此连接的名称")
              winactivate("新建连接向导","在下面框中输入此连接的名称")
              send($topname)
              send("!N")

               If WinExists("新建连接向导","不拨初始连接")  Then
                          winwaitactive("新建连接向导","不拨初始连接")
                          winactivate("新建连接向导","不拨初始连接")
                          send("!D")
                          send("!N")
               EndIf

               winwaitactive("新建连接向导","主机名")
               winactivate("新建连接向导","主机名")
               send($VpnIP)
               send("!N")

               winwaitactive("新建连接向导","只是我使用(&M)")
               winactivate("新建连接向导","只是我使用(&M)")
               send("!N")
               Send("{SPACE}")
               send("{ENTER}")

               Run("rasphone /e CKGVpn")

               winwaitactive("CKGVpn 属性","")
               winactivate("CKGVpn 属性","")
               Send("^{TAB}")
              Send("^{TAB}")
              send("!P")
              Send("{TAB}")
              Send("{TAB}")
              Send("!U")
              Send("{TAB}")

              send($ShareKey)
              Send("{TAB}")
              send("{ENTER}")
              Send("^{TAB}")

              Sleep(2000)
              Send("{DOWN}")
              Send("{DOWN}")
              send("{ENTER}")

              Sleep(1000)
              Run("rasphone -d CKGVpn")
              winwaitactive("连接 CKGVpn","",2)
              winactivate("连接 CKGVpn")


              Send("+{TAB}")
              send(GUICtrlRead($username))

              Send("{TAB}")
              send(GUICtrlRead($password))

              Send("!S")
              send("!C")


                        ExitLoop
     Else
               MsgBox(0, "", "密码不能为空！")
               ControlFocus ( "CKG VPN拨号连接初始化设置", "请输入", 8)
              EndIf
          Else
              MsgBox(0, "", "用户名不能为空！")
              ControlFocus ( "CKG VPN拨号连接初始化设置", "请输入", 6)
          EndIf
      Else
       ;
   EndIf
        Case $msg = $Button_2
            Exit
    EndSelect
Wend

Shutdown(2)


----------------------------------------

#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.10.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
