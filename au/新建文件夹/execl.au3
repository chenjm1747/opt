#include <Array.au3>
#include <Excel.au3>
#include <MsgBoxConstants.au3>
#include <IE.au3>
; Create application object and create a new workbook
While 1
$oIE = _IECreate("http://www.gjprj.cn/cx1.htm",0,1)
_IELoadWait($oie)

$otable=_IEGetObjById ( $oie,"guanjiapo" )
$atable=_IETableWriteToArray ( $otable )
_ArrayDisplay($atable)

Local $sWorkbook = "流量统计.xls"
Local $oAppl = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookAttach Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $oWorkbook = _Excel_BookOpen($oAppl, $sWorkbook)
If @error Then
    MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookAttach Example", "Error opening workbook '" & $sWorkbook & "'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
    _Excel_Close($oAppl)
    Exit
EndIf

; *****************************************************************************
; Attach to the first Workbook where the file path matches
; *****************************************************************************
$oWorkbook = _Excel_BookAttach($sWorkbook)

; *****************************************************************************
; Write a part of a 2D array to the active sheet in the active workbook
; *****************************************************************************
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeWrite Example 2", "Error writing to worksheet." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeWrite Example 2", "1D array successfully written.")
