Opt('MustDeclareVars', 1) 

Local $objCOMError, $objAppIE, $jQuery 

$objCOMError = ObjEvent("AutoIt.Error", "_COMErrorHandler") 

$objAppIE = ObjCreate("InternetExplorer.Application")
$objAppIE.visible = True 

$objAppIE.navigate("http://www.baidu.com") 

$jQuery = InsertJQuery($objAppIE) 

;~ 更改“Google搜索”为“百度”
MsgBox(0,"",$jQuery('body').html())
$jQuery('su').attr('value','百度sb') 


  

Func InsertJQuery($objAppIE)
    Local $objWindow, $objHead, $objScript 

    _IEPageLoadWait($objAppIE)
ConsoleWrite('2' & @LF)
    $objWindow = $objAppIE.document.parentWindow
    $objHead = $objAppIE.document.getElementsByTagName('head').item(0)
;~     error
    If Not(IsObj($objWindow.jQuery)) Then
        $objScript = $objAppIE.document.createElement('script')
        $objScript.type = 'text/javascript'
        $objScript.defer = 'defer'
        $objScript.text = FileRead(@ScriptDir & '\jquery-1.10.2.min.js')
        $objHead.appendChild($objScript)
        While Not(IsObj($objWindow.jQuery))
            Sleep(100)
        WEnd
        $objWindow.jQuery.noConflict()
    EndIf
    Return $objWindow.jQuery
EndFunc 

Func _IEPageLoadWait($objAppIE)
    Do
        Sleep(100)
    Until ($objAppIE.readyState = 'complete' Or $objAppIE.readyState = 4)
    Do
        Sleep(100)
    Until ($objAppIE.document.readyState = 'complete' Or $objAppIE.document.readyState = 4)
EndFunc 

Func _COMErrorHandler()
    Switch $objCOMError.number
    Case -2147352570
        Return 0
    Case Else
; Don't use central errorhandler
        MsgBox(8240, "Automation Error", "Unhandled COM Automation Error." & @CRLF & @CRLF & _
                    "This operation resulted in an unhandled error." & @CRLF & @CRLF & _
                    "Technical Information: " & @CRLF & _
                    "Error Number: " & $objCOMError.number & @CRLF & _
                    "Error Description: " & $objCOMError.winDescription & @CRLF & _
                    "Line Number: " & $objCOMError.scriptLine & @CRLF & @CRLF & _
                    "Contact technical support for furthur help.")
        Exit
    EndSwitch
EndFunc
