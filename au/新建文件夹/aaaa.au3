$oExcel=ObjCreate("Excel.Application")
$oExcel.Workbooks.Add
$oExcel.Worksheets(3).Delete
$oExcel.Worksheets(2).Delete
$wsheet ="Sheet1"
For $I=1 To 20
For $J=1 To 20
$oExcel.Cells($I,$J).Value=Random(1,20,1)
Next
Next
$oExcel.Range("A1:T20").Select
$oExcel.Charts.Add()
$oExcel.ActiveChart.HasTitle=TRUE
$oExcel.ActiveChart.ChartTitle.Characters.Text="20 by 20 Random Numbers 1 to 20"
$oExcel.ActiveChart.ChartType=51
$oExcel.ActiveChart.Location (2, $wsheet) ;xlLocationAsObject
    With $oExcel.ActiveChart.Parent
        .Top = $oExcel.ActiveSheet.Range("A21:T50").Top
        .Left = $oExcel.ActiveSheet.Range("A21:T50").Left
        .Height = $oExcel.ActiveSheet.Range("A21:T50").Height
        .Width = $oExcel.ActiveSheet.Range("A21:T50").Width
     EndWith
$oExcel.Visible = True
msgbox(4096,"Excel Chart","Click OK When Done...")
$oExcel.Quit
$Tit="Microsoft Excel"
Opt("WinTitleMatchMode",3)
WinWait($Tit)
ControlClick($Tit,"","[ID:7]")
