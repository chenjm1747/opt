
; Script Start - Add your code below here
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         jim

 Script Function:
	点开管家婆点华军

#ce ----------------------------------------------------------------------------
;696
; Script Start - Add your code below here
#include <IE.au3>
#include <MsgBoxConstants.au3>
While 1

$oIE = _IECreate("http://www.baidu.com",0,1)
Sleep(2000)
_IELoadWait($oie)
Sleep(20000)
$oie.document.form1.kw1.value="管家婆免费版"
$oie.document.form1.su1.click()
Sleep(2000)
_IELoadWait($oie)
Sleep(2000)
;_IELinkClickByText($oie,"管家婆免费仓库管理软件官方下载|管家婆免费仓库管理软件 5.2.1最...")
Local $oInputs = _IETagNameGetCollection($oIE, "a")
For $oInput In $oInputs
   if $oInput.innertext="管家婆免费仓库管理软件官方下载|管家婆免费仓库管理软件 5.2.1最..." then
	  $oInput.target=""
	  $oInput.click()
	  endif
   Next
_IELoadWait($oie)
sleep(Random(5000,19999,1))
ProcessClose("iexplore.exe")
wend
