#Include <Date.au3>
#include <IE.au3>
#include <FTPEx.au3>  
#include <SQLite.au3>  
#include <SQLite.dll.au3>  
ShellExecute ("iexplore.exe", "about:blank")
WinWait ("about:blank")
$oIE = _IEAttach ("about:blank", "url")
_IENavigate ($oIE, "https://passport.360buy.com/new/login.aspx")
_IELoadWait ($oIE)

ShellExecute ("iexplore.exe", "about:blank")
WinWait ("about:blank")
$oIE1 = _IEAttach ("about:blank", "url")

$oQ = _IEGetObjByName ($oIE,  "loginname")
_IEFormElementSetValue ($oQ, "aontimer")
$oQ = _IEGetObjByName ($oIE,  "loginpwd")
_IEFormElementSetValue ($oQ, "903291")
$oQ = _IEGetObjByName ($oIE,  "chkRememberMe")
$oQ.click
$oQ = _IEGetObjByName ($oIE,  "loginsubmit")
$oQ.click


_IELoadWait ($oIE)
_IENavigate($oIE,"http://club.360buy.com/mycomments.aspx")
_IELoadWait ($oIE)
;$oIE = _IEAttach ("http://club.360buy.com/mycomments.aspx", "url")
$olinks = $oIE.document.getElementsBytagName("a")
$review="很好的东西"
$review1="很好的东西"&Chr(13)&"朋友送我的我很喜欢谢谢了"
For $olink In $olinks	
	If( StringInStr($olink.href, "Simplereview")>0)Then
		_IENavigate ($oIE1, $olink.href)
		_IELoadWait ($oIE1)
		$oQ = _IEGetObjByName ($oIE1,  "point")
		$oQ.click
		$oQ = _IEGetObjByName ($oIE1, "title")
		$oQ.value=$review
		$oQ = _IEGetObjByName ($oIE1,  "content")
		$oQ.innerText=$review1
		$oQ = _IEGetObjByName ($oIE1,  "pros")
		$oQ.innerText=$review
		$oQ = _IEGetObjByName ($oIE1,  "saveComment")
		$oQ.click

		Sleep(2000)
	EndIf
Next

$olinks = $oIE.document.getElementsBytagName("a")
For $olink In $olinks	
	If( StringInStr($olink.href, "&page=2")>0)Then
		$olink.click
	EndIf
Next
_IELoadWait ($oIE)
$olinks = $oIE.document.getElementsBytagName("a")
$review="很好的东西"
$review1="很好的东西"&Chr(13)&"朋友送我的我很喜欢谢谢了"
For $olink In $olinks	
	If( StringInStr($olink.href, "Simplereview")>0)Then
		_IENavigate ($oIE1, $olink.href)
		_IELoadWait ($oIE1)
		$oQ = _IEGetObjByName ($oIE1,  "point")
		$oQ.click
		$oQ = _IEGetObjByName ($oIE1, "title")
		$oQ.value=$review
		$oQ = _IEGetObjByName ($oIE1,  "content")
		$oQ.innerText=$review1
		$oQ = _IEGetObjByName ($oIE1,  "pros")
		$oQ.innerText=$review
		$oQ = _IEGetObjByName ($oIE1,  "saveComment")
		$oQ.click

		Sleep(2000)
	EndIf
Next