#include <IE.au3>

Local $aArray = FileReadToArray('proxylist1.txt')
$lresolveTimeout = 2000
$lconnectTimeout = 2000
$lsendTimeout = 2000
$lreceiveTimeout = 2000
$icount=0
While 1

;$oie=_IECreate("http://more.tianjimedia.com/soft/down.jsp?id=35355366&f=official&path=")
;_IELoadWait($oIE)
;_IEQuit($oie)

;$oie=_IECreate("http://dlsw.baidu.com/sw-search-sp/soft/2f/25517/2014_02_13_ckgl521360.1395284267.exe")
 ;  _IELoadWait($oIE)
;_IEQuit($oie)
;567
$oie=_IECreate("http://www.pc6.com/down.asp?id=35356")
   _IELoadWait($oIE)
_IEQuit($oie)
;下雨天qq农场管家婆 V2.0绿色版 4下载
;$oie=_IECreate("http://www.crsky.com/soft/31171.html")
;   _IELoadWait($oIE)
;_IEQuit($oie)

WEnd
886
26005
WinKill("查看下载 - Internet Explorer")
;   count.crsky.com/tools/DownCount.ashx?id=28938
;   http://www.crsky.com/soft/31171.html
$oie=_IECreate("http://www.duote.com/soft/69408.html")
   _IELoadWait($oIE)

663
$oHTTP = ObjCreate("WinHttp.WinHttpRequest.5.1")
$oHTTP.setTimeouts($lresolveTimeout, $lconnectTimeout, $lsendTimeout, $lreceiveTimeout)
$oHTTP.SetProxy( 2, $aArray[$icount],"");
$oHTTP.Open("post","http://d.onlinedown.net/ajax_top_1.4.php",false)
$oHTTP.setRequestHeader("Accept-Language", "zh-cn")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("Referer","http://d.onlinedown.net/topinfo_1.5.php?id=117854")
$oHTTP.Send("do=digg&action=1&id=117854")
$oHTTP = 0
$oHTTP = ObjCreate("WinHttp.WinHttpRequest.5.1")
$oHTTP.setTimeouts($lresolveTimeout, $lconnectTimeout, $lsendTimeout, $lreceiveTimeout)
$oHTTP.SetProxy( 2, $aArray[$icount],"");
$icount=$icount+1
$oHTTP.Open("get","http://www.duote.com/soft_pj.php?st=1&id=42789&dt=1402645534570",false)
;$oHTTP.Open("get","http://20140507.ip138.com/ic.asp",false)
$oHTTP.setRequestHeader("Accept-Language", "zh-cn")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("Referer","http://www.duote.com/soft/42789.html")
$oHTTP.Send("")
$oHTTP = 0
Sleep(1000)
_IEQuit($oie)


for $ii=0 to UBound($aArray)
_SetIEProxy($aArray[$ii])
;run("RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255")
;Sleep(1000)
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.setTimeouts($lresolveTimeout, $lconnectTimeout, $lsendTimeout, $lreceiveTimeout)
$oHTTP.Open("post","http://d.onlinedown.net/ajax_top_1.4.php",false)
$oHTTP.setRequestHeader("Accept-Language", "zh-cn")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("Referer","http://d.onlinedown.net/topinfo_1.5.php?id=117854")
$oHTTP.Send("do=digg&action=1&id=117854")
MsgBox(0,0,$oHTTP.responsetext)
next

Func _SetIEProxy($DLIP = "")
        RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings", "ProxyEnable", "REG_DWORD",Hex(1));开启代理
        RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings", "ProxyServer", "REG_SZ", $DLIP)
	DllCall("wininet.dll", "uint", "InternetSetOption", "ptr", 0, "dword", 39, "ptr", 0, "dword", 0);INTERNET_OPTION_SETTINGS_CHANGED
	DllCall('wininet.dll', 'uint', 'InternetSetOption', 'ptr', 0, 'dword', 37, 'ptr', 0, 'dword', 0) ; INTERNET_OPTION_REFRESH
EndFunc   ;==&gt;_SetIEProxy

RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings", "ProxyEnable", "REG_DWORD", 0)
DllCall("wininet.dll", "uint", "InternetSetOption", "ptr", 0, "dword", 37, "ptr", 0, "dword", 0)