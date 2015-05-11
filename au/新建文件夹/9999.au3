;=====================================================
; AGraphOWC__Embedded - sample of OWC Chart used by AutoIt
; It allows to embed MS OWC controls into AutoIt Gui
; Requirement:
; - MS OWC installed from http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=22276
; Version 0.5
;
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include "AGraph_Constants.au3"
Global $oSpreadsheet, $SinkObject, $GUISpreadsheetX
Global $oActiveWindow, $oActiveSheet
Global $File, $i
Global $oChartSpace, $oChart, $GUIChartX
Global $GUI_OfficeLogo, $GUI_PropertyToolbox, $GUI_WorkbookTabs, $GUI_ColumnHeadings
Global $SSW = 250, $SSH = 480
Global $ViewW = 712, $ViewH = 480
Global $hWnd, $msg
Global $MonthNames = StringSplit("Jan. Feb. Mar. Apr. May Jun. Jul. Aug. Sep. Oct. Nov. Dec."," ")
;=============================================
Global $Caption = "AGraphOWC_Embedded ? Valery Ivanov, 21 June 2010"
$oSpreadsheet = ObjCreate("OWC11.Spreadsheet")
If Not IsObj($oSpreadsheet) then MsgBox(0,"","Spreadsheet failed!")

$SinkObject = ObjEvent($oSpreadsheet,"SSEvent_","ISpreadsheetEventSink")
$oSpreadsheet.DisplayOfficeLogo = False
$oChartSpace = ObjCreate("OWC11.Chartspace")
; Create a simple GUI for our output
$hWnd = GUICreate($Caption, 1000, 580, (@DesktopWidth - 1000) / 2, (@DesktopHeight - 580) / 2, BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPSIBLINGS, $WS_CLIPCHILDREN))
$GUI_OfficeLogo = GUICtrlCreateButton("OfficeLogo", 10, 10, 100, 30)
$GUI_PropertyToolbox = GUICtrlCreateButton("PropertyToolbox", 120, 10, 100, 30)
$GUI_WorkbookTabs = GUICtrlCreateButton("WorkbookTabs", 230, 10, 100, 30)
$GUI_ColumnHeadings = GUICtrlCreateButton("ColumnHeadings", 340, 10, 100, 30)
$oSpreadsheet.MaxHeight = $SSH
$oSpreadsheet.MaxWidth = $SSW
With $oSpreadsheet
.MaxHeight = $SSH
.MaxWidth = $SSW
EndWith
$oActiveWindow = $oSpreadsheet.ActiveWindow
With $oActiveWindow
.ColumnHeadings(1).Caption = "Motors"
.ColumnHeadings(2).Caption = "Cars"
.ColumnHeadings(3).Caption = "Vehicles"
;Set the caption of the actual rowheadings.
  For $i = 1 To $MonthNames[0]
    .RowHeadings($i).Caption = $MonthNames[$i]
  Next
;Limit the viewable part of the worksheet.
  .ViewableRange = "A1:C12"
EndWith
$oActiveSheet = $oSpreadsheet.ActiveSheet
$oActiveSheet.Name = "Sheet1"
With $oActiveSheet
For $i = 1 to $MonthNames[0]
  .Cells($i,1).Value = Round(Random(0,450),1)
  .Cells($i,2).Value = Round(Random(0,750),1)
  .Cells($i,3).Value = Round(Random(0,1350),1)
next
EndWith
$oChartSpace.Clear
$oChartSpace.DisplayToolbar = True
$oChartSpace.AllowPropertyToolbox = True
;Set up the Spreadsheet control to be the data source.
$oChartSpace.DataSource = $oSpreadsheet
$oChart = $oChartSpace.Charts.Add(0)
$oChart.HasTitle=TRUE
$oChart.Title.Caption = "统计图"
 $oChartSpace.Axes[0].HasTitle = true;

 $oChartSpace.SeriesCollection(2).Name = "今年"
;$oChart.Axes[0].HasTitle = true;
 ;    $oChart.Axes[1].HasTitle = true;
  $oChartSpace.Axes[0].Title.Caption = "月份"
 ;    $oChart.Axes[1].Title.Caption = "数量"

With $oChart
.SetSpreadsheetData("Sheet1!A1:C12", True)
.Type = $chChartTypeLine
EndWith
;Space for embedded SpreadSheet
$GUISpreadsheetX = GUICtrlCreateObj ($oSpreadsheet, 10, 80, $SSW, $SSH)
;Space for embedded ChartSpace
$GUIChartX = GUICtrlCreateObj ($oChartSpace, 290, 80, $ViewW, $ViewH)
GUISetState()
While 1
  $msg = GUIGetMsg()
  Select
  Case $msg = $GUI_EVENT_CLOSE
    ExitLoop
  Case $msg = $GUI_OfficeLogo
    $oSpreadsheet.DisplayOfficeLogo = Not $oSpreadsheet.DisplayOfficeLogo
    $oChartSpace.DisplayOfficeLogo = Not $oChartSpace.DisplayOfficeLogo
  Case $msg = $GUI_PropertyToolbox
    $oSpreadsheet.DisplayPropertyToolbox = Not $oSpreadsheet.DisplayPropertyToolbox
    $oChartSpace.AllowPropertyToolbox =  Not $oChartSpace.AllowPropertyToolbox
  Case $msg = $GUI_WorkbookTabs
    $oSpreadsheet.DisplayWorkbookTabs = Not $oSpreadsheet.DisplayWorkbookTabs
  Case $msg = $GUI_ColumnHeadings
    $oSpreadsheet.DisplayColumnHeadings = Not $oSpreadsheet.DisplayColumnHeadings
  EndSelect

WEnd
GUIDelete()
