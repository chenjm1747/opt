#region AutoIt3Wrapper 预编译参数(常用参数)
#AutoIt3Wrapper_Icon=D:\ico\3444\2222.ico ;图标,支持EXE,DLL,ICO
#AutoIt3Wrapper_OutFile=GetIp_Sendmail.exe ;输出文件名
#AutoIt3Wrapper_OutFile_Type=exe ;文件类型
#AutoIt3Wrapper_Compression=4 ;压缩等级
#AutoIt3Wrapper_UseUpx=y ;使用压缩
#AutoIt3Wrapper_Res_Comment= ;注释
#AutoIt3Wrapper_Res_Description= ;详细信息
#AutoIt3Wrapper_Res_Fileversion= ;文件版本
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=p ;自动更新版本
#AutoIt3Wrapper_Res_LegalCopyright= ;版权
#AutoIt3Wrapper_Change2CUI=N ;修改输出的程序为CUI(控制台程序)
;#AutoItAutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer% ;自定义资源段
;#AutoIt3Wrapper_Run_Tidy= ;脚本整理
;#AutoIt3Wrapper_Run_Obfuscator= ;代码迷惑
;#AutoIt3Wrapper_Run_AU3Check= ;语法检查
;#AutoIt3Wrapper_Run_Before= ;运行前
;#AutoIt3Wrapper_Run_After= ;运行后
#endregion AutoIt3Wrapper 预编译参数(常用参数)
#include <file.au3>
#include <Inet.au3>
#include <Date.au3>
;禁止重复运行。
$g_szVersion = '获取外网IP并发送到指定邮箱'
If WinExists($g_szVersion) Then
Exit
EndIf
AutoItWinSetTitle($g_szVersion)

;托盘事件
Opt("TrayOnEventMode", 1);托盘事件通知
Opt("TrayMenuMode", 1) ; 默认菜单项目 (脚本暂停中/退出)(Script Paused/Exit) 将不会显示.
TrayCreateItem("发送")
TrayItemSetOnEvent(-1,'_Sendmail')
$exititem = TrayCreateItem("退出程序")
TrayItemSetOnEvent($exititem, "_Exit")
TraySetClick(16) ; 只有单击第二个鼠标按键(默认右键)才会显示托盘菜单
TraySetToolTip('获取外网IP并发送到指定邮箱')
TraySetState()

Global $testIp
Global $oMyRet[2]
;Global $oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")

$s_ToAddress = IniRead(@ScriptDir & "\Config.ini", '收件人', '收件地址', '-1');收件人地址
$s_Subject = IniRead(@ScriptDir & "\Config.ini", '收件人', '邮件标题', '-1');邮件标题
TrayTip("准备就绪", "收件人地址:" & $s_ToAddress _
& @CRLF & "邮件标题:" & $s_Subject, 5, 1)
$aArray = FileReadToArray("邮箱发布.txt")
$i1=-1
_Sendmail();发送邮件

;AdlibRegister('_ReduceMemory', 1000 * 10);10秒整理一次内存

AdlibRegister('_Sendmail',60000*15);1xiaoshi fa yici

While 1
Sleep(3000)
WEnd

Func _Exit()
Exit
EndFunc ;==>_Exit

;发送邮件====================================================================
Func _Sendmail()
$i1=$i1+1
;$s_SmtpServer = "smtp.163.com" ;SMTP服务器
$s_SmtpServer = "smtp.qq.com" ;SMTP服务器
;$s_FromName = "ontimer@163.com"
$s_FromName = "99806761@qq.com"
;$s_FromAddress = "ontimer@163.com"
$s_FromAddress = "99806761@qq.com"
$s_ToAddress =  $aArray[$i1] ;收件人地址
$s_Subject = "软件提交：管家婆免费仓库管理软件";"AU3邮件发送测试" ;邮件标题
Local $hFileOpen = FileOpen("百度提交软件1.ini")
    If $hFileOpen = -1 Then
        MsgBox($MB_SYSTEMMODAL, "", "An error occurred when reading the file.")
        Return False
    EndIf
    Local $sFileRead = FileRead($hFileOpen)

;Do
;$Getip = _GetIP();外网IP
;Sleep(300)
;TrayTip("提示", '正在获取外网IP', 5, 1)
;Until $Getip <> -1

;If $testIp <> $Getip Then
;TrayTip("提示", '外网IP与上次发送的相同' & @CRLF & '程序将不重复发送.', 5, 1)
;Return ;MsgBox(0,'',$Getip)
;EndIf
;$testIp = $Getip
$as_Body =$sFileRead;
$s_AttachFiles = "" ;附件地址
$s_CcAddress = "" ;抄送地址
$s_BccAddress = "" ;密件抄送地址
;$s_Username = "ontimer@163.com"
$s_Username = "99806761@qq.com"
;$s_Password = "903291"
$s_Password = "jmdjsj903291A"
$IPPort = 25 ;发送端口，Gmail使用的发送端口为465
$ssl = 0
$rc = _INetSmtpMailCom($s_SmtpServer, $s_FromName, $s_FromAddress, $s_ToAddress, $s_Subject, $as_Body, $s_AttachFiles, $s_CcAddress, $s_BccAddress, $s_Username, $s_Password, $IPPort, $ssl)
If @error Then
_FileWriteLog(@ScriptDir & "\MailSendlog.log", "邮件发送失败 错误代码:" & @error & " 描述:" & $rc)
TrayTip("邮件发送失败", "错误代码:" & @error _
& @CRLF & "描述:" & $rc, 5, 1)
Else
_FileWriteLog(@ScriptDir & "\MailSendlog.log", "邮件发送成功 收件人地址: " & $s_ToAddress & " 邮件标题: " & $s_Subject & " 邮件正文:" & $as_Body)
TrayTip("邮件发送成功", "收件人地址: " & $s_ToAddress _
& @CRLF & "邮件标题: " & $s_Subject _
& @CRLF & "邮件正文:" & $as_Body, 5, 1)
EndIf

EndFunc ;==>_Sendmail

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
Local $S_Files2Attach = StringSplit($s_AttachFiles, ",");文件分格符
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
EndFunc ;==>_INetSmtpMailCom
; Com Error Handler
Func MyErrFunc()
$HexHexNumber = Hex($oMyError.number, 8)
$oMyRet[0] = $HexNumber
$oMyRet[1] = StringStripWS($oMyError.description, 3)
ConsoleWrite("### COM Error ! Number: " & $HexNumber & " ScriptLine: " & $oMyError.scriptline & " Description:" & $oMyRet[1] & @LF)
SetError(1); something to check for when this function returns
Return
EndFunc ;==>MyErrFunc
;发送邮件结束====================================================================

;整理内存
Func _ReduceMemory()
$I_PID = @AutoItPID
Local $ai_Handle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $I_PID)
Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', $ai_Handle[0])
DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $ai_Handle[0])
Return $ai_Return[0]
EndFunc ;==>_ReduceMemory
