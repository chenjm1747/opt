#include <Excel.au3>
#include <MsgBoxConstants.au3>
#include <IE.au3>
; Create application object and open an example workbook
Local $sWorkbook = "_Excel.xls"
Local $oAppl = _Excel_Open()
If @error <> 0 Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookAttach Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $oWorkbook = _Excel_BookOpen($oAppl, @ScriptDir & $sWorkbook)
If @error Then
    MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookAttach Example", "Error opening workbook '" & @ScriptDir & "\Extras\_Excel1.xls'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
    _Excel_Close($oAppl)
    Exit
EndIf

; *****************************************************************************
; Attach to the first Workbook where the file name matches
; *****************************************************************************

$oWorkbook = _Excel_BookAttach($sWorkbook, "filename")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookAttach Example 2", "Error attaching to '" & $sWorkbook & "'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

$oIE = _IECreate("http://www.gjprj.cn/cx1.asp",0,0)
_IELoadWait($oie)

$otable=_IEGetObjById ( $oie,"guanjiapo" )
$atable=_IETableWriteToArray ( $otable )
Local $alastyear[32]
Local $athisyear[32]
$lastyear="2013-06-05"
$thisyear="2014-06-05"
for $i=0 to 99
if StringReplace($atable[1][$i]," ","")=$lastyear Then exitloop
next
for $j=0 to 30
   $alastyear[$j]=StringReplace($atable[2][$i+$j]," ","")
 ;  MsgBox(0,$lastyear, $alastyear[$j])
next
for $i=0 to 999
if StringReplace($atable[1][$i]," ","")=$thisyear Then exitloop
next
for $j=0 to 30
   $athisyear[$j]=StringReplace($atable[2][$i+$j]," ","")
;   MsgBox(0,$thisyear, $athisyear[$j])
next
_IEQuit($oie)
_Excel_RangeWrite($oWorkbook, $oWorkbook.Activesheet, $alastyear, "B2")
Local $aArray1D[] = [11, 111, 111]
_Excel_RangeWrite($oWorkbook, $oWorkbook.Activesheet, $athisyear, "C2")
$oWorkbook.Range("A0:c30").Select
$chart=$oWorkbook.Charts.Add()
$oWorkbook.ActiveChart.HasTitle=TRUE
$oWorkbook.ActiveChart.ChartTitle.Characters.Text="流量统计表"
$oWorkbook.ActiveChart.SeriesCollection(1).Name = "去年"
$oWorkbook.ActiveChart.SeriesCollection(2).Name = "今年"
$oWorkbook.ActiveChart.Export("c:\111.gif")


