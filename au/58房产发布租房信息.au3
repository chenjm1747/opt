#include <MsgBoxConstants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GUIListBox.au3>
#include <array.au3>
#include <IE.au3>
#include <MsgBoxConstants.au3>
#include <ScreenCapture.au3>
#include <WindowsConstants.au3>
$sFilePath = @TempDir & "\FileRead.txt"
InetGet("http://dx.caiwuhao.com:3000/azufangs/1.json", $sFilePath, 1)
Local $hFileOpen = FileOpen($sFilePath, 0)
    If $hFileOpen = -1 Then
        MsgBox(0, "", "An error occurred when reading the file.")
        Return False
    EndIf
$json = FileRead($hFileOpen)
FileClose($hFileOpen)
FileDelete($sFilePath)
$oMSSC = ObjCreate('ScriptControl')
$oMSSC.Language = 'JavaScript'
$oMSSC.AddCode('var a = ' & $json & ';')
ConsoleWrite('var a = {' & $json & '};')
$id = $oMSSC.Eval('a.id');age
$username = $oMSSC.Eval('a.username');age
$Passwd =$oMSSC.Eval('a.password');age
$innertext =$oMSSC.Eval('a.innertext');age
$xiaoqu =$oMSSC.Eval('a.xiaoqu')
$title =$oMSSC.Eval('a.title')
$area =$oMSSC.Eval('a.area')
$minprice =$oMSSC.Eval('a.minprice')
$lianxiren=$oMSSC.Eval('a.lianxiren')
$phone =$oMSSC.Eval('a.phone')
$updated_at=$oMSSC.Eval('a.updated_at')
$aArray = StringRegExp($updated_at, '(.+?)T', 1)
$updated_at=$aarray[0]
;����

$tupian =$oMSSC.Eval('a.tupian')
$sfilejpg = @TempDir & "\"&$id&".jpg"
InetGet($tupian, $sfilejpg, 1)

Local $oIE = _IECreateEmbedded()
GUICreate("Embedded Web control Test", @DesktopWidth, @DesktopHeight, 0, 0, _
        $WS_OVERLAPPEDWINDOW + $WS_CLIPSIBLINGS + $WS_CLIPCHILDREN)
GUICtrlCreateObj($oIE, 0, 20, @DesktopWidth, @DesktopHeight)

Global $g_idError_Message = GUICtrlCreateLabel("", 100, 500, 500, 30)
GUICtrlSetColor(-1, 0xff0000)
;1053*459
GUISetState(@SW_SHOW) ;Show GUI
login()
chuzu()
Exit
While 1
    Local $iMsg = GUIGetMsg()
    Select
        Case $iMsg = $GUI_EVENT_CLOSE
            ExitLoop
    EndSelect
WEnd

GUIDelete()

Exit


func chuzu()
sleep(1000)
_IENavigate($oIE, "http://post.58.com/79/8/s5?ver=npost")
_IELoadWait($oie)
$xiaoqu=_IEGetObjByname($oie,"isBiz")
$xiaoqu.click()
$oIE.document.parentWindow.aspnetForm.jushishuru.value="2"
$oIE.document.parentWindow.aspnetForm.huxingting.value="1"
$oIE.document.parentWindow.aspnetForm.huxingwei.value="1"
$oIE.document.parentWindow.aspnetForm.Floor.value=4
$xiaoqu=_IEGetObjById($oie,"xiaoqu")
$xiaoqu.value=$xiaoqu
$oIE.document.parentWindow.aspnetForm.zonglouceng.value=20
$oIE.document.parentWindow.aspnetForm.Toward.value=2
$oIE.document.parentWindow.aspnetForm.FitType.value=4
$oIE.document.parentWindow.aspnetForm.Title.value=$title
$oIE.document.parentWindow.aspnetForm.area.value=$area
$oIE.document.parentWindow.aspnetForm.MinPrice.value=$minprice
$oIE.document.parentWindow.aspnetForm.goblianxiren.value=$lianxiren
$oIE.document.parentWindow.aspnetForm.Phone.value=$phone
;$oIE.document.parentWindow.aspnetForm.cbxFreeDivert.click()
$xiaoqu=_IEGetObjById($oie,"changetuSingle")
$xiaoqu.click()
run(@AppDataDir"\upload.exe "&$sfilejpg)
$xiaoqu=_IEGetObjById($oie,"fileUploadInput")
if @error>0 then
   else
$xiaoqu.click()
endif
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
_IEPropertySet($oFrame1, "innertext", $innertext)
sleep(1000)
$oIE.document.parentWindow.aspnetForm.fabu.click()
sleep(1000)
$oIE.document.parentWindow.aspnetForm.fabu.click()
sleep(1000)
$oIE.document.parentWindow.aspnetForm.fabu.click()
_IELoadWait($oie)
sleep(50000)

   endfunc

func login()
   ;��¼
_IENavigate($oIE, "http://passport.58.com/login?path=http://my.58.com")
_IELoadWait($oie)
$oIE.document.parentWindow.submitForm.username.value=$username
$oIE.document.parentWindow.submitForm.password.value=$passwd
;sleep(1000)
$oIE.document.parentWindow.submitForm.btnSubmit.click()
;sleep(1000)
_IELoadWait($oie)
;sleep(1000)
endfunc

func s($message)
   msgbox(0,0,$message)
endfunc