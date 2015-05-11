$wint = "Microsoft Internet Explorer"
$wintt = "单位唯一识别标识，平台内已Are you sure you want to navigate away from this page?"
while 1
if WinExists($wint) then Controlclick($wint,"", "Button1", "LEFT", 1)
sleep(500)
wend