#include<IE.au3>
#include <INet.au3>

$oIE = _IECreate("http://openapi.qzone.qq.com/oauth/show?which=Login&display=pc&client_id=200065&redirect_uri=http%3A%2F%2Fpassport.58.com%2Fqqloginvalidate&scope=get_user_info&response_type=code&redirect_uri=http://passport.58.com/qqloginvalidate&state=javaSdk-code&client_id=200065")
_IELoadWait($oIE)
Send("{tab}")
Send("{tab}")
Send("{tab}")
Send("{enter}")
Sleep(1000)
_IELoadWait($oIE)
_IENavigate($oIE,"http://post.58.com/79/156/s5")
_IELoadWait($oIE)
	js(FileRead("r:\jquery-1.10.2.min.js"))
	js("$('#title').val('我发布租车业务')")
	_IELinkClickByText($oIE, "杭州周边")



Func js($script)
	$oIE.document.parentWindow.eval($script)
EndFunc   ;==>js