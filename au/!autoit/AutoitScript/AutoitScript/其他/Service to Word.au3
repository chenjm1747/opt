#Region ACN预处理程序参数(常用参数)
#PRE_Icon= 										;图标,支持EXE,DLL,ICO
#PRE_OutFile=									;输出文件名
#PRE_OutFile_Type=exe							;文件类型
#PRE_Compression=4								;压缩等级
#PRE_UseUpx=y 									;使用压缩
#PRE_Res_Comment= 								;程序注释
#PRE_Res_Description=							;详细信息
#PRE_Res_Fileversion=							;文件版本
#PRE_Res_FileVersion_AutoIncrement=p			;自动更新版本
#PRE_Res_LegalCopyright= 						;版权
#PRE_Change2CUI=N                   			;修改输出的程序为CUI(控制台程序)
;#PRE_Res_Field=AutoIt Version|%AutoItVer%		;自定义资源段
;#PRE_Run_Tidy=                   				;脚本整理
;#PRE_Run_Obfuscator=      						;代码迷惑
;#PRE_Run_AU3Check= 							;语法检查
;#PRE_Run_Before= 								;运行前
;#PRE_Run_After=								;运行后
;#PRE_UseX64=n									;使用64位解释器
;#PRE_Compile_Both								;进行双平台编译
#EndRegion ACN预处理程序参数设置完成
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

 Au3 版本: 
 脚本作者: 
 电子邮件: 
	QQ/TM: 
 脚本版本: 
 脚本功能: 

#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

Const $NUMBER_OF_ROWS = 1
Const $NUMBER_OF_COLUMNS = 3

$objWord = ObjCreate("Word.Application")
$objWord.Visible = 1
$objDoc = $objWord.Documents.Add()

$objRange = $objDoc.Range()
$objDoc.Tables.Add ($objRange, $NUMBER_OF_ROWS, $NUMBER_OF_COLUMNS)
$objTable = $objDoc.Tables(1)

$objTable.Cell(1, 1).Range.Text = "Service Name"
$objTable.Cell(1, 2).Range.Text = "Display Name"
$objTable.Cell(1, 3).Range.Text = "Service State"

$x = 2

$strComputer = "."

$objWMIService = _
                ObjGet("winmgmts:\\" & $strComputer & "\root\cimv2")
$colItems = $objWMIService.ExecQuery("Select * from Win32_Service")

For $objItem in $colItems
        $objTable.ROWS.Add()
        $objTable.Cell($x, 1).Range.Text = $objItem.Name
        $objTable.Cell($x, 2).Range.Text = $objItem.DisplayName
        $objTable.Cell($x, 3).Range.Text = $objItem.State
        $x = $x + 1
Next

$objTable.AutoFormat(9)