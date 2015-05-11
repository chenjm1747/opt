#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <IE.au3>
#include <MsgBoxConstants.au3>
;Local $oIE1 = _IECreate("http://www.onlinedown.net/softdown/151968_2.htm")
$hFileOpen = FileOpen("log.txt", $FO_APPEND)
;$oie=_IECreate("http://www.33lc.com/api.php?op=count&id=24250&modelid=2")
for $i=1 to 999999999
;RunWait('rasdial /d')
;runwait('rasdial adsl 057105858542 909188 /phonebook:c:\rasphone.pbk')
;xdown评论action=ok&n=%C2%CC%C3%CB%CD%F8%D3%D1&t=undefined&m=%CE%D2%C3%C7%B9%AB%CB%BE%D3%C3%C1%CB%D2%BB%C4%EA%B6%E0%C1%CB%20%D5%CB%C4%BF%C7%E5%CE%FA%C1%CB%BA%DC%B6%E0&id=107801&CodeStr=1234
;http://c.236.xdowns.com/c/commentnew.asp?action=ok&n=%C2%CC%C3%CB%CD%F8%D3%D1&t=undefined&m=%CE%D2%C3%C7%B9%AB%CB%BE%D3%C3%C1%CB%D2%BB%C4%EA%B6%E0%C1%CB%20%D5%CB%C4%BF%C7%E5%CE%FA%C1%CB%BA%DC%B6%E0&id=107801&CodeStr=1234
;Referer:http://c.236.xdowns.com/c/pinglunnew.html?id=107801
;键	值
;http://www.9553.com/api.php?op=count&id=26193&modelid=12

;_IENavigate($oie,"http://www.9553.com/api.php?op=count&id=26193&modelid=12")
;send("{f5}")
;_IENavigate($oie,"http://www.3987.com/api.php?op=count&id=37398&modelid=2")

$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://count.crsky.com/tools/DownCount.ashx?id=28938",false)
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Accept-Encoding","gzip,deflate,sdch")
$oHTTP.setRequestHeader("Accept-Language", "zh-CN,zh;q=0.8")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.setRequestHeader("DNT","1")
$oHTTP.setRequestHeader("Cookie","DownCount28938=28938; DownRate28938=0%7c0")
$oHTTP.setRequestHeader("Host","count.crsky.com")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Referer","http://www.crsky.com/soft/28938.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")
$oHTTP=0
#cs

$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.pc6.com/down.asp?id=36111",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Accept-Encoding","gzip,deflate,sdch")
$oHTTP.setRequestHeader("Accept-Language", "zh-CN,zh;q=0.8")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.setRequestHeader("DNT","1")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Host","www.pc6.com")
$oHTTP.setRequestHeader("Referer","http://www.pc6.com/softview/SoftView_98439.html")
$oHTTP.Send("")



$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("post","http://www.pc6.com/ajax.asp",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Accept-Encoding","gzip,deflate,sdch")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("DNT", "1")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("Content-Length","39")
$oHTTP.setRequestHeader("Host","www.pc6.com")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Origin", "http://www.pc6.com")
$oHTTP.setRequestHeader("Referer","http://www.pc6.com/softview/SoftView_98439.html")
$oHTTP.Send("Action=6&softid=98439&SoftLinkID=149646")

$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","/ex?i=mm_16135210_3478841_13170662&cb=jsonp_callback_76477&callback=&userid=&o=&f=&n=&re=1920x1080&r=http%3A%2F%2Fsearch.crsky.com%2Fsearch.aspx%3Fkeyword%3D%25B9%25DC%25BC%25D2%25C6%25C5%26sType%3Dall&cah=1040&caw=1920&ccd=32&ctz=8&chl=0&cja=1&cpl=0&cmm=0&cf=10.0&cg=ab3591b816b3842e063b3765a06a3cc0&pvid=a9a65ccdd5d03d9bb6e550acd5f180a0&ai=0&ac=4549&prl=123174922&cas=prl&cbh=445&cbw=1879&dx=1&u=http%3A%2F%2Fwww.crsky.com%2Fsoft%2F28938.html&k=%25B9%25DC%25BC%25D2%25C6%25C5&tt=%E5%85%8D%E8%B4%B9%E4%BB%93%E5%BA%93%E7%AE%A1%E7%90%86%E8%BD%AF%E4%BB%B6%7C%E7%AE%A1%E5%AE%B6%E5%A9%86%E5%85%8D%E8%B4%B9%E4%BB%93%E5%BA%93%E7%AE%A1%E7%90%86%E8%BD%AF%E4%BB%B6%20v5.2.1%E4%B8%8B%E8%BD%BD_%E9%9D%9E%E5%87%A1%E8%BD%AF%E4%BB%B6%E7%AB%99",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("Host","count.crsky.com")
$oHTTP.setRequestHeader("Referer","http://www.crsky.com/soft/70056.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")


$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.9553.com/api.php?op=count&id=26193&modelid=12",false)
$oHTTP.setRequestHeader("Accept", "application/javascript, */*;q=0.8")
$oHTTP.setRequestHeader("Referer","http://www.9553.com/soft/26193.htm")
$oHTTP.setRequestHeader("Accept-Language", "zh-CN")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.setRequestHeader("Accept-Encoding","gzip, deflate")
$oHTTP.setRequestHeader("Host","www.9553.com")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.Send("")
;绿茶刷量http://www.33lc.com/api.php?op=count&id=24250&modelid=2
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.33lc.com/api.php?op=count&id=24250&modelid=2",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.33lc.com")
$oHTTP.setRequestHeader("Referer","http://www.33lc.com/soft/24250.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")

;http://www.3987.com/api.php?op=count&id=37398&modelid=2
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.3987.com/api.php?op=count&id=37398&modelid=2",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.3987.com")
$oHTTP.setRequestHeader("Referer","http://www.3987.com/xiazai/2/60/61/37398.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")

$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("post","http://www.qqtn.com/ajax.asp",false)
$oHTTP.setRequestHeader("Accept-Encoding", "gzip,deflate,sdch")
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Content-Type","Content-Type	application/x-www-form-urlencoded; charset=UTF-8")
$oHTTP.setRequestHeader("Host","www.qqtn.com")
$oHTTP.setRequestHeader("Referer","http://www.qqtn.com/down/47751.html")
$oHTTP.setRequestHeader("X-Requested-With","XMLHttpRequest")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("action=3&id=47751&num=1&type=soft")


$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.cnd8.com/inc/soft_vote.php?vote=1&id=10244",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.cnd8.com")
$oHTTP.setRequestHeader("Referer","http://www.cnd8.com/soft/10244.htm")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")

;http://www.downbank.cn/soft/download.asp?softid=57222&downid=21&id=68157
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.downbank.cn/soft/download.asp?softid=57222&downid=21&id=68157",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.downbank.cn")
$oHTTP.setRequestHeader("Referer","http://www.downbank.cn/s/57222.htm")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")

;http://www.downyi.com/Download.asp?ID=33639&sID=0
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.downyi.com/Download.asp?ID=33639&sID=0",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.downyi.com")
$oHTTP.setRequestHeader("Referer","http://www.downyi.com/downinfo/33176.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")


$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.wmzhe.com/plus/download.php?open=2&id=7988&uhash=6ebd1c37fc41decb47a75dad",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.wmzhe.com")
$oHTTP.setRequestHeader("Referer","http://www.wmzhe.com/soft-7988.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")

;刷量15非凡http://www.crsky.com/soft/70056.html
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://count.crsky.com/code.aspx",false)
$oHTTP.setRequestHeader("Accept", "image/webp,*/*;q=0.8")
$oHTTP.setRequestHeader("Accept-Encoding", "gzip,deflate,sdch")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("Host","count.crsky.com")
$oHTTP.setRequestHeader("Cookie","selectval=all; DownCount70056=70056; DownRate70056=0%7c0; ASP.NET_SessionId=wi325355piz1ygb10sidtnbv")
$oHTTP.setRequestHeader("Referer","http://www.crsky.com/soft/70056.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")


;投票
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.bkill.com/d/axaj.php?mod=downvote&n=1&id=32728&poll=1",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.bkill.com")
$oHTTP.setRequestHeader("Referer","http://www.bkill.com/download/32746.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")


$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.bkill.com/d/dl.php?n=1&server=1&id=32746::1402479044",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.bkill.com")
$oHTTP.setRequestHeader("Referer","http://www.bkill.com/download/32746.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")

$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://count.ddooo.com/redirect.asp?downurl=http://soft.ddooo.com/gjpmfckglrj_47582.rar",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.ddooo.com")
$oHTTP.setRequestHeader("Referer","http://www.ddooo.com/softdown/47582.htm")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")
;http://www.9553.com/api.php?op=count&id=26193&modelid=12
;action=18&CommentTpye=0&sendid=170350
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("post","http://www.uzzf.com/ajax.asp",false)
$oHTTP.setRequestHeader("Accept-Encoding", "gzip,deflate,sdch")
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("Host","www.uzzf.com")
$oHTTP.setRequestHeader("Origin","http://www.uzzf.com")
$oHTTP.setRequestHeader("Referer","http://www.uzzf.com/soft/73275.html")
$oHTTP.setRequestHeader("X-Requested-With","XMLHttpRequest")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("action=18&CommentTpye=0&sendid=170350")

;下载http://www.huacolor.com/soft/download.asp?softid=78375&downid=47&id=78726
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.huacolor.com/soft/download.asp?softid=78375&downid=47&id=78726",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.huacolor.com")
$oHTTP.setRequestHeader("Referer","http://www.huacolor.com/soft/78375.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.huacolor.com/soft/ajaxpost.asp?id=78375&t=1&m=130&s=0",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.huacolor.com")
$oHTTP.setRequestHeader("Referer","http://www.huacolor.com/soft/78375.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")

;赞http://www.52z.com/soft/softvote
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("post","http://www.52z.com/soft/softvote",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.52z.com")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8")
$oHTTP.setRequestHeader("Referer","http://www.52z.com/soft/95770.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("id=95770&type=1&votenum=4&typeid=1")

;pingjiahttp://www.gezila.com/?ac=download&sid=1&url=soft/224/gjpckglV5.21.zip
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("post","http://www.gezila.com/index.php?ac=ajax&ct=vote",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.gezila.com")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8")
$oHTTP.setRequestHeader("DNT","1")
$oHTTP.setRequestHeader("X-Requested-With","XMLHttpRequest")
$oHTTP.setRequestHeader("Referer","http://www.gezila.com/ruanjian/hangye/7224_34402.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("type=soft&id=7224&vote=1")

;刷量http://www.gezila.com/?ac=download&sid=1&url=soft/224/gjpckglV5.21.zip
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.gezila.com/?ac=download&sid=1&url=soft/224/gjpckglV5.21.zip",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.gezila.com")
$oHTTP.setRequestHeader("Referer","http://www.gezila.com/ruanjian/hangye/7224_34402.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")

;xdown刷量http://www.33lc.com/api.php?op=count&id=24250&modelid=2
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.xdowns.com/soft/xdowns2009.asp?softid=107801&down=0",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.xdowns.com")
$oHTTP.setRequestHeader("Referer","http://www.xdowns.com/soft/17/45/2013/Soft_107801.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")

;tiankong刷量http://www.33lc.com/api.php?op=count&id=24250&modelid=2
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.skycn.com/?m=downloader&id=23656",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Host","www.skycn.com")
$oHTTP.setRequestHeader("Referer","http://www.skycn.com/soft/appid/23656.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")


;pc6 刷量 2187 http://www.pc6.com/softview/SoftView_98439.html
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.pc6.com/down.asp?id=98439",false)
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("Host","www.pc6.com")
$oHTTP.setRequestHeader("Origin", "http://www.pc6.com")
$oHTTP.setRequestHeader("Referer","http://www.pc6.com/softview/SoftView_98439.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")

;
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.pc6.com/down.asp?id=98439",false)
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("Host","www.pc6.com")
$oHTTP.setRequestHeader("Origin", "http://www.pc6.com")
$oHTTP.setRequestHeader("Referer","http://www.pc6.com/pc/cangkugl/")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("")

$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("post","http://www.pc6.com/ajax.asp",false)
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("Host","www.pc6.com")
$oHTTP.setRequestHeader("Origin", "http://www.pc6.com")
$oHTTP.setRequestHeader("Referer","http://www.pc6.com/softview/SoftView_98439.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("Action=1&softid=98439&type=0")

$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("post","http://www.pc6.com/ajax.asp",false)
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Accept-encoding", "gzip,deflate,sdch")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn,zh;q=0.8")
$oHTTP.setRequestHeader("Cache-Control", "max-age=0")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("DNT","1")
$oHTTP.setRequestHeader("Host","www.pc6.com")
$oHTTP.setRequestHeader("Origin", "http://www.pc6.com")
$oHTTP.setRequestHeader("Referer","http://www.pc6.com/softview/SoftView_98439.html")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("action=18&id=98439&CommentTpye=0&sendid=583605%2C514101%2C511270%2C504584%2C499665%2C498202%2C487646%2C456289%2C446531%2C441547")

;pc6刷刷赞

$oHTTP = 0
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("post","http://www.pc6.com/ajax.asp",false)
$oHTTP.setRequestHeader("Accept-Language", "zh-cn")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("Referer","http://www.pc6.com/softview/SoftView_98440.html")
$oHTTP.Send("Action=0&softid=98439&num=1&type=0")
$msg3=$oHTTP.responsetext
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("post","http://www.pc6.com/ajax.asp",false)
$oHTTP.setRequestHeader("Accept-Language", "zh-cn")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("Referer","http://www.pc6.com/softview/SoftView_98440.html")
$oHTTP.Send("Action=1&softid=98439&type=0")
$msg2=$oHTTP.responsetext
$oHTTP = 0
;多特刷赞
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("get","http://www.duote.com/soft_pj.php?st=1&id=42789&dt=1402645534570",false)
$oHTTP.setRequestHeader("Accept-Language", "zh-cn")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("Referer","http://www.duote.com/soft/42789.html")
$oHTTP.Send("")
$msg=$oHTTP.responsetext
$oHTTP = 0
$oHTTP = ObjCreate("microsoft.xmlhttp")
$oHTTP.Open("post","http://d.onlinedown.net/ajax_top_1.4.php",false)
$oHTTP.setRequestHeader("Accept", "*/*")
$oHTTP.setRequestHeader("Accept-Language", "zh-cn;q=0.8")
$oHTTP.setRequestHeader("Connection","keep-alive")
$oHTTP.setRequestHeader("Content-Length","26")
$oHTTP.setRequestHeader("Content-Type","application/x-www-form-urlencoded")
$oHTTP.setRequestHeader("Cookie","diggid=466290")
$oHTTP.setRequestHeader("Host","d.onlinedown.net")
$oHTTP.setRequestHeader("Origin","http://d.onlinedown.net")
$oHTTP.setRequestHeader("Referer","http://d.onlinedown.net/topinfo_1.5.php?id=466289")
$oHTTP.setRequestHeader("Origin","http://d.onlinedown.net")
$oHTTP.setRequestHeader("User-Agent","User-Agent:Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1952.0 Safari/537.36")
$oHTTP.Send("do=digg&action=1&id=466289")
$msg1=$oHTTP.responsetext
;MsgBox(0,0,$oHTTP.responsetext&$msg)
$oHTTP=0
;onlinedown 推荐
FileWriteLine ( $hFileOpen,$msg&$msg1)
#ce
Next
#cs
;sina
Local $oIE2 = _IECreate("http://down.tech.sina.com.cn/page/53464.html")
_IELinkClickByText ($oie2,"很好")
WinWait('Microsoft Internet Explorer')
ControlClick('Microsoft Internet Explorer', '', 'Button1')
_IEQuit($oie2)
WinKill ('文件下载')
;sina down
Local $oIE2 = _IECreate("http://down.tech.sina.com.cn/download/d_load.php?d_id=53464&down_id=2&ip=")
_IEQuit($oie2)
WinKill ('文件下载')
;sina 制胜管家
Local $oIE2 = _IECreate("http://down.tech.sina.com.cn/content/58941.html")
_IELinkClickByText ($oie2,"很好")
WinWait('Microsoft Internet Explorer')
ControlClick('Microsoft Internet Explorer', '', 'Button1')
_IEQuit($oie2)
WinKill ('文件下载')
;sina down
Local $oIE2 = _IECreate("http://down.tech.sina.com.cn/download/d_load.php?d_id=53464&down_id=2&ip=")
_IEQuit($oie2)
WinKill ('文件下载')

;onlinedown 推荐
Local $oIE2 = _IECreate("http://www.onlinedown.net/soft/117854.htm")
_IELinkClickByText ($oie2,"推荐")
_IEQuit($oie2)
WinKill ('文件下载')
Local $oIE2 = _IECreate("http://www.pc6.com/down.asp?id=98439")
_IEQuit($oie2)
WinKill ('文件下载')
Local $oIE2 = _IECreate("http://www.doyo.cn/down/add_game?d=10251828&c=3100")
_IEQuit($oie2)
WinKill ('文件下载')
Local $oIE2 = _IECreate("http://www.crsky.com/soft/31171.html")
;550天虹管家婆来电通软件 v3.31 跳到下载链接
_IEQuit($oie2)
WinKill ('文件下载')
;http://xiazai.zol.com.cn/down.php?nn=304ce170cf3bcb0ae&softid=413376&subcateid=1006&site=10&server=10&isvip=1&rand=2720468

;29 http://www.onlinedown.net/softdown/522143_2.htm
Local $oIE2 = _IECreate("http://www.onlinedown.net/api/index2.php?ver=2.0&name=%E7%AE%A1%E5%AE%B6%E5%A9%86-%E9%BA%BB%E5%B0%86%E6%9C%BA%E5%8E%82%E7%AE%A1%E7%90%86%E7%B3%BB%E7%BB%9F&id=522143&token=cd88e949df7cb1d8e6d5e945fbf9f121")
;麻将机
_IELoadWait($oie2)
_IEQuit($oie2)
WinKill ('文件下载')

;_IENavigate($oie1,"http://www.baidu.com")
;Local $oIE = _IECreate("http://www.onlinedown.net/soft/151968.htm")
;Local $oIE = _IECreate("http://www.pc6.com/softview/SoftView_111320.html")
;_IEQuit($oie)
;Local $oIE = _IECreate("http://www.duote.com/soft/10916.html")
;4
;_IEQuit($oie)


;Local $oIE = _IECreate("http://www.crsky.com/soft/31171.html")
;550天虹管家婆来电通软件 v3.31 跳到下载链接
;_IEQuit($oie)


;Local $oIE = _IECreate("http://down.tech.sina.com.cn/content/53464.html")
;130638管家婆
;_IEQuit($oie)


;www.onegreen.net
;4
;sleep(1000)
;_IENavigate($oie,"http://www.onlinedown.net/soft/565228.htm")
;_IELoadWait($oie)
;_IENavigate($oie,"http://www.onlinedown.net/softdown/151968_2.htm")
;_IELoadWait($oie)

;$oIE = _IEAttach("旅程同行旅行社管理软件之单项服务官方下载|旅程同行旅行社管理软件之单项服务 2014最新免费下载")
;_IELinkClickByText ($oie, "中国电信网络下载1")
;WinWait('文件下载')
;sleep(100)
;Send("!S")
;WinWait('另存为')
;Send($i&".rar!S")

Next
#ce


Func _IEInPrivateCreate($s_url, $i_timeout = -1) ; Simple version, you can add all the other stuff if you like ($i_timeout is in secs).
    Local $s_random = "about:InPrivate " & Random(1000000, 99999999, 1) & "-" & Random(1000000, 99999999, 1)
    If $s_url = "" Then $s_url = "about:InPrivate"

    Local $i_pid = Run('"' & @ProgramFilesDir & '\Internet Explorer\iexplore.exe" -private "' & $s_random & '"')
    If $i_pid = 0 Then Return SetError(1, 0, 0)

    If StringInStr("|default|-1|", "|" & $i_timeout & "|") Then $i_timeout = 0


    Local $h_wnd, $o_shell, $o_shell_wins, $i_timer

    If $i_timeout > 0 Then $i_timer = TimerInit()
    While 1

        If $i_timeout And TimerDiff($i_timer) / 1000 > $i_timeout Then
            Return SetError(2, $i_pid, 0)
        EndIf

        $h_wnd = WinGetHandle($s_random)
        If $h_wnd Then ExitLoop
        Sleep(10)
    WEnd

    $o_shell = ObjCreate("Shell.Application")
    If IsObj($o_shell) Then
        $o_shell_wins = $o_shell.Windows

        For $o_shell_win In $o_shell_wins
            ; IE.au3 checks for IWebBrowser as well as IWebBrowser2 with __IEIsObjType
            ; This fails with my outlook with "hwnd" property
            ; So if its 100% neccessary, you'll need to find a work around
            If String(ObjName($o_shell_win)) = "IWebBrowser2" Then
                If $o_shell_win.hwnd = $h_wnd Then
                    Return SetError(0, $i_pid, $o_shell_win)
                EndIf
            EndIf
        Next
    EndIf

    Return SetError(3, $i_pid, 0)
EndFunc