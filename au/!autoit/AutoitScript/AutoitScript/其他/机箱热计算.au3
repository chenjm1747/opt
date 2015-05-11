#region ACN预处理程序参数(常用参数)
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
#endregion ACN预处理程序参数(常用参数)
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
	
	Au3 版本:
	脚本作者:
	电子邮件:
	QQ/TM:
	脚本版本:
	脚本功能:
	
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#include <Array.au3>
#include <Excel.au3>
Local $s
Local $array[130][4]
Local $T
For $s = -40 To 85
	$T = tem($s)
	$array[$s + 40][0] = $s
	$array[$s + 40][1] = $T[1]
	$array[$s + 40][2] = $T[2]
	$array[$s + 40][3] = $T[3]
Next
;~ _ArrayDisplay($array)

Local $oExcel = _ExcelBookNew() ;创建新工作簿, 并使其可见
Sleep(1000)
_ExcelWriteSheetFromArray($oExcel, $array, 1, 1, 0, 0) ;基于 0 开始的数组参数

Func tem($T0)
	Local $Q = 150 ;机箱总发热量
	Local $T[4] ;机箱温度数组返回值
	Local $T1, $T2, $T3 ;分别对应机箱外壳温度，机箱内壳体温度，内部空气温度
	Local $h1 = 15 ;机箱外部空气对流系数
	Local $h2 = 10 ;机箱内部空气对流系数
	Local $A = 0.7395 ;机箱外壳对流有效面积
	Const $e = 0.33 * 5.67 * 0.00000001 ;机箱外壳黑度*黑体辐射常数
	Local $A1 = 0.9474 ;机箱外壳辐射有效面积
	Local $l = 0.003 ;机箱内表面至外表面传导距离
	Local $k = 0156 ;机箱铝材导热系数
	Local $m = 2 * (0.4318 * 0.158 + 0.158 * 0.2985 + 0.4318 * 0.2985);机箱内表面面积
	For $T1 = $T0 To 500 Step 0.001
		$Q = ($T1 - $T0) * $h1 * $A + ($T1 ^ 4 - $T0 ^ 4) * $e * $A1
		If $Q - 150 < 0.1 And $Q - 150 > 0 Then
			ExitLoop
		EndIf
	Next
	
	$T2 = $Q * $l / $k / $m + $T1
	
	$T3 = $Q / $m / $h2 + $T2
	
	$T[1] = $T1
	$T[2] = $T2
	$T[3] = $T3
	Return $T
EndFunc   ;==>tem