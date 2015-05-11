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

#include <FTPEx.au3>
$FTP_Server = IniRead("x:\xms\config.txt", "TSPC_Checker_FTP", "SERVER", "unknow")
$user = IniRead("x:\xms\config.txt", "TSPC_Checker_FTP", "USERNAME", "unknow")
$Password = IniRead("x:\xms\config.txt", "TSPC_Checker_FTP", "PASSWORD", "unknow")
$FilePath = IniRead("x:\xms\config.txt", "TSPC_Checker_FTP", "FILE_PATH", "unknow")
$ret = _DownloadFileFromFTP($FTP_Server, $user, $Password, $FilePath, @ScriptName)
If Not @error Then MsgBox(0,0,"Download success")
                                
Func _DownloadFileFromFTP($iIP, $iUsername, $iPassword, $iFilePath, $iFilename)
        Local $Open = _FTP_Open('MyFTP Control')
        Local $Conn = _FTP_Connect($Open, $iIP, $iUsername, $iPassword, 0, "21")
 
        If $Conn Then
                $File_Get = _FTP_FileGet($Conn, $iFilePath & "\" & $iFilename, @ScriptDir & "\updated.exe")
                If Not @error Then
                        Return 1 ;下载成功
                Else
                        Return SetError(-1, -1, 0) ;下载失败
                EndIf
                _FTP_Close($Conn)
        Else
                Return SetError(-1, -1, -1) ;FTP连接失败,返回值为-1，并设置Error为-1
        EndIf
 
EndFunc   ;==>_DownloadFileFromFTP