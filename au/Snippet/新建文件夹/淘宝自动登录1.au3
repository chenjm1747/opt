#include<IE.au3>
#include <INet.au3>
$skeyword = _INetGetSource("http://www.caiwuhao.com/keywords.txt")
$aKeywords = StringSplit("旅行社软件,旅行社管理软件,旅行社系统,旅行社分销软件,旅游管理软件", ",")
For $element In $aKeywords
	Sleep(1000)
	if (StringLen($element) <= 1) Then ContinueLoop
	Global $oIE = _IECreate("http://www.baidu.com")

	js(FileRead("jquery-1.10.2.min.js"))
	js("$('#kw').val('" & $element & "')")
	js("$('#su').click()")
	_IELoadWait($oIE)
	_IELinkClickByText($oIE, $element & " [旅贸通]管理系统软件,免费试用")
	Sleep(5000)
	_IEQuit($oIE)
	$oe1 = _IEAttach("http://www.716580.com/soft/", "url")
	_IELoadWait($oIE)
	_IEQuit($oe1)

Next


Func js($script)
	$oIE.document.parentWindow.eval($script)
EndFunc   ;==>js