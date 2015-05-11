#include <WinAPI.au3>
Global Const $DESKTOP_ENUMERATE = 0x40
Global Const $SPI_GETSCREENSAVERRUNNING = 114
Global Const $DESKTOP_SWITCHDESKTOP = 0x100
$OriginalThread = DLLCall("kernel32.dll","int","GetCurrentThreadId")
$OriginalInput = DllCall('user32.dll', 'hwnd', 'OpenInputDesktop', 'int', 0, 'int', 0, 'int', 0x100)
$NewDesktopName=DllStructCreate('wchar[255]')
DllStructSetData($NewDesktopName,1,'DeskName')
$NewDesktop = DLLCall("user32.dll","hwnd","CreateDesktopW","ptr",DllStructGetPtr($NewDesktopName,1), "str",'',"ptr",0,"dword",0x1,"int",$GENERIC_ALL,"ptr",0)
DllCall('user32.dll', 'int', 'SetThreadDesktop', 'hwnd', $NewDesktop[0])
DLLCall("user32.dll","int","SwitchDesktop","int",$NewDesktop[0])
$Startup = DllStructCreate($tagSTARTUPINFO)
$Process = DllStructCreate($tagPROCESS_INFORMATION)
DllStructSetData($Startup, "Size", DllStructGetSize($Startup))
DllStructSetData($Startup, "Desktop", DllStructGetPtr($NewDesktopName,1))
Sleep(1000)
_WinAPI_CreateProcess("", "C:\Program Files (x86)\AutoIt3\AutoIt3.exe D:\InnoExtractor\2\oem1±àÐ´°²×°³ÌÐò.au3", 0, 0, False, 0, 0, "")
Sleep(11000)
;_WinAPI_CreateProcess("", "C:\Windows\explorer.exe", 0, 0, False, 0, 0, "", DllStructGetPtr($Startup), DllStructGetPtr($Process))

;RunWait("cmd.exe","" , "" , $NewDesktop[0] )

_WinAPI_CloseHandle(DllStructGetData($Process, "hProcess"))
_WinAPI_CloseHandle(DllStructGetData($Process, "hThread" ))
DLLCall("user32.dll","int","SwitchDesktop","int",$OriginalInput[0])
DllCall('user32.dll', 'int', 'SetThreadDesktop', 'hwnd', $OriginalThread[0])
DLLCall("user32.dll","int","CloseDesktop","int",$NewDesktop[0])
