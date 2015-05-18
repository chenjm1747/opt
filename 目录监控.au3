#cs -------------------------------------------------------------------------

        AutoIt Version: 3.2.10+
        Author:         zorphnog (M. Mims)
        Last modified: ceoguang

        Script Function:
        Monitors the user defined directories for file activity.

#ce -------------------------------------------------------------------------

Global Const $OPEN_EXISTING = 3
Global Const $FILE_SHARE_READ = 0x00000001
Global Const $FILE_SHARE_WRITE = 0x00000002
Global Const $FILE_SHARE_DELETE = 0x00000004
Global Const $ERROR_NO_TOKEN = 1008
Global Const $SE_PRIVILEGE_ENABLED = 0x00000002
Global Const $tagLVITEM = "int Mask;int Item;int SubItem;int State;int StateMask;ptr Text;int TextMax;int Image;int Param;" & "int Indent;int GroupID;int Columns;ptr pColumns"
Global Const $tagTOKEN_PRIVILEGES = "int Count;int64 LUID;int Attributes"
Global Const $tagMEMMAP = "hwnd hProc;int Size;ptr Mem"
Global Const $tagSYSTEMTIME = "short Year;short Month;short Dow;short Day;short Hour;short Minute;short Second;short MSeconds"
Global Const $tagOVERLAPPED = "int Internal;int InternalHigh;int Offset;int OffsetHigh;int hEvent"
Func _PathFull($sRelativePath, $sBasePath = @WorkingDir)
	If Not $sRelativePath Or $sRelativePath = "." Then Return $sBasePath

	; Normalize slash direction.
	Local $sFullPath = StringReplace($sRelativePath, "/", "\") ; Holds the full path (later, minus the root)
	Local Const $sFullPathConst = $sFullPath ; Holds a constant version of the full path.
	Local $sPath ; Holds the root drive/server
	Local $bRootOnly = StringLeft($sFullPath, 1) = "\" And StringMid($sFullPath, 2, 1) <> "\"

	If $sBasePath = Default Then $sBasePath = @WorkingDir

	; Check for UNC paths or local drives.  We run this twice at most.  The
	; first time, we check if the relative path is absolute.  If it's not, then
	; we use the base path which should be absolute.
	For $i = 1 To 2
		$sPath = StringLeft($sFullPath, 2)
		If $sPath = "\\" Then
			$sFullPath = StringTrimLeft($sFullPath, 2)
			Local $nServerLen = StringInStr($sFullPath, "\") - 1
			$sPath = "\\" & StringLeft($sFullPath, $nServerLen)
			$sFullPath = StringTrimLeft($sFullPath, $nServerLen)
			ExitLoop
		ElseIf StringRight($sPath, 1) = ":" Then
			$sFullPath = StringTrimLeft($sFullPath, 2)
			ExitLoop
		Else
			$sFullPath = $sBasePath & "\" & $sFullPath
		EndIf
	Next

	; If this happens, we've found a funky path and don't know what to do
	; except for get out as fast as possible.  We've also screwed up our
	; variables so we definitely need to quit.
	; If $i = 3 Then Return ""

	; A path with a drive but no slash (e.g. C:Path\To\File) has the following
	; behavior.  If the relative drive is the same as the $BasePath drive then
	; insert the base path.  If the drives differ then just insert a leading
	; slash to make the path valid.
	If StringLeft($sFullPath, 1) <> "\" Then
		If StringLeft($sFullPathConst, 2) = StringLeft($sBasePath, 2) Then
			$sFullPath = $sBasePath & "\" & $sFullPath
		Else
			$sFullPath = "\" & $sFullPath
		EndIf
	EndIf

	; Build an array of the path parts we want to use.
	Local $aTemp = StringSplit($sFullPath, "\")
	Local $aPathParts[$aTemp[0]], $j = 0
	For $i = 2 To $aTemp[0]
		If $aTemp[$i] = ".." Then
			If $j Then $j -= 1
		ElseIf Not ($aTemp[$i] = "" And $i <> $aTemp[0]) And $aTemp[$i] <> "." Then
			$aPathParts[$j] = $aTemp[$i]
			$j += 1
		EndIf
	Next

	; Here we re-build the path from the parts above.  We skip the
	; loop if we are only returning the root.
	$sFullPath = $sPath
	If Not $bRootOnly Then
		For $i = 0 To $j - 1
			$sFullPath &= "\" & $aPathParts[$i]
		Next
	Else
		$sFullPath &= $sFullPathConst
		; If we detect more relative parts, remove them by calling ourself recursively.
		If StringInStr($sFullPath, "..") Then $sFullPath = _PathFull($sFullPath)
	EndIf

	; Clean up the path.
	Do
		$sFullPath = StringReplace($sFullPath, ".\", "\")
	Until @extended = 0
	Return $sFullPath
EndFunc   ;==>_PathFull


Func _Security__AdjustTokenPrivileges($hToken, $fDisableAll, $pNewState, $iBufferLen, $pPrevState = 0, $pRequired = 0)
        Local $aResult
        $aResult = DllCall("Advapi32.dll", "int", "AdjustTokenPrivileges", "hwnd", $hToken, "int", $fDisableAll, "ptr", $pNewState, _
                        "int", $iBufferLen, "ptr", $pPrevState, "ptr", $pRequired)
        Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Security__AdjustTokenPrivileges
Func _Security__ImpersonateSelf($iLevel = 2)
        Local $aResult
        $aResult = DllCall("Advapi32.dll", "int", "ImpersonateSelf", "int", $iLevel)
        Return SetError($aResult[0] = 0, 0, $aResult[0] <> 0)
EndFunc   ;==>_Security__ImpersonateSelf
Func _Security__LookupPrivilegeValue($sSystem, $sName)
        Local $tData, $aResult
        $tData = DllStructCreate("int64 LUID")
        $aResult = DllCall("Advapi32.dll", "int", "LookupPrivilegeValue", "str", $sSystem, "str", $sName, "ptr", DllStructGetPtr($tData))
        Return SetError($aResult[0] = 0, 0, DllStructGetData($tData, "LUID"))
EndFunc   ;==>_Security__LookupPrivilegeValue
Func _Security__OpenThreadToken($iAccess, $hThread = 0, $fOpenAsSelf = False)
        Local $tData, $pToken, $aResult
        If $hThread = 0 Then $hThread = _WinAPI_GetCurrentThread()
        $tData = DllStructCreate("int Token")
        $pToken = DllStructGetPtr($tData, "Token")
        $aResult = DllCall("Advapi32.dll", "int", "OpenThreadToken", "int", $hThread, "int", $iAccess, "int", $fOpenAsSelf, "ptr", $pToken)
        Return SetError($aResult[0] = 0, 0, DllStructGetData($tData, "Token"))
EndFunc   ;==>_Security__OpenThreadToken
Func _Security__OpenThreadTokenEx($iAccess, $hThread = 0, $fOpenAsSelf = False)
        Local $hToken
        $hToken = _Security__OpenThreadToken($iAccess, $hThread, $fOpenAsSelf)
        If $hToken = 0 Then
                If _WinAPI_GetLastError() = $ERROR_NO_TOKEN Then
                        If Not _Security__ImpersonateSelf() Then Return SetError(-1, _WinAPI_GetLastError(), 0)
                        $hToken = _Security__OpenThreadToken($iAccess, $hThread, $fOpenAsSelf)
                        If $hToken = 0 Then Return SetError(-2, _WinAPI_GetLastError(), 0)
                Else
                        Return SetError(-3, _WinAPI_GetLastError(), 0)
                EndIf
        EndIf
        Return SetError(0, 0, $hToken)
EndFunc   ;==>_Security__OpenThreadTokenEx
Func _Security__SetPrivilege($hToken, $sPrivilege, $fEnable)
        Local $pRequired, $tRequired, $iLUID, $iAttributes, $iCurrState, $pCurrState, $tCurrState, $iPrevState, $pPrevState, $tPrevState
        $iLUID = _Security__LookupPrivilegeValue("", $sPrivilege)
        If $iLUID = 0 Then Return SetError(-1, 0, False)
        $tCurrState = DllStructCreate($tagTOKEN_PRIVILEGES)
        $pCurrState = DllStructGetPtr($tCurrState)
        $iCurrState = DllStructGetSize($tCurrState)
        $tPrevState = DllStructCreate($tagTOKEN_PRIVILEGES)
        $pPrevState = DllStructGetPtr($tPrevState)
        $iPrevState = DllStructGetSize($tPrevState)
        $tRequired = DllStructCreate("int Data")
        $pRequired = DllStructGetPtr($tRequired)
        DllStructSetData($tCurrState, "Count", 1)
        DllStructSetData($tCurrState, "LUID", $iLUID)
        If Not _Security__AdjustTokenPrivileges($hToken, False, $pCurrState, $iCurrState, $pPrevState, $pRequired) Then
                Return SetError(-2, @error, False)
        EndIf
        DllStructSetData($tPrevState, "Count", 1)
        DllStructSetData($tPrevState, "LUID", $iLUID)
        $iAttributes = DllStructGetData($tPrevState, "Attributes")
        If $fEnable Then
                $iAttributes = BitOR($iAttributes, $SE_PRIVILEGE_ENABLED)
        Else
                $iAttributes = BitAND($iAttributes, BitNOT($SE_PRIVILEGE_ENABLED))
        EndIf
        DllStructSetData($tPrevState, "Attributes", $iAttributes)
        If Not _Security__AdjustTokenPrivileges($hToken, False, $pPrevState, $iPrevState, $pCurrState, $pRequired) Then
                Return SetError(-3, @error, False)
        EndIf
        Return SetError(0, 0, True)
EndFunc   ;==>_Security__SetPrivilege
Func _SendMessage($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lparam")
        Local $aResult = DllCall("user32.dll", $sReturnType, "SendMessage", "hwnd", $hWnd, "int", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
        If @error Then Return SetError(@error, @extended, "")
        If $iReturn >= 0 And $iReturn <= 4 Then Return $aResult[$iReturn]
        Return $aResult
EndFunc   ;==>_SendMessage
Func _SendMessageA($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lparam")
        Local $aResult = DllCall("user32.dll", $sReturnType, "SendMessageA", "hwnd", $hWnd, "int", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
        If @error Then Return SetError(@error, @extended, "")
        If $iReturn >= 0 And $iReturn <= 4 Then Return $aResult[$iReturn]
        Return $aResult
EndFunc   ;==>_SendMessageA
Global $winapi_gaInProcess[64][2] = [[0, 0]]
Global Const $__WINAPCONSTANT_FORMAT_MESSAGE_FROM_SYSTEM = 0x1000
Global Const $__WINAPCONSTANT_TOKEN_ADJUST_PRIVILEGES = 0x00000020
Global Const $__WINAPCONSTANT_TOKEN_QUERY = 0x00000008
Global Const $KF_EXTENDED = 0x100
Global Const $KF_ALTDOWN = 0x2000
Global Const $KF_UP = 0x8000
Global Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 8)
Global Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 8)
Global Const $LLKHF_UP = BitShift($KF_UP, 8)
Func _WinAPI_Check($sFunction, $fError, $vError, $fTranslate = False)
        If $fError Then
                If $fTranslate Then $vError = _WinAPI_GetLastErrorMessage()
                _WinAPI_ShowError($sFunction & ": " & $vError)
        EndIf
EndFunc   ;==>_WinAPI_Check
Func _WinAPI_CloseHandle($hObject)
        Local $aResult
        $aResult = DllCall("Kernel32.dll", "int", "CloseHandle", "int", $hObject)
        _WinAPI_Check("_WinAPI_CloseHandle", ($aResult[0] = 0), 0, True)
        Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_CloseHandle
Func _WinAPI_FormatMessage($iFlags, $pSource, $iMessageID, $iLanguageID, $pBuffer, $iSize, $vArguments)
        Local $aResult
        $aResult = DllCall("Kernel32.dll", "int", "FormatMessageA", "int", $iFlags, "hwnd", $pSource, "int", $iMessageID, "int", $iLanguageID, _
                        "ptr", $pBuffer, "int", $iSize, "ptr", $vArguments)
        If @error Then Return SetError(@error, 0, 0)
        Return $aResult[0]
EndFunc   ;==>_WinAPI_FormatMessage
Func _WinAPI_GetClassName($hWnd)
        Local $aResult
        If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
        $aResult = DllCall("User32.dll", "int", "GetClassName", "hwnd", $hWnd, "str", "", "int", 4096)
        If @error Then Return SetError(@error, 0, "")
        Return $aResult[2]
EndFunc   ;==>_WinAPI_GetClassName
Func _WinAPI_GetCurrentThread()
        Local $aResult
        $aResult = DllCall("Kernel32.dll", "int", "GetCurrentThread")
        If @error Then Return SetError(@error, 0, 0)
        Return $aResult[0]
EndFunc   ;==>_WinAPI_GetCurrentThread
Func _WinAPI_GetLastError()
        Local $aResult
        $aResult = DllCall("Kernel32.dll", "int", "GetLastError")
        If @error Then Return SetError(@error, 0, 0)
        Return $aResult[0]
EndFunc   ;==>_WinAPI_GetLastError
Func _WinAPI_GetLastErrorMessage()
        Local $tText
        $tText = DllStructCreate("char Text[4096]")
        _WinAPI_FormatMessage($__WINAPCONSTANT_FORMAT_MESSAGE_FROM_SYSTEM, 0, _WinAPI_GetLastError(), 0, DllStructGetPtr($tText), 4096, 0)
        Return DllStructGetData($tText, "Text")
EndFunc   ;==>_WinAPI_GetLastErrorMessage
Func _WinAPI_GetOverlappedResult($hFile, $pOverlapped, ByRef $iBytes, $fWait = False)
        Local $pRead, $tRead, $aResult
        $tRead = DllStructCreate("int Read")
        $pRead = DllStructGetPtr($tRead)
        $aResult = DllCall("Kernel32.dll", "int", "GetOverlappedResult", "int", $hFile, "ptr", $pOverlapped, "ptr", $pRead, "int", $fWait)
        $iBytes = DllStructGetData($tRead, "Read")
        Return SetError(_WinAPI_GetLastError(), 0, $aResult[0] <> 0)
EndFunc   ;==>_WinAPI_GetOverlappedResult
Func _WinAPI_GetWindowThreadProcessId($hWnd, ByRef $iPID)
        Local $pPID, $tPID, $aResult
        $tPID = DllStructCreate("int ID")
        $pPID = DllStructGetPtr($tPID)
        $aResult = DllCall("User32.dll", "int", "GetWindowThreadProcessId", "hwnd", $hWnd, "ptr", $pPID)
        If @error Then Return SetError(@error, 0, 0)
        $iPID = DllStructGetData($tPID, "ID")
        Return $aResult[0]
EndFunc   ;==>_WinAPI_GetWindowThreadProcessId
Func _WinAPI_InProcess($hWnd, ByRef $hLastWnd)
        Local $iI, $iCount, $iProcessID
        If $hWnd = $hLastWnd Then Return True
        For $iI = $winapi_gaInProcess[0][0] To 1 Step -1
                If $hWnd = $winapi_gaInProcess[$iI][0] Then
                        If $winapi_gaInProcess[$iI][1] Then
                                $hLastWnd = $hWnd
                                Return True
                        Else
                                Return False
                        EndIf
                EndIf
        Next
        _WinAPI_GetWindowThreadProcessId($hWnd, $iProcessID)
        $iCount = $winapi_gaInProcess[0][0] + 1
        If $iCount >= 64 Then $iCount = 1
        $winapi_gaInProcess[0][0] = $iCount
        $winapi_gaInProcess[$iCount][0] = $hWnd
        $winapi_gaInProcess[$iCount][1] = ($iProcessID = @AutoItPID)
        Return $winapi_gaInProcess[$iCount][1]
EndFunc   ;==>_WinAPI_InProcess
Func _WinAPI_IsClassName($hWnd, $sClassName)
        Local $sSeperator, $aClassName, $sClassCheck
        $sSeperator = Opt("GUIDataSeparatorChar")
        $aClassName = StringSplit($sClassName, $sSeperator)
        If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
        $sClassCheck = _WinAPI_GetClassName($hWnd)
        For $x = 1 To UBound($aClassName) - 1
                If StringUpper(StringMid($sClassCheck, 1, StringLen($aClassName[$x]))) = StringUpper($aClassName[$x]) Then
                        Return True
                EndIf
        Next
        Return False
EndFunc   ;==>_WinAPI_IsClassName
Func _WinAPI_MsgBox($iFlags, $sTitle, $sText)
        BlockInput(0)
        MsgBox($iFlags, $sTitle, $sText & "      ")
EndFunc   ;==>_WinAPI_MsgBox
Func _WinAPI_OpenProcess($iAccess, $fInherit, $iProcessID, $fDebugPriv = False)
        Local $hToken, $aResult
        $aResult = DllCall("Kernel32.dll", "int", "OpenProcess", "int", $iAccess, "int", $fInherit, "int", $iProcessID)
        If Not $fDebugPriv Or($aResult[0] <> 0) Then
                _WinAPI_Check("_WinAPI_OpenProcess:Standard", ($aResult[0] = 0), 0, True)
                Return $aResult[0]
        EndIf
        $hToken = _Security__OpenThreadTokenEx(BitOR($__WINAPCONSTANT_TOKEN_ADJUST_PRIVILEGES, $__WINAPCONSTANT_TOKEN_QUERY))
        _WinAPI_Check("_WinAPI_OpenProcess:OpenThreadTokenEx", @error, @extended)
        _Security__SetPrivilege($hToken, "SeDebugPrivilege", True)
        _WinAPI_Check("_WinAPI_OpenProcess:SetPrivilege:Enable", @error, @extended)
        $aResult = DllCall("Kernel32.dll", "int", "OpenProcess", "int", $iAccess, "int", $fInherit, "int", $iProcessID)
        _WinAPI_Check("_WinAPI_OpenProcess:Priviliged", ($aResult[0] = 0), 0, True)
        _Security__SetPrivilege($hToken, "SeDebugPrivilege", False)
        _WinAPI_Check("_WinAPI_OpenProcess:SetPrivilege:Disable", @error, @extended)
        _WinAPI_CloseHandle($hToken)
        Return $aResult[0]
EndFunc   ;==>_WinAPI_OpenProcess
Func _WinAPI_ReadProcessMemory($hProcess, $pBaseAddress, $pBuffer, $iSize, ByRef $iRead)
        Local $pRead, $tRead, $aResult
        $tRead = DllStructCreate("int Read")
        $pRead = DllStructGetPtr($tRead)
        $aResult = DllCall("Kernel32.dll", "int", "ReadProcessMemory", "int", $hProcess, "int", $pBaseAddress, "ptr", $pBuffer, "int", $iSize, "ptr", $pRead)
        _WinAPI_Check("_WinAPI_ReadProcessMemory", ($aResult[0] = 0), 0, True)
        $iRead = DllStructGetData($tRead, "Read")
        Return $aResult[0]
EndFunc   ;==>_WinAPI_ReadProcessMemory
Func _WinAPI_ShowError($sText, $fExit = True)
        _WinAPI_MsgBox(266256, "Error", $sText)
        If $fExit Then Exit
EndFunc   ;==>_WinAPI_ShowError
Func _WinAPI_WriteProcessMemory($hProcess, $pBaseAddress, $pBuffer, $iSize, ByRef $iWritten, $sBuffer = "ptr")
        Local $pWritten, $tWritten, $aResult
        $tWritten = DllStructCreate("int Written")
        $pWritten = DllStructGetPtr($tWritten)
        $aResult = DllCall("Kernel32.dll", "int", "WriteProcessMemory", "int", $hProcess, "int", $pBaseAddress, $sBuffer, $pBuffer, _
                        "int", $iSize, "int", $pWritten)
        _WinAPI_Check("_WinAPI_WriteProcessMemory", ($aResult[0] = 0), 0, True)
        $iWritten = DllStructGetData($tWritten, "Written")
        Return $aResult[0]
EndFunc   ;==>_WinAPI_WriteProcessMemory
Func _WinAPI_ValidateClassName($hWnd, $sClassNames)
        Local $aClassNames, $sSeperator = Opt("GUIDataSeparatorChar"), $sText
        If Not _WinAPI_IsClassName($hWnd, $sClassNames) Then
                $aClassNames = StringSplit($sClassNames, $sSeperator)
                For $x = 1 To $aClassNames[0]
                        $sText &= $aClassNames[$x] & ", "
                Next
                $sText = StringTrimRight($sText, 2)
                _WinAPI_ShowError("Invalid Class Type(s):" & @LF & @TAB & _
                                "Expecting Type(s): " & $sText & @LF & @TAB & _
                                "Received Type : " & _WinAPI_GetClassName($hWnd))
        EndIf
EndFunc   ;==>_WinAPI_ValidateClassName
Global Const $MEM_COMMIT = 0x00001000
Global Const $MEM_RESERVE = 0x00002000
Global Const $MEM_SHARED = 0x08000000
Global Const $PAGE_READWRITE = 0x00000004
Global Const $MEM_RELEASE = 0x00008000
Global Const $__MEMORYCONSTANT_PROCESS_VM_OPERATION = 0x00000008
Global Const $__MEMORYCONSTANT_PROCESS_VM_READ = 0x00000010
Global Const $__MEMORYCONSTANT_PROCESS_VM_WRITE = 0x00000020
Func _MemFree(ByRef $tMemMap)
        Local $hProcess, $pMemory, $bResult
        $pMemory = DllStructGetData($tMemMap, "Mem")
        $hProcess = DllStructGetData($tMemMap, "hProc")
        If @OSTYPE = "WIN32_WINDOWS" Then
                $bResult = _MemVirtualFree($pMemory, 0, $MEM_RELEASE)
        Else
                $bResult = _MemVirtualFreeEx($hProcess, $pMemory, 0, $MEM_RELEASE)
        EndIf
        _WinAPI_CloseHandle($hProcess)
        Return $bResult
EndFunc   ;==>_MemFree
Func _MemInit($hWnd, $iSize, ByRef $tMemMap)
        Local $iAccess, $iAlloc, $pMemory, $hProcess, $iProcessID
        _WinAPI_GetWindowThreadProcessId($hWnd, $iProcessID)
        If $iProcessID = 0 Then _MemShowError("_MemInit: Invalid window handle [0x" & Hex($hWnd) & "]")
        $iAccess = BitOR($__MEMORYCONSTANT_PROCESS_VM_OPERATION, $__MEMORYCONSTANT_PROCESS_VM_READ, $__MEMORYCONSTANT_PROCESS_VM_WRITE)
        $hProcess = _WinAPI_OpenProcess($iAccess, False, $iProcessID, True)
        If @OSTYPE = "WIN32_WINDOWS" Then
                $iAlloc = BitOR($MEM_RESERVE, $MEM_COMMIT, $MEM_SHARED)
                $pMemory = _MemVirtualAlloc(0, $iSize, $iAlloc, $PAGE_READWRITE)
        Else
                $iAlloc = BitOR($MEM_RESERVE, $MEM_COMMIT)
                $pMemory = _MemVirtualAllocEx($hProcess, 0, $iSize, $iAlloc, $PAGE_READWRITE)
        EndIf
        If $pMemory = 0 Then _MemShowError("_MemInit: Unable to allocate memory")
        $tMemMap = DllStructCreate($tagMEMMAP)
        DllStructSetData($tMemMap, "hProc", $hProcess)
        DllStructSetData($tMemMap, "Size", $iSize)
        DllStructSetData($tMemMap, "Mem", $pMemory)
        Return $pMemory
EndFunc   ;==>_MemInit
Func _MemMsgBox($iFlags, $sTitle, $sText)
        BlockInput(0)
        MsgBox($iFlags, $sTitle, $sText & "      ")
EndFunc   ;==>_MemMsgBox
Func _MemRead(ByRef $tMemMap, $pSrce, $pDest, $iSize)
        Local $iRead
        Return _WinAPI_ReadProcessMemory(DllStructGetData($tMemMap, "hProc"), $pSrce, $pDest, $iSize, $iRead)
EndFunc   ;==>_MemRead
Func _MemShowError($sText, $fExit = True)
        _MemMsgBox(16 + 4096, "Error", $sText)
        If $fExit Then Exit
EndFunc   ;==>_MemShowError
Func _MemWrite(ByRef $tMemMap, $pSrce, $pDest = 0, $iSize = 0, $sSrce = "ptr")
        Local $iWritten
        If $pDest = 0 Then $pDest = DllStructGetData($tMemMap, "Mem")
        If $iSize = 0 Then $iSize = DllStructGetData($tMemMap, "Size")
        Return _WinAPI_WriteProcessMemory(DllStructGetData($tMemMap, "hProc"), $pDest, $pSrce, $iSize, $iWritten, $sSrce)
EndFunc   ;==>_MemWrite
Func _MemVirtualAlloc($pAddress, $iSize, $iAllocation, $iProtect)
        Local $aResult
        $aResult = DllCall("Kernel32.dll", "ptr", "VirtualAlloc", "ptr", $pAddress, "int", $iSize, "int", $iAllocation, "int", $iProtect)
        Return SetError($aResult[0] = 0, 0, $aResult[0])
EndFunc   ;==>_MemVirtualAlloc
Func _MemVirtualAllocEx($hProcess, $pAddress, $iSize, $iAllocation, $iProtect)
        Local $aResult
        $aResult = DllCall("Kernel32.dll", "ptr", "VirtualAllocEx", "int", $hProcess, "ptr", $pAddress, "int", $iSize, "int", $iAllocation, "int", $iProtect)
        Return SetError($aResult[0] = 0, 0, $aResult[0])
EndFunc   ;==>_MemVirtualAllocEx
Func _MemVirtualFree($pAddress, $iSize, $iFreeType)
        Local $aResult
        $aResult = DllCall("Kernel32.dll", "ptr", "VirtualFree", "ptr", $pAddress, "int", $iSize, "int", $iFreeType)
        Return $aResult[0]
EndFunc   ;==>_MemVirtualFree
Func _MemVirtualFreeEx($hProcess, $pAddress, $iSize, $iFreeType)
        Local $aResult
        $aResult = DllCall("Kernel32.dll", "ptr", "VirtualFreeEx", "hwnd", $hProcess, "ptr", $pAddress, "int", $iSize, "int", $iFreeType)
        Return $aResult[0]
EndFunc   ;==>_MemVirtualFreeEx
Func _Date_Time_GetLocalTime()
        Local $tSystTime
        $tSystTime = DllStructCreate($tagSYSTEMTIME)
        DllCall("Kernel32.dll", "none", "GetLocalTime", "ptr", DllStructGetPtr($tSystTime))
        Return $tSystTime
EndFunc   ;==>_Date_Time_GetLocalTime
Func _Date_Time_SystemTimeToArray(ByRef $tSystemTime)
        Local $aInfo[8]
        $aInfo[0] = DllStructGetData($tSystemTime, "Month")
        $aInfo[1] = DllStructGetData($tSystemTime, "Day")
        $aInfo[2] = DllStructGetData($tSystemTime, "Year")
        $aInfo[3] = DllStructGetData($tSystemTime, "Hour")
        $aInfo[4] = DllStructGetData($tSystemTime, "Minute")
        $aInfo[5] = DllStructGetData($tSystemTime, "Second")
        $aInfo[6] = DllStructGetData($tSystemTime, "MSeconds")
        $aInfo[7] = DllStructGetData($tSystemTime, "DOW")
        Return $aInfo
EndFunc   ;==>_Date_Time_SystemTimeToArray
Func _Date_Time_SystemTimeToDateTimeStr(ByRef $tSystemTime)
        Local $aInfo
        $aInfo = _Date_Time_SystemTimeToArray($tSystemTime)
        Return StringFormat("%02d/%02d/%04d %02d:%02d:%02d", $aInfo[0], $aInfo[1], $aInfo[2], $aInfo[3], $aInfo[4], $aInfo[5])
EndFunc   ;==>_Date_Time_SystemTimeToDateTimeStr
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_ENABLE = 64
Global Const $GUI_DISABLE = 128
Global Const $LBS_NOTIFY = 0x00000001
Global Const $LBS_SORT = 0x00000002
Global Const $LB_ADDSTRING = 0x0180
Global Const $LB_DELETESTRING = 0x0182
Global Const $LB_GETCURSEL = 0x0188
Global Const $LB_GETTEXT = 0x0189
Global Const $LB_GETTEXTLEN = 0x018A
Global Const $LB_GETCOUNT = 0x018B
Global Const $__LISTBOXCONSTANT_WS_BORDER = 0x00800000
Global Const $__LISTBOXCONSTANT_WS_VSCROLL = 0x00200000
Global Const $GUI_SS_DEFAULT_LIST = BitOR($LBS_SORT, $__LISTBOXCONSTANT_WS_BORDER, $__LISTBOXCONSTANT_WS_VSCROLL, $LBS_NOTIFY)
Global $Debug_LB = False
Global Const $__LISTBOXCONSTANT_ClassName = "ListBox"
Func _GUICtrlListBox_AddString($hWnd, $sText)
        If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
        If IsHWnd($hWnd) Then
                Return _SendMessage($hWnd, $LB_ADDSTRING, 0, $sText, 0, "wparam", "str")
        Else
                Return GUICtrlSendMsg($hWnd, $LB_ADDSTRING, 0, $sText)
        EndIf
EndFunc   ;==>_GUICtrlListBox_AddString
Func _GUICtrlListBox_DebugPrint($sText, $iLine = @ScriptLineNumber)
        ConsoleWrite( _
                        "!===========================================================" & @LF & _
                        "+======================================================" & @LF & _
                        "-->Line(" & StringFormat("%04d", $iLine) & "):" & @TAB & $sText & @LF & _
                        "+======================================================" & @LF)
EndFunc   ;==>_GUICtrlListBox_DebugPrint
Func _GUICtrlListBox_DeleteString($hWnd, $iIndex)
        If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
        If IsHWnd($hWnd) Then
                Return _SendMessage($hWnd, $LB_DELETESTRING, $iIndex)
        Else
                Return GUICtrlSendMsg($hWnd, $LB_DELETESTRING, $iIndex, 0)
        EndIf
EndFunc   ;==>_GUICtrlListBox_DeleteString
Func _GUICtrlListBox_GetCount($hWnd)
        If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
        If IsHWnd($hWnd) Then
                Return _SendMessage($hWnd, $LB_GETCOUNT)
        Else
                Return GUICtrlSendMsg($hWnd, $LB_GETCOUNT, 0, 0)
        EndIf
EndFunc   ;==>_GUICtrlListBox_GetCount
Func _GUICtrlListBox_GetCurSel($hWnd)
        If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
        If IsHWnd($hWnd) Then
                Return _SendMessage($hWnd, $LB_GETCURSEL)
        Else
                Return GUICtrlSendMsg($hWnd, $LB_GETCURSEL, 0, 0)
        EndIf
EndFunc   ;==>_GUICtrlListBox_GetCurSel
Func _GUICtrlListBox_GetText($hWnd, $iIndex)
        If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
        Local $struct = DllStructCreate("char Text[" & _GUICtrlListBox_GetTextLen($hWnd, $iIndex) + 1 & "]")
        If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
        _SendMessageA($hWnd, $LB_GETTEXT, $iIndex, DllStructGetPtr($struct), 0, "wparam", "ptr")
        Return DllStructGetData($struct, "Text")
EndFunc   ;==>_GUICtrlListBox_GetText
Func _GUICtrlListBox_GetTextLen($hWnd, $iIndex)
        If $Debug_LB Then _GUICtrlListBox_ValidateClassName($hWnd)
        If IsHWnd($hWnd) Then
                Return _SendMessage($hWnd, $LB_GETTEXTLEN, $iIndex)
        Else
                Return GUICtrlSendMsg($hWnd, $LB_GETTEXTLEN, $iIndex, 0)
        EndIf
EndFunc   ;==>_GUICtrlListBox_GetTextLen
Func _GUICtrlListBox_ValidateClassName($hWnd)
        _GUICtrlListBox_DebugPrint("This is for debugging only, set the debug variable to false before submitting")
        _WinAPI_ValidateClassName($hWnd, $__LISTBOXCONSTANT_ClassName & "|TListBox")
EndFunc   ;==>_GUICtrlListBox_ValidateClassName
Global Const $LVM_FIRST = 0x1000
Global Const $LVHT_ONITEMICON = 0x00000002
Global Const $LVHT_ONITEMLABEL = 0x00000004
Global Const $LVHT_ONITEMSTATEICON = 0x00000008
Global Const $LVHT_ONITEM = BitOR($LVHT_ONITEMICON, $LVHT_ONITEMLABEL, $LVHT_ONITEMSTATEICON)
Global Const $LVIF_IMAGE = 0x00000002
Global Const $LVIF_PARAM = 0x00000004
Global Const $LVIF_TEXT = 0x00000001
Global Const $LVM_DELETEALLITEMS = ($LVM_FIRST + 9)
Global Const $LVM_GETITEMA = ($LVM_FIRST + 5)
Global Const $LVM_GETITEMW = ($LVM_FIRST + 75)
Global Const $LVM_GETITEMCOUNT = ($LVM_FIRST + 4)
Global Const $LVM_GETUNICODEFORMAT = 0x2000 + 6
Global Const $LVM_INSERTITEMA = ($LVM_FIRST + 7)
Global Const $LVM_INSERTITEMW = ($LVM_FIRST + 77)
Global Const $LVM_SETITEMA = ($LVM_FIRST + 6)
Global Const $LVM_SETITEMW = ($LVM_FIRST + 76)
Global Const $LVN_FIRST = -100
Global $_lv_ghLastWnd
Global $Debug_LV = False
Global Const $__LISTVIEWCONSTANT_ClassName = "SysListView32"
Func _GUICtrlListView_AddSubItem($hWnd, $iIndex, $sText, $iSubItem, $iImage = -1)
        If $Debug_LV Then _GUICtrlListView_ValidateClassName($hWnd)
        Local $iMask, $iBuffer, $pBuffer, $tBuffer, $iItem, $pItem, $tItem, $pMemory, $tMemMap, $pText, $iResult
        Local $fUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
        $iBuffer = StringLen($sText) + 1
        If $fUnicode Then
                $iBuffer *= 2
                $tBuffer = DllStructCreate("wchar Text[" & $iBuffer & "]")
        Else
                $tBuffer = DllStructCreate("char Text[" & $iBuffer & "]")
        EndIf
        $pBuffer = DllStructGetPtr($tBuffer)
        $tItem = DllStructCreate($tagLVITEM)
        $pItem = DllStructGetPtr($tItem)
        $iMask = $LVIF_TEXT
        If $iImage <> -1 Then $iMask = BitOR($iMask, $LVIF_IMAGE)
        DllStructSetData($tBuffer, "Text", $sText)
        DllStructSetData($tItem, "Mask", $iMask)
        DllStructSetData($tItem, "Item", $iIndex)
        DllStructSetData($tItem, "SubItem", $iSubItem)
        DllStructSetData($tItem, "Image", $iImage)
        If IsHWnd($hWnd) Then
                If _WinAPI_InProcess($hWnd, $_lv_ghLastWnd) Then
                        DllStructSetData($tItem, "Text", $pBuffer)
                        If $fUnicode Then
                                $iResult = _SendMessage($hWnd, $LVM_SETITEMW, 0, $pItem, 0, "wparam", "ptr")
                        Else
                                $iResult = _SendMessage($hWnd, $LVM_SETITEMA, 0, $pItem, 0, "wparam", "ptr")
                        EndIf
                Else
                        $iItem = DllStructGetSize($tItem)
                        $pMemory = _MemInit($hWnd, $iItem + $iBuffer, $tMemMap)
                        $pText = $pMemory + $iItem
                        DllStructSetData($tItem, "Text", $pText)
                        _MemWrite($tMemMap, $pItem, $pMemory, $iItem)
                        _MemWrite($tMemMap, $pBuffer, $pText, $iBuffer)
                        If $fUnicode Then
                                $iResult = _SendMessage($hWnd, $LVM_SETITEMW, 0, $pMemory, 0, "wparam", "ptr")
                        Else
                                $iResult = _SendMessage($hWnd, $LVM_SETITEMA, 0, $pMemory, 0, "wparam", "ptr")
                        EndIf
                        _MemFree($tMemMap)
                EndIf
        Else
                DllStructSetData($tItem, "Text", $pBuffer)
                If $fUnicode Then
                        $iResult = GUICtrlSendMsg($hWnd, $LVM_SETITEMW, 0, $pItem)
                Else
                        $iResult = GUICtrlSendMsg($hWnd, $LVM_SETITEMA, 0, $pItem)
                EndIf
        EndIf
        Return $iResult <> 0
EndFunc   ;==>_GUICtrlListView_AddSubItem
Func _GUICtrlListView_DebugPrint($sText, $iLine = @ScriptLineNumber)
        ConsoleWrite( _
                        "!===========================================================" & @LF & _
                        "+======================================================" & @LF & _
                        "-->Line(" & StringFormat("%04d", $iLine) & "):" & @TAB & $sText & @LF & _
                        "+======================================================" & @LF)
EndFunc   ;==>_GUICtrlListView_DebugPrint
Func _GUICtrlListView_DeleteAllItems($hWnd)
        If $Debug_LV Then _GUICtrlListView_ValidateClassName($hWnd)
        Local $ctrlID, $index
        If _GUICtrlListView_GetItemCount($hWnd) == 0 Then Return True
        If IsHWnd($hWnd) Then
                Return _SendMessage($hWnd, $LVM_DELETEALLITEMS) <> 0
        Else
                For $index = _GUICtrlListView_GetItemCount($hWnd) - 1 To 0 Step -1
                        $ctrlID = _GUICtrlListView_GetItemParam($hWnd, $index)
                        If $ctrlID Then GUICtrlDelete($ctrlID)
                Next
                If _GUICtrlListView_GetItemCount($hWnd) == 0 Then Return True
        EndIf
        Return False
EndFunc   ;==>_GUICtrlListView_DeleteAllItems
Func _GUICtrlListView_GetItemCount($hWnd)
        If $Debug_LV Then _GUICtrlListView_ValidateClassName($hWnd)
        If IsHWnd($hWnd) Then
                Return _SendMessage($hWnd, $LVM_GETITEMCOUNT)
        Else
                Return GUICtrlSendMsg($hWnd, $LVM_GETITEMCOUNT, 0, 0)
        EndIf
EndFunc   ;==>_GUICtrlListView_GetItemCount
Func _GUICtrlListView_GetItemEx($hWnd, ByRef $tItem)
        If $Debug_LV Then _GUICtrlListView_ValidateClassName($hWnd)
        Local $iItem, $pItem, $pMemory, $tMemMap, $iResult
        Local $fUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
        $pItem = DllStructGetPtr($tItem)
        If IsHWnd($hWnd) Then
                If _WinAPI_InProcess($hWnd, $_lv_ghLastWnd) Then
                        If $fUnicode Then
                                $iResult = _SendMessage($hWnd, $LVM_GETITEMW, 0, $pItem, 0, "wparam", "ptr")
                        Else
                                $iResult = _SendMessage($hWnd, $LVM_GETITEMA, 0, $pItem, 0, "wparam", "ptr")
                        EndIf
                Else
                        $iItem = DllStructGetSize($tItem)
                        $pMemory = _MemInit($hWnd, $iItem, $tMemMap)
                        _MemWrite($tMemMap, $pItem)
                        If $fUnicode Then
                                _SendMessage($hWnd, $LVM_GETITEMW, 0, $pMemory, 0, "wparam", "ptr")
                        Else
                                _SendMessage($hWnd, $LVM_GETITEMA, 0, $pMemory, 0, "wparam", "ptr")
                        EndIf
                        _MemRead($tMemMap, $pMemory, $pItem, $iItem)
                        _MemFree($tMemMap)
                EndIf
        Else
                If $fUnicode Then
                        $iResult = GUICtrlSendMsg($hWnd, $LVM_GETITEMW, 0, $pItem)
                Else
                        $iResult = GUICtrlSendMsg($hWnd, $LVM_GETITEMA, 0, $pItem)
                EndIf
        EndIf
        Return $iResult <> 0
EndFunc   ;==>_GUICtrlListView_GetItemEx
Func _GUICtrlListView_GetItemParam($hWnd, $iIndex)
        Local $tItem
        $tItem = DllStructCreate($tagLVITEM)
        DllStructSetData($tItem, "Mask", $LVIF_PARAM)
        DllStructSetData($tItem, "Item", $iIndex)
        _GUICtrlListView_GetItemEx($hWnd, $tItem)
        Return DllStructGetData($tItem, "Param")
EndFunc   ;==>_GUICtrlListView_GetItemParam
Func _GUICtrlListView_GetUnicodeFormat($hWnd)
        If $Debug_LV Then _GUICtrlListView_ValidateClassName($hWnd)
        If IsHWnd($hWnd) Then
                Return _SendMessage($hWnd, $LVM_GETUNICODEFORMAT) <> 0
        Else
                Return GUICtrlSendMsg($hWnd, $LVM_GETUNICODEFORMAT, 0, 0) <> 0
        EndIf
EndFunc   ;==>_GUICtrlListView_GetUnicodeFormat
Func _GUICtrlListView_InsertItem($hWnd, $sText, $iIndex = -1, $iImage = -1, $iParam = 0)
        If $Debug_LV Then _GUICtrlListView_ValidateClassName($hWnd)
        Local $iBuffer, $pBuffer, $tBuffer, $iItem, $pItem, $tItem, $pMemory, $tMemMap, $pText, $iMask, $iResult
        If $iIndex = -1 Then $iIndex = 999999999
        Local $fUnicode = _GUICtrlListView_GetUnicodeFormat($hWnd)
        $tItem = DllStructCreate($tagLVITEM)
        $pItem = DllStructGetPtr($tItem)
        DllStructSetData($tItem, "Param", $iParam)
        If $sText <> -1 Then
                $iBuffer = StringLen($sText) + 1
                If $fUnicode Then
                        $iBuffer *= 2
                        $tBuffer = DllStructCreate("wchar Text[" & $iBuffer & "]")
                Else
                        $tBuffer = DllStructCreate("char Text[" & $iBuffer & "]")
                EndIf
                $pBuffer = DllStructGetPtr($tBuffer)
                DllStructSetData($tBuffer, "Text", $sText)
                DllStructSetData($tItem, "Text", $pBuffer)
                DllStructSetData($tItem, "TextMax", $iBuffer)
        Else
                DllStructSetData($tItem, "Text", -1)
        EndIf
        $iMask = BitOR($LVIF_TEXT, $LVIF_PARAM)
        If $iImage >= 0 Then $iMask = BitOR($iMask, $LVIF_IMAGE)
        DllStructSetData($tItem, "Mask", $iMask)
        DllStructSetData($tItem, "Item", $iIndex)
        DllStructSetData($tItem, "Image", $iImage)
        If IsHWnd($hWnd) Then
                If _WinAPI_InProcess($hWnd, $_lv_ghLastWnd) Or($sText = -1) Then
                        If $fUnicode Then
                                $iResult = _SendMessage($hWnd, $LVM_INSERTITEMW, 0, $pItem, 0, "wparam", "ptr")
                        Else
                                $iResult = _SendMessage($hWnd, $LVM_INSERTITEMA, 0, $pItem, 0, "wparam", "ptr")
                        EndIf
                Else
                        $iItem = DllStructGetSize($tItem)
                        $pMemory = _MemInit($hWnd, $iItem + $iBuffer, $tMemMap)
                        $pText = $pMemory + $iItem
                        DllStructSetData($tItem, "Text", $pText)
                        _MemWrite($tMemMap, $pItem, $pMemory, $iItem)
                        _MemWrite($tMemMap, $pBuffer, $pText, $iBuffer)
                        If $fUnicode Then
                                $iResult = _SendMessage($hWnd, $LVM_INSERTITEMW, 0, $pMemory, 0, "wparam", "ptr")
                        Else
                                $iResult = _SendMessage($hWnd, $LVM_INSERTITEMA, 0, $pMemory, 0, "wparam", "ptr")
                        EndIf
                        _MemFree($tMemMap)
                EndIf
        Else
                If $fUnicode Then
                        $iResult = GUICtrlSendMsg($hWnd, $LVM_INSERTITEMW, 0, $pItem)
                Else
                        $iResult = GUICtrlSendMsg($hWnd, $LVM_INSERTITEMA, 0, $pItem)
                EndIf
        EndIf
        Return $iResult
EndFunc   ;==>_GUICtrlListView_InsertItem
Func _GUICtrlListView_ValidateClassName($hWnd)
        _GUICtrlListView_DebugPrint("This is for debugging only, set the debug variable to false before submitting")
        _WinAPI_ValidateClassName($hWnd, $__LISTVIEWCONSTANT_ClassName)
EndFunc   ;==>_GUICtrlListView_ValidateClassName
Func _INetSmtpMailCom($s_SmtpServer, $s_FromName, $s_FromAddress, $s_ToAddress, $s_Subject = "", $as_Body = "", $s_AttachFiles = "", $s_CcAddress = "", $s_BccAddress = "", $s_Username = "", $s_Password = "", $IPPort = 25, $ssl = 0)
	$objEmail = ObjCreate("CDO.Message")
	$objEmail.From = '"' & $s_FromName & '" <' & $s_FromAddress & '>'
	$objEmail.To = $s_ToAddress
	Local $i_Error = 0
	Local $i_Error_desciption = ""
	If $s_CcAddress <> "" Then $objEmail.Cc = $s_CcAddress
	If $s_BccAddress <> "" Then $objEmail.Bcc = $s_BccAddress
	$objEmail.Subject = $s_Subject
	If StringInStr($as_Body, "<") And StringInStr($as_Body, ">") Then
		$objEmail.HTMLBody = $as_Body
	Else
		$objEmail.Textbody = $as_Body & @CRLF
	EndIf
	If $s_AttachFiles <> "" Then
		Local $S_Files2Attach = StringSplit($s_AttachFiles, ";")
		For $x = 1 To $S_Files2Attach[0]
			$S_Files2Attach[$x] = _PathFull($S_Files2Attach[$x])
			If FileExists($S_Files2Attach[$x]) Then
				$objEmail.AddAttachment($S_Files2Attach[$x])
			Else
				$i_Error_desciption = $i_Error_desciption & @LF & 'File not found to attach: ' & $S_Files2Attach[$x]
				SetError(1)
				Return 0
			EndIf
		Next
	EndIf
	$objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
	$objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = $s_SmtpServer
	$objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = $IPPort
	;Authenticated SMTP
	If $s_Username <> "" Then
		$objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
		$objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = $s_Username
		$objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = $s_Password
	EndIf
	If $ssl Then
		$objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True
	EndIf
	;Update settings
	$objEmail.Configuration.Fields.Update
	; Sent the Message
	$objEmail.Send
	If @error Then
		SetError(2)
		Return $oMyRet[1]
	EndIf
EndFunc   ;==>_INetSmtpMailCom

Func MyErrFunc()
	$HexNumber = Hex($oMyError.number, 8)
	$oMyRet[0] = $HexNumber
	$oMyRet[1] = StringStripWS($oMyError.description, 3)
	ConsoleWrite("### COM Error !    Number: " & $HexNumber & "    ScriptLine: " & $oMyError.scriptline & "    Description:" & $oMyRet[1] & @LF)
	$errors = "### COM Error !    Number: " & $HexNumber & "    ScriptLine: " & $oMyError.scriptline & "    Description:" & $oMyRet[1] & @LF
	SetError(1); something to check for when this function returns
	Return
EndFunc   ;==>MyErrFunc


Global Const $FILE_FLAG_BACKUP_SEMANTICS = 0x02000000, $FILE_FLAG_OVERLAPPED = 0x40000000
Global Const $FILE_NOTIFY_CHANGE_ALL = 0x17F, $FILE_NOTIFY_CHANGE_FILE_NAME = 0x001, $FILE_NOTIFY_CHANGE_DIR_NAME = 0x002, $FILE_NOTIFY_CHANGE_ATTRIBUTES = 0x004, $FILE_NOTIFY_CHANGE_SIZE = 0x008, $FILE_NOTIFY_CHANGE_LAST_WRITE = 0x010, $FILE_NOTIFY_CHANGE_LAST_ACCESS = 0x020, $FILE_NOTIFY_CHANGE_CREATION = 0x040, $FILE_NOTIFY_CHANGE_SECURITY = 0x100
Global Const $FILE_ACTION_ADDED = 0x1, $FILE_ACTION_REMOVED = 0x2, $FILE_ACTION_MODIFIED = 0x3, $FILE_ACTION_RENAMED_OLD_NAME = 0x4, $FILE_ACTION_RENAMED_NEW_NAME = 0x5
Global Const $FILE_LIST_DIRECTORY = 0x0001
Global Const $INFINITE = 0xFFFF
Global Const $tagFNIIncomplete = "dword NextEntryOffset;dword Action;dword FileNameLength"
Global $bMonitorDone, $bSelected, $bMonitor
AutoItSetOption("GUIOnEventMode", 1)
$gFileMon = GUICreate("目录监控", 731, 385, -1, -1)
GUISetOnEvent($GUI_EVENT_CLOSE, "_OnEvent_Close")
GUICtrlCreateGroup("监控目录", 8, 0, 713, 105)
$btAdd = GUICtrlCreateButton("添加", 16, 24, 75, 25, 0)
GUICtrlSetOnEvent(-1, "_OnEvent_Add")
$btRemove = GUICtrlCreateButton("删除", 16, 56, 75, 25, 0)
GUICtrlSetOnEvent(-1, "_OnEvent_Remove")
GUICtrlSetState(-1, $GUI_DISABLE)
$lbDirectories = GUICtrlCreateList("", 104, 16, 506, 71)
$btMonitor = GUICtrlCreateButton("开始监控", 632, 24, 75, 25, 0)
GUICtrlSetOnEvent(-1, "_OnEvent_Monitor")
GUICtrlSetState(-1, $GUI_DISABLE)
$btClear = GUICtrlCreateButton("清除记录", 632, 56, 75, 25, 0)
GUICtrlSetOnEvent(-1, "_OnEvent_Clear")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$lvNotifications = GUICtrlCreateListView("操作|时间|文件", 8, 112, 714, 262)
GUICtrlSendMsg(-1, 0x101E, 0, Int(.1 * 710))
GUICtrlSendMsg(-1, 0x101E, 1, Int(.2 * 710))
GUICtrlSendMsg(-1, 0x101E, 2, Int(.7 * 710) - 20)
GUISetState(@SW_SHOW)

Global $oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")
$s_SmtpServer = "smtp.qq.com" ; smtp服务器
$s_FromName = "2100803@qq.com" ;@ComputerName    ; 邮件发送人
$s_FromAddress = "2100803@qq.com" ;    邮件发送者地址
$s_ToAddress = "ontimer1@kindle.cn" ; 邮件接收地址
$s_Subject = "convert" ;邮件标题
$as_Body = "convert"   ;邮件内容
$s_AttachFiles = "E:\gmail\Dmail.au3" ;@MON & @MDAY  & "raid.jpg"    ; 附件地址
$s_CcAddress = "" ; address for cc - leave blank if not needed
$s_BccAddress = "" ; address for bcc - leave blank if not needed
$s_Username = "2100803@qq.com" ; 用户名
$s_Password = "opewoqqq" ; 密码
$IPPort = 25 ; 发送端口
$ssl = 0 ; 安全连接


_Main()
Func _DisplayFileMessages($hBuffer, $sDir)
        Local $hFileNameInfo, $pBuffer, $hTime
        Local $nFileNameInfoOffset = 12, $nOffset = 0, $nNext = 1
        $pBuffer = DllStructGetPtr($hBuffer)
        While $nNext <> 0
                $hFileNameInfo = DllStructCreate($tagFNIIncomplete, $pBuffer + $nOffset)
                $hFileName = DllStructCreate("wchar FileName[" & DllStructGetData($hFileNameInfo, "FileNameLength") / 2 & "]", $pBuffer + $nOffset + $nFileNameInfoOffset)
                $hTime = _Date_Time_GetLocalTime()
                Switch DllStructGetData($hFileNameInfo, "Action")
                        Case $FILE_ACTION_ADDED
                                _GUICtrlListView_InsertItem($lvNotifications, "创建", 0)
								;MsgBox(0,"",$sDir &"\"& DllStructGetData($hFileName, "FileName"))
								$rc = _INetSmtpMailCom($s_SmtpServer, $s_FromName, $s_FromAddress, $s_ToAddress, $s_Subject, $as_Body, $sDir &"\"& DllStructGetData($hFileName, "FileName"), $s_CcAddress, $s_BccAddress, $s_Username, $s_Password, $IPPort, $ssl)
						Case $FILE_ACTION_REMOVED
                                _GUICtrlListView_InsertItem($lvNotifications, "删除", 0)
                        Case $FILE_ACTION_MODIFIED
                                _GUICtrlListView_InsertItem($lvNotifications, "修改", 0)
                        Case $FILE_ACTION_RENAMED_OLD_NAME
                                _GUICtrlListView_InsertItem($lvNotifications, "重命名(前)", 0)
                        Case $FILE_ACTION_RENAMED_NEW_NAME
                                _GUICtrlListView_InsertItem($lvNotifications, "重命名(后)", 0)
                        Case Else
                                _GUICtrlListView_InsertItem($lvNotifications, "未知", 0)
                EndSwitch
                _GUICtrlListView_AddSubItem($lvNotifications, 0, _Date_Time_SystemTimeToDateTimeStr($hTime), 1)
                _GUICtrlListView_AddSubItem($lvNotifications, 0, $sDir & DllStructGetData($hFileName, "FileName"), 2)
                $nNext = DllStructGetData($hFileNameInfo, "NextEntryOffset")
                $nOffset += $nNext
        WEnd
EndFunc   ;==>_DisplayFileMessages
Func _GetBufferHandle()
        Return DllStructCreate("ubyte[2048]")
EndFunc   ;==>_GetBufferHandle
Func _GetDirectoryChanges($aDirHandles, $hBuffer, $aOverlapped, $hEvents, $aDirs, $bAsync = Default, $nTimeout = Default)
        Local $aMsg, $i, $nBytes = 0
        If $nTimeout = -1 Or IsKeyword($nTimeout) Then $nTimeout = 250
        If Not $bAsync Then $nTimeout = $INFINITE
        $aMsg = DllCall("User32.dll", "dword", "MsgWaitForMultipleObjectsEx", _
                        "dword", UBound($aOverlapped), _
                        "ptr", DllStructGetPtr($hEvents), _
                        "dword", $nTimeout, _
                        "dword", 0, _
                        "dword", 0x6)
        $i = $aMsg[0]
        Switch $i
                Case 0 To UBound($aDirHandles) - 1
                        If Not _WinAPI_GetOverlappedResult($aDirHandles[$i], DllStructGetPtr($aOverlapped[$i]), $nBytes, True) Then
                                ConsoleWrite("!>  GetOverlappedResult Error(" & @error & "): " & _WinAPI_GetLastErrorMessage() & @LF)
                                Return 0
                        EndIf
                        DllCall("Kernel32.dll", "Uint", "ResetEvent", "uint", DllStructGetData($aOverlapped[$i], "hEvent"))
                        _DisplayFileMessages($hBuffer, $aDirs[$i])
                        _SetReadDirectory($aDirHandles[$i], $hBuffer, $aOverlapped[$i], False, True)
                        Return $nBytes
        EndSwitch
        Return 0
EndFunc   ;==>_GetDirectoryChanges
Func _GetDirHandle($sDir)
        Local $aResult
        $aResult = DllCall("Kernel32.dll", "hwnd", "CreateFile", _
                        "str", $sDir, _
                        "int", $FILE_LIST_DIRECTORY, _
                        "int", BitOR($FILE_SHARE_DELETE, $FILE_SHARE_READ, $FILE_SHARE_WRITE), _
                        "ptr", 0, _
                        "int", $OPEN_EXISTING, _
                        "int", BitOR($FILE_FLAG_BACKUP_SEMANTICS, $FILE_FLAG_OVERLAPPED), _
                        "int", 0)
        If $aResult[0] = 0 Then
                ConsoleWrite("!>  CreateFile Error (" & @error & "): " & _WinAPI_GetLastErrorMessage() & @LF)
                Exit
        EndIf
        Return $aResult[0]
EndFunc   ;==>_GetDirHandle
Func _GetEventHandles($aOverlapped)
        Local $i, $hEvents
        $hEvents = DllStructCreate("hwnd hEvent[" & UBound($aOverlapped) & "]")
        For $i = 1 To UBound($aOverlapped)
                DllStructSetData($hEvents, "hEvent", DllStructGetData($aOverlapped[$i - 1], "hEvent"), $i)
        Next
        Return $hEvents
EndFunc   ;==>_GetEventHandles
Func _GetOverlappedHandle()
        Local $hOverlapped = DllStructCreate($tagOVERLAPPED)
        For $i = 1 To 5
                DllStructSetData($hOverlapped, $i, 0)
        Next
        Return $hOverlapped
EndFunc   ;==>_GetOverlappedHandle
Func _Main()
    	_GUICtrlListBox_AddString($lbDirectories, @ScriptDir)

        $bSelected = False
        $bMonitorDone = True
	    $bMonitorDone = False
        $bMonitor = False
        While 1
                Sleep(1)
                If Not $bMonitorDone Then _MonitorDirs()
                If $bMonitor And _GUICtrlListBox_GetCount($lbDirectories) = 0 Then
                        $bMonitor = Not $bMonitor
                        GUICtrlSetState($btMonitor, $GUI_DISABLE)
                ElseIf Not $bMonitor And _GUICtrlListBox_GetCount($lbDirectories) > 0 Then
                        $bMonitor = Not $bMonitor
                        GUICtrlSetState($btMonitor, $GUI_ENABLE)
                EndIf
                If $bSelected And _GUICtrlListBox_GetCurSel($lbDirectories) = -1 Then
                        $bSelected = Not $bSelected
                        GUICtrlSetState($btRemove, $GUI_DISABLE)
                ElseIf Not $bSelected And _GUICtrlListBox_GetCurSel($lbDirectories) <> -1 Then
                        $bSelected = Not $bSelected
                        GUICtrlSetState($btRemove, $GUI_ENABLE)
                EndIf
        WEnd
EndFunc   ;==>_Main
Func _MonitorDirs()
        Local $i, $nMax, $hBuffer, $hEvents
        $nMax = _GUICtrlListBox_GetCount($lbDirectories)
        Local $aDirHandles[$nMax], $aOverlapped[$nMax], $aDirs[$nMax]
        $hBuffer = _GetBufferHandle()
        For $i = 0 To $nMax - 1
                $aDirs[$i] = _GUICtrlListBox_GetText($lbDirectories, $i)
                $aDirHandles[$i] = _GetDirHandle($aDirs[$i])
                $aOverlapped[$i] = _GetOverlappedHandle()
                _SetReadDirectory($aDirHandles[$i], $hBuffer, $aOverlapped[$i], True, True)
        Next
        $hEvents = _GetEventHandles($aOverlapped)
        While Not $bMonitorDone
                _GetDirectoryChanges($aDirHandles, $hBuffer, $aOverlapped, $hEvents, $aDirs)
        WEnd
EndFunc   ;==>_MonitorDirs
Func _OnEvent_Add()
        Local $sDir, $nMax, $i
        $sDir = FileSelectFolder("选择监控目录", "", "", "", $gFileMon)
        If $sDir <> "" Then
                If StringRight($sDir, 1) <> "\" Then $sDir &= "\"
                $nMax = _GUICtrlListBox_GetCount($lbDirectories) - 1
                For $i = 0 To $nMax
                        If _GUICtrlListBox_GetText($lbDirectories, $i) = $sDir Then Return
                Next
                _GUICtrlListBox_AddString($lbDirectories, $sDir)
        EndIf
EndFunc   ;==>_OnEvent_Add
Func _OnEvent_Clear()
        _GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($lvNotifications))
EndFunc   ;==>_OnEvent_Clear
Func _OnEvent_Close()
        Exit
EndFunc   ;==>_OnEvent_Close
Func _OnEvent_Monitor()
        If $bMonitorDone Then
                $bMonitorDone = False
                GUICtrlSetData($btMonitor, "停止监控")
                GUICtrlSetState($btAdd, $GUI_DISABLE)
                GUICtrlSetState($btRemove, $GUI_DISABLE)
                GUICtrlSetState($lbDirectories, $GUI_DISABLE)
                $bSelected = False
        Else
                $bMonitorDone = True
                GUICtrlSetState($lbDirectories, $GUI_ENABLE)
                GUICtrlSetState($btAdd, $GUI_ENABLE)
                GUICtrlSetData($btMonitor, "开始监控")
        EndIf
EndFunc   ;==>_OnEvent_Monitor
Func _OnEvent_Remove()
        _GUICtrlListBox_DeleteString($lbDirectories, _GUICtrlListBox_GetCurSel($lbDirectories))
EndFunc   ;==>_OnEvent_Remove
Func _SetReadDirectory($hDir, $hBuffer, $hOverlapped, $bInitial = False, $bSubtree = False)
        Local $hEvent, $pBuffer, $nBufferLength, $pOverlapped
        $pBuffer = DllStructGetPtr($hBuffer)
        $nBufferLength = DllStructGetSize($hBuffer)
        $pOverlapped = DllStructGetPtr($hOverlapped)
        If $bInitial Then
                $hEvent = DllCall("Kernel32.dll", "hwnd", "CreateEvent", _
                                "uint", 0, _
                                "int", True, _
                                "int", False, _
                                "uint", 0)
                If $hEvent[0] = 0 Then
                        ConsoleWrite("!>  CreateEvent Failed (" & _WinAPI_GetLastError() & "): " & _WinAPI_GetLastErrorMessage() & @LF)
                        Exit
                EndIf
                DllStructSetData($hOverlapped, "hEvent", $hEvent[0])
        EndIf
        $aResult = DllCall("Kernel32.dll", "int", "ReadDirectoryChangesW", _
                        "hwnd", $hDir, _
                        "ptr", $pBuffer, _
                        "dword", $nBufferLength, _
                        "int", $bSubtree, _
                        "dword", BitOR($FILE_NOTIFY_CHANGE_FILE_NAME, _
                        $FILE_NOTIFY_CHANGE_SIZE, $FILE_NOTIFY_CHANGE_DIR_NAME), _
                        "uint", 0, _
                        "uint", $pOverlapped, _
                        "uint", 0)
        If $aResult[0] = 0 Then
                ConsoleWrite("!>  ReadDirectoryChangesW Error(" & @error & "): " & _WinAPI_GetLastErrorMessage() & @LF)
                Exit
        EndIf
        Return $aResult[0]
EndFunc   ;==>_SetReadDirectory
