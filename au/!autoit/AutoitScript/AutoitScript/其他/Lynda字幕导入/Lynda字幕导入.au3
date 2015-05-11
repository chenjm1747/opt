#Region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Icon=..\..\..\ICO\Lync.ico
#PRE_Outfile=D:\GoogleCode\AutoitScript\其他\Lynda字幕导入\Lynda字幕导入.exe
#PRE_Compression=4
#PRE_Res_Description=Lynda视频与字幕同步并自动导入
#PRE_Res_Fileversion=0.0.0.2
#PRE_Res_Fileversion_AutoIncrement=y
#PRE_Res_requestedExecutionLevel=None
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
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
	
	Au3 版本:
	脚本作者:
	电子邮件:
	QQ/TM:
	脚本版本:
	脚本功能:
	
#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

#include <File.au3>
#include <Array.au3>
Local $flag = 2 ;1代表视频名字拷给字幕名字，2代表字幕名字拷给视频。
If FileExists(@DesktopDir & "\newsrt") Then DirRemove((@DesktopDir & "\newsrt"), 1)
Local $videodirlasttime = IniRead(@TempDir & "\lynda.ini", "视频", "上次地址", "")
Local $srtdirlasttime = IniRead(@TempDir & "\lynda.ini", "字幕", "上次地址", "")
Global $videodir = FileSelectFolder("请选择视频文件夹", "", 2, $videodirlasttime)
If @error Then Exit
IniWrite(@TempDir & "\lynda.ini", "视频", "上次地址", $videodir)
Global $srtdir = FileSelectFolder("请选择字幕文件夹", "", 2, $srtdirlasttime)
If @error Then Exit
IniWrite(@TempDir & "\lynda.ini", "字幕", "上次地址", $srtdir)
Global $videoFolderList = _FileListToArray($videodir, "*", 2) ;有可能存在练习文件夹
Global $srtFolderList = _FileListToArray($srtdir, "*", 2)
If @error Then Exit ;出错就退出咯！
;~ _ArrayDisplay($videoFolderList, "视频文件夹列表")
;~ _ArrayDisplay($srtFolderList, "字幕文件夹列表")
If $videoFolderList[0] = $srtFolderList[0] Or $videoFolderList[0] = $srtFolderList[0] + 1 Then
	TrayTip("提示", "文件夹匹配成功！即将进行文件夹内文件匹配检查。", 2000)
Else
	TrayTip("提示", "文件夹匹配失败！请检查是不是同一视频的字幕。", 2000)
	Sleep(2000)
	Exit
EndIf

check()
changename()
TrayTip("恭喜！", "字幕和视频完成了匹配，并且复制到了视频文件夹。", 3000)
Sleep(3000)

Func check()
	For $i = 1 To $srtFolderList[0]
		Local $srtname = _FileListToArray($srtdir & "\" & $srtFolderList[$i])
;~ 		_ArrayDisplay($srtname, "字幕文件列表")
		Local $videoname = _FileListToArray($videodir & "\" & $videoFolderList[$i])
;~ 		_ArrayDisplay($videoname, "视频文件列表")
		If $srtname[0] <> $videoname[0] Then
			Local $shuzucd ;数组的长度
			If $srtname[0] < $videoname[0] Then
				$shuzucd = $videoname[0]+1
			Else
				$shuzucd = $srtname[0]+1
			EndIf
			Local $bijiao[$shuzucd][2]
			For $s = 0 To $videoname[0]
				$bijiao[$s][0] = $videoname[$s]
			Next
			For $s = 0 To $srtname[0]
				$bijiao[$s][1] = $srtname[$s]
			Next
			TrayTip("提示","文件夹内的文件数量不匹配，请检查！",3000)
;~ 			_ArrayConcatenate($videoname, $srtname)
			_ArrayDisplay($bijiao, "不匹配的文件夹@" & $videoFolderList[$i])
			Exit
		EndIf
	Next
EndFunc   ;==>check

Func changename()
	For $i = 1 To $srtFolderList[0]
		DirMove($srtdir & "\" & $srtFolderList[$i], $srtdir & "\" & $videoFolderList[$i])
		Local $srtname = _FileListToArray($srtdir & "\" & $videoFolderList[$i])
		Local $videoname = _FileListToArray($videodir & "\" & $videoFolderList[$i])
		For $n = 1 To $srtname[0]
			Local $szDrive, $szDir, $szFName, $szExt, $format
			If $flag = 1 Then
				_PathSplit($srtdir & "\" & $videoFolderList[$i] & "\" & $srtname[$n], $szDrive, $szDir, $szFName, $format) ;获取字幕类型
				_PathSplit($videodir & "\" & $videoFolderList[$i] & "\" & $videoname[$n], $szDrive, $szDir, $szFName, $szExt)
				Local $old = $srtdir & "\" & $videoFolderList[$i] & "\" & $srtname[$n]
				Local $new = $srtdir & "\" & $videoFolderList[$i] & "\" & $szFName & $format
			Else
				_PathSplit($videodir & "\" & $videoFolderList[$i] & "\" & $videoname[$n], $szDrive, $szDir, $szFName, $format) ;获取视频类型
				_PathSplit($srtdir & "\" & $videoFolderList[$i] & "\" & $srtname[$n], $szDrive, $szDir, $szFName, $szExt)
				Local $old = $videodir & "\" & $videoFolderList[$i] & "\" & $videoname[$n]
				Local $new = $videodir & "\" & $videoFolderList[$i] & "\" & $szFName & $format
			EndIf
			FileMove($old, $new)
		Next
	Next
	DirCopy($srtdir, $videodir, 1)
EndFunc   ;==>changename

