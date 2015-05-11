  #include <IE.au3>
    $lresolveTimeout = 5100
    $lconnectTimeout = 5100
    $lsendTimeout = 5220
    $lreceiveTimeout = 5000
  Local $aArray = FileReadToArray('proxylist1.txt')
  Local $aduishou = FileReadToArray('newhua对手.txt')
for $ii=0 to UBound($aArray)-1
_SetIEProxy($aArray[$ii])
      for $ii1=1 to UBound($aduishou)-1

$oIE = _IEInPrivateCreate("", 2)
 _IENavigate($oie,"http://d.onlinedown.net/topinfo_1.5.php?id="&$aduishou[$ii1],0)
$ien= _IELoadWait($oIE)
if not $ien=0 then

   Local $oElements = _IETagNameGetCollection($oIE, "a")
   For $oElement In $oElements
	  If $oElement.innerText="不推荐" Then $oElement.click()
	  Next
   Else
	  _IEQuit($oIE)
	  ExitLoop

endif
sleep(1000)
_IEQuit($oIE)
   next
next

Func _SetIEProxy($DLIP = "")
        RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings", "ProxyEnable", "REG_DWORD",Hex(1));开启代理
        RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings", "ProxyServer", "REG_SZ", $DLIP)
	DllCall("wininet.dll", "uint", "InternetSetOption", "ptr", 0, "dword", 39, "ptr", 0, "dword", 0);INTERNET_OPTION_SETTINGS_CHANGED
	DllCall('wininet.dll', 'uint', 'InternetSetOption', 'ptr', 0, 'dword', 37, 'ptr', 0, 'dword', 0) ; INTERNET_OPTION_REFRESH
EndFunc   ;==&gt;_SetIEProxy


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