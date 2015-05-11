#include<IE.au3>
$aKeyword = StringSplit("旅行社软件,旅行社管理软件,旅行社系统,旅行社分销软件,旅游管理软件", ",")
    FOR $element IN $aKeyword
        Sleep(1000)
Global $oIE = _IECreate("http://www.baidu.com")
js(FileRead("jquery-1.10.2.min.js"))
js("$('#kw').val('旅行社软件')")
js("$('#su').click()")
_IELoadWait($oie)
_IELinkClickByText ($oie, "旅行社软件 [旅贸通]管理系统软件,免费试用")
    Next


Func js($script)
  $oIE.document.parentWindow.eval($script)
EndFunc
