#Include <Date.au3>
#include <IE.au3>
#include <FTPEx.au3>  
#include <SQLite.au3>  
#include <SQLite.dll.au3>  
ShellExecute ("iexplore.exe", "about:blank")
WinWait ("about:blank")
$oIEbaidu = _IEAttach ("about:blank", "url")
_IENavigate ($oIEbaidu, "http://openapi.baidu.com/map/createMap.html")
_IELoadWait ($oIEbaidu)
Sleep(500)
ShellExecute ("iexplore.exe", "about:blank")
WinWait ("about:blank")
$oIEctrip = _IEAttach ("about:blank", "url")
_IENavigate ($oIEctrip, "http://baidu.com")
Sleep(500)

$file = FileOpen("test.txt", 0)
While 1
	$line = FileReadLine($file)
	If @error = -1 Then ExitLoop
$as=StringSplit($line, ",",1)
$surl=$as[1]
$sname=$as[2]
$sbaidu=$as[3]
$sctrip=$as[4]
;MsgBox(0,$sname, $surl)
ShellExecute ("iexplore.exe", "about:blank")
WinWait ("about:blank")
$oIE = _IEAttach ("about:blank", "url")
_IENavigate ($oIE, "http://211.155.229.94/travel/tbc_v5/hotel.asp")
_IELoadWait ($oIE)
_IENavigate ($oIE, $surl)
_IELoadWait ($oIE)
$oQ = _IEGetObjByName ($oIE,  "user_loginname")
_IEFormElementSetValue ($oQ, $sname)
$oQ = _IEGetObjByName ($oIE,  "user_pwd")
_IEFormElementSetValue ($oQ, "123456")
$oQ = _IEGetObjByName ($oIE,  "save")
$oQ.click
;$oQ = _IEGetObjByName ($oIE,  "chkRememberMe")
;$oQ.click
$oQ = _IEGetObjByName ($oIE,  "Login")
$oQ.action="http://211.155.229.94/travel/tbc_v5/ytt_login/check.asp"
Sleep(1000)
$oQ.submit
_IENavigate ($oIE, "http://211.155.229.94/travel/tbc_v5/ytt_hotel/main_show_aboutus.asp?xaction=change")
_IENavigate ($oIEctrip, $sctrip)
_IELoadWait ($oIEctrip)
$sdesc= _IEGetObjByName ($oIEctrip,  "ctl00_MainContentPlaceHolder_lbDesc")
$otable= _IEGetObjByName ($oIEctrip,  "traffic_info")
$oTable = _IETableGetCollection ($otable, 1)
$aTableData = _IETableWriteToArray ($oTable, True)
$arraylen=UBound($aTableData)
$oQ = _IEGetObjByName ($oIEbaidu,  "searchMap")
_IEFormElementSetValue ($oQ, $sbaidu)
$oIEbaidu.document.parentWindow.execscript("getlikeArea()")
Sleep(1000)
$ox= _IEGetObjByName ($oIEbaidu,  "mapCenterPointX")
$oy= _IEGetObjByName ($oIEbaidu,  "mapCenterPointY")
;$oFrame = _IEFrameGetObjByName ($oIE, "frmright")
;_IELoadWait ($oIE)
$ox1= _IEGetObjByName ($oIE,  "s_hotel_mapj")
_IEFormElementSetValue ($ox1, $ox.value)
$oy1= _IEGetObjByName ($oIE,  "s_hotel_mapw")
_IEFormElementSetValue ($oy1, $oy.value)
$oy1= _IEGetObjByName ($oIE,  "s_hotel_aboutus")
_IEFormElementSetValue ($oy1, $sdesc.innerText)




$oForm = _IEFormGetObjByName($oIE, 'form1')
$oForm.submit()
For $i = 1 to $arraylen-1
;_IENavigate ($oIE, "http://211.155.229.94/travel/tbc_v5/ytt_hotel/main_show_trafic.asp?xaction=add")
;_IELoadWait ($oIE)
;$ox1= _IEGetObjByName ($oIE,  "s_hotel_trafic_b")
;_IEFormElementSetValue ($ox1, $aTableData[$i][0])
;$oy1= _IEGetObjByName ($oIE,  "s_hotel_trafic_bname")
;_IEFormElementSetValue ($oy1, $aTableData[$i][1])
;$ox1= _IEGetObjByName ($oIE,  "s_hotel_trafic_distance")
;_IEFormElementSetValue ($ox1, StringReplace($aTableData[$i][2], " ¹«Àï", ""))
;$oy1= _IEGetObjByName ($oIE,  "s_hotel_trafic_demo")
;_IEFormElementSetValue ($oy1, $aTableData[$i][3])
;$oForm = _IEFormGetObjByName($oIE, 'form1')
;$oForm.submit()
;_IELoadWait ($oIE)
Next
_IENavigate ($oIE, "http://211.155.229.94/travel/tbc_v5/ytt_hotel/main_show_base.asp")
;$o1= _IEGetObjByName ($oIE,  "s_hotel_linkman")
;$o2= _IEGetObjByName ($oIE,  "s_hotel_cman")
;$o2.value=$o1.value;
;$o1= _IEGetObjByName ($oIE,  "s_hotel_linkmb")
;$o2= _IEGetObjByName ($oIE,  "s_hotel_cmb")
;$o2.value=$o1.value;
;$oForm = _IEFormGetObjByName($oIE, 'change')
;$oForm.submit()
_IELoadWait ($oIE)


_IENavigate ($oIE, "http://211.155.229.94/travel/tbc_v5/hotel.asp")

Wend

FileClose($file)

