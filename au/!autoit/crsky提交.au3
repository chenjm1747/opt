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
For $i = 2 To 19; Loop through the array.
Global $oIE = _IEcreate("http://u.crsky.com/Member_softadd.aspx")
$b=""
;$b=$b& "<p>"LF &IniRead(@ScriptDir &"\百度提交软件.ini", "Genera"&$i, "softName", "AutoIt")
;$b=$b& "<p>"LF &"大小：50000KB"
;$b=$b& "<p>"LF &"语言：中文"
;$b=$b& "<p>"LF &"版本：5.21免费版"
;$b=$b& "<p>"LF &"适用平台   winxp/win7/win8"
;$b=$b& "<p>"LF &"公司网站   www.gjprj.cn"
;$b=$b& "<p>"LF &"下载地址   "&IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'down_url', '')
;$b=$b& "<p>"LF &"截屏地址   http://www.gjprj.cn/down/"&IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'snap_1', '')&"1.png"
;$b=$b& "<p>"LF &"截屏地址   http://www.gjprj.cn/down/"&IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'snap_1', '')&"2.png"
;$b=$b& "<p>"LF &"截屏地址   http://www.gjprj.cn/down/"&IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'snap_1', '')&"3.png"
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc1', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc2', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc3', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc4', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc5', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc6', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc7', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc8', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc9', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc10', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc11', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc12', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc13', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc14', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc15', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc16', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc17', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc18', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc19', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc20', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc21', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc22', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc23', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc24', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc25', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc26', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc27', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc28', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc29', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc30', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc31', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc32', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc33', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc34', '')
$b=$b&"<p>"& IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'soft_desc35', '')
_IELoadWait($oie)
$oIE.document.parentWindow.aspnetForm.txtKeywords.value=="管家婆,免费仓库管软件,管家婆erp,管家婆进销存"
$oIE.document.parentWindow.aspnetForm.txtContent.value=$b
$oIE.document.parentWindow.aspnetForm.txtdescription.value==StringLeft ($b,300)

$oIE.document.parentWindow.aspnetForm.ddlClassId.value=171
$oIE.document.parentWindow.aspnetForm.ddl_plus.value=1
$oIE.document.parentWindow.aspnetForm.txtResName.value=IniRead(@ScriptDir &"\百度提交软件.ini", "Genera"&$i, "softName", "")
$oIE.document.parentWindow.aspnetForm.txtResVer.value="6.18"
$oIE.document.parentWindow.aspnetForm.txtResSize.value="50000"
$oIE.document.parentWindow.aspnetForm.txttags.value="管家婆,免费仓库管软件,管家婆erp,管家婆进销存"
$oIE.document.parentWindow.aspnetForm.ddl_shouquan.value="免费版"
$oIE.document.parentWindow.aspnetForm.txtauthorURL.value="http://www.gjprj.net"
$oIE.document.parentWindow.aspnetForm.txtauthorname.value="管家婆软件"
$oIE.document.parentWindow.aspnetForm.txtdownurl1.value=IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'down_url', '')
$oIE.document.parentWindow.aspnetForm.txthzurl.value=="http://www.gjprj.cn"
$oIE.document.parentWindow.aspnetForm.txtupContent.value="编辑大人您辛苦了。"
$oIE.document.parentWindow.aspnetForm.txtPreviewImg.value="http://www.gjprj.cn/down/"&IniRead(@ScriptDir & "\百度提交软件.ini","Genera"&$i, 'snap_1', '')&"1.png"
$oIE.document.parentWindow.aspnetForm.submit()
;_IEPropertySet($oFrame2, "innertext", $b)




;newfeature


;img_file_1
;xhe0_iframe
;_IEQuit($oie)
Next
