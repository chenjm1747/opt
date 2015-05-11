$wint = "来自网页的消息"
$wintt = "Are you sure you want to navigate away from this page?"
while 1
if WinExists($wint) then Controlclick($wint,"", "Button1", "LEFT", 1)
sleep(500)
wend