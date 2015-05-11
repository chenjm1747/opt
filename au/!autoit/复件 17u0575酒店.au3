#Include <Date.au3>
#include <IE.au3>
#include <FTPEx.au3>  
#include <SQLite.au3>  
#include <SQLite.dll.au3>  

   ;_SQLite_Startup()
   ;_SQLite_Open("d:\17u0574hotel.db")
   ;_SQLite_Exec(-1,"Create table d (lvxingshe,dianhua,chuanzhen,lianxiren);")
$file = FileOpen("d:\17u0574hotel.csv", 1)
FileWriteLine($file,"姓,名,住宅电话,住宅传真"&@CRLF)
ShellExecute ("iexplore.exe", "about:blank")
WinWait ("about:blank")
$oIE = _IEAttach ("about:blank", "url")
_IELoadWait ($oIE)
$opages=1
For $page=1 To 13
_IENavigate ($oIE, "http://www.17u.net/qybl/list_31_388_2_0_2_"&$page&".html")
_IELoadWait($oIE)
$oas = $oIE.document.getElementsBytagName("ul")
For $oa In $oas
	If StringInStr($oa.className,'com_member')=1 Then
$stext=$oa.innerText
$atexts = StringSplit($stext, Chr(10))
For $stext In $atexts
	If StringLen($stext)>20 Then
$aname = StringSplit($stext, '【',1)
$sname=$aname[1]
$atel = StringSplit($stext, '话：',1)
$atel = StringSplit($atel[2] , '传',1)
$stel=$atel[1]
$atel = StringSplit($stext, '真：',1)
$atel = StringSplit($atel[2] , '联',1)
$sfax=$atel[1]
$aman = StringSplit($stext, '联系人：',1)
$aman = StringSplit($aman[2], ' ',1)
$sman = $aman[1]
;MsgBox(4096, $stel, "Insert into d (lvxingshe,dianhua,chuanzhen,lianxiren) values ('"&$sname&'","'&$stel&","&$sfax&","&$sman&"');", 10)
;_SQLite_Exec(-1, "Insert into d (lvxingshe,dianhua,chuanzhen,lianxiren) values ('"&$sname&"','"&$stel&"','"&$sfax&"','"&$sman&"');")  
FileWriteLine($file,$sname&","&$sman&","&$stel&","&$sfax&@CRLF)
EndIf
Next
     EndIf
Next
Next
