#Include <Date.au3>
#include <IE.au3>
#include <Array.au3>
$file = FileOpen("old.txt", 0)
Local $filewrite = FileOpen("����.csv", 2)
$s='����,�ƶ��绰1,�ƶ��绰2,�칫�绰1,�칫�绰2,�ֻ�����,����,��ͥ�绰,MSN,QQ,Skype,�����ʼ�,��ҳ,��λ����,����ְ��,��λ��ַ,��λ�ʱ�,��ͥ��ַ,��ͥ�ʱ�,��ע��Ϣ,####WJORGCLASSID####' 
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




