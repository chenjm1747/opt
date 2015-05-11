#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Color.au3>
#Include <Clipboard.au3>
#Region ### START Koda GUI section ### Form=c:\documents and settings\administrator\桌面\屏幕颜色拾取.kxf
$Form1 = GUICreate("屏幕取色器", 337, 260, 192, 124);创建窗口
GUISetBkColor(0x91D0F4);设置窗体的背景颜色，此处为浅蓝色
$chuang = GUICtrlCreateGraphic (8, 40, 145, 129);创建绘图控件，就是那个用来显示当前颜色的矩形
GUICtrlSetColor(-1, 0x008FF0);设置绘图控件的边框颜色
$Label1 = GUICtrlCreateLabel("当前颜色", 192, 48, 88, 23);创建静态标签
GUICtrlSetFont(-1, 14, 800, 0, "楷体_GB2312");设置字体
GUICtrlSetColor(-1, 0xFF0000);设置字体颜色
$Label2 = GUICtrlCreateLabel("十六进制", 162, 80, 52, 17);创建静态标签
$Label3 = GUICtrlCreateLabel("十进制", 255, 80, 40, 17);创建静态标签
$Input16 = GUICtrlCreateInput("", 156, 96, 65, 21);创建输入框，用来显示16进制的颜色代码
$Input10 = GUICtrlCreateInput("", 243, 96, 65, 21);创建输入框，用来显示10进制的颜色代码
$Button16 = GUICtrlCreateButton("复制", 160, 128, 57, 17);按钮，复制十六进制代码
GUICtrlSetState(-1,$GUI_DISABLE);将复制按钮变成不可用（灰色）
$Button10 = GUICtrlCreateButton("复制", 247, 128, 57, 17);按钮，复制十进制代码
GUICtrlSetState(-1,$GUI_DISABLE);将复制按钮变成不可用（灰色）
$Label4 = GUICtrlCreateLabel("屏幕坐标", 160, 160, 52, 20);创建静态标签
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif");设置字体
$zuobiaox = GUICtrlCreateLabel("x", 222, 160, 50, 20)
;创建静态标签,显示x坐标,此时这里的"x"没有意义，只为方便查看，因为只要一运行，这里将会被修改
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif");设置字体
$zuobiaoy = GUICtrlCreateLabel("y", 272, 160, 50, 20)
;创建静态标签,显示y坐标,此时这里的"y"没有意义，只为方便查看
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif");设置字体
$Label6 = GUICtrlCreateLabel("红色", 16, 189, 28, 20);创建静态标签,显示红色两个字
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif");设置字体

$Label7 = GUICtrlCreateLabel("绿色", 55, 189, 28, 20);创建静态标签,显示绿色两个字
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif");设置字体

$Label8 = GUICtrlCreateLabel("蓝色", 94, 189, 28, 20);创建静态标签,显示蓝色两个字
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif");设置字体

$hong = GUICtrlCreateInput("1", 8, 208, 33, 24);创建输入框，用来显示红色成分，这里的"1"没有意义
GUICtrlSetBkColor(-1, 0xFF0000);设置输入框的背景颜色为红色
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif");设置字体

$lv = GUICtrlCreateInput("2", 50, 208, 33, 24);创建输入框，用来显示绿色成分，这里的"2"没有意义
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif");设置字体
GUICtrlSetBkColor(-1, 0x008000);设置输入框的背景颜色为绿色

$lan = GUICtrlCreateInput("3", 92, 208, 33, 24);创建输入框，用来显示蓝色成分，这里的"3"没有意义
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif");设置字体
GUICtrlSetBkColor(-1, 0x0054E3);设置输入框的背景颜色为蓝色
$Label9 = GUICtrlCreateLabel("按空格暂停捕捉颜色", 76, 8, 175, 23);创建静态标签,显示最上面的标题
GUICtrlSetFont(-1, 14, 400, 0, "黑体");设置字体
GUICtrlSetColor(-1, 0x008000);设置字体颜色
$Buttonguanyu = GUICtrlCreateButton("关于", 160, 207, 65, 33);创建按钮控件
GUICtrlSetFont(-1, 12, 800, 0, "仿宋_GB2312");设置字体
$Buttonexit = GUICtrlCreateButton("退出", 250, 207, 65, 33);创建按钮控件
GUICtrlSetFont(-1, 12, 800, 0, "仿宋_GB2312");设置字体
GUISetState(@SW_SHOW);显示窗体
#EndRegion ### END Koda GUI section ###
Dim $temp,$tempx,$tempy,$pause;声明变量
HotKeySet("{SPACE}","pause");注册“空格”热键，按下空格即运行pause()函数
While 1
	If $pause = 0 Then 
	    $shu=MouseGetPos();获取当前的鼠标位置，返回一个数组，$shu[0]为x坐标，$shu[1]为y坐标
	    $color = PixelGetColor( $shu[0] , $shu[1] );获取该坐标的颜色，返回一个十进制的颜色
        If $color <> $temp Then
        	GUICtrlSetData($Input10,$color);修改输入框的数据（显示出十进制的那个输入框，修改为当前鼠标位置的颜色编码）
    	    GUICtrlSetData($Input16, Hex($color, 6))
			;修改输入框的数据，因为$color是十进制的，所以需要用Hex函数将它变成十六进制
			
	    	GUICtrlSetBkColor($chuang,$color)
			;将控件的背景颜色改成鼠标位置的颜色，$chuang是那个绘图控件，即左上角那块显示颜色的那个矩形
		    GUICtrlSetData($hong,_ColorGetRed($Color));修改红色成分的数据，_ColorGetRed：返回指定颜色的红色成分
			GUICtrlSetData($lv,_ColorGetGreen($Color));修改绿色成分的数据，同上，$color是此时鼠标所在位置的颜色
 	    	GUICtrlSetData($lan,_ColorGetBlue($Color));修改蓝色成分的数据，同上
    	EndIf
	EndIf
	
	If $shu[0]<>$tempx Then GUICtrlSetData($zuobiaox,"X:"&$shu[0]&"");实时显示鼠标所在位置的x坐标
	If  $shu[1]<>$tempy Then GUICtrlSetData($zuobiaoy,"Y:"&$shu[1]&"");实时显示鼠标所在位置的y坐标
	$temp = $color;设置一个临时变量，用来与下一次取到的颜色进行对比，有改变才去修改控件的数据，这样可以减少CUP的使用
	$tempx = $shu[0];同上，你会发现上面用了几个IF，就是用来判断是不是有数据变动
	$tempy = $shu[1];同上
	$nMsg = GUIGetMsg();捕获窗口消息.
	Switch $nMsg
		Case $GUI_EVENT_CLOSE;捕到关闭按钮X就退出
			Exit
		Case $Buttonexit;点击退出按钮
			Exit
		Case $Button10;点击复制按钮（十进制那个）
			    _ClipBoard_SetData (GUICtrlRead($Input10));读取那个十进制的输入框后放进剪贴板里，实现复制功能
				MsgBox(0,"提示","成功复制！",1);显示复制成功，延时一秒
		Case $Button16;点击复制按钮（十六进制那个）
		    _ClipBoard_SetData (GUICtrlRead($Input16));同上
			MsgBox(0,"提示","成功复制！",1)
		Case $Buttonguanyu;点击关于按钮，下面是创建一个新的窗口，上面都是些静态标签
			$sm = GUICreate("风行工作室", 218, 241, -1,-1)
			GUISetBkColor(0x91D0F4)
			$banben = GUICtrlCreateLabel("版本：1.0", 24, 32, 76, 20)
			GUICtrlSetFont(-1, 12, 400, 0, "仿宋_GB2312")
			$zuozhe = GUICtrlCreateLabel("作者：tryhi", 24, 72, 104, 23)
			GUICtrlSetFont(-1, 14, 400, 0, "楷体_GB2312")
			GUICtrlSetColor(-1, 0xFF0000)
			$lianxi = GUICtrlCreateLabel("QQ:601622714    い☆ve嗨♂", 32, 110, 160, 17)
			$shuoming = GUICtrlCreateLabel("说明：打开本程序后其它"&@crlf&"程序将无法使用"& _
			"空格比如"&@crlf&"说无法打字，关闭本程序"&@crlf&"后即正常", 32, 150, 460, 50)
			GUISetState(@SW_SHOW)
			;当一行代码太长时可以用"& _回车"来进行换行，这样看代码时比较方便，可以用"&@crlf&"来表示换行
			While 1
                $msg = GUIGetMsg()
				Select
					Case $msg = $GUI_EVENT_CLOSE
						GUIDelete($sm);当点击X时删除这个"关于"窗体
						ExitLoop
				EndSelect
				
			WEnd
	EndSwitch
WEnd
Func pause();当按下空格时将执行这个函数
	If $pause = 0 Then ;用一个变量两种值来达到按下空格就暂停，再按一次就继续的功能
	    $pause = 1
		GUICtrlSetState($Button10,$GUI_ENABLE);将“复制”那两个按钮变成可用（本来是灰色的）
		GUICtrlSetState($Button16,$GUI_ENABLE)
	Else
	    $pause = 1
		$pause = 0
		GUICtrlSetState($Button10,$GUI_DISABLE);将“复制”那两个按钮变成不可用（灰色）
		GUICtrlSetState($Button16,$GUI_DISABLE)
	EndIf
EndFunc
