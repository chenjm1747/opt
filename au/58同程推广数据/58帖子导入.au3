#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GUIListBox.au3>
#include <array.au3>
#include <IE.au3>
#include <ScreenCapture.au3>
#include <WindowsConstants.au3>
#include <InetConstants.au3>
;http://hz.58.com/zufang/21728244941973x.shtml?adtype=3
Local $oIE = _IECreateEmbedded()
Local $oIE1 = _IECreateEmbedded()
GUICreate("58���ӵ���", @DesktopWidth, @DesktopHeight, 0, 0, _
        $WS_OVERLAPPEDWINDOW + $WS_CLIPSIBLINGS + $WS_CLIPCHILDREN)
GUICtrlCreateObj($oIE, 0, 20, @DesktopWidth, @DesktopHeight)
GUICtrlCreateObj($oIE1, 0, 20, @DesktopWidth, @DesktopHeight)
Global $g_idError_Message = GUICtrlCreateLabel("", 100, 500, 500, 30)
GUICtrlSetColor(-1, 0xff0000)
GUISetState(@SW_SHOW) ;Show GUI
;_call()
;copy58zufang('http://hz.58.com/zufang/21728244941973x.shtml?adtype=3')
Global $g_yonghu = GUICtrlCreatelabel ("������", 0, 00, 100, 20)
Global $g_yaoqingma = GUICtrlCreateInput ("abce", 50, 00, 100, 20)
Global $g_yonghu = GUICtrlCreatelabel ("58�˺�", 150, 00, 100, 20)
Global $g_yonghu1 = GUICtrlCreateInput ("13858101782", 200, 00, 100, 20)
Global $g_yonghu = GUICtrlCreatelabel ("58����", 300, 00, 100, 20)
Global $g_passwd1 = GUICtrlCreateInput ("903291", 350, 00, 100, 20)
Global $g_yonghu = GUICtrlCreatelabel ("58��ַ", 450, 00, 100, 20)
Global $g_edit = GUICtrlCreateInput ("http://hz.58.com/zufang/21728244941973x.shtml", 500, 00, 300, 20)
Local $fatie2430 = GUICtrlCreateButton("����", 900, 0, 100, 20)



;http://www.mzmoney.com/yymeq/10541.htm
; Waiting for user to close the window
While 1
    Local $iMsg = GUIGetMsg()
    Select
        Case $iMsg = $GUI_EVENT_CLOSE
            ExitLoop
        Case $iMsg = $fatie2430
            copy58zufang( GUICtrlRead($g_edit),GUICtrlRead($g_yonghu1),GUICtrlRead($g_passwd1))
    EndSelect
WEnd

GUIDelete()

Exit

Func copy58zufang($url,$username1,$passwd1);����

   ;http://www.p2peye.com/platform/search/h0i4c0x0r0t0s0b0p1.html
   $oie= _iecreate($url)
   $a58url=_IEBodyReadhtml($oie)
   _iequit($oie)
   ;<h1>�ű�����ӡ�� 5��2��180ƽͬ�º���Ŀͻ�������С�������� </h1>
   Local $title = StringRegExp($a58url, '<h1>(.+?)</h1>', 3)
   ;
   Local $img = StringRegExp($a58url, 'http://pic6.58cdn.com.cn/p1/big/(.+?).jpg', 3)
   ;<span id="t_phone" class="arial c_e22" style="font-size:26px;font-weight:bold;">182 5822 3996
   Local $tel = StringRegExp($a58url, '(\d\d\d \d\d\d\d \d\d\d\d)', 3)
   ;<div class="description_con ">                                </div>
   Local $body= StringRegExp($a58url, '<div class="description_con ">([\w\W]+?)</div>', 3)
   ;<a href="http://hz.58.com/xiaoqu/dexinbolinyinxiang/" target="_blank">���Ų���ӡ��</a>
   Local $xiaoqu= StringRegExp($a58url, '<a href="http://hz.58.com/xiaoqu/.+?/" target="_blank">(.+?)</a>', 3)

   ;5��
   Local $shi= StringRegExp($a58url, '(\d+?)��', 3)
   Local $ting= StringRegExp($a58url, '(\d+?)��', 3)
   Local $wei= StringRegExp($a58url, '(\d+?)��', 3)
   ;180�O
   Local $area= StringRegExp($a58url, '(\d+?)�O', 3)
   Local $ceng= StringRegExp($a58url, '(\d+?)��/18��', 3)
   Local $zongceng= StringRegExp($a58url, '��/(\d+?)��', 3)
   Local $price= StringRegExp($a58url, '<span class="bigpri arial">(\d+?)</span>', 3)
   ;<a rel="nofollow" href="http://my.58.com/2756797104903/">
   Local $lianxiren= StringRegExp($a58url, '<span class="lxr"><a title="(.+?)"', 3)
   ConsoleWrite($lianxiren[0])
   For $i = 0 To UBound($title) - 1
   $oie= _iecreate("http://dx.caiwuhao.com:3000/azufangs/new")
   $oid=_IEGetObjByname($oie,"azufang[innertext]")
   $body[$i]=StringRegExpReplace($body[$i],"(<P>)|(<br>)",@CRLF)
   $body[$i]=StringRegExpReplace($body[$i],"&nbsp;"," ")

   $body[$i]=StringRegExpReplace($body[$i],"&amp;","'")
   $body[$i]=StringRegExpReplace($body[$i],"<[\w\W]+?>","")
   $body[$i]=StringRegExpReplace($body[$i],@CRLF,"<p>")
   $oid.value=$body[$i]
   $oid=_IEGetObjByname($oie,"azufang[title]")
   $oid.value=$title[$i]
   $oid=_IEGetObjByname($oie,"azufang[phone]")
      $tel[$i]=StringRegExpReplace($tel[$i]," ","")
   $oid.value=$tel[$i]
   $oid=_IEGetObjByname($oie,"azufang[tupian]")
   $oid.value= _ArrayToString($img,";")
   $oid=_IEGetObjByname($oie,"azufang[xiaoqu]")
   $oid.value=$xiaoqu[$i]
   $oid=_IEGetObjByname($oie,"azufang[shi]")
   $oid.value=$shi[$i]
   $oid=_IEGetObjByname($oie,"azufang[ting]")
   $oid.value=$ting[$i]
   $oid=_IEGetObjByname($oie,"azufang[wei]")
   $oid.value=$wei[$i]
   $oid=_IEGetObjByname($oie,"azufang[ceng]")
   $oid.value=$ceng[$i]
   $oid=_IEGetObjByname($oie,"azufang[zongceng]")
   $oid.value=$zongceng[$i]
   $oid=_IEGetObjByname($oie,"azufang[area]")
   $oid.value=$area[$i]
   $oid=_IEGetObjByname($oie,"azufang[minprice]")
   $oid.value=$price[$i]
   $oid=_IEGetObjByname($oie,"azufang[lianxiren]")
   $oid.value=$lianxiren[$i]
   $oid=_IEGetObjByname($oie,"azufang[username]")
   $oid.value=$username1
   $oid=_IEGetObjByname($oie,"azufang[password]")
   $oid.value=$passwd1
$oid=_IEGetObjByname($oie,"commit")
   $oid.click()
   sleep(100)
   _IELoadWait($oie)
    _iequit($oie)
next
EndFunc

Func _call();���в�ѯ
   ;http://www.p2peye.com/platform/search/h0i4c0x0r0t0s0b0p1.html
for $i1=1 to 14
   $oie= _iecreate("http://www.p2peye.com/platform/search/h0i4c0x0r0t0s0b0p"&$i1&".html")
   $s=_IEBodyReadText($oie)
   _iequit($oie)
   Local $aArray = StringRegExp($s, '��ƽ̨([\w\W]+?)����ƽ̨', 1)
   $a58url=$aarray[0]
   ConsoleWrite ($a58url)
   Local $name = StringRegExp($a58url, '   (.+?)д����', 3)
   Local $type = StringRegExp($a58url, ' ��Ŀ���� �� (.+?)\n', 3)
   Local $date = StringRegExp($a58url, '����ʱ�� �� (.+?) ', 3)
   Local $shengfen = StringRegExp($a58url, '�� (.+?) ', 3)
   Local $nianhua = StringRegExp($a58url, '�껯���� : (.+?) ', 3)
   For $i = 0 To UBound($nianhua) - 1
   $oie= _iecreate("http://dx.caiwuhao.com:3000/p2pcompanies/new")
;
   $oid=_IEGetObjById($oie,"p2pcompany[c_name]")
   $oid.value=$name[$i]
   $oid=_IEGetObjById($oie,"p2pcompany[c_province]")
   $oid.value=$shengfen[$i]
   $oid=_IEGetObjById($oie,"p2pcompany[c_create_time]")
   $oid.value=$date[$i]
   $oid=_IEGetObjById($oie,"p2pcompany[c_product_type]")
   $oid.value=$type[$i]
   $oid=_IEGetObjByname($oie,"commit")
   $oid.click()
    _iequit($oie)
   Next
next
EndFunc

Func UniDecode($sUni, $sExp = '\\u')
        Local $sStr = ''
        $sHex = StringRegExp($sUni, $sExp & '(\w{4})', 3)
        If @error = 0 Then
        For $i = 0 To UBound($sHex) - 1
                        $sText = ChrW(Dec($sHex[$i]))
                        $sStr = StringRegExpReplace($sUni, $sExp & $sHex[$i], $sText, 1)
                        $sUni = $sStr
        Next
        EndIf
        Return $sStr
EndFunc   ;==>UniDecode


Func _callp2pproduct()
   ;���в�ѯhttp://caifu.baidu.com/wealth?wd=���&qid=12652813456031052444&pssid=13468_13636_1444_13520_12658_13074_12867_13322_13691_10562_12722_13203_13762_13256_13780_12439_13838_13085_8498&sid=ui%3A0%26bsInsurance%3A3%26bsInvest%3A1%26bsLoan%3A1&tn=baiduhome_pg&fr=ps&zt=ps&category=0http://t12.baidu.com/it/u=736650914,665923987&fm=58
   $oHTTP1 = ObjCreate("winhttp.winhttprequest.5.1")
   $oHTTP1.Open("get","http://caifu.baidu.com/wealth",false)
   $oHTTP1.Send()

   $oie1= _iecreate("http://caifu.baidu.com/wealth")
for $i1=1 to 1
   $oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
   $oHTTP.Open("get","http://caifu.baidu.com/wealth/ajax?pageSize=10&pageNum="&$i1&"&module=Finance&category=wealth&serverTime=1430382666866&pvid=1430382666862364492&resourceid=1800181&subqid=1430382666862364492&sid=ui%3A0%26bsInsurance%3A4%26bsInvest%3A3%26bsLoan%3A2&pssid=0&tn=NONE&signTime=96&qid=1430286027550707061&wd=&zt=self&fr=-&f=-&amount=&cycle=&profit=&risk=&productType=0",false)
   $oHTTP.Send ()
   $a58url=UniDecode($oHTTP.responseText)
   ConsoleWrite($a58url)
   Local $title = StringRegExp($a58url, '"title":"(.+?)"', 3)
   $oldid = StringRegExp($a58url, '"id":"(.+?)"', 3)
   Local $company = StringRegExp($a58url, '"channelName":"(.+?)"', 3)
   $investFieldDesc= StringRegExp($a58url, '"investFieldDesc":"(.+?)"', 3)
   Local $company = StringRegExp($a58url, '"channelName":"(.+?)"', 3)
;���Ͷ�ʽ�
   $lowestAmount = StringRegExp($a58url, '"lowestAmount":"(.+?)"', 3)
   $productTypeLabel=StringRegExp($a58url, '"productTypeLabel":"(.+?)"', 3)
   ;��ҵ����
   $supplierNameShort=StringRegExp($a58url, '"supplierNameShort":"(.+?)"', 3)
   ;��ҵlogo
   $supplierLogoUrl=StringRegExp($a58url, '"supplierLogoUrl":"(.+?)"', 3)
   ;��ַ
   $channelUrl=StringRegExp($a58url, '"channelUrl":"(.+?)"', 3)
   ;������
   $expectedProfitRate=StringRegExp($a58url, '"expectedProfitRate":"(.+?)"', 3)
   $idea=StringRegExp($a58url, '"idea":"(.+?)"', 3)
   ;Ͷ������
   $extraFields=StringRegExp($a58url, 'investCycle":"(.+?)"', 3)
   ;Ͷ������
   $investField=StringRegExp($a58url, '"investField":"(.+?)"', 3)
   ;$riskScore=StringRegExp($a58url, '"riskScore":"(.+?)"', 3)
   $earlyBack=StringRegExp($a58url, '"earlyBack":(.+?),', 3)
   $earlyTransfer=StringRegExp($a58url, '"earlyTransfer":(.+?),', 3)
   For $i = 0 To UBound($title) - 1
   ConsoleWrite($investField[$i]&@CRLF)

   $oie= _iecreate("http://dx.caiwuhao.com:3000/p2pproducts/new")
   _IELoadWait($oie)
   $oid=_IEGetObjByname($oie,"p2pproduct[name]")
   $oid.value=$title[$i]
   ;$oid=_IEGetObjById($oie,"p2pproduct[oldid]")
   ;$oid.value=$oldid[$i]
   $oid=_IEGetObjByname($oie,"p2pproduct[company]")
   $oid.value=$company[$i]
   $oid=_IEGetObjByname($oie,"p2pproduct[lowestAmount]")
   $oid.value=$lowestAmount[$i]
   $oid=_IEGetObjByname($oie,"p2pproduct[producttypelabel]")
   $oid.value=$productTypeLabel[$i]
   $oid=_IEGetObjByname($oie,"p2pproduct[suppliernameshort]")
   $oid.value=$supplierNameShort[$i]
   $oid=_IEGetObjByname($oie,"p2pproduct[supplierlogourl]")
   $logourl=$supplierLogoUrl[$i]
   $logourl=StringReplace($logourl,"\/","/")
   $logourl=StringReplace($logourl,"\u0026","&")
   $oid.value=$logourl
   ConsoleWrite($logourl)
   ConsoleWrite("d:/down/"&$oldid[$i]&".jpg")
   $oie1=_iecreate($logourl)
   Sleep(1000)
   _IELoadWait($oie1)
   $oImgs = _IEImgGetCollection($oIE1,0)
;MsgBox($MB_SYSTEMMODAL, "Img Info",$oImgs.src)
  $oPic = $oie1.Document.body.createControlRange()
  $oPic.Add($oImgs)
  $oPic.execCommand("Copy")
  $bmp = ClipGet()
  FileCopy($bmp,"d:\1.jpg",1)

$ohttp1.Open("GET",$logourl,0)
$ohttp1.Send()
$aGet = ObjCreate("ADODB.Stream")
$aGet.Mode = 3
$aGet.Type = 1
$aGet.Open()
$aGet.Write($ohttp1.responseBody)
$aGet.SaveToFile("x:\zl.exe",2)
   InetGet($logourl, @TempDir & "\"&$oldid[$i]&".jpg", 0,0)
   $oid=_IEGetObjByname($oie,"p2pproduct[channelurl]")
   $oid.value=$channelUrl[$i]
   $oid=_IEGetObjByname($oie,"p2pproduct[idea]")
   $oid.value=$idea[$i]
   $oid=_IEGetObjByname($oie,"p2pproduct[extrafields]")
   $oid.value=$extraFields[$i]
   $oid=_IEGetObjByname($oie,"p2pproduct[investfield]")
   $oid.value=$investField[$i]
   $oid=_IEGetObjByname($oie,"p2pproduct[expectedprofitrate]")
   $oid.value=$expectedProfitRate[$i]
   $oid=_IEGetObjByname($oie,"p2pproduct[earlytransfer]")
   $oid.value=$earlyTransfer[$i]
   $oid=_IEGetObjByname($oie,"p2pproduct[earlyBack]")
   $oid.value=$earlyBack[$i]
;   $oid.value=$shengfen[$i]
;   $oid=_IEGetObjById($oie,"p2pcompany[c_create_time]")
;   $oid.value=$date[$i]
;   $oid=_IEGetObjById($oie,"p2pcompany[c_product_type]")
;   $oid.value=$type[$i]
   $oid=_IEGetObjByname($oie,"commit")
   $oid.click()
   _IELoadWait($oie)
   _iequit($oie)
   Next
next


EndFunc

Func _Base64Decode4CH($Data)
	Local $Opcode = "0xC81000005356578365F800E8500000003EFFFFFF3F3435363738393A3B3C3DFFFFFF00FFFFFF000102030405060708090A0B0C0D0E0F10111213141516171819FFFFFFFFFFFF1A1B1C1D1E1F202122232425262728292A2B2C2D2E2F303132338F45F08B7D0C8B5D0831D2E9910000008365FC00837DFC047D548A034384C0750383EA033C3D75094A803B3D75014AB00084C0751A837DFC047D0D8B75FCC64435F400FF45FCEBED6A018F45F8EB1F3C2B72193C7A77150FB6F083EE2B0375F08A068B75FC884435F4FF45FCEBA68D75F4668B06C0E002C0EC0408E08807668B4601C0E004C0EC0208E08847018A4602C0E00624C00A46038847028D7F038D5203837DF8000F8465FFFFFF89D05F5E5BC9C21000"

	Local $CodeBuffer = DllStructCreate("byte[" &BinaryLen($Opcode) & "]")
	DllStructSetData($CodeBuffer, 1, $Opcode)

	Local $Ouput = DllStructCreate("byte["& BinaryLen($Data) & "]")
	Local $ret = DllCall("user32.dll", "int", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer), _
			"str", $Data, _
			"ptr", DllStructGetPtr($Ouput), _
			"int", 0, _
			"int", 0)

	Return BinaryToString(BinaryMid(DllStructGetData($Ouput, 1), 1, $ret[0]))
EndFunc   ;==&gt;_Base64Decode4CH


Func _bu_yb();�첽ʶ��ť
	Local $TimeOut = 15 * 1000 ;���ó�ʱʱ��15��
	;����ʹ�ò��� _uu_asyn_upload('��֤��ͼƬ·��','�û���','����'[,'��֤������=1004'][,'�Զ���½=1']) �ɹ�����һ������ [0]Ϊ��֤��ID [1]Ϊ��֤���� ʧ�ܷ��ش������
	;��������Զ���½���������������Ϊ0����
	$rHandle = _uu_asyn_upload(@TempDir&'\GDIPlus_Image2.jpg','aontimer','jmdjsj903291A')
	If @error Then
;		_echo_log('�ϴ�ͼƬʧ��,�������['&$rHandle&']')
		Return
	EndIf
;	_echo_log('���ڵȴ�ʶ����')
	Local $lInit = TimerInit()
	While 1
		Sleep(1)
		$rRs = _uu_asyn_Result($rHandle)
		If @error<>-1102 Then ExitLoop
		If TimerDiff($lInit) >= $TimeOut Then
			$rRs = 'ʶ��ʱ'
			ExitLoop
		EndIf
	WEnd
	If IsArray($rRs) Then
	;	msgbox(0,0,'ʶ����[' & $rRs[1] & ']')
	Else
	;	msgbox(0,0,'ʶ��ʧ�ܣ��������['&$rRs&']')
	EndIf
	;######����ע������ǵ��ñ����������Է�����֤��ʶ������ʱ��ʹ�ã�#######
	;If IsArray($rRs) Then  _uu_reporterror($rRs[0])
	;###########################################################################
	_uu_asyn_close($rHandle)
	;����ʹ�ò��� _uu_asyn_close('���')
	;��_uu_asyn_upload()����
	Return $rRs[1]
 EndFunc   ;==>_bu_yb


Func _bu_login();��½��ť

	If Not @error Then
		MsgBox(0,0,'��½�ɹ����û�IDΪ��[' & $rMsg & ']')
	ElseIf @error = -1 Then
	Else
	EndIf
 EndFunc   ;==>_bu_login

Func CheckError($sMsg, $iError, $iExtended)
    If $iError Then
        $sMsg = "Error using " & $sMsg & " button (" & $iExtended & ")"
    Else
        $sMsg = ""
    EndIf
    GUICtrlSetData($g_idError_Message, $sMsg)
EndFunc   ;==>CheckError

func shouji()
   ;1�ֻ���֤
_IENavigate($oIE, "http://www.mzmoney.com/password/index.jspx")
_IEAction($oIE, "stop")
_ScreenCapture_Capture(@TempDir&"\GDIPlus_Image2.jpg",573,437,573+80,437+34)
$oIE.document.parentWindow.jvForm.username.value="13291488404"
$s=_uu_start($softid,$softkey,$softcrckey);�����ʼ����_uu_start('���ID','���KEY'��'DLLУ��KEY')
$captcha=_bu_yb()
$oIE.document.parentWindow.jvForm.captcha.value= $captcha
$oIE.document.parentWindow.jvForm.submit.click()
sleep(1000)
_IELoadWait($oie)
$oIE.document.parentWindow.jvForm.timer.click()



endfunc


func yizhuce()
   ;1�ֻ�����ע�� �û���ע��
_IENavigate($oIE, "http://www.mzmoney.com/register.jspx")
_IEAction($oIE, "stop")
_ScreenCapture_Capture(@TempDir&"\GDIPlus_Image2.jpg",573,437,573+80,437+34)
$oIE.document.parentWindow.jvForm.username.value="13291488404"
$s=_uu_start($softid,$softkey,$softcrckey);�����ʼ����_uu_start('���ID','���KEY'��'DLLУ��KEY')
$captcha=_bu_yb()
$oIE.document.parentWindow.jvForm.username.value= "aontimer"
$oIE.document.parentWindow.jvForm.mobile.value="13291488404"
sleep(1000)
_IELoadWait($oie)
$oIE.document.parentWindow.jvForm.timer.click()

endfunc
func genghuanshouji()
   ;1�����ֻ���
_IENavigate($oIE, "http://www.mzmoney.com/security/index.jspx")
_IEAction($oIE, "stop")
;�޸�û��id��û����
_ScreenCapture_Capture(@TempDir&"\GDIPlus_Image2.jpg",573,437,573+80,437+34)
$oIE.document.parentWindow.jvForm.origMobile.value="13291488404"
$s=_uu_start($softid,$softkey,$softcrckey);�����ʼ����_uu_start('���ID','���KEY'��'DLLУ��KEY')
$captcha=_bu_yb()
$oIE.document.parentWindow.jvForm.username.value= "aontimer"
$oIE.document.parentWindow.jvForm.mobile.value="13291488404"
sleep(1000)
_IELoadWait($oie)
$oIE.document.parentWindow.jvForm.timer.click()

endfunc

func genghuanjiaoyimima()
_IENavigate($oIE, "http://www.mzmoney.com/security/index.jspx")
_IEAction($oIE, "stop")
$oIE.document.parentWindow.payPwdForm.origPayPassword.value="jmdjsj903291A"
$oIE.document.parentWindow.payPwdForm.payPassword.value="jmdjsj903291AA"
$oIE.document.parentWindow.payPwdForm.confirmPayPwd.value="jmdjsj903291AA"
$oIE.document.parentWindow.payPwdForm.payPwdSubmit.click()
sleep(1000)
_IELoadWait($oie)
s('�һؽ�������')
_IENavigate($oIE, "http://www.mzmoney.com/security/index.jspx")
_IEAction($oIE, "stop")
$oIE.document.parentWindow.payPwdForm.origPayPassword.value="jmdjsj903291AA"
$oIE.document.parentWindow.payPwdForm.payPassword.value="jmdjsj903291A"
$oIE.document.parentWindow.payPwdForm.confirmPayPwd.value="jmdjsj903291A"
$oIE.document.parentWindow.payPwdForm.payPwdSubmit.click()
sleep(1000)
_IELoadWait($oie)
endfunc

func genghuanmima()
   _IENavigate($oIE, "http://www.mzmoney.com/security/index.jspx")
_IELoadWait($oie)
$oIE.document.parentWindow.pwdForm.origPassword.value="111111"
$oIE.document.parentWindow.pwdForm.Password.value="1111111"
$oIE.document.parentWindow.pwdForm.confirmPwd.value="1111111"
$oIE.document.parentWindow.pwdForm.pwdSubmit.click()
sleep(1000)
_IELoadWait($oie)
s('������')
_IENavigate($oIE, "http://www.mzmoney.com/security/index.jspx")
_IELoadWait($oie)
$oIE.document.parentWindow.pwdForm.origPassword.value="1111111"
$oIE.document.parentWindow.pwdForm.Password.value="111111"
$oIE.document.parentWindow.pwdForm.confirmPwd.value="111111"
$oIE.document.parentWindow.pwdForm.pwdSubmit.click()
sleep(1000)

EndFunc

func zhaohuimima()
   ;1�һ����ǵĵ�¼����
_IENavigate($oIE, "http://www.mzmoney.com/password/index.jspx")
_IEAction($oIE, "stop")
_ScreenCapture_Capture(@TempDir&"\GDIPlus_Image2.jpg",573,437,573+80,437+34)
$oIE.document.parentWindow.jvForm.username.value="13291488404"
$s=_uu_start($softid,$softkey,$softcrckey);�����ʼ����_uu_start('���ID','���KEY'��'DLLУ��KEY')
$captcha=_bu_yb()
$oIE.document.parentWindow.jvForm.captcha.value= $captcha
$oIE.document.parentWindow.jvForm.submit.click()
sleep(1000)
_IELoadWait($oie)
$oIE.document.parentWindow.jvForm.timer.click()



endfunc
;

func touzi()
   ;1���ɴ������
_IENavigate($oIE, "http://www.mzmoney.com/nnh6/10535.htm")
_IEAction($oIE, "stop")
$oIE.document.parentWindow.jvForm.amount.value="1000"
$s=_uu_start($softid,$softkey,$softcrckey);�����ʼ����_uu_start('���ID','���KEY'��'DLLУ��KEY')
$oIE.document.parentWindow.jvForm.button.click()
sleep(1000)
_IELoadWait($oie)
$oIE.document.parentWindow.jvForm.submit.click()
sleep(1000)
_IELoadWait($oie)
$oIE.document.parentWindow.jvForm.bankCardNo.value=5218990177587721
$oIE.document.parentWindow.jvForm.phone.value=13291488404
$oIE.document.parentWindow.jvForm.submit.click()
sleep(5000)
_IELoadWait($oie)
$oIE.document.parentWindow.jvForm.payPassword.value="jmdjsj903291A"
$oIE.document.parentWindow.jvForm.verifyCode.value=683941
;$oIE.document.parentWindow.jvForm.submit.click()
sleep(5000)

_IELoadWait($oie)


endfunc

func daifukuan()
s('������ɾ��')
_IENavigate($oIE, "http://www.mzmoney.com/part/history.jspx")
_IEAction($oIE, "stop")
s('�鿴����')
_IENavigate($oIE, "http://www.mzmoney.com/part/201412011454166885.jspx")
_IEAction($oIE, "stop")

s('Ͷ���б��в鿴')
_IENavigate($oIE, "http://www.mzmoney.com/part/201412011454166885.jspx")
_IEAction($oIE, "stop")

s('վ����')
_IENavigate($oIE, "http://www.mzmoney.com/member/message_list.jspx?box=0")
_IEAction($oIE, "stop")

endfunc

func chuzu()
_IENavigate($oIE, "http://post.58.com/79/8/s5?ver=npost")
sleep(1000)
_IELoadWait($oie)
$xiaoqu=_IEGetObjByname($oie,"isBiz")
$xiaoqu.click()
$oIE.document.parentWindow.aspnetForm.jushishuru.value="2"
$oIE.document.parentWindow.aspnetForm.huxingting.value="1"
$oIE.document.parentWindow.aspnetForm.huxingwei.value="1"
$oIE.document.parentWindow.aspnetForm.Floor.value=4
$xiaoqu=_IEGetObjById($oie,"xiaoqu")
$xiaoqu.value="��ɳ��Ƚ��԰"
$oIE.document.parentWindow.aspnetForm.zonglouceng.value=20
$oIE.document.parentWindow.aspnetForm.Toward.value=2
$oIE.document.parentWindow.aspnetForm.FitType.value=4
$oIE.document.parentWindow.aspnetForm.Title.value='300-500���⾰Ƚ��԰�з������С���а���ҵ�������Ҿ߼ҵ�۸�˫����ԤԼ����'
$oIE.document.parentWindow.aspnetForm.area.value=66
$oIE.document.parentWindow.aspnetForm.MinPrice.value=500
$oIE.document.parentWindow.aspnetForm.goblianxiren.value="������"
$oIE.document.parentWindow.aspnetForm.Phone.value="15314649829"
;$oIE.document.parentWindow.aspnetForm.cbxFreeDivert.click()
run("c:\upload.exe c:\11.jpg")
$xiaoqu=_IEGetObjById($oie,"fileUploadInput")
$xiaoqu.click()
;run("c:\upload.exe c:\12.jpg")
;$xiaoqu=_IEGetObjById($oie,"fileUploadInput")
;$xiaoqu.click()
;run("c:\upload.exe c:\13.jpg")
;$xiaoqu=_IEGetObjById($oie,"fileUploadInput")
;$xiaoqu.click()
;run("c:\upload.exe c:\1.jpg")
;$xiaoqu=_IEGetObjById($oie,"fileUploadInput")
;$xiaoqu.click()
;run("c:\upload.exe c:\2.jpg")
;$xiaoqu=_IEGetObjById($oie,"fileUploadInput")
;$xiaoqu.click()

$oIE.document.parentWindow.aspnetForm.IM.value="2100803"
$oFrame1 = _IEFrameGetCollection($oIE,0)
_IEPropertySet($oFrame1, "innertext", "1. ˵˵�����  ����ķ����Ǿ��õĸ��ϼ䣬��Ů����"& @CRLF & "  2. ����������  ���׷����Ƕ๦�ܵĴ�լ�����л����ļҾߡ��������м�¥�㣬���ܱ�¥�ϵ�ס�����׽��羰����¥�µ��ھӸ�����⣡"& @CRLF & "  3.�ܱ�����  С���ܱ����׷ḻ�����꣬���У�����ʮ�ֱ�����")
$oIE.document.parentWindow.aspnetForm.fabu.click()
sleep(1000)
_IELoadWait($oie)
sleep(5000)

   endfunc

func login()
   ;��¼
_IENavigate($oIE, "http://10.10.20.240")
sleep(1000)
_IELoadWait($oie)
$oIE.document.parentWindow.autoform.id51.value="kk/*0905"
$oIE.document.parentWindow.autoform.loginbutton.click()
sleep(1000)
endfunc
func s($message)
   msgbox(0,0,$message)
endfunc