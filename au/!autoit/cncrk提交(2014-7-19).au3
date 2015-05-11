#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         jm

 Script Function:
	提交软件评价用

#ce ----------------------------------------------------------------------------
#include <MsgBoxConstants.au3>

; Script Start - Add your code below here

#include <IE.au3>
#include <MsgBoxConstants.au3>
;Local $aArray = FileReadToArray("自动留言.txt")
;Local $aArray1 = FileReadToArray("xdown自动留言url.txt")
For $i = 1 To 19; Loop through the array.
Global $oIE = _IEcreate("http://publish.cncrk.com/")
$b=""
$b=$b& @CRLF &IniRead(@ScriptDir &"\百度提交软件.ini", "Genera"&$i, "softName", "AutoIt")
$b=$b& @CRLF &"大小：50000KB"
$b=$b& @CRLF &"语言：中文"
$b=$b& @CRLF &"版本：5.21免费版"
$b=$b& @CRLF &"适用平台   winxp/win7/win8"
$b=$b& @CRLF &"公司网站   www.gjprj.cn"
$b=$b& @CRLF &"下载地址   "&IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'down_url', '')
$b=$b& @CRLF &"截屏地址   http://www.gjprj.cn/down/"&IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'snap_1', '')&"1.png"
$b=$b& @CRLF &"截屏地址   http://www.gjprj.cn/down/"&IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'snap_1', '')&"2.png"
$b=$b& @CRLF &"截屏地址   http://www.gjprj.cn/down/"&IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'snap_1', '')&"3.png"
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc1', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc2', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc3', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc4', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc5', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc6', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc7', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc8', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc9', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc10', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc11', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc12', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc13', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc14', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc15', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc16', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc17', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc18', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc19', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc20', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc21', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc22', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc23', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc24', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc25', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc26', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc27', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc28', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc29', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc30', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc31', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc32', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc33', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc34', '')
$b=$b&@CR& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc35', '')
Local $ovalue= _IEGetObjById($oIE, "xhe0_iframe")
$oFrame2 = _IEFrameGetCollection($ovalue, 0)
;$oFrame2 = _IEFrameGetCollection($oFrame2, 0)
_IEPropertySet($oFrame2, "innertext", $b)
$oIE.document.parentWindow.myform.ResName.value=IniRead(@ScriptDir &"\百度提交软件.ini", "Genera"&$i, "softName", "")
$oIE.document.parentWindow.myform.content.value=$b
$oIE.document.parentWindow.myform.ResLink.value="http://www.gjprj.cn"
$oIE.document.parentWindow.myform.Author.value="qq2100803"
$oIE.document.parentWindow.myform.ResRank.value=5
$oIE.document.parentWindow.myform.ResSize.value=50
$oIE.document.parentWindow.myform.ResUrl.value="http://www.gjprj.cn"
$oIE.document.parentWindow.myform.ResAddress.value=IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'down_url', '')
$oIE.document.parentWindow.myform.image.value="http://www.gjprj.cn/down/"&IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'snap_1', '')&"1.png"
$oIE.document.parentWindow.myform.tags.value="管家婆,管家婆软件,仓库管理软件"
sleep(10000)
;xhe0_iframe
;_IEQuit($oie)
Next
