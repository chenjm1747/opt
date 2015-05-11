#include <Excel.au3>

$oExcel = _ExcelBookOpen(@ScriptDir & '\Excel.xlsx')
;打开当前目录下的Excel.xlsx表格文件

With $oExcel
	.Range("A1:B13").Select
	;这句话的意思是选择A1:B13的数据，其实没什么用可以删除
    .ActiveSheet.Shapes.AddChart.Select
	;这句话是插入一个图表
    .ActiveChart.SetSourceData = .Range("Sheet1!$A$1:$B$13")
	;这句话的意思是设置图表的数据源，$A$1:$b$13
	;这句话设置数据源在VBA里面Source是告诉这个图表数据源是什么
	;在au3里面可以把这段删除，也可以识别数据
	;同样，后面Range也是$oExcel的一个方法，我们在前面加上.
    .ActiveChart.ChartType = 5
	;这句话的意思是设置图表的类型是饼图
	;至于这个xlPie我们可以通过VBA的对象浏览器来查看它的值
	;它的值我们看到=5，我们这里直接设置5就可以了。
EndWith

;这样我们就可以看到自动创建图表的过程了。视频到此结束！

Sleep(5000)
;延迟5秒
_ExcelBookClose($oExcel)
;关闭表格文件