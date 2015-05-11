#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <IE.au3>


;Run("自动确认.exe")
Local $oIE = _IECreateEmbedded()
GUICreate("Embedded Web control Test", 1000, 580, 0, 0, _
		$WS_OVERLAPPEDWINDOW + $WS_VISIBLE + $WS_CLIPSIBLINGS + $WS_CLIPCHILDREN)
GUICtrlCreateObj($oIE, 0, 40, 1000, 560)

GUISetState() ;Show GUI
Local $file = FileOpen("自动评价.txt", 0)
If $file = -1 Then
	MsgBox(0, "Error", "Unable to open file.")
	Exit
EndIf
While 1
	$pingjia = FileReadLine($file)
	If @error = -1 Then ExitLoop
'管家婆致胜
	_IENavigate($oIE, "http://www.onlinedown.net/soft/117854.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆财务
	_IENavigate($oIE, "http://www.onlinedown.net/soft/117858.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆管店婆
	_IENavigate($oIE, "http://www.onlinedown.net/soft/118112.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆管致胜
	_IENavigate($oIE, "http://www.onlinedown.net/soft/118112.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)

'管家婆汽车维修
	_IENavigate($oIE, "http://www.onlinedown.net/soft/117859.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆超市
	_IENavigate($oIE, "http://www.onlinedown.net/soft/307499.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆进销存
	_IENavigate($oIE, "http://www.onlinedown.net/soft/117862.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆五金建材
	_IENavigate($oIE, "http://www.onlinedown.net/soft/307497.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆服装企业erp
	_IENavigate($oIE, "http://www.onlinedown.net/soft/117837.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'http://www.onlinedown.net/soft/117837.htm
'管家婆致胜管家高级ERP免费版
	_IENavigate($oIE, "http://www.onlinedown.net/soft/307565.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆系列_服装鞋帽高级进销存 5.2.1
	_IENavigate($oIE, "http://www.onlinedown.net/soft/307495.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆系列-致胜管家高级工贸免费版
_IENavigate($oIE, "http://www.onlinedown.net/soft/307493.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆系列_食品行业高级进销存
_IENavigate($oIE, "http://www.onlinedown.net/soft/307496.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆名片管理系统 4.2.8
_IENavigate($oIE, "http://www.onlinedown.net/soft/118427.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆系列_致胜管家高级财贸免费版 5.2.1
_IENavigate($oIE, "http://www.onlinedown.net/soft/307492.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆系列_致胜管家高级财贸免费版 5.2.1
_IENavigate($oIE, "http://www.onlinedown.net/soft/307492.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆系列_客户关系管理系统
_IENavigate($oIE, "http://www.onlinedown.net/soft/537490.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆免费仓库管理软件绿色版 5.15
_IENavigate($oIE, "http://www.onlinedown.net/soft/530145.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆免费仓库管理软件绿色版离散制造
_IENavigate($oIE, "http://www.onlinedown.net/soft/117833.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家空调
_IENavigate($oIE, "http://www.onlinedown.net/soft/117855.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆-健身房会员管理系统 2.0
_IENavigate($oIE, "http://www.onlinedown.net/soft/522144.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆旗舰版进销存免费版 2.00
_IENavigate($oIE, "http://www.onlinedown.net/soft/564231.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'管家婆旗舰版进销存免费版 2.00
_IENavigate($oIE, "http://www.onlinedown.net/soft/564231.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'麻将机
_IENavigate($oIE, "http://www.onlinedown.net/soft/522143.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)
'羽绒erp
_IENavigate($oIE, "http://www.onlinedown.net/soft/117838.htm")
	_IELoadWait($oIE)
	$ouname = _IEGetObjById($oIE, "content")
	$ouname.value = $pingjia
    $ouname = _IEGetObjById($oIE, "soft_id")
	$ouname.value = 	117854
	$ouname = _IEGetObjById($oIE, "commentForm")
	$ouname.submit()
	Sleep(500)
	_IELoadWait($oIE)

'http://www.onlinedown.net/soft/117838.htm
'http://www.onlinedown.net/soft/522143.htm
http://www.onlinedown.net/soft/537490.htm
WEnd
;http://www.onlinedown.net/soft/118174.htm
; Waiting for user to close the window
; Waiting for user to close the window
While 1
	Local $msg = GUIGetMsg()
	Select
		Case $msg = $GUI_EVENT_CLOSE
			ExitLoop

	EndSelect
WEnd

GUIDelete()

Exit