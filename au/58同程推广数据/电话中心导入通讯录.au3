#Include <Date.au3>
#include <IE.au3>
#include <Array.au3>
$file = FileOpen("old.txt", 0)
Local $filewrite = FileOpen("导入.csv", 2)
$s='姓名,移动电话1,移动电话2,办公电话1,办公电话2,分机号码,传真,家庭电话,MSN,QQ,Skype,电子邮件,主页,单位名称,部门职务,单位地址,单位邮编,家庭地址,家庭邮编,备注信息,####WJORGCLASSID####' 
FileWriteLine($filewrite,$s)
While 1
	$companyname = FileReadLine($file)
	$no = FileReadLine($file)
	$name = FileReadLine($file)
	$tel = FileReadLine($file)
	$stel=""
	If StringLen($tel)>10 Then
		$atel = StringRegExp($tel, '(\d{1,15})', 3)
		For $i = 0 To UBound($atel) - 1
			$stel=$atel[$i]
		Next
	endif
	$line= FileReadLine($file)
	$addr= FileReadLine($file)
	$addr1= FileReadLine($file)
			If @error = -1 Then ExitLoop
	$stel=""
	If StringLen($line)>10 Then
	$aReg = StringRegExp($line, '(1\d{10})', 3)
		For $i = 0 To UBound($areg) - 1
			$sreg=$areg[$i]
		Next
	endif

	FileWriteLine($filewrite,$name&','&$sreg&',,,,,,,,,,,,,,,,,,,0')
Wend
FileClose($filewrite)
FileClose($file)




