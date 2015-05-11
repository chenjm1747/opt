#region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=..\..\ICO\rss (2).ico
#PRE_Outfile=优酷视频下载.exe
#PRE_Compression=4
#PRE_Res_Comment=优酷专辑批量下载
#PRE_Res_Description=帮助你快速下载优酷专辑
#PRE_Res_Fileversion=0.0.0.57
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
#include <myImageSearch.au3>
Global $lastlink ;检测上一次的地址，避免重复
Local $youkulogo, $chongshi ;图片搜索坐标、是否重试
_MyProExists() ;检查是否重复运行。
HotKeySet("{ESC}", tuichu)
AdlibRegister("_Quit", 1000 * 10) ;程序10s调用一次！检测优酷客户端是否存在！
FileInstall("立即下载.PNG", @TempDir & "\立即下载.PNG", 1)
FileInstall("YouKu Playlist Analysis.exe", @TempDir & "\YouKu Playlist Analysis.exe", 1)

If ProcessExists("YoukuDesktop.exe") = 0 Then  ;如果客户端不存在，那就要启动客户端了！
	TrayTip("提示！", "正在启动优酷客户端，请稍候！", 3000)
	Run("C:\Program Files\YouKu\YoukuClient\YoukuDesktop.exe") ;检测优酷客户端
	WinWait("优酷客户端")
	Sleep(20*1000) ;暂停20s，等待客户端完全启动！
EndIf
;~ WinSetState("优酷客户端", "", @SW_SHOW)
WinActivate("优酷客户端")
Global $xy = WinGetPos("优酷客户端") ;获取优酷客户端窗口坐标
MouseClick("left", $xy[0] + 265, $xy[1] + $xy[3] - 30)  ;点击下载
Sleep(500)
MouseClick("left", $xy[0] + 265, $xy[1] + $xy[3] - 30)  ;再点击一次！
WinSetState("优酷客户端", "", @SW_MINIMIZE)
ClipPut("") ;清空剪切板
TrayTip("提示！", "优酷客户端已经准备好啦！复制链接地址即可启动下载。", 3000)
While 1
	If StringInStr(ClipGet(), "http://v.youku.com/v_show/") = 1 And StringCompare($lastlink, ClipGet()) <> 0 Then
		TrayTip("提示！", "检测到一个优酷播放页地址，正在启动下载！", 3000)
		$lastlink = ClipGet()
		$chongshi = youku()
		If $chongshi = 1 Then
			TrayTip("连接超时！", "正在准备重试！", 3000)
			youku() ;仅仅重复一次！
		EndIf
		WinSetState("优酷客户端", "", @SW_MINIMIZE)
		TrayTip("恭喜！", "剪切板地址视频成功添加到了YouKu下载！", 3000)
	EndIf
	If StringInStr(ClipGet(), "http://www.youku.com/playlist_show/") = 1 And StringCompare($lastlink, ClipGet()) Then ;如果是专辑，进入自动模式！
		TrayTip("提示！", "检测到一个优酷专辑页地址，正在解析文件页地址，请稍候！", 3000)
		$lastlink = ClipGet()
		zhuanji()
	EndIf
	Sleep(1000)
WEnd

Func _Quit()
	If Not ProcessExists("YoukuDesktop.exe") Then
		TrayTip("提示", "没有检测到优酷主程序，即将自动退出！", 3000)
		Sleep(3000)
		Exit
	EndIf
EndFunc   ;==>_Quit

Func tuichu() ;手动退出
	TrayTip("提示！", "优酷下载助手即将自动退出！", 3000)
	Sleep(3000)
	Exit
EndFunc   ;==>tuichu

Func _MyProExists()
	Local $my_Version = "Youku downloader"
	If WinExists($my_Version) Then
		TrayTip("提示", "程序已经运行了！", 3000)
		Sleep(3000)
		Exit
	EndIf
	AutoItWinSetTitle($my_Version)
EndFunc   ;==>_MyProExists

Func zhuanji()
	Local $arraytxt = @TempDir & "\YouKu Playlist Analysis.txt" ;The file dir
	If FileExists($arraytxt) Then FileDelete($arraytxt) ;If Exist Then Delet The TXT file.
	Local $Analysis = "YouKu Playlist Analysis.exe"
	Local $playlistadress = ClipGet() ;保存专辑页面的地址。
	TrayTip("提示", "正在获取专辑页的视频播放地址集，请稍候！", 3000)
	Run(@TempDir & "\" & $Analysis)
	Local $counttime = 0 ;供超时判断用
	While 1
		If ProcessExists($Analysis) Then
			Sleep(1000)
			$counttime = $counttime + 1
		EndIf
		
		If FileExists($arraytxt) And Not ProcessExists($Analysis) Then
			ExitLoop
		EndIf
		
		If $counttime = 10 Then ;10s了，说明超时，就重来一次了！
			TrayTip("提示", "获取错误，正在重试！", 3000)
			ProcessClose($Analysis)
			Sleep(1000)
			Run(@TempDir & "\" & $Analysis) ;重来
			$counttime = 0
		EndIf
	WEnd
	If FileReadLine($arraytxt, 1) = 1 Then
		TrayTip("提示！", "似乎这个页面已经没有优酷视频了", 3000)
	Else
		TrayTip("视频地址获取完毕！", "共获取了" & FileReadLine($arraytxt, 1) - 1 & "个视频地址，即将添加它们到优酷下载！", 3000)
	EndIf
	Local $num = 2
	While $num <= FileReadLine($arraytxt, 1)
		ClipPut(FileReadLine($arraytxt, $num))
		If ClipGet() = "" Then ExitLoop
		$chongshi = youku()
		If $chongshi = 1 Then
			TrayTip("连接超时或检测失败！", "正在准备重试，请稍候！", 3000)
		Else
			TrayTip("共" & FileReadLine($arraytxt, 1) - 1 & "个视频", "已经添加了" & $num - 1 & "个视频。", 3000)
			$num = $num + 1
		EndIf
	WEnd
	TrayTip("恭喜", "专辑页面共" & FileReadLine($arraytxt, 1) - 1 & "个视频已经都添加到了下载！", 3000)

	If FileReadLine($arraytxt, 1) = 21 Then ;如果现在的页面有20个视频，说明有可能存在下一页。
		Local $nextpageadress ;下一个专辑页的地址
		If StringInStr($playlistadress, "_page_") Then
			Local $playlistsplit = StringSplit($playlistadress, "_page_", 1)
			If $playlistsplit[0] = 2 Then
				Local $splitnum = StringSplit($playlistsplit[2], ".", 1)
				$nextpageadress = $playlistsplit[1] & "_page_" & $splitnum[1] + 1 & "." & $splitnum[2]
			EndIf
		Else
			Local $playlistsplit = StringSplit($playlistadress, ".", 1)
			If $playlistsplit[0] = 4 Then
				$nextpageadress = $playlistsplit[1] & "." & $playlistsplit[2] & "." & $playlistsplit[3] & "_page_2." & $playlistsplit[4]
			EndIf
		EndIf
		If $nextpageadress = "" Then
			TrayTip("警告", "专辑页的下一个页面地址获取错误，请手动尝试下载！", 3000)
		Else
			ClipPut($nextpageadress)
			TrayTip("提示", "专辑可能存在下一页，即将启动下一波下载！", 3000)
			Sleep(3000)
		EndIf
	Else
		ClipPut($lastlink)  ;避免重复的按钮！
		TrayTip("提示", "这个专辑的所有文件都已经添加到了下载队列！", 3000)
	EndIf
EndFunc   ;==>zhuanji

Func youku()
	WinActivate("优酷客户端")
	MouseClick("left", $xy[0] + 50, $xy[1] + 70)
	Sleep(500)
	Local $pos = myImageSearch_Desktop(@TempDir & "\立即下载.PNG", 0, 0, @DesktopWidth, @DesktopHeight, "", True)
	If @error Then
		Sleep(1000)
		SetError(0)
		$pos = myImageSearch_Desktop(@TempDir & "\立即下载.PNG", 0, 0, @DesktopWidth, @DesktopHeight, "", True)
		If @error Then
			TrayTip("提示", "出现意外错误，必须手动清除。程序即将自动退出！", 3000)
			Sleep(3000)
			Exit
		EndIf
	EndIf
	MouseClick("", $pos[0] + 20, $pos[1] - 235)
	MouseClick("", $pos[0] + 20, $pos[1] - 20)
	Local $time = 0
	While PixelGetColor($pos[0], $pos[1]) <> 4042723 ;通过检测颜色判断是否可以点击下载！
		Sleep(1000)
		If $time = 20 Then ExitLoop ;20秒无响应即退出循环！
		$time = $time + 1
	WEnd
	If $time = 20 Then
		MouseClick("", $pos[0] + 468, $pos[1] - 293) ;超时点击关闭按钮
		Return 1
	Else
		MouseClick("", $pos[0] + 60, $pos[1] + 20) ;正常，点击下载！
		Return 0
	EndIf
EndFunc   ;==>youku