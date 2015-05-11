#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#Include <ScreenCapture.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#Include <GuiEdit.au3>
#include <GDIPlus.au3>
#include <file.au3>
#include <Array.au3>
#NoTrayIcon
;~ $Open2  打开文件数组
;~ $CodeDB  字符的数据信息
;~ $Row  $Cro    数组行列数
;~ $aRecords  记录数组
Global $Open2=0,$CodeDB="",$Cro=0 ,$Row=0,$aRecords="",$SetFlg=False
Global $ResPicPos[4][4]
;~ $BackCorlor  窗体背景颜色
Global $BackCorlor=0x008080
;~  数据库中读出高度，宽度， 色差
Global $iWidth=IniRead(@ScriptDir&"\set.db","set","iwth","10"),$iHeight=IniRead(@ScriptDir&"\set.db","set","ihth","10"),$ColorToRemove=IniRead(@ScriptDir&"\set.db","set","remcolor","0xcccccc")
;读取字符边框设置
Global $Top=0,$Left=0,$Jianju=0,$SetFlgLet="",$CreateMode=""
;对数组初始化. 每个字符的坐标
Func chushihua()
	;上端空白区的象素
	$Top=IniRead(@ScriptDir&"\set.db","set","Top","0")
	;字符左边的空白区的象素
	$Left=IniRead(@ScriptDir&"\set.db","set","Left","0")
	;字符间距
	$Jianju=IniRead(@ScriptDir&"\set.db","set","Jianju","0")
	$ResPicPos[0][0]=$Left    ;第1个分割图片左上角X坐标
	$ResPicPos[0][1]=$Top   ;
	$ResPicPos[0][2]=$iWidth
	$ResPicPos[0][3]=$iHeight
	$ResPicPos[1][0]=$iWidth+$Left+$Jianju   ;第2个分割图片左上角X坐标 
	$ResPicPos[1][1]=$Top  
	$ResPicPos[1][2]=$iWidth
	$ResPicPos[1][3]=$iHeight
	$ResPicPos[2][0]=$iWidth*2+$Left+$Jianju*2   ;第3个分割图片左上角X坐标
	$ResPicPos[2][1]=$Top
	$ResPicPos[2][2]=$iWidth
	$ResPicPos[2][3]=$iHeight
	$ResPicPos[3][0]=$iWidth*3+$Left+$Jianju*3   ;第4个分割图片左上角X坐标
	$ResPicPos[3][1]=$Top
	$ResPicPos[3][2]=$iWidth
	$ResPicPos[3][3]=$iHeight
EndFunc
chushihua()	
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=C:\Documents and Settings\Administrator\桌面\code\CodeRead.kxf
$Form1 = GUICreate("CodeReader", 520, 402, 92, 114)
GUISetBkColor($BackCorlor)
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
$MainPic = GUICtrlCreatePic("", 24, 16, 160, 40)
$FirstPic = GUICtrlCreatePic("", 24, 80, 28, 28)
$LoadPic = GUICtrlCreateButton("加载图片", 208, 24, 75, 25)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "LoadPicClick")
$MoveLef1 = GUICtrlCreateButton("<", 8, 85, 11, 17)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveLef1Click")
$MoveRight1 = GUICtrlCreateButton(">", 56, 85, 11, 17)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveRight1Click")
$MoveDown1 = GUICtrlCreateButton("\/", 28, 111, 19, 10)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveDown1Click")
$MoveUp1 = GUICtrlCreateButton("/\", 28, 66, 19, 10)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveUp1Click")
$SecondPic = GUICtrlCreatePic("", 96, 80, 28, 28)
$MoveDown2 = GUICtrlCreateButton("\/", 100, 111, 19, 10)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveDown2Click")
$MoveLeft2 = GUICtrlCreateButton("<", 80, 85, 11, 17)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveLeft2Click")
$MoveUp2 = GUICtrlCreateButton("/\", 100, 66, 19, 10)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveUp2Click")
$MoveRight2 = GUICtrlCreateButton(">", 128, 85, 11, 17)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveRight2Click")
$ThirdPic = GUICtrlCreatePic("", 168, 80, 28, 28)
$MoveDown3 = GUICtrlCreateButton("\/", 172, 111, 19, 10)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveDown3Click")
$MoveLeft3 = GUICtrlCreateButton("<", 152, 85, 11, 17)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveLeft3Click")
$MoveUp3 = GUICtrlCreateButton("/\", 172, 66, 19, 10)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveUp3Click")
$MoveRight3 = GUICtrlCreateButton(">", 200, 85, 11, 17)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveRight3Click")
$FourthPic = GUICtrlCreatePic("", 240, 80, 28, 28)
$MoveDown4 = GUICtrlCreateButton("\/", 244, 111, 19, 10)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveDown4Click")
$MoveLeft4 = GUICtrlCreateButton("<", 224, 85, 11, 17)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveLeft4Click")
$MoveUp4 = GUICtrlCreateButton("/\", 244, 66, 19, 10)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveUp4Click")
$MoveRight4 = GUICtrlCreateButton(">", 272, 85, 11, 17)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent(-1, "MoveRight4Click")
$LogList = GUICtrlCreateList("", 304, 24, 209, 370,BitOR($LBS_NOTIFY,$LBS_DISABLENOSCROLL,$WS_HSCROLL,$WS_VSCROLL,$WS_BORDER))
$LogListcontext = GUICtrlCreateContextMenu($LogList)
$ClearMenu = GUICtrlCreateMenuItem("清空记录", $LogListcontext)
GUICtrlSetOnEvent(-1, "ClearMenuClick")
$LogListLb = GUICtrlCreateLabel("操作记录", 375, 6, 52, 17)
$FirstInput = GUICtrlCreateInput("", 8, 136, 57, 21)
$SecondInput = GUICtrlCreateInput("", 80, 136, 57, 21)
$ThirdInput = GUICtrlCreateInput("", 152, 136, 57, 21)
$FourthInput = GUICtrlCreateInput("", 224, 136, 57, 21)
$FirstBt = GUICtrlCreateButton("1入库", 8, 176, 59, 25)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent($FirstBt, "FirstClick")
$SecondBt = GUICtrlCreateButton("2入库", 80, 176, 59, 25)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent($SecondBt, "SecondClick")
$ThirdBt = GUICtrlCreateButton("3入库", 152, 176, 59, 25)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent($ThirdBt, "ThirdClick")
$FourthBt = GUICtrlCreateButton("4入库", 224, 176, 59, 25)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent($FourthBt, "FourthClick")
$CodeEdit = GUICtrlCreateEdit("", 8, 208, 201, 185)
GUICtrlSetData(-1, "")
$reload = GUICtrlCreateButton("重载", 224, 312, 59, 25)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent($reload, "reloadclick")
$quitbt = GUICtrlCreateButton("退出", 224, 352, 59, 25)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent($quitbt, "form1close")
$ReadBt = GUICtrlCreateButton("识别", 224, 272, 59, 25)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent($ReadBt, "ReadBtClick")
$ResultLb = GUICtrlCreateLabel("结果", 238, 232, 52, 17)
$SetBt = GUICtrlCreateButton(">>", 491, 0, 21, 25)
GUICtrlSetBkColor(-1, $BackCorlor)
GUICtrlSetOnEvent($SetBt, "SetBtClick")
;----设置窗体显示
$SetForm = GUICreate("SetForm", 338, 427, 618, 114,"","",WinGetHandle($form1))
GUISetBkColor(BitOR($BackCorlor,0X00FF00))
GUISetOnEvent($GUI_EVENT_CLOSE, "SetCancelClick")
$SetOK = GUICtrlCreateButton("确认", 72, 341, 75, 25)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent($SetOK, "SetOKClick")
$SetCancel = GUICtrlCreateButton("取消", 184, 341, 75, 25)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetOnEvent($SetCancel, "SetCancelClick")
$widthinput = GUICtrlCreateInput("", 48, 144, 41, 21)
$Heightinput = GUICtrlCreateInput("", 136, 144, 41, 21)
$widthlab = GUICtrlCreateLabel("宽度", 16, 147, 28, 17)
$Heightlab = GUICtrlCreateLabel("高度", 104, 147, 28, 17)
$Info = GUICtrlCreateGroup("验证码信息", 4, -2, 329, 109, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
$picwidth = GUICtrlCreateLabel("宽度:", 24, 37, 71, 17)
$picheight = GUICtrlCreateLabel("高度:", 119, 37, 71, 17)
$lettercount = GUICtrlCreateLabel("字符数量:", 224, 37, 87, 17)
$everywidth = GUICtrlCreateLabel("每字符宽:", 24, 84, 87, 17)
$everyheight = GUICtrlCreateLabel("每字符高:", 119, 84, 87, 17)
$Label2 = GUICtrlCreateLabel("每字符线宽:", 223, 84, 87, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$msg = GUICtrlCreateLabel("设置每个字符参数", 39, 117, 100, 17)
$ModeSelect = GUICtrlCreateCombo("选择模板", 161, 114, 153, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData($ModeSelect, "光通验证码|ASP验证码|ASP-II|杂色验证码|万卡系统|永硕E盘|上下浮动|左右倾斜")
GUICtrlSetOnEvent($ModeSelect, "ModeSelectChange")
$Colorlab = GUICtrlCreateLabel("颜色", 16, 182, 28, 17)
$ColorInput = GUICtrlCreateInput("0XCCCCCC", 48, 178, 129, 21)
$CodeCreateModeCheckBox = GUICtrlCreateCheckbox("自动模式", 120, 208, 73, 17)
GUICtrlSetOnEvent(-1, "CodeCreateModeCheckClick")
$FlgLetterLab = GUICtrlCreateLabel("标志位(F/0)", 208, 209, 93, 17)
$FlgLetterInput = GUICtrlCreateInput("0", 288, 204, 25, 21)
$ZoomPic = GUICtrlCreatePic("", 16, 210, 100, 100)
$ColorUdMsLab = GUICtrlCreateLabel("鼠标下的颜色", 120, 294, 76, 17)
$MousePosLab = GUICtrlCreateLabel("鼠标绝对坐标", 120, 242, 76, 17)
$PosByPicLab = GUICtrlCreateLabel("相对图片坐标", 208, 242, 76, 17)
$MousePos = GUICtrlCreateLabel("", 135, 264, 64, 17)
$MouseByPic = GUICtrlCreateLabel("", 212, 264, 64, 17)
$ColorUdMs = GUICtrlCreateLabel("", 208, 294, 64, 17)
$TopInput = GUICtrlCreateInput("0", 216, 144, 25, 21)
$LeftInput = GUICtrlCreateInput("0", 288, 144, 25, 21)
$jianjuInput = GUICtrlCreateInput("2", 216, 176, 25, 21)
$TopLab = GUICtrlCreateLabel("上边", 184, 147, 28, 17)
$LeftLab = GUICtrlCreateLabel("左边", 256, 147, 28, 17)
$jianjuLab = GUICtrlCreateLabel("间距", 184, 179, 28, 17)

;-----
GUISwitch($form1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	If $SetFlg= True Then
		Local $MousePosInSet=MouseGetPos()
		Local $Form1Pos=WinGetPos($Form1)
		Local $PosColor=""
		If $MousePosInSet[0]>$Form1Pos[0]+20 And $MousePosInSet[0]<$Form1Pos[0]+190 And $MousePosInSet[1]>$Form1Pos[1]+30 And $MousePosInSet[1]<$Form1Pos[1]+89 Then
			_ScreenCapture_Capture(@TempDir&"\undermouse.bmp",$MousePosInSet[0]-10,$MousePosInSet[1]-10,$MousePosInSet[0]+10,$MousePosInSet[1]+10,False)
	    	GUICtrlSetImage($ZoomPic,@TempDir&"\undermouse.bmp")
			$PosColor=PixelGetColor($MousePosInSet[0],$MousePosInSet[1])
			GUICtrlSetData($ColorUdMs,"0X"&StringTrimLeft(Hex($PosColor),2))
			GUICtrlSetData($MousePos,$MousePosInSet[0]&","&$MousePosInSet[1])
			GUICtrlSetData($MouseByPic,$MousePosInSet[0]-27-$Form1Pos[0]&","&$MousePosInSet[1]-38-$Form1Pos[1])
	    EndIf
		WinMove($SetForm,"",$Form1Pos[0]+$Form1Pos[2],$Form1Pos[1],Default,Default,1)
	EndIf
	Sleep(100)
WEnd
Func CodeCreateModeCheckClick()
	If GUICtrlRead($CodeCreateModeCheckBox)=$GUI_CHECKED Then
		GUICtrlSetData($CodeCreateModeCheckBox,"手动模式")
		$CreateMode="Auto"
	Else
		GUICtrlSetData($CodeCreateModeCheckBox,"自动模式")
		$CreateMode="Hand"
	EndIf
EndFunc
Func ClearMenuClick()  ;清空历史记录
	GUICtrlSetData($LogList,"")
EndFunc
Func Form1Close() ;窗体关闭  删除临时文件,退出.
	FileDelete(@ScriptDir&"\0.bmp")
	FileDelete(@ScriptDir&"\1.bmp")
	FileDelete(@ScriptDir&"\2.bmp")
	FileDelete(@ScriptDir&"\3.bmp")
	Exit
EndFunc
Func ModeSelectChange()
	Switch GUICtrlRead($ModeSelect)
		Case "ASP验证码"
			GUICtrlSetData($LeftInput,2)
			GUICtrlSetData($TopInput,0)
			GUICtrlSetData($jianjuInput,4)
			GUICtrlSetData($Heightinput,10)
			GUICtrlSetData($widthinput,6)
			GUICtrlSetData($ColorInput,"0XCCCCCC")
			GUICtrlSetData($FlgLetterInput,"0")
		Case "光通验证码"
			GUICtrlSetData($LeftInput,4)
			GUICtrlSetData($TopInput,5)
			GUICtrlSetData($jianjuInput,2)
			GUICtrlSetData($Heightinput,12)
			GUICtrlSetData($widthinput,8)
			GUICtrlSetData($ColorInput,"0XCCCCCC")
			GUICtrlSetData($FlgLetterInput,"0")
		Case "ASP-II"
			GUICtrlSetData($LeftInput,5)
			GUICtrlSetData($TopInput,1)
			GUICtrlSetData($jianjuInput,1)
			GUICtrlSetData($Heightinput,8)
			GUICtrlSetData($widthinput,5)
			GUICtrlSetData($ColorInput,"0XCCCCCC")
			GUICtrlSetData($FlgLetterInput,"0")
		Case "杂色验证码"
			GUICtrlSetData($LeftInput,6)
			GUICtrlSetData($TopInput,3)
			GUICtrlSetData($jianjuInput,5)
			GUICtrlSetData($Heightinput,13)
			GUICtrlSetData($widthinput,8)
			GUICtrlSetData($ColorInput,"0X999999")
			GUICtrlSetData($FlgLetterInput,"0")
		Case "万卡系统"
			GUICtrlSetData($LeftInput,0)
			GUICtrlSetData($TopInput,0)
			GUICtrlSetData($jianjuInput,4)
			GUICtrlSetData($Heightinput,10)
			GUICtrlSetData($widthinput,6)
			GUICtrlSetData($ColorInput,"0XEEEEEE")
			GUICtrlSetData($FlgLetterInput,"0")
		Case "永硕E盘"
			GUICtrlSetData($LeftInput,5)
			GUICtrlSetData($TopInput,4)
			GUICtrlSetData($jianjuInput,1)
			GUICtrlSetData($Heightinput,11)
			GUICtrlSetData($widthinput,8)
			GUICtrlSetData($ColorInput,"0X777777")
			GUICtrlSetData($FlgLetterInput,"F")
		Case "上下浮动"
			GUICtrlSetData($LeftInput,6)
			GUICtrlSetData($TopInput,1)
			GUICtrlSetData($jianjuInput,4)
			GUICtrlSetData($Heightinput,19)
			GUICtrlSetData($widthinput,9)
			GUICtrlSetData($ColorInput,"0X777777")
			GUICtrlSetData($FlgLetterInput,"0")
		Case "左右倾斜"
			GUICtrlSetData($LeftInput,4)
			GUICtrlSetData($TopInput,5)
			GUICtrlSetData($jianjuInput,1)
			GUICtrlSetData($Heightinput,10)
			GUICtrlSetData($widthinput,10)
			GUICtrlSetData($ColorInput,"0X777777")
			GUICtrlSetData($FlgLetterInput,"F")
	EndSwitch
EndFunc

Func SetOKClick()  ;确认设置, 先判断3个值是不是空， 如果为空,日志列表写如出错信息 并返回.不为空,则给3个全局变量赋值,然后存入数据库.
	If GUICtrlRead($widthinput)="" Then
		_GUICtrlListBox_AddString($LogList,"错误,宽度不能为空!")
		Return
	Else
		$iWidth=GUICtrlRead($widthinput)
	EndIf
	If GUICtrlRead($Heightinput)="" Then
		_GUICtrlListBox_AddString($LogList,"错误,高度不能为空!")
		Return
	Else
		$iHeight=GUICtrlRead($Heightinput)
	EndIf
	If GUICtrlRead($ColorInput)="" Then
		_GUICtrlListBox_AddString($LogList,"错误,颜色值不能为空!")
		Return
	Else
		$ColorToRemove=GUICtrlRead($ColorInput)
	EndIf
	$SetFlg=False
	_GUICtrlListBox_AddString($LogList,"设置保存,设置信息为:宽"&$iWidth&",高"&$iHeight)
	_GUICtrlListBox_AddString($LogList,"颜色值为:"&$ColorToRemove)
	_GUICtrlListBox_AddString($LogList,"边界信息:上-"&GUICtrlRead($TopInput)&",左-"&GUICtrlRead($LeftInput)&",间距-"&GUICtrlRead($jianjuInput))
	If $CreateMode="Auto" Then
		_GUICtrlListBox_AddString($LogList,"CODE生成模式为:自动模式")
	Else
		_GUICtrlListBox_AddString($LogList,"CODE生成模式为:手动模式")
	EndIf
	_GUICtrlListBox_AddString($LogList,"标志位为："&GUICtrlRead($FlgLetterInput))
	IniWrite(@ScriptDir&"\set.db","set","iwth",$iWidth)
	IniWrite(@ScriptDir&"\set.db","set","ihth",$iHeight)
	IniWrite(@ScriptDir&"\set.db","set","remcolor",$ColorToRemove)
	IniWrite(@ScriptDir&"\set.db","set","Top",GUICtrlRead($TopInput))
	IniWrite(@ScriptDir&"\set.db","set","Left",GUICtrlRead($LeftInput))
	IniWrite(@ScriptDir&"\set.db","set","Jianju",GUICtrlRead($jianjuInput))
	$SetFlgLet=GUICtrlRead($FlgLetterInput)
	reloadclick()
	GUISwitch($SetForm)
	GUISetState(@SW_HIDE)
EndFunc
Func SetCancelClick()  ;取消按钮, 日志写如信息, 窗体隐藏
	_GUICtrlListBox_AddString($LogList,"取消设置,设置未保存!")
	GUISwitch($SetForm)
	GUISetState(@SW_HIDE)
EndFunc

Func SetBtClick()  ;设置按钮. 设置窗体显示,日志写如图形信息.
	If $Open2="" Then Return _GUICtrlListBox_AddString($LogList,"未加载图形文件,不能设置！")
	$SetFlg=True
	GUICtrlSetCursor($MainPic,3)
	GUICtrlSetData($picwidth,"宽度:"&$Row)
	GUICtrlSetData($picheight,"高度:"&$Cro)
	_GUICtrlListBox_AddString($LogList,"图形信息："&"宽度:"&$Row&",高度:"&$Cro)
	GUICtrlSetData($lettercount,"字符数量:4")
	GUICtrlSetData($everyheight,"每字符高:"&$iHeight)
	GUICtrlSetData($everywidth,"每字符宽:"&$iWidth)
	_GUICtrlListBox_AddString($LogList,"字符数量:4,"&"每字符宽:"&$iWidth&",高:"&$iHeight)
	GUISwitch($SetForm)
	GUISetState(@SW_SHOW)	
EndFunc
Func ReadBtClick() ;识别按钮.   如果无数据库或没加载文件,则日志写如错误信息并返回.
;~ 	$nowtime=TimerInit()
	If Not(FileExists(@ScriptDir&"\data.db")) Then Return _GUICtrlListBox_AddString($LogList,"错误,数据库文件不存在！")
	If $Open2="" Then Return _GUICtrlListBox_AddString($LogList,"未加载图形文件,无法识别！")
	Local $String="",$tempstr="",$CheckNum=0,$dbstend="",$DbArray[200]
	;读4次,因为验证码有4个字符.
	For $i=0 To _FileCountLines(@ScriptDir&"\data.db")-1 Step 1
		$iLine=StringSplit(FileReadLine(@ScriptDir&"\data.db",$i+1),"|",1)
		$DbArray[$i]=$iLine[2]
	Next
	For $i=0 To 3 Step 1
		;读取次数加1,用于判断读取的是第几个字符.
		$CheckNum+=1
		;临时字符串是由函数StartReadCode读取返回.
		StartReadCode(@ScriptDir&"\"&$i&".bmp",$ColorToRemove)
		$NowCode=GetCode()
		Switch $CheckNum
			Case 1
				;查询的是第一个字符,临时字符串和最终查找到的字符串相同,则认为查找成功,否则出错。
				If $NowCode<>False Then
					$string&=$NowCode
					GUICtrlSetData($FirstInput,$string)
					_GUICtrlListBox_AddString($LogList,"查询第一个字符成功！字符为:"&$string)
				Else
					GUICtrlSetData($FirstInput,"-")
					_GUICtrlListBox_AddString($LogList,"查询第一个字符失败！数据库中无记录！")
				EndIf
			Case 2
				If $NowCode<>False Then
					$string&=$NowCode
					GUICtrlSetData($SecondInput,StringRight($string,1))
				    _GUICtrlListBox_AddString($LogList,"查询第二个字符成功！字符为:"&StringRight($string,1))
				Else
					GUICtrlSetData($SecondInput,"-")
				    _GUICtrlListBox_AddString($LogList,"查询第二个字符失败！数据库中无记录！")
				EndIf
			Case 3
				If $NowCode<>False Then
					$string&=$NowCode
					GUICtrlSetData($ThirdInput,StringRight($string,1))
					_GUICtrlListBox_AddString($LogList,"查询第三个字符成功！字符为:"&StringRight($string,1))
				Else
					GUICtrlSetData($ThirdInput,"-")
					_GUICtrlListBox_AddString($LogList,"查询第三个字符失败！数据库中无记录！")
				EndIf
			Case 4
				If $NowCode<>False Then
					$string&=$NowCode
					GUICtrlSetData($FourthInput,StringRight($string,1))
					_GUICtrlListBox_AddString($LogList,"查询第四个字符成功！字符为:"&StringRight($string,1))
				Else
				    GUICtrlSetData($FourthInput,"-")
					_GUICtrlListBox_AddString($LogList,"查询第四个字符失败！数据库中无记录！")
				EndIf
		EndSwitch
	Next
	GUICtrlSetData($ResultLb,$String)
	;最终验证码结果输出.
	If StringLen($string)<4 Then
		_GUICtrlListBox_AddString($LogList,"分析失败，验证码中有缺位！")
	Else
		_GUICtrlListBox_AddString($LogList,"分析成功！验证码为:"&$string)
	EndIf
;~ 	MsgBox(0,"",TimerDiff($nowtime))
EndFunc
Func LoadPicClick()  ;加载图片
	chushihua()
	$message2 = "选择识别码."
	$Open2 = FileOpenDialog($message2, "", "验证码 (*.gif;*.jpg;*.bmp)", 1 )
	If @error Then
		_GUICtrlListBox_AddString($LogList,"加载图片文件失败,原因:没有选择文件!")
	Else
		$Open2 = StringSplit($Open2, "|", @CRLF)
		If $Open2[0] = 1 Then GUICtrlSetImage ($MainPic,$Open2[1])
		_GUICtrlListBox_AddString($LogList,"加载图片文件:"&$Open2[1])
		;以数组中的坐标信息为拆分单元,分割图片,并将图片显示到子图片框.
		myReadImageToArray(0,$Open2[1],$ResPicPos[0][0],$ResPicPos[0][1],$ResPicPos[0][2],$ResPicPos[0][3],False)  ;拆分
		;myReadImageToArray($Num,$ImageFile,$ix0,$iy0,$iX,$iY,$b_Array2d=False)
		GUICtrlSetImage($FirstPic,@ScriptDir&"\0.bmp")
		myReadImageToArray(1,$Open2[1],$ResPicPos[1][0],$ResPicPos[1][1],$ResPicPos[1][2],$ResPicPos[1][3],False)
		GUICtrlSetImage($SecondPic,@ScriptDir&"\1.bmp")
		myReadImageToArray(2,$Open2[1],$ResPicPos[2][0],$ResPicPos[2][1],$ResPicPos[2][2],$ResPicPos[2][3],False)
		GUICtrlSetImage($ThirdPic,@ScriptDir&"\2.bmp")
		myReadImageToArray(3,$Open2[1],$ResPicPos[3][0],$ResPicPos[3][1],$ResPicPos[3][2],$ResPicPos[3][3],False)
		GUICtrlSetImage($FourthPic,@ScriptDir&"\3.bmp")
	EndIf
EndFunc
Func reloadclick()  ;重载图片.
	If $Open2 = "" Then Return
	chushihua()
	If $Open2[0] = 1 Then GUICtrlSetImage ($MainPic,$Open2[1])
	_GUICtrlListBox_AddString($LogList,"重载图片文件:"&$Open2[1])
	myReadImageToArray(0,$Open2[1],$ResPicPos[0][0],$ResPicPos[0][1],$ResPicPos[0][2],$ResPicPos[0][3],False)  ;拆分
	GUICtrlSetImage($FirstPic,@ScriptDir&"\0.bmp")
	myReadImageToArray(1,$Open2[1],$ResPicPos[1][0],$ResPicPos[1][1],$ResPicPos[1][2],$ResPicPos[1][3],False)
	GUICtrlSetImage($SecondPic,@ScriptDir&"\1.bmp")
	myReadImageToArray(2,$Open2[1],$ResPicPos[2][0],$ResPicPos[2][1],$ResPicPos[2][2],$ResPicPos[2][3],False)
	GUICtrlSetImage($ThirdPic,@ScriptDir&"\2.bmp")
	myReadImageToArray(3,$Open2[1],$ResPicPos[3][0],$ResPicPos[3][1],$ResPicPos[3][2],$ResPicPos[3][3],False)
	GUICtrlSetImage($FourthPic,@ScriptDir&"\3.bmp")
EndFunc
;图片1  移动操作函数  开始---
Func MoveUp1Click()  ;图片1上移一象素
	If $Open2=0 Then Return
	$ResPicPos[0][0]=$ResPicPos[0][0]   ;图片上移，则子图片的Y值加1,高度值-1
	$ResPicPos[0][2]=$ResPicPos[0][2]
	If $ResPicPos[0][1]=$Top Then  ;如果图片最上端Y值为0,则有可能是经过了下移,此时图形高度值小于设置的高度.
		$ResPicPos[0][3]=$ResPicPos[0][3]+1  ;则图片高度+1
		If $ResPicPos[0][3]>$iHeight Then  ;如果图片高度大于设置的高度,则认为图形显示的是全部高度.
			$ResPicPos[0][1]+=1  ;此时图形上移就代表图形的上端Y值向下移动一象素, 图形高度等于设置高度减去移动的象素值.
			$ResPicPos[0][3]=$iHeight-$ResPicPos[0][1]+$Top
		Else  ;如果图形高度不大于设置高度,则认为图形确实是经过了下移, 图形上端Y值不变.
			$ResPicPos[0][1]=$ResPicPos[0][1]
		EndIf
	Else  ;如果上端不为0,则认为经过了上移,继续上移即可.
		If $ResPicPos[0][1]>=$iHeight+$Top Then  ;如果图形最上端Y值大于图形高度,则认为图形移动到了最上边, 图形坐标最上端和高度恢复初始值.
			$ResPicPos[0][1]=$Top
			$ResPicPos[0][3]=$iHeight
		Else  ;如果最上端坐标小于图形高度,则继续上移
			$ResPicPos[0][1]+=1
			$ResPicPos[0][3]=$iHeight-$ResPicPos[0][1]+$Top
		EndIf
	EndIf
	;重新从原始图片中拆分出经过移动后的坐标的图形,日志写入当前图片坐标信息,子图形框显示当前子图形.
	myReadImageToArray(0,$Open2[1],$ResPicPos[0][0],$ResPicPos[0][1],$ResPicPos[0][2],$ResPicPos[0][3])  ;拆分
	_GUICtrlListBox_AddString($LogList,"字符1上移一象素:"&$ResPicPos[0][0]&","&$ResPicPos[0][1]&","&$ResPicPos[0][2]&","&$ResPicPos[0][3])
	GUICtrlSetImage($FirstPic,@ScriptDir&"\0.bmp")
	;图形颜色数据信息列表显示当前的子图片处理后的数据信息.
	StartReadCode(@ScriptDir&"\0.bmp",$ColorToRemove)
EndFunc
Func MoveDown1Click()  ;图片1下移一象素
	If $Open2=0 Then Return
	$ResPicPos[0][0]=$ResPicPos[0][0]
	If $ResPicPos[0][1]<>$Top Then  ;如果图片上端坐标不为设置的顶部值, 则代表图形经过了上移动,
		$ResPicPos[0][1]=$ResPicPos[0][1] - 1  ;则将图形的Y坐标-1,直到Y坐标为设置的顶部值.
		$ResPicPos[0][3]=$iHeight-$ResPicPos[0][1]+$Top  ;高度值=10-上端的Y坐标,代表要抓取的区域为上端Y坐标到底部.
	Else   ;如果上端Y坐标为0,则代表图形现在显示的是从最顶端开始
		$ResPicPos[0][1]=$ResPicPos[0][1]  ;则抓取区域上端不变, 下端坐标减1,即高度减1..
		$ResPicPos[0][3]=$ResPicPos[0][3]-1
	EndIf
	$ResPicPos[0][2]=$ResPicPos[0][2]  ;上下移动的时候,图形宽度不变
	If $ResPicPos[0][3]<0 Then $ResPicPos[0][3]=$iHeight  ;如果高度小于0, 则复位.
	myReadImageToArray(0,$Open2[1],$ResPicPos[0][0],$ResPicPos[0][1],$ResPicPos[0][2],$ResPicPos[0][3])  ;拆分
	_GUICtrlListBox_AddString($LogList,"字符1下移一象素:"&$ResPicPos[0][0]&","&$ResPicPos[0][1]&","&$ResPicPos[0][2]&","&$ResPicPos[0][3])
	GUICtrlSetImage($FirstPic,@ScriptDir&"\0.bmp")
	StartReadCode(@ScriptDir&"\0.bmp",$ColorToRemove)
EndFunc
Func MoveRight1Click()   ;图片1右移一象素
	If $Open2=0 Then Return
	$ResPicPos[0][0]=$ResPicPos[0][0] - 1 ;首先将图形左边界坐标减1
	$ResPicPos[0][1]=$ResPicPos[0][1]   ;上端Y不变
	If $ResPicPos[0][1]<$Top Then $ResPicPos[0][1]=$Top  ;上端Y如果小于0,则置0.
	If $ResPicPos[0][0]<$Left Then
		$ResPicPos[0][0]=$Left
		If $ResPicPos[0][2]>0 Then  ;如果抓图宽度小于0,则将抓图宽度恢复.
			$ResPicPos[0][2]=$ResPicPos[0][2] -1
		Else
			$ResPicPos[0][2]=$iWidth
		EndIf
	Else
		$ResPicPos[0][2]=$ResPicPos[0][2]
	EndIf
	$ResPicPos[0][3]=$ResPicPos[0][3]
	myReadImageToArray(0,$Open2[1],$ResPicPos[0][0],$ResPicPos[0][1],$ResPicPos[0][2],$ResPicPos[0][3])  ;拆分
	GUICtrlSetImage($FirstPic,@ScriptDir&"\0.bmp")
	StartReadCode(@ScriptDir&"\0.bmp",$ColorToRemove)
	_GUICtrlListBox_AddString($LogList,"字符1右移一象素:"&$ResPicPos[0][0]&","&$ResPicPos[0][1]&","&$ResPicPos[0][2]&","&$ResPicPos[0][3])
EndFunc
Func MoveLef1Click()  ;图片1左移一象素
	If $Open2=0 Then Return
		$ResPicPos[0][1]=$ResPicPos[0][1]
	If $ResPicPos[0][2]<$iWidth Then
		$ResPicPos[0][2]+=1
	Else
		$ResPicPos[0][0]=$ResPicPos[0][0] +1
	    If $ResPicPos[0][0]>$iWidth+$Left Then $ResPicPos[0][0]=$Left
		$ResPicPos[0][2]=$ResPicPos[0][2]
	EndIf
	$ResPicPos[0][3]=$ResPicPos[0][3]
	myReadImageToArray(0,$Open2[1],$ResPicPos[0][0],$ResPicPos[0][1],$ResPicPos[0][2],$ResPicPos[0][3])  ;拆分
	GUICtrlSetImage($FirstPic,@ScriptDir&"\0.bmp")
	StartReadCode(@ScriptDir&"\0.bmp",$ColorToRemove)
	_GUICtrlListBox_AddString($LogList,"字符1左移一象素:"&$ResPicPos[0][0]&","&$ResPicPos[0][1]&","&$ResPicPos[0][2]&","&$ResPicPos[0][3])
EndFunc
;图片1  移动函数结束

;图片2  移动操作函数开始---
Func MoveUp2Click()  ;图片2上移一象素
	If $Open2=0 Then Return
	$ResPicPos[1][0]=$ResPicPos[1][0]   ;图片上移，则子图片的Y值加1,高度值-1
	$ResPicPos[1][2]=$ResPicPos[1][2]
	If $ResPicPos[1][1]=$Top Then
		$ResPicPos[1][3]=$ResPicPos[1][3]+1
		If $ResPicPos[1][3]>$iHeight Then
			$ResPicPos[1][1]+=1
			$ResPicPos[1][3]=$iHeight-$ResPicPos[1][1]+$Top
		Else
			$ResPicPos[1][1]=$ResPicPos[1][1]
		EndIf
	Else
		If $ResPicPos[1][1]>=$iHeight+$Top Then
			$ResPicPos[1][1]=$Top
			$ResPicPos[1][3]=$iHeight
		Else
			$ResPicPos[1][1]+=1
			$ResPicPos[1][3]=$iHeight-$ResPicPos[1][1]+$Top
		EndIf
	EndIf
	myReadImageToArray(1,$Open2[1],$ResPicPos[1][0],$ResPicPos[1][1],$ResPicPos[1][2],$ResPicPos[1][3])  ;拆分
	_GUICtrlListBox_AddString($LogList,"字符2上移一象素:"&$ResPicPos[1][0]&","&$ResPicPos[1][1]&","&$ResPicPos[1][2]&","&$ResPicPos[1][3])
	GUICtrlSetImage($SecondPic,@ScriptDir&"\1.bmp")
	StartReadCode(@ScriptDir&"\1.bmp",$ColorToRemove)
EndFunc
Func MoveDown2Click()  ;图片2下移一象素
	If $Open2=0 Then Return
	$ResPicPos[1][0]=$ResPicPos[1][0]
	If $ResPicPos[1][1]<>$Top Then  ;如果图片上端坐标不为0, 则代表图形经过了上移动,
		$ResPicPos[1][1]=$ResPicPos[1][1] - 1  ;则将图形的Y坐标-1,直到Y坐标为0.
		$ResPicPos[1][3]=$iHeight-$ResPicPos[1][1]+$Top  ;高度值=10-上端的Y坐标,代表要抓取的区域为上端Y坐标到底部.
	Else   ;如果上端Y坐标为0,则代表图形现在显示的是从最顶端开始
		$ResPicPos[1][1]=$ResPicPos[1][1]  ;则抓取区域上端不变, 下端坐标减1,即高度减1..
		$ResPicPos[1][3]=$ResPicPos[1][3]-1
	EndIf
	$ResPicPos[1][2]=$ResPicPos[1][2]
	If $ResPicPos[1][3]<0 Then $ResPicPos[1][3]=$iHeight
	myReadImageToArray(1,$Open2[1],$ResPicPos[1][0],$ResPicPos[1][1],$ResPicPos[1][2],$ResPicPos[1][3])  ;拆分
	_GUICtrlListBox_AddString($LogList,"字符2下移一象素:"&$ResPicPos[1][0]&","&$ResPicPos[1][1]&","&$ResPicPos[1][2]&","&$ResPicPos[1][3])
	GUICtrlSetImage($SecondPic,@ScriptDir&"\1.bmp")
	StartReadCode(@ScriptDir&"\1.bmp",$ColorToRemove)
EndFunc
Func MoveRight2Click()  ;图片2右移一象素
	If $Open2=0 Then Return
	$ResPicPos[1][0]=$ResPicPos[1][0] - 1
	$ResPicPos[1][1]=$ResPicPos[1][1]
	If $ResPicPos[1][1]<$Top Then $ResPicPos[1][1]=$Top
	If $ResPicPos[1][0]>=$Left Then
		$ResPicPos[1][0]=$ResPicPos[1][0]
	Else
		$ResPicPos[1][0]=$iWidth+$Left+$Jianju
	EndIf
	$ResPicPos[1][3]=$ResPicPos[1][3]
	myReadImageToArray(1,$Open2[1],$ResPicPos[1][0],$ResPicPos[1][1],$ResPicPos[1][2],$ResPicPos[1][3])  ;拆分
	GUICtrlSetImage($SecondPic,@ScriptDir&"\1.bmp")
	StartReadCode(@ScriptDir&"\1.bmp",$ColorToRemove)
	_GUICtrlListBox_AddString($LogList,"字符2右移一象素:"&$ResPicPos[1][0]&","&$ResPicPos[1][1]&","&$ResPicPos[1][2]&","&$ResPicPos[1][3])
EndFunc
Func MoveLeft2Click()  ;图片2左移一象素
	If $Open2=0 Then Return
	$ResPicPos[1][0]=$ResPicPos[1][0] +1
	$ResPicPos[1][1]=$ResPicPos[1][1]
	If $ResPicPos[1][0]<($iWidth*2+$Left+$Jianju*2) Then
		$ResPicPos[1][0]=$ResPicPos[1][0]
	Else
		$ResPicPos[1][0]=$iWidth+$Left+$Jianju 
	EndIf
	$ResPicPos[1][3]=$ResPicPos[1][3]
	myReadImageToArray(1,$Open2[1],$ResPicPos[1][0],$ResPicPos[1][1],$ResPicPos[1][2],$ResPicPos[1][3])  ;拆分
	GUICtrlSetImage($SecondPic,@ScriptDir&"\1.bmp")
	StartReadCode(@ScriptDir&"\1.bmp",$ColorToRemove)
	_GUICtrlListBox_AddString($LogList,"字符2左移一象素:"&$ResPicPos[1][0]&","&$ResPicPos[1][1]&","&$ResPicPos[1][2]&","&$ResPicPos[1][3])
EndFunc
;图片2  移动操作函数结束

;~ 图片3  移动操作函数开始---
Func MoveUp3Click()   ;图片3上移一象素
	If $Open2=0 Then Return
	$ResPicPos[2][0]=$ResPicPos[2][0]   ;图片上移，则子图片的Y值加1,高度值-1
	$ResPicPos[2][2]=$ResPicPos[2][2]
	If $ResPicPos[2][1]=$Top Then
		$ResPicPos[2][3]=$ResPicPos[2][3]+1
		If $ResPicPos[2][3]>$iHeight Then
			$ResPicPos[2][1]+=1
			$ResPicPos[2][3]=$iHeight-$ResPicPos[2][1]+$Top
		Else
			$ResPicPos[2][1]=$ResPicPos[2][1]
		EndIf
	Else
		If $ResPicPos[2][1]>=$iHeight+$Top Then
			$ResPicPos[2][1]=$Top
			$ResPicPos[2][3]=$iHeight
		Else
			$ResPicPos[2][1]+=1
			$ResPicPos[2][3]=$iHeight-$ResPicPos[2][1]+$Top
		EndIf
	EndIf
	myReadImageToArray(2,$Open2[1],$ResPicPos[2][0],$ResPicPos[2][1],$ResPicPos[2][2],$ResPicPos[2][3])  ;拆分
	_GUICtrlListBox_AddString($LogList,"字符3上移一象素:"&$ResPicPos[2][0]&","&$ResPicPos[2][1]&","&$ResPicPos[2][2]&","&$ResPicPos[2][3])
	GUICtrlSetImage($ThirdPic,@ScriptDir&"\2.bmp")
	StartReadCode(@ScriptDir&"\2.bmp",$ColorToRemove)
EndFunc
Func MoveDown3Click()  ;图片3下移一象素
	If $Open2=0 Then Return
	$ResPicPos[2][0]=$ResPicPos[2][0]
	If $ResPicPos[2][1]<>$Top Then  ;如果图片上端坐标不为0, 则代表图形经过了上移动,
		$ResPicPos[2][1]=$ResPicPos[2][1] - 1  ;则将图形的Y坐标-1,直到Y坐标为0.
		$ResPicPos[2][3]=$iHeight-$ResPicPos[2][1]+$Top  ;高度值=10-上端的Y坐标,代表要抓取的区域为上端Y坐标到底部.
	Else   ;如果上端Y坐标为0,则代表图形现在显示的是从最顶端开始
		$ResPicPos[2][1]=$ResPicPos[2][1]  ;则抓取区域上端不变, 下端坐标减1,即高度减1..
		$ResPicPos[2][3]=$ResPicPos[2][3]-1
	EndIf
	$ResPicPos[2][2]=$ResPicPos[2][2]
	If $ResPicPos[2][3]<0 Then $ResPicPos[2][3]=$iHeight
	myReadImageToArray(2,$Open2[1],$ResPicPos[2][0],$ResPicPos[2][1],$ResPicPos[2][2],$ResPicPos[2][3])  ;拆分
	_GUICtrlListBox_AddString($LogList,"字符3下移一象素:"&$ResPicPos[2][0]&","&$ResPicPos[2][1]&","&$ResPicPos[2][2]&","&$ResPicPos[2][3])
	GUICtrlSetImage($ThirdPic,@ScriptDir&"\2.bmp")
	StartReadCode(@ScriptDir&"\2.bmp",$ColorToRemove)
EndFunc
Func MoveRight3Click()   ;图片3右移一象素
	If $Open2=0 Then Return
	$ResPicPos[2][0]=$ResPicPos[2][0] - 1
	$ResPicPos[2][1]=$ResPicPos[2][1]
	If $ResPicPos[2][1]<$Top Then $ResPicPos[2][1]=$Top
	If $ResPicPos[2][0]>=($iWidth+$Left+$Jianju) Then
		$ResPicPos[2][0]=$ResPicPos[2][0]
	Else
		$ResPicPos[2][0]=$iWidth*2+$Left+$Jianju*2
	EndIf
	$ResPicPos[2][3]=$ResPicPos[2][3]
	myReadImageToArray(2,$Open2[1],$ResPicPos[2][0],$ResPicPos[2][1],$ResPicPos[2][2],$ResPicPos[2][3])  ;拆分
	GUICtrlSetImage($ThirdPic,@ScriptDir&"\2.bmp")
	_GUICtrlListBox_AddString($LogList,"字符3右移一象素:"&$ResPicPos[2][0]&","&$ResPicPos[2][1]&","&$ResPicPos[2][2]&","&$ResPicPos[2][3])
    StartReadCode(@ScriptDir&"\2.bmp",$ColorToRemove)
EndFunc
Func MoveLeft3Click()   ;图片3左移一象素
	If $Open2=0 Then Return
	$ResPicPos[2][0]=$ResPicPos[2][0] +1
	$ResPicPos[2][1]=$ResPicPos[2][1]
	If $ResPicPos[2][0]<($iWidth*3+$Left+$Jianju*3) Then
		$ResPicPos[2][0]=$ResPicPos[2][0]
	Else
		$ResPicPos[2][0]=$iWidth*2+$Left+$Jianju*2
	EndIf
	$ResPicPos[2][3]=$ResPicPos[2][3]
	myReadImageToArray(2,$Open2[1],$ResPicPos[2][0],$ResPicPos[2][1],$ResPicPos[2][2],$ResPicPos[2][3])  ;拆分
	GUICtrlSetImage($ThirdPic,@ScriptDir&"\2.bmp")
	_GUICtrlListBox_AddString($LogList,"字符3左移一象素:"&$ResPicPos[2][0]&","&$ResPicPos[2][1]&","&$ResPicPos[2][2]&","&$ResPicPos[2][3])
    StartReadCode(@ScriptDir&"\2.bmp",$ColorToRemove)
EndFunc
;~ ;图片3  移动操作函数结束

;图片4  移动操作函数开始---
Func MoveUp4Click()   ;图片4上移一象素
	If $Open2=0 Then Return
	$ResPicPos[3][0]=$ResPicPos[3][0]   ;图片上移，则子图片的Y值加1,高度值-1
	$ResPicPos[3][2]=$ResPicPos[3][2]
	If $ResPicPos[3][1]=$Top Then
		$ResPicPos[3][3]=$ResPicPos[3][3]+1
		If $ResPicPos[3][3]>$iHeight Then
			$ResPicPos[3][1]+=1
			$ResPicPos[3][3]=$iHeight-$ResPicPos[3][1]+$Top
		Else
			$ResPicPos[3][1]=$ResPicPos[3][1]
		EndIf
	Else
		If $ResPicPos[3][1]>=$iHeight+$Top Then
			$ResPicPos[3][1]=$Top
			$ResPicPos[3][3]=$iHeight
		Else
			$ResPicPos[3][1]+=1
			$ResPicPos[3][3]=$iHeight-$ResPicPos[3][1]+$Top
		EndIf
	EndIf
	myReadImageToArray(3,$Open2[1],$ResPicPos[3][0],$ResPicPos[3][1],$ResPicPos[3][2],$ResPicPos[3][3])  ;拆分
	_GUICtrlListBox_AddString($LogList,"字符4上移一象素:"&$ResPicPos[3][0]&","&$ResPicPos[3][1]&","&$ResPicPos[3][2]&","&$ResPicPos[3][3])
	GUICtrlSetImage($FourthPic,@ScriptDir&"\3.bmp")
	StartReadCode(@ScriptDir&"\3.bmp",$ColorToRemove)
EndFunc
Func MoveDown4Click()  ;图片4下移一象素
	If $Open2=0 Then Return
	$ResPicPos[3][0]=$ResPicPos[3][0]
	If $ResPicPos[3][1]<>$Top Then  ;如果图片上端坐标不为0, 则代表图形经过了上移动,
		$ResPicPos[3][1]=$ResPicPos[3][1] - 1  ;则将图形的Y坐标-1,直到Y坐标为0.
		$ResPicPos[3][3]=$iHeight-$ResPicPos[3][1]+$Top  ;高度值=10-上端的Y坐标,代表要抓取的区域为上端Y坐标到底部.
	Else   ;如果上端Y坐标为0,则代表图形现在显示的是从最顶端开始
		$ResPicPos[3][1]=$ResPicPos[3][1]  ;则抓取区域上端不变, 下端坐标减1,即高度减1..
		$ResPicPos[3][3]=$ResPicPos[3][3]-1
	EndIf
	$ResPicPos[3][2]=$ResPicPos[3][2]
	If $ResPicPos[3][3]<0 Then $ResPicPos[3][3]=$iHeight
	myReadImageToArray(3,$Open2[1],$ResPicPos[3][0],$ResPicPos[3][1],$ResPicPos[3][2],$ResPicPos[3][3])  ;拆分
	_GUICtrlListBox_AddString($LogList,"字符4下移一象素:"&$ResPicPos[3][0]&","&$ResPicPos[3][1]&","&$ResPicPos[3][2]&","&$ResPicPos[3][3])
	GUICtrlSetImage($FourthPic,@ScriptDir&"\3.bmp")
    StartReadCode(@ScriptDir&"\3.bmp",$ColorToRemove)
EndFunc
Func MoveRight4Click()  ;图片4右移一象素
	If $Open2=0 Then Return
	$ResPicPos[3][0]=$ResPicPos[3][0] - 1
	$ResPicPos[3][1]=$ResPicPos[3][1]
	If $ResPicPos[3][1]<0 Then $ResPicPos[3][1]=0
	If $ResPicPos[3][0]>=($iWidth*2+$Left+$Jianju*2) Then
		$ResPicPos[3][0]=$ResPicPos[3][0]
		If $ResPicPos[3][2]<$iWidth Then $ResPicPos[3][2]+=1
	Else
		$ResPicPos[3][0]=$iWidth*3+$Left+$Jianju*3 
	EndIf
	$ResPicPos[3][3]=$ResPicPos[3][3]
	myReadImageToArray(3,$Open2[1],$ResPicPos[3][0],$ResPicPos[3][1],$ResPicPos[3][2],$ResPicPos[3][3])  ;拆分
	GUICtrlSetImage($FourthPic,@ScriptDir&"\3.bmp")
	_GUICtrlListBox_AddString($LogList,"字符4右移一象素:"&$ResPicPos[3][0]&","&$ResPicPos[3][1]&","&$ResPicPos[3][2]&","&$ResPicPos[3][3])
    StartReadCode(@ScriptDir&"\3.bmp",$ColorToRemove)
EndFunc
Func MoveLeft4Click()  ;图片4左移一象素
	If $Open2=0 Then Return
	$ResPicPos[3][0]=$ResPicPos[3][0] +1
	$ResPicPos[3][1]=$ResPicPos[3][1]
	
	If $ResPicPos[3][0]<$iWidth*4+$Left+$Jianju*3 Then
		$ResPicPos[3][0]=$ResPicPos[3][0]
		$ResPicPos[3][2]=$iWidth*4+$Left+$Jianju*3-$ResPicPos[3][0]
		If $ResPicPos[3][2]<0 Then $ResPicPos[3][2]=$iWidth
	Else
		$ResPicPos[3][0]=$iWidth*3+$Left+$Jianju*3 
		$ResPicPos[3][2]=$iWidth
	EndIf
	$ResPicPos[3][3]=$ResPicPos[3][3]
	;myReadImageToArray($Num,$ImageFile,$ix0,$iy0,$iX,$iY,$b_Array2d=False)
	myReadImageToArray(3,$Open2[1],$ResPicPos[3][0],$ResPicPos[3][1],$ResPicPos[3][2],$ResPicPos[3][3])  ;拆分
	GUICtrlSetImage($FourthPic,@ScriptDir&"\3.bmp")
	_GUICtrlListBox_AddString($LogList,"字符4左移一象素:"&$ResPicPos[3][0]&","&$ResPicPos[3][1]&","&$ResPicPos[3][2]&","&$ResPicPos[3][3])
    StartReadCode(@ScriptDir&"\3.bmp",$ColorToRemove)
EndFunc
;图片4  移动操作函数结束

;检查库中是否有该验证码。
Func CheckCodeIsInDb($CheckString)
	;定义一个检查变量，为真则代表数据库有记录，为假则代表数据库中无记录。
	Local $CheckResult=False
    ;从数据库文件第一行开始读到倒数第二行.
	For $i=0 To _FileCountLines(@ScriptDir&"\data.db")-1 Step 1
		;拆分读到的字符串
		$iL=StringSplit(FileReadLine(@ScriptDir&"\data.db",$i+1),"|",1)
;~ 		_ArrayDisplay($iL,"")
        ;检查字符串和读到的字符串是否相同.
		If $CheckString=StringRight($iL[1],2)&"|"&$iL[2] Then
			$CheckResult=True
			ExitLoop
		Else
			$CheckResult=False
		EndIf
	Next
	Return $CheckResult
EndFunc
;结束

;将Edit控件中的信息转换成点阵信息。
Func EdittextPointInfo($EditHwnd,$FlgLetter,$ReturnFlg="string")
	;首先将EDIT控件中的数值按换行符拆分成一个数组.
	Local $EditArray=StringSplit(GUICtrlRead($EditHwnd),@CRLF,1)
	;定义一个高度和宽度为验证码的高和宽的一个二维数组,用于存放点阵.
	Local $ArrayEveryMem[$iHeight][$iWidth]
	; $FlgCount 指的是找到标志位次数 $PointInfoString 点阵信息.
	Local $FlgCount=0,$PointInfoString=""
	;二级For循环给点阵数组赋值.
	For $i=0 To $iWidth-1 Step 1
		For $j=0 To $iHeight-1 Step 1
			;点阵数组该位置的元素等于 EDIT控件数组中的相应行中的第$i+1个元素.
			;因为点阵数组定义的下标是从0开始,而控件数组中的元素是通过函数返回的,下标是从1开始.
			$ArrayEveryMem[$j][$i]=StringMid($EditArray[$j+1],$i+1,1)
			;如果该位置的字符为标志字符, 则找到次数加1, 点阵信息字符串记录该位置坐标.
			If $ArrayEveryMem[$j][$i]=$FlgLetter Then
				$FlgCount+=1
				$PointInfoString&=$j&":"&$i&","
			EndIf
		Next
	Next
	;最后,将找到次数和点阵信息再组合到一起返回.
	$PointInfoString=StringTrimRight($FlgCount&"|"&$PointInfoString,1)
	;如果要返回字符串,则返回 $PointInfoString , 如果要返回数组  则返回 $ArrayEveryMem 
	If $ReturnFlg="string" Then
		Return $PointInfoString
	ElseIf $ReturnFlg="array" Then
		Return $ArrayEveryMem
	EndIf
EndFunc
;点阵转换结束

;获取字符
Func GetCode()
	;定义一个数值用于存储出现标志位的次数。
	;$P 是一个数组,用于存放数据库中的标志信息的两个坐标值.
	Local $count=0,$p  
	Local $DBinFile[200]
	For $m=0 To _FileCountLines(@ScriptDir&"\data.db")-1 Step 1
		$DBinFile[$m]=FileReadLine(@ScriptDir&"\data.db",$m+1)
	Next
	;将当前的EDIT控件中的数据拆成 二维数组.
	$NowEditArray=EdittextPointInfo($CodeEdit,$SetFlgLet,"Array")
;~ 	_ArrayDisplay($NowEditArray,"当前EDIT中的信息")
	;优化后的算法， 不用遍历EDIT数组了，直接调用数据库中的点阵信息对比EDIT数组中的相应元素即可。
	For $n=0 To _FileCountLines(@ScriptDir&"\data.db")-1 Step 1
		$count=0
		;将数据库中的点阵信息按|拆分成数组,数组第一个元素存放的是出现标志位的次数和点阵对应的字符,第二个元素是标志位的坐标.
		$Data=StringSplit($DBinFile[$n],"|",1)
;~ 		_ArrayDisplay($Data,"拆分数据库中信息后")
		;将标志位的坐标拆分成单个点阵信息.
		$Point=StringSplit($Data[2],",",1)
;~ 		_ArrayDisplay($Point,"拆分点阵--"&$Data[1])
		;遍历点阵信息数组.
		For $k=1 To $Point[0] Step 1
			;先将每个点阵信息拆成2个坐标值.
			$p=StringSplit($Point[$k],":",1)
			$_Edit_X=$p[1]
			$_Edit_Y=$p[2]
			;如果拆出来的下标信息比返回的EDIT数组边界大，则代表一定不是该字符。直接退出。
			If $_Edit_X>UBound($NowEditArray)-1 Or $_Edit_Y>UBound($NowEditArray,2)-1 Then ExitLoop
			;如果当前EDIT数组中的相应元素为标志位,则代表找到,找到次数加1,
			;如果该坐标点的字符跟标志字符不同，也证明不是该字符，直接退出。
			If $NowEditArray[$_Edit_X][$_Edit_Y]=$SetFlgLet Then
				$count+=1
			Else 
				ExitLoop
			EndIf
		Next
		;如果最终的找到次数等于 点阵信息的次数,则代表该EDIT数组中存放的就是该数字的点阵.
		If $count=StringRight($Data[1],2) Then
			$Seached=StringLeft($Data[1],1)
			ExitLoop
		Else
			$Seached=False
		EndIf
	Next
	Return $Seached
EndFunc
;

;图片验证码入库
Func FirstClick()  ;第一个识别码入库
	Local $Code=GUICtrlRead($FirstInput)  ;从第一个验证码输入框读取要入库的数据是哪个字符
	$CodeDB=""
	If $CreateMode="Auto" Then startreadcode(@ScriptDir&"\0.bmp",$ColorToRemove)
	$CodeDB=EdittextPointInfo($CodeEdit,$SetFlgLet)
	$Checked=CheckCodeIsInDb($CodeDB)
	If $Code="" Then
		_GUICtrlListBox_AddString($LogList,"你什么都不输，让数据库学什么？")
		Return
	Else
		If $Checked=True Then
			_GUICtrlListBox_AddString($LogList,"数据库中已有该记录，不必再学习了！")
		Else
			FileWriteLine(@ScriptDir&"\data.db",$Code&","&$CodeDB)
			_GUICtrlListBox_AddString($LogList,"字符一入库成功！内容为"&$Code&","&$CodeDB)
		EndIf
	EndIf
EndFunc
Func SecondClick()  ;第二个验证码设置完毕后,入库
	Local $Code=GUICtrlRead($SecondInput)  ;从第一个验证码输入框读取要入库的数据是哪个字符
	$CodeDB=""
    If $CreateMode="Auto" Then startreadcode(@ScriptDir&"\1.bmp",$ColorToRemove)
	$CodeDB=EdittextPointInfo($CodeEdit,$SetFlgLet)
	$Checked=CheckCodeIsInDb($CodeDB)
	If $Code="" Then
		_GUICtrlListBox_AddString($LogList,"你什么都不输，让数据库学什么？")
		Return
	Else
		If $Checked=True Then
			_GUICtrlListBox_AddString($LogList,"数据库中已有该记录，不必再学习了！")
		Else
			FileWriteLine(@ScriptDir&"\data.db",$Code&","&$CodeDB)
			_GUICtrlListBox_AddString($LogList,"字符二入库成功！内容为"&$Code&","&$CodeDB)
		EndIf
	EndIf
EndFunc
Func ThirdClick()  ;第三个验证码设置完毕后,入库
	Local $Code=GUICtrlRead($ThirdInput)  ;从第一个验证码输入框读取要入库的数据是哪个字符
	$CodeDB=""
    If $CreateMode="Auto" Then startreadcode(@ScriptDir&"\2.bmp",$ColorToRemove)
	$CodeDB=EdittextPointInfo($CodeEdit,$SetFlgLet)
	$Checked=CheckCodeIsInDb($CodeDB)
	If $Code="" Then
		_GUICtrlListBox_AddString($LogList,"你什么都不输，让数据库学什么？")
		Return
	Else
		If $Checked=True Then
			_GUICtrlListBox_AddString($LogList,"数据库中已有该记录，不必再学习了！")
		Else
			FileWriteLine(@ScriptDir&"\data.db",$Code&","&$CodeDB)
			_GUICtrlListBox_AddString($LogList,"字符三入库成功！内容为"&$Code&","&$CodeDB)
		EndIf
	EndIf
EndFunc
Func FourthClick()   ;第四个验证码设置完毕后,入库
	Local $Code=GUICtrlRead($FourthInput)  ;从第一个验证码输入框读取要入库的数据是哪个字符
	$CodeDB=""
	If $CreateMode="Auto" Then startreadcode(@ScriptDir&"\3.bmp",$ColorToRemove)
	$CodeDB=EdittextPointInfo($CodeEdit,$SetFlgLet)
	$Checked=CheckCodeIsInDb($CodeDB)
	If $Code="" Then
		_GUICtrlListBox_AddString($LogList,"你什么都不输，让数据库学什么？")
		Return
	Else
		If $Checked=True Then
			_GUICtrlListBox_AddString($LogList,"数据库中已有该记录，不必再学习了！")
		Else
			FileWriteLine(@ScriptDir&"\data.db",$Code&","&$CodeDB)
			_GUICtrlListBox_AddString($LogList,"字符四入库成功！内容为"&$Code&","&$CodeDB)
		EndIf
	EndIf
EndFunc

Func myArrayChangeSC($func_array, $func_sc_type=0, $func_sc=0x777777, $func_bg=0xffffff);数组中的颜色值做黑白变化
        If Not IsArray($func_array) Or $func_sc_type<1 Or $func_sc_type>3 Or $func_sc_type=0 Then Return $func_array
        If UBound($func_array,2)>0 Then;二维
                Local $i_width=UBound($func_array,1)
                Local $i_height=UBound($func_array,2)
                Local $a_return[$i_width][$i_height], $x, $y, $s
                For $y=0 To $i_height-1
                        For $x= 0 To $i_width-1
                                $a_return[$x][$y]= $func_array[$x][$y]
                                Select
                                Case $func_sc_type=1;黑白
                                        If $a_return[$x][$y]>=$func_sc Then
                                                $a_return[$x][$y]=$func_bg
                                        Else
                                                $a_return[$x][$y]=0
                                        EndIf
                                Case $func_sc_type=2;反相黑白
                                        If $a_return[$x][$y]<$func_sc Then
                                                $a_return[$x][$y]=$func_bg
                                        Else
                                                $a_return[$x][$y]=0
                                        EndIf
                                Case $func_sc_type=3;相当于=1,但黑色用原色代替(就是保留原色)
                                        If $a_return[$x][$y]>=$func_sc Then
                                                $a_return[$x][$y]=$func_bg
                                        EndIf
                                EndSelect
                        Next
                Next
        Else
                Local $i_height=UBound($func_array)
                Local $a_return[$i_height], $y
                For $y=0 To $i_height-1
                        $a_return[$y] = myChangeRegExpSC($func_array[$y], $func_sc_type, $func_sc, $func_bg);正则变化
                Next
        EndIf
        Return $a_return
EndFunc

;以下三个函数都是供myArrayChangeSC使用的,不做详细介绍了
Func myChangeRegExpSC($func_string, $func_sc_type=1, $func_sc=0x777777, $func_bg=0xffffff);将串做黑白变化
        If $func_string="" Or $func_sc_type<1 Or $func_sc_type>3 Or Mod(StringLen($func_string),6)<>0 Then Return $func_string
        $func_string = StringRegExpReplace($func_string, ".{6}", "$0,")
        $func_sc = myGetRegExpSC($func_sc)
        $func_string = StringRegExpReplace($func_string,$func_sc,"______")
        Select
        Case $func_sc_type=1
                $func_string = StringRegExpReplace($func_string,"[0-9A-F]{6},","000000")
                $func_string = StringReplace($func_string,"______,",Hex($func_bg,6))
        Case $func_sc_type=2
                $func_string = StringRegExpReplace($func_string,"[0-9A-F]{6},",Hex($func_bg,6))
                $func_string = StringReplace($func_string,"______,","000000")
        Case $func_sc_type=3
                $func_string = StringReplace($func_string,"______,",Hex($func_bg,6))
                $func_string = StringReplace($func_string,",", "")
        EndSelect 
        Return $func_string
EndFunc
Func myGetRegExpSC($func_sc=0x777777);获取变化黑白临界值的正则表达式,供myChangeRegExpSC调用
        $func_sc=Hex($func_sc,6)
        Local $i,$s,$s_RegExp
        For $i=1 To 6
                $s=StringLeft($func_sc,$i)
                If StringRight($s,1)<>"F" Then
                        Select
                        Case $i=6
                                $s_RegExp &= myRegExp(StringLeft($s,5)) & myRegExp(StringRight($s,1))
                        Case $i=5
                                $s_RegExp &=myRegExp(Hex(Number("0x"&$s)+1,$i))&"[0-9A-F]|"
                        Case Else
                                $s_RegExp &=myRegExp(Hex(Number("0x"&$s)+1,$i)) & "[0-9A-F]{"&6-$i&"}|"
                        EndSelect
                EndIf
        Next
        If StringRight($s_RegExp,1)="|" Then $s_RegExp=StringTrimRight($s_RegExp,1)
        Return $s_RegExp
EndFunc
Func myRegExp($func_string);供myGetRegExpSC调用,单字符转正则
        If $func_string="" Then Return ""
        Local $s_RegExp="", $s_tmp=""
        For $i=1 To StringLen($func_string)
                $s_tmp=Number("0x"&StringMid($func_string, $i,1))
                Select
                Case $s_tmp<9
                        $s_RegExp &="["&$s_tmp &"-9A-F]"
                Case $s_tmp=9
                        $s_RegExp &="[9A-F]"
                Case $s_tmp=0xF
                        $s_RegExp &="[F]"
                Case Else
                        $s_RegExp &="["&Hex($s_tmp,1)&"-F]"
                EndSelect
        Next
        Return $s_RegExp
EndFunc
;以下为前面已经说明过的函数,将图形文件读入二维数组

;-----------------------------------------------------------------------------------------------
Func myReadImageToArray($Num,$ImageFile,$ix0,$iy0,$iX,$iY,$b_Array2d=False);成功则返回数组.失败返回0.$b_Array2d=True返回二维数组,=False返回一维数组
    Local $hBitmap, $BitmapData, $i_width, $i_height, $Scan0, $pixelData, $s_BMPData, $i_Stride
	Local $hClone, $hImage
	_GDIPlus_Startup()
    $hBitmap = _GDIPlus_BitmapCreateFromFile($ImageFile)
	$i_width = _GDIPlus_ImageGetWidth($hBitmap)
	$i_height = _GDIPlus_ImageGetHeight($hBitmap)
	$Row=$i_width
	$Cro=$i_height
	$hClone = _GDIPlus_BitmapCloneArea($hBitmap, $ix0, $iy0, $iX, $iY)
	_GDIPlus_ImageSaveToFile($hClone, @ScriptDir&"\"&$Num &".bmp")
	If @error Then 
		MsgBox(0,"","wrong")
		_GDIPlus_ShutDown ()
		Return 0;无效的图形文件或未找到该文件
	EndIf
    $BitmapData = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, $i_width, $i_height, $GDIP_ILMREAD, $GDIP_PXF24RGB)
    $i_Stride = DllStructGetData($BitmapData, "Stride");Stride - Offset, in bytes, between consecutive scan lines of the bitmap. If the stride is positive, the bitmap is top-down. If the stride is negative, the bitmap is bottom-up.
    $Scan0 = DllStructGetData($BitmapData, "Scan0");Scan0 - Pointer to the first (index 0) scan line of the bitmap.
    $pixelData = DllStructCreate("ubyte lData[" & (Abs($i_Stride) * $i_height) & "]", $Scan0)
    $s_BMPData = DllStructGetData($pixelData, "lData")
    $s_BMPData = StringTrimLeft($s_BMPData,2);去掉头部"0x"
    _GDIPlus_BitmapUnlockBits($hBitmap, $BitmapData)
    _GDIPlus_ImageDispose($hBitmap)
	_GDIPlus_ImageDispose($hClone)
	_WinAPI_DeleteObject ($hBitmap)
	_GDIPlus_Shutdown()
       
	If $b_Array2d Then;要求返回二维数组
		Local $a_return[$i_width][$i_height], $x, $y, $s
		For $y=0 To $i_height-1
		$s=StringMid($s_BMPData, $y*($i_Stride*2)+1, $i_width*6)
		;不要使用一些例子中提出的$s=StringMid($s_BMPData, $y*($i_width*6)+1, $i_width*6),经实际测试,该方式无法正确处理:
		;GIF冗余,带隐藏内容的图形文件(一种数据加密方式),或者多页图形文件,当然这些情形比较少见,下同
		For $x= 0 To $i_width-1
		$a_return[$x][$y]= Number("0x"&StringMid($s,$x*6+1 ,6))
		Next
		Next
	Else;要求返回一维数组
		Local $a_return[$i_height], $y
		For $y=0 To $i_height-1
			$a_return[$y]=StringMid($s_BMPData, $y*($i_Stride*2)+1, $i_width*6)
			;见上说明
		Next
	EndIf
	Return $a_return
EndFunc  ;==>myReadImageToArray

Func StartReadCode($FileName,$ColorFlg)
	$ResultString=""
	GUICtrlSetData($CodeEdit,"")
	;myReadImageToArray($Num,$ImageFile,$ix0,$iy0,$iX,$iY,$b_Array2d=False)
	$a_Image = myReadImageToArray(0,$FileName,0,0,0,0,False)
	$a_Image = myArrayChangeSC($a_Image, 1, $ColorFlg, 0xffffff)  
	for $line=0 to $Cro-1 Step 1
		$a_Image[$line]=StringReplace($a_Image[$line],"FFFFFF","F")  ;数组中所有的6位颜色信息转换为1位的颜色信息
		$a_Image[$line]=StringReplace($a_Image[$line],"000000","0")
		_GUICtrlEdit_InsertText($CodeEdit,$a_Image[$line]&@CRLF)  ;所有信息输出到代码列表中.
		$ResultString&=$a_Image[$line]   ;每行的颜色信息重组成字符串,用于输出到数据库.
	Next
	Return $ResultString
EndFunc
