#include <IE.au3>
$log=FileOpen("log.txt",2)
Local $aArray = FileReadToArray('proxylist1.txt')
$lresolveTimeout = 5100
$lconnectTimeout = 5100
$lsendTimeout = 5220
$lreceiveTimeout = 5000
$icount=0
While 1
$icount=$icount+1
$oHTTP = ObjCreate("WinHttp.WinHttpRequest.5.1")
$oHTTP.setTimeouts($lresolveTimeout, $lconnectTimeout, $lsendTimeout, $lreceiveTimeout)
$oHTTP.SetProxy( 2,"127.0.0.1:9666","");
$oHTTP.Open("post","http://d.onlinedown.net/ajax_top_1.4.php",false)
$oHTTP.setRequestHeader("Accept-Language", "zh-cn")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("Referer","http://d.onlinedown.net/topinfo_1.5.php?id=117854")
$oHTTP.Send("do=digg&action=1&id=117854")
if $oHTTP.responsetext>"" then FileWriteLine($log,$aArray[$icount]&$oHTTP.responsetext)
;FileWriteLine($log,$oHTTP.responsetext)
$oHTTP=0
WEnd

Func _SetIEProxy($DLIP = "")
        RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings", "ProxyEnable", "REG_DWORD",Hex(1));?a??¡ä¨²¨¤¨ª
        RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings", "ProxyServer", "REG_SZ", $DLIP)
	DllCall("wininet.dll", "uint", "InternetSetOption", "ptr", 0, "dword", 39, "ptr", 0, "dword", 0);INTERNET_OPTION_SETTINGS_CHANGED
	DllCall('wininet.dll', 'uint', 'InternetSetOption', 'ptr', 0, 'dword', 37, 'ptr', 0, 'dword', 0) ; INTERNET_OPTION_REFRESH
EndFunc   ;==&gt;_SetIEProxy

RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings", "ProxyEnable", "REG_DWORD", 0)
DllCall("wininet.dll", "uint", "InternetSetOption", "ptr", 0, "dword", 37, "ptr", 0, "dword", 0)



Func _IEInPrivateCreate($s_url, $i_timeout = -1) ; Simple version, you can add all the other stuff if you like ($i_timeout is in secs).
    Local $s_random = "about:InPrivate " & Random(1000000, 99999999, 1) & "-" & Random(1000000, 99999999, 1)
    If $s_url = "" Then $s_url = "about:InPrivate"

    Local $i_pid = Run('"' & @ProgramFilesDir & '\Internet Explorer\iexplore.exe" -private "' & $s_random & '"')
    If $i_pid = 0 Then Return SetError(1, 0, 0)

    If StringInStr("|default|-1|", "|" & $i_timeout & "|") Then $i_timeout = 0


    Local $h_wnd, $o_shell, $o_shell_wins, $i_timer

    If $i_timeout > 0 Then $i_timer = TimerInit()
    While 1

        If $i_timeout And TimerDiff($i_timer) / 1000 > $i_timeout Then
            Return SetError(2, $i_pid, 0)
        EndIf

        $h_wnd = WinGetHandle($s_random)
        If $h_wnd Then ExitLoop
        Sleep(10)
    WEnd

    $o_shell = ObjCreate("Shell.Application")
    If IsObj($o_shell) Then
        $o_shell_wins = $o_shell.Windows

        For $o_shell_win In $o_shell_wins
            ; IE.au3 checks for IWebBrowser as well as IWebBrowser2 with __IEIsObjType
            ; This fails with my outlook with "hwnd" property
            ; So if its 100% neccessary, you'll need to find a work around
            If String(ObjName($o_shell_win)) = "IWebBrowser2" Then
                If $o_shell_win.hwnd = $h_wnd Then
                    Return SetError(0, $i_pid, $o_shell_win)
                EndIf
            EndIf
        Next
    EndIf

    Return SetError(3, $i_pid, 0)
EndFunc