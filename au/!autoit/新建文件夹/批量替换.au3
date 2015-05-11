;Example:
;myReplaceStringInFile("D:\AutoIt\复件 article", "discuz", "BackUp,_private,images", "(?m)^tag:", "thisistag:")
; ===============================================================================
;
; Function Name: myReplaceStringInFile
; Description:: 用正则表达式批量搜索或替换文件中的字符串
; Parameter(s): $sPath = 路径
;             $rPath = 匹配路径的正则表达式
;             $sPathExclude = 要排除的路径，用,分隔多个
;             $rPattern = 要搜索的字符串的正则模式
;             $rReplace = 替换字符串，支持反向引用，省略表示只搜索不替换
;             $iCount 替换次数，默认0，进行全局替换
; Requirement(s): autoit v3.2.2.0，My.au3 
; Return Value(s): 成功则返回数组$a[0]是结果数，$a[1]是第一个结果
;===============================================================================
#ce
Func myReplaceStringInFile($sPath, $rPath = 0, $sPathExclude = 0, $rPattern = 0, $rReplace = 0, $iCount = 0)
;yidabu.com提示：$sRe 返回值,供递归调用，非可选参数要在前面
Local $sRe
$sRe=myReplaceStringInFileTemp($sRe, $sPath, $rPath, $sPathExclude, $rPattern, $rReplace, $iCount)
$sRe=StringStripWS($sRe,2)
;提示：stringsplit时要注意，参数1不能省，否则会@cr和@lf两个分隔参数
$sRe=StringSplit($sRe,@CRLF,1)
Return $sRe
EndFunc ;==>myReplaceStringInFile
Func myReplaceStringInFileTemp(ByRef $sRe, $sPath, $rPath = 0, $sPathExclude = 0, $rPattern = 0, $rReplace = 0, $iCount = 0)
Local $hSearch, $sFile
If Not FileExists($sPath) Then Return SetError(1, 1, "")
$hSearch = FileFindFirstFile($sPath & "\*")
If $hSearch = -1 Then Return SetError(4, 4, "")
While 1
      $sFile = FileFindNextFile($hSearch)
      If @error Then
         SetError(0)
         ExitLoop
      EndIf

      ;提示：已经被排除的路径，就不要搜索子目录了
      If $sPathExclude And StringLen($sPathExclude) > 0 Then $sPathExclude = StringSplit($sPathExclude, ",")
      $bExclude = False
      If IsArray($sPathExclude) Then
         For $ii = 1 To $sPathExclude[0] Step 1
            If StringInStr($sPath & "\" & $sFile, $sPathExclude[$ii]) Then
                  $bExclude = True
                  ExitLoop
            EndIf
         Next
      EndIf
      If $bExclude Then ContinueLoop
      If StringInStr(FileGetAttrib($sPath & "\" & $sFile), "D") Then ;如果遇到目录就递归
         myReplaceStringInFileTemp($sRe, $sPath & "\" & $sFile, $rPath, $sPathExclude, $rPattern, $rReplace, $iCount)
         ContinueLoop ;跳过目录
      EndIf

      ;提示：要求正则匹配路径，且匹配失败时就跳过。
      If $rPath And (Not StringRegExp($sPath & "\" & $sFile, $rPath, 0)) Then ContinueLoop

      Local $s = FileRead($sPath & "\" & $sFile)
      ;不替换，也就是查找
      If Not $rReplace Then
         If Not StringRegExp($s, $rPattern, 0) Then ContinueLoop
      ;执行替换
      Else
         ;将要替换的文件保存到BackUp目录，以备意外情况下恢复
         Local $CopyDest = StringRegExpReplace($sPath & "\" & $sFile, "(.+?\\)([^\\]+$)", "$1BackUp\\$2", 1)
         If FileCopy($sPath & "\" & $sFile, $CopyDest, 9) Then ConsoleWrite("backup:" & $sPath & "\" & $sFile & @LF)
         $s = StringRegExpReplace($s, $rPattern, $rReplace, $iCount)
         If @error Then ContinueLoop;替换失败就不要打开文件了
         Local $hFile = FileOpen($sPath & "\" & $sFile, 2);清除原来内容
         FileWrite($hFile, $s)
         FileClose($hFile)
      EndIf
      $sRe &= $sPath & "\" & $sFile & @CRLF
WEnd

FileClose($hSearch)
Return $sRe
EndFunc ;==>myReplaceStringInFileTemp
