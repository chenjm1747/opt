#NoTrayIcon
#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=Dmail.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Res_Comment=www.duxt.net
#AutoIt3Wrapper_Res_Description=www.duxt.net
#AutoIt3Wrapper_Res_Fileversion=0.0.0.10
#AutoIt3Wrapper_Res_LegalCopyright=duxt
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#Region AutoIt3Wrapper Ԥ�������(���ò���)
;#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%		;�Զ�����Դ��
;#AutoIt3Wrapper_Run_Tidy=                   				;�ű�����
;#AutoIt3Wrapper_Run_Obfuscator=      						;�����Ի�
;#AutoIt3Wrapper_Run_AU3Check= 								;�﷨���
;#AutoIt3Wrapper_Run_Before= 								;����ǰ
;#AutoIt3Wrapper_Run_After=									;���к�
#EndRegion AutoIt3Wrapper Ԥ�������(���ò���)
#cs �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ�

	Au3 �汾: 3.xxx
	�ű�����: duxt
	Email: 37361025@qq.com
	QQ/TM: 37361025
	�ű��汾: 1.0
	�ű�����: ������˫��

#ce �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣ߽ű���ʼ�ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ�
#include <Constants.au3>
#include <file.au3>

;Opt("TrayAutoPause", 0) ;����ͼ�겻��ͣ
Opt("TrayIconHide", 1) ;��������ͼ��
;Opt("WinDetectHiddenText", 1) ;������ش���
;Opt("WinSearchChildren", 1) ;�����Ӵ���
Opt("WinTitleMatchMode", 2) ;ƥ���������λ��
;Opt("TrayMenuMode", 1) ; ɾ��Ĭ�ϲ˵���Ŀ (�ű���ͣ/�˳�)
;Opt("TrayOnEventMode", 1) ;��������ͼ���¼�


;____________________________________________________________________________
; DOS �������
;ConsoleWrite("This is to test the command line output")
;_____________________________________________________________________________


;��ʼ������

Global $oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")
$s_SmtpServer = "smtp.qq.com" ; smtp������
$s_FromName = "ontimer1" ;@ComputerName    ; �ʼ�������
$s_FromAddress = "ontimer1@qq.com" ;    �ʼ������ߵ�ַ
$s_ToAddress = "ontimer1@kindle.cn" ; �ʼ����յ�ַ
$s_Subject = "����" ;�ʼ�����
$as_Body = "test"   ;�ʼ�����
$s_AttachFiles = "" ;@MON & @MDAY  & "raid.jpg"    ; ������ַ
$s_CcAddress = "" ; address for cc - leave blank if not needed
$s_BccAddress = "" ; address for bcc - leave blank if not needed
$s_Username = "2100803@qq.com" ; �û���
$s_Password = "opewoqqq" ; ����
$IPPort = 25 ; ���Ͷ˿�
$ssl = 0 ; ��ȫ����

;�жϱ�����Ϣ

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

;ִ�г���
Global $oMyRet[2]

$rc = _INetSmtpMailCom($s_SmtpServer, $s_FromName, $s_FromAddress, $s_ToAddress, $s_Subject, $as_Body, $s_AttachFiles, $s_CcAddress, $s_BccAddress, $s_Username, $s_Password, $IPPort, $ssl)


;�ļ�������Ϣ
Func help()
    MsgBox(0,0,0)
	ConsoleWrite(@ScriptName & " <-Smtp SmtpServer> <-Name FromName> <-From FromAddress> <-To ToAddress> <-Subject Subject> <-Body Body> <-User Username> <-Pass Password>" & @CRLF)
	;ConsoleWrite("-c �ı��ļ�����ʱ��" & @CRLF)
	;ConsoleWrite("-m �ı��ļ��޸�ʱ��" & @CRLF)
	;ConsoleWrite("��." & @CRLF)
	;ConsoleWrite(@ScriptName & " -c 20090814 readme.txt" & @CRLF)
	;ConsoleWrite(@ScriptName & " -c 20101001155801 readme.txt" & @CRLF)
	;ConsoleWrite(@ScriptName & " -c 20090814 -m 20101001155801 readme.txt" & @CRLF)
	Exit
EndFunc   ;==>help


;#######################################################################################################################################
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

;�ʼ����ͺ���
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
