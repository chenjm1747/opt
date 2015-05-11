#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IECreate("http://www.xiangguohe.com")
Local $oDoc = _IEDocGetObj($oIE)
MsgBox($MB_SYSTEMMODAL, "Document Created Date", $oDoc.fileCreatedDate)

