#NoTrayIcon
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=Dmail.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Res_Comment=www.duxt.net
#AutoIt3Wrapper_Res_Description=www.duxt.net
#AutoIt3Wrapper_Res_Fileversion=0.0.0.10
#AutoIt3Wrapper_Res_LegalCopyright=duxt
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#Region AutoIt3Wrapper 预编译参数(常用参数)
;#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%		;自定义资源段
;#AutoIt3Wrapper_Run_Tidy=                   				;脚本整理
;#AutoIt3Wrapper_Run_Obfuscator=      						;代码迷惑
;#AutoIt3Wrapper_Run_AU3Check= 								;语法检查
;#AutoIt3Wrapper_Run_Before= 								;运行前
;#AutoIt3Wrapper_Run_After=									;运行后
#EndRegion AutoIt3Wrapper 预编译参数(常用参数)
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

	Au3 版本: 3.xxx
	脚本作者: duxt
	Email: 37361025@qq.com
	QQ/TM: 37361025
	脚本版本: 1.0
	脚本功能: 解放你的双手

#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
#include <Constants.au3>
#include <file.au3>

;Opt("TrayAutoPause", 0) ;单击图标不暂停
Opt("TrayIconHide", 1) ;隐藏托盘图标
;Opt("WinDetectHiddenText", 1) ;检测隐藏窗口
;Opt("WinSearchChildren", 1) ;搜索子窗口
Opt("WinTitleMatchMode", 2) ;匹配标题任意位置
;Opt("TrayMenuMode", 1) ; 删除默认菜单项目 (脚本暂停/退出)
;Opt("TrayOnEventMode", 1) ;开启托盘图标事件


;____________________________________________________________________________
; DOS 窗口输出
;ConsoleWrite("This is to test the command line output")
;_____________________________________________________________________________


;初始化变量

Global $oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")
$s_SmtpServer = "smtp.qq.com" ; smtp服务器
$s_FromName = "ontimer1" ;@ComputerName    ; 邮件发送人
$s_FromAddress = "ontimer1@qq.com" ;    邮件发送者地址
$s_ToAddress = "ontimer1@kindle.cn" ; 邮件接收地址
$s_Subject = "测试" ;邮件标题
$as_Body = "test"   ;邮件内容
$s_AttachFiles = "" ;@MON & @MDAY  & "raid.jpg"    ; 附件地址
$s_CcAddress = "" ; address for cc - leave blank if not needed
$s_BccAddress = "" ; address for bcc - leave blank if not needed
$s_Username = "2100803@qq.com" ; 用户名
$s_Password = "opewoqqq" ; 密码
$IPPort = 25 ; 发送端口
$ssl = 0 ; 安全连接

;判断变量信息

;If Not StringRegExp($CmdLineRaw, '-[s]', 0) Then help()
$cmds = $CmdLine[0]
$i = 1
While $i <= $cmds
	$p = $CmdLine[$i]
	Select
		Case StringInStr($p, "-smtp")
			$i = $i + 1
			If $cmds < $i Then help()
			$s_SmtpServer = $CmdLine[$i]
		Case StringInStr($p, "-name")
			$i = $i + 1
			If $cmds < $i Then help()
			$s_FromName = $CmdLine[$i]
		Case StringInStr($p, "-from")
			$i = $i + 1
			If $cmds < $i Then help()
			$s_FromAddress = $CmdLine[$i]
		Case StringInStr($p, "-to")
			$i = $i + 1
			If $cmds < $i Then help()
			$s_ToAddress = $CmdLine[$i]
		Case StringInStr($p, "-subject")
			$i = $i + 1
			If $cmds < $i Then help()
			$s_Subject = $CmdLine[$i]
		Case StringInStr($p, "-body")
			$i = $i + 1
			If $cmds < $i Then help()
			$as_Body = $CmdLine[$i]
		Case StringInStr($p, "-file")
			$i = $i + 1
			If $cmds < $i Then help()
			$s_AttachFiles= $CmdLine[$i]
		Case StringInStr($p, "-user")
			$i = $i + 1
			If $cmds < $i Then help()
			$s_Username = $CmdLine[$i]
		Case StringInStr($p, "-pass")
			$i = $i + 1
			If $cmds < $i Then help()
			$s_Password = $CmdLine[$i]
		Case Else
			;$filename = $CmdLine[$CmdLine[0]]
			;$i = $i + 1
			help()
		;	ExitLoop
	EndSelect
	$i = $i + 1
WEnd

;执行程序
Global $oMyRet[2]

$rc = _INetSmtpMailCom($s_SmtpServer, $s_FromName, $s_FromAddress, $s_ToAddress, $s_Subject, $as_Body, $s_AttachFiles, $s_CcAddress, $s_BccAddress, $s_Username, $s_Password, $IPPort, $ssl)


;文件帮助信息
Func help()
    MsgBox(0,0,0)
	ConsoleWrite(@ScriptName & " <-Smtp SmtpServer> <-Name FromName> <-From FromAddress> <-To ToAddress> <-Subject Subject> <-Body Body> <-User Username> <-Pass Password>" & @CRLF)
	;ConsoleWrite("-c 改变文件创建时间" & @CRLF)
	;ConsoleWrite("-m 改变文件修改时间" & @CRLF)
	;ConsoleWrite("例." & @CRLF)
	;ConsoleWrite(@ScriptName & " -c 20090814 readme.txt" & @CRLF)
	;ConsoleWrite(@ScriptName & " -c 20101001155801 readme.txt" & @CRLF)
	;ConsoleWrite(@ScriptName & " -c 20090814 -m 20101001155801 readme.txt" & @CRLF)
	Exit
EndFunc   ;==>help


;#######################################################################################################################################
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

;邮件发送函数
Func _INetSmtpMailCom($s_SmtpServer, $s_FromName, $s_FromAddress, $s_ToAddress, $s_Subject = "", $as_Body = "", $s_AttachFiles = "", $s_CcAddress = "", $s_BccAddress = "", $s_Username = "", $s_Password = "", $IPPort = 25, $ssl = 0)
	$objEmail = ObjCreate("CDO.Message")
	$objEmail.From = '"' & $s_FromName & '" <' & $s_FromAddress & '>'
	$objEmail.To = $s_ToAddress
	Local $i_Error = 0
	Local $i_Error_desciption = ""
	If $s_CcAddress <> "" Then $objEmail.Cc = $s_CcAddress
	If $s_BccAddress <> "" Then $objEmail.Bcc = $s_BccAddress
	$objEmail.Subject = $s_Subject
	If StringInStr($as_Body, "<") And StringInStr($as_Body, ">") Then
		$objEmail.HTMLBody = $as_Body
	Else
		$objEmail.Textbody = $as_Body & @CRLF
	EndIf
	If $s_AttachFiles <> "" Then
		Local $S_Files2Attach = StringSplit($s_AttachFiles, ";")
		For $x = 1 To $S_Files2Attach[0]
			$S_Files2Attach[$x] = _PathFull($S_Files2Attach[$x])
			If FileExists($S_Files2Attach[$x]) Then
				$objEmail.AddAttachment($S_Files2Attach[$x])
			Else
				$i_Error_desciption = $i_Error_desciption & @LF & 'File not found to attach: ' & $S_Files2Attach[$x]
				SetError(1)
				Return 0
			EndIf
		Next
	EndIf
	$objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
	$objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = $s_SmtpServer
	$objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = $IPPort
	;Authenticated SMTP
	If $s_Username <> "" Then
		$objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
		$objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = $s_Username
		$objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = $s_Password
	EndIf
	If $ssl Then
		$objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True
	EndIf
	;Update settings
	$objEmail.Configuration.Fields.Update
	; Sent the Message
	$objEmail.Send
	If @error Then
		SetError(2)
		Return $oMyRet[1]
	EndIf
EndFunc   ;==>_INetSmtpMailCom

Func MyErrFunc()
	$HexNumber = Hex($oMyError.number, 8)
	$oMyRet[0] = $HexNumber
	$oMyRet[1] = StringStripWS($oMyError.description, 3)
	ConsoleWrite("### COM Error !    Number: " & $HexNumber & "    ScriptLine: " & $oMyError.scriptline & "    Description:" & $oMyRet[1] & @LF)
	$errors = "### COM Error !    Number: " & $HexNumber & "    ScriptLine: " & $oMyError.scriptline & "    Description:" & $oMyRet[1] & @LF
	SetError(1); something to check for when this function returns
	Return
EndFunc   ;==>MyErrFunc
