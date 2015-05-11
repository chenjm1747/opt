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

#Include <File.au3>
#include <Array.au3>

Local $i
Local $movesplit[4]
Local $srtsplit[4]
Local $moviename[1]
$inidir=IniRead(@TempDir&"\moviedir.ini","视频文件夹","默认",@DesktopDir)
$moviedir= FileSelectFolder("请选择视频文件夹","",2,$inidir)
If @error Then Exit
_Find($moviedir, ".mkv", 0,$moviename)
$srtdir= FileSelectFolder("请选择字幕文件夹","",2)
If @error Then Exit
$srtname=_FileListToArray($srtdir)
If $moviename[0]<>$srtname[0] Then
	MsgBox(0,"","字幕数量和视频数量不一致")
	Exit
EndIf
$flag=MsgBox(4,"请选择","字幕文件时候要加后缀？")
IniWrite(@TempDir&"\moviedir.ini","视频文件夹","默认",$moviedir)
For $i=1 To $moviename[0]
	_PathSplit($moviename[$i],$movesplit[0],$movesplit[1],$movesplit[2],$movesplit[3])
	_PathSplit($srtname[$i],$srtsplit[0],$srtsplit[1],$srtsplit[2],$srtsplit[3])
	If $flag=7 Then FileMove($srtdir&"\"&$srtname[$i],$moviedir&"\"&$movesplit[2]&$srtsplit[3])   ;eng
	If $flag=6 Then FileMove($srtdir&"\"&$srtname[$i],$moviedir&"\"&$movesplit[2]&"_gb"&$srtsplit[3])  ;gb
Next
TrayTip("提示","字幕文件名称修改完成！",5)
Sleep(5000)

#cs
============================================================================================
特定类型文件搜索
Version    : 1.0
Written by : 小包乖兔兔 
Date       : 2009.04.20
email    :226xb_tu@163.com
============================================================================================
_Find($path, $type, $flag,ByRef $result)
============================================================================================
参数说明：
 
$path  
表示要搜索的位置，如"E:\abc",表示E盘下的abc文件夹，路径的末尾请勿加斜杠；
 
$type  
表示文件类型，如".exe"，一定要带点；
 
$flag
值为0，代表仅搜索该目录,不包括子目录;
值为1，代表搜索该目录及其以下的所有子目录；
 
$result
表示要引用的数组，用来存放搜索结果，请先初始化要引用的数组为只拥有一个元素,如  Dim $get[1]
 
注：$result[0]的值为搜索到的匹配个数
============================================================================================
============================================================================================
例子
============================================================================================
Example1----------------搜索e盘的new文件夹下的所有txt文本文件，包括子目录
============================================================================================
Dim $get[1]
_Find("E:\new", ".txt", 1,$get)
_ArrayDisplay($get)
============================================================================================
============================================================================================
Example2----------------搜索e盘的new文件夹下的所有txt文本文件，不包括子目录
============================================================================================
Dim $get[1]
_Find("E:\new", ".txt", 0,$get)
_ArrayDisplay($get)
============================================================================================
#ce
 
Func _Find($path, $type, $flag,ByRef $result)
        $FileList = _FileListToArray($path)
        If Not @error Then
                For $i = 1 To $FileList[0] Step 1
                        If StringRight($FileList[$i],4)=$type then
                                _ArrayAdd($result,$path & "\" & $FileList[$i])
                                $result[0]=UBound($result)-1
                        Else
                                If $flag == 1 Then
                                        _Find($path & "\" & $FileList[$i], $type, $flag,$result)
                                EndIf
                        EndIf
                Next
        EndIf
EndFunc   ;==>_Find
