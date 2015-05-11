#cs ----------------------------------------------------------------------------
 AutoIt Version: 3.3.12.0
 Author:         蒋明
 Script Function:
	把华军待审核页面的软件名称加入待审列表 把华军审核通过的加入审核通过列表
#ce ----------------------------------------------------------------------------
#include <IE.au3>
#include "mysql.au3"
;user.newhua.com/?action=list&perpage=2500&type=0
_MySQL_InitLibrary()
$MysqlConn = _MySQL_Init()
$connected = _MySQL_Real_Connect($MysqlConn,"sql.caiwuhao.com","php","jmdjsj903291A","yourphp_www")
_MySQL_Set_Character_Set($MysqlConn, "GBK")
;数据库为utf8 好像au3必须设置为gbk
$sdaisheng_html=gethtml("user.newhua.com/?action=list&perpage=2500&type=0")
$sdaisheng_txt=gettxt("user.newhua.com/?action=list&perpage=2500&type=0")
$sstart=StringInStr($sdaisheng_html,"操作")
$sdaisheng_html=Stringmid($sdaisheng_html,$sstart,Stringlen($sdaisheng_html))
$sdaisheng_html = StringReplace($sdaisheng_html, Chr(13)&chr(10), "")
$sdaisheng_html = StringReplace($sdaisheng_html, "操作", "编辑")

$aArray = StringRegExp($sdaisheng_html,"<TBODY><TR>.+?"">(.+?)&nbsp.+?</A></TD",3)
;查询预审查的软件名称
For $i = 0 To UBound($aArray) - 1
 $ssoftname=$aArray[$i]
 $sMySqlStatement="update `yourphp_softname` set hua=1 WHERE title = '"&$ssoftname&"';"
   ;必须查询语句长度*2 gbk为英文字符的2倍
   	  ConsoleWrite ($sMySqlStatement&@CRLF)
   If _MySQL_Real_Query($MysqlConn,$sMySqlStatement,StringLen($sMySqlStatement) * 2) <> $MYSQL_SUCCESS Then
	  ConsoleWrite ($sMySqlStatement&@CRLF)
   EndIf
Next
exit

while Stringlen($ssoftname)>2
   $sstart=StringInStr($sdaisheng_html,"编辑")
   $s1start=StringInStr($sdaisheng_txt,"<td><a href=""./?action=editsoft&amp;type=1&amp;slanguage=cn&amp;id=")
   $sdaisheng_html=Stringmid($sdaisheng_html,$sstart+2,Stringlen($sdaisheng_html))
   ;截取
   $sdaisheng_txt=Stringmid($sdaisheng_txt,$s1start+67,Stringlen($sdaisheng_txt))
   ;获取软件名的结尾 以 为边界
   $send=StringInStr($sdaisheng_html," ")
   $ssoftname=Stringmid($sdaisheng_html,1, $send-1)
   ;查询到软件名后把txt文本截断到软件名后
   $s=Stringmid($sdaisheng_html,$send,Stringlen($sdaisheng_html))

$sMySqlStatement="update `yourphp_softname` set hua=1 WHERE title = '"&$ssoftname&"';"
   ;必须查询语句长度*2 gbk为英文字符的2倍
   If _MySQL_Real_Query($MysqlConn,$sMySqlStatement,StringLen($sMySqlStatement) * 2) <> $MYSQL_SUCCESS Then
	  ConsoleWrite ($sMySqlStatement&@CRLF)
   EndIf
   $sMySqlStatement="update `yourphp_softname` set hua=1 WHERE title = '"&StringReplace($ssoftname,"旅贸通","")&"';"
   ;必须查询语句长度*2 gbk为英文字符的2倍
   If _MySQL_Real_Query($MysqlConn,$sMySqlStatement,StringLen($sMySqlStatement) * 2) <> $MYSQL_SUCCESS Then
   EndIf
   $sMySqlStatement="update `yourphp_softname` set hua=1 WHERE title = '"&StringReplace($ssoftname,"管家婆","")&"';"
   If _MySQL_Real_Query($MysqlConn,$sMySqlStatement,StringLen($sMySqlStatement) * 2) <> $MYSQL_SUCCESS Then
   EndIf
WEnd


$s=gethtml("user.newhua.com/?action=list&perpage=2500&type=0")
$s1=gettxt("user.newhua.com/?action=list&perpage=2500&type=0")
$sstart=StringInStr($s,"操作")
$s=Stringmid($s,$sstart,Stringlen($s))
$s = StringReplace($s, Chr(13)&chr(10), "")
$s = StringReplace($s, "操作", "更新")
$ssoftname="aaaa"
while Stringlen($ssoftname)>2
   $sstart=StringInStr($s,"更新")
   $s1start=StringInStr($s1,"<td><a href=""./?action=editsoft&amp;type=1&amp;slanguage=cn&amp;id=")
   $s=Stringmid($s,$sstart+2,Stringlen($s))
   ;截取
   $s1=Stringmid($s1,$s1start+67,Stringlen($s1))
   ;获取软件名的结尾 以 为边界
   $send=StringInStr($s," ")
   $ssoftname=Stringmid($s,1, $send-1)
   ;查询到软件名后把txt文本截断到软件名后
   $s=Stringmid($s,$send,Stringlen($s))
   ;获取id长度
   $s1end=StringInStr($s1,""">")
   $ssoftnameid=Stringmid($s1,1, $s1end-1)
   ;获取软件id
   $sMySqlStatement="update `yourphp_softname` set hua="&$ssoftnameid&" WHERE title = '"&$ssoftname&"';"
   ;必须查询语句长度*2 gbk为英文字符的2倍
   If _MySQL_Real_Query($MysqlConn,$sMySqlStatement,StringLen($sMySqlStatement) * 2) <> $MYSQL_SUCCESS Then
	  	  ;ConsoleWrite ($sMySqlStatement&@CRLF)
   EndIf
   $sMySqlStatement="update `yourphp_softname` set hua="&$ssoftnameid&" WHERE title = '"&StringReplace($ssoftname,"旅贸通","")&"';"
   ;必须查询语句长度*2 gbk为英文字符的2倍
   If _MySQL_Real_Query($MysqlConn,$sMySqlStatement,StringLen($sMySqlStatement) * 2) <> $MYSQL_SUCCESS Then
   EndIf
   $sMySqlStatement="update `yourphp_softname` set hua="&$ssoftnameid&" WHERE title = '"&StringReplace($ssoftname,"管家婆","")&"';"
   If _MySQL_Real_Query($MysqlConn,$sMySqlStatement,StringLen($sMySqlStatement) * 2) <> $MYSQL_SUCCESS Then
   EndIf
WEnd
_MySQL_Close($MysqlConn)
_MySQL_EndLibrary()
Func gethtml($url)
$oIE = _IEcreate($url)
_IELoadWait($oie)
$s=_IEBodyReadhtml($oie)
_IEQuit($oie)
Return $s

;~ 	  $oHTTP=ObjCreate("microsoft.xmlhttp")
;~ 	  $oHTTP.Open("get",$url,false)
;~ 	  $oHTTP.Send()
;~ 	  Return $oHTTP.responseText
EndFunc 
Func gettxt($url)
$oIE = _IEcreate($url)
_IELoadWait($oie)
$s=_IEBodyReadtext($oie)
_IEQuit($oie)
Return $s
;~ 	  $oHTTP=ObjCreate("microsoft.xmlhttp")
;~ 	  $oHTTP.Open("get",$url,false)
;~ 	  $oHTTP.Send()
;~ 	  Return $oHTTP.responseText
EndFunc 