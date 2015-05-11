#Include <WinAPIEx.au3>

#include <Process.au3>

#include <GUIConstants.au3>

#include <guiconstantsex.au3>

#include <WindowsConstants.au3>

#include <GuiButton.au3>



$filename="gta_sa.exe"



HotKeySet("^s","_cs")

HotKeySet("^{F2}","cf2")

HotKeySet("+{F8}","quit")





HotKeySet("^{F8}","test")

HotKeySet("^{F3}","InsertKeyValue")





While 1

Sleep(1000)        

WEnd



Func quit()

Exit

EndFunc



Func _cs()

        RunWait(@ScriptDir&"\getKeyMsg.exe")

        Sleep(200)

        Send("!f")

        Sleep(200)

        Send("a")

        WinWaitActive("保存网页","",3)

        Send("{tab}")

        Send("{down 3}")

        Send("{Enter 2}")

EndFunc

        

Func cf2()

        RunWait(@ScriptDir&"\getKeyMsg.exe")

        Sleep(200)

        Send("HESOYAM") ;gta_sa作弊码输入，测试不成功！

        ;Sleep(200)

        ;Send("m")

EndFunc

