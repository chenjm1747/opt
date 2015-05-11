#region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=..\..\ICO\5.ico
#PRE_Outfile=YouKu Playlist Analysis.exe
#PRE_Compression=4
#PRE_Res_Comment=优酷专辑批量下载
#PRE_Res_Description=优酷专辑分析工具
#PRE_Res_Fileversion=0.0.0.48
#PRE_Res_Fileversion_AutoIncrement=y
#PRE_Res_requestedExecutionLevel=None
#endregion ;**** 参数创建于 ACNWrapper_GUI ****
#region ACN预处理程序参数(常用参数)
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
	
	Au3 版本:http://v.youku.com/v_show/id_XMTE4MDY1MTgw.html?f=3744460
	脚本作者:http://v.youku.com/v_show/id_XMTE4MDY3Mzky.html?f=3744460
	电子邮件:
	QQ/TM:
	脚本版本:
	脚本功能:
	
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#include <IE.au3>
#include <Array.au3>
TraySetState(2)   ;hide the tray ico
Local $PlalistAdress=ClipGet()
Local $arraytxt = @TempDir & "\YouKu Playlist Analysis.txt" ;The file dir
Local $alllinks[100] ;原始的链接数组
Local $oIE = _IECreate($PlalistAdress, 0, 0)
Local $oLinks = _IELinkGetCollection($oIE)
Local $flag = 1
While @error Or @extended = 0
	SetError(0)
	Local $oLinks = _IELinkGetCollection($oIE)
	Sleep(500)
WEnd
Local $i = 0
For $oLink In $oLinks
	If StringInStr($oLink.href, "http://v.youku.com/v_show/") = 1 Then
		$alllinks[$i] = $oLink.href
		$i = $i + 1
	EndIf
Next

$links = _ArrayUnique($alllinks) ;最终获得的数组。
;~ _ArrayDelete($links,100)   ;销毁数组中最后一个空字符。不过这一行可有可无,因为它总是存在的！
$i = 0
While $i < $links[0]
	FileWriteLine($arraytxt, $links[$i]) ;一行一行写入
	$i = $i + 1
WEnd
_IEQuit($oIE) ;退出浏览器
