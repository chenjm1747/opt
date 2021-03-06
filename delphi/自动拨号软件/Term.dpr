program Term;

uses SysUtils, Windows, Tapi;

{$R *.RES}
{$APPTYPE CONSOLE}

var
  bConnected: Boolean = False;

procedure lineCallback(hDevice, dwMsg, dwCallbackInstance,
		dwParam1, dwParam2, dwParam3: Longint); stdcall;
  begin
  if (dwMsg = LINE_CALLSTATE) and
        (dwParam1 = LINECALLSTATE_CONNECTED) then
    bConnected := True;
  end;

function GetDevCaps(hLineApp: THLineApp; dwDeviceID: Longint;
    var lpdwAPIVersion: Longint): LPLineDevCaps;
  var
    pLineDevCaps: LPLineDevCaps;
    extensionID: TLineExtensionID;
  begin
  lineNegotiateAPIVersion(hLineApp, dwDeviceID, $10004, $10004,
      lpdwAPIVersion, extensionID);
  pLineDevCaps := AllocMem(SizeOf(TLineDevCaps));
  pLineDevCaps^.dwTotalSize := SizeOf(TLineDevCaps);
  lineGetDevCaps(hLineApp, dwDeviceID, lpdwAPIVersion, 0,
      pLineDevCaps^);
  if pLineDevCaps^.dwNeededSize > pLineDevCaps^.dwTotalSize then
    begin
    ReallocMem(pLineDevCaps, pLineDevCaps^.dwNeededSize);
    pLineDevCaps^.dwTotalSize := pLineDevCaps^.dwNeededSize;
    lineGetDevCaps(hLineApp, dwDeviceID, lpdwAPIVersion, 0,
        pLineDevCaps^);
    end;
    Result :=  pLineDevCaps;
  end;

function SelectTAPIDevice(hLineApp: THLineApp; dwNumDevs: Longint;
    var lphLine: THLine; var lphCall: THCall): THandle;
  var
    pLineDevCaps: LPLineDevCaps;
    dwDeviceID: Longint;
    dwAPIVersion: Longint;
    i: Longint;
    lineCallParams: TLineCallParams;
    lpDeviceID: LPVARSTRING;
    msg: TMsg;
    szNumber: Array[0..80] of char;
  begin
  for i := 0 to dwNumDevs - 1 do
    begin
    pLineDevCaps := GetDevCaps(hLineApp, i, dwAPIVersion);
    if (pLineDevCaps^.dwMediaModes and LINEMEDIAMODE_DATAMODEM) <> 0 then
      Writeln(Format('%d: %s', [i,
          PChar(pLineDevCaps) + pLineDevCaps^.dwLineNameOffset]));
    FreeMem(pLineDevCaps);
    end;
  dwDeviceID := $FFFFFFF;
  while dwDeviceID >= dwNumDevs do
    begin
    Write('Select device: ');
    ReadLn(dwDeviceID);
    if dwDeviceID >= dwNumDevs then
      continue;
    pLineDevCaps := GetDevCaps(hLineApp, dwDeviceID, dwAPIVersion);
    if (pLineDevCaps^.dwMediaModes and LINEMEDIAMODE_DATAMODEM) = 0 then
      begin
      dwDeviceID := $FFFFFFF;
      FreeMem(pLineDevCaps);
      end;
    end;
  Write('Enter telephone number: ');
  ReadLn(szNumber);
  Write(Format('Dialing %s on %s...', [szNumber,
      PChar(pLineDevCaps) + pLineDevCaps^.dwLineNameOffset]));
  FreeMem(pLineDevCaps);
  FillChar(lineCallParams, SizeOf(TLineCallParams), 0);
  lineCallParams.dwTotalSize := sizeof(TLineCallParams);
  lineCallParams.dwMinRate := 2400;
  lineCallParams.dwMaxRate := 57600;
  lineCallParams.dwMediaMode := LINEMEDIAMODE_DATAMODEM;
  lineOpen(hLineApp, dwDeviceID, lphLine, dwAPIVersion, 0, 0,
      LINECALLPRIVILEGE_NONE, LINEMEDIAMODE_DATAMODEM, @lineCallParams);
  lineMakeCall(lphLine, lphCall, szNumber, 0, @lineCallParams);
  while not bConnected do
    if GetMessage(msg, 0, 0, 0) then
      DispatchMessage(msg);
  Writeln;
  lpDeviceID := AllocMem(SizeOf(TVarString));
  lpDeviceID^.dwTotalSize := sizeof(TVarString);
  lineGetID(0, 0, lphCall, LINECALLSELECT_CALL, lpDeviceID^,
      'comm/datamodem');
  if lpDeviceID^.dwNeededSize > lpDeviceID^.dwTotalSize then
    begin
    ReallocMem(lpDeviceID, lpDeviceID^.dwNeededSize);
    lpDeviceID^.dwTotalSize := lpDeviceID^.dwNeededSize;
    lineGetID(0, 0, lphCall, LINECALLSELECT_CALL, lpDeviceID^,
        'comm/datamodem');
    end;
  Result := PHandle(PChar(lpDeviceID) + SizeOf(TVarString))^;
  end;

var
  hLineApp: THLineApp;
  hLine: THLine;
  hCall: THCall;
  dwNumDevs: Longint;
  hConIn, hConOut, hCommPort: THandle;
  hEvents: Array[0..1] of THandle;
  dwCount: Dword;
  dwWait: Longint;
  ctmoCommPort: TCommTimeOuts;
  dcbCommPort: TDcb;
  ov: TOverlapped;
  irBuffer: TInputRecord;
  fInRead: Boolean;
  c: Char;
  i: Integer;

label EndLoop;

begin
  lineInitialize(hLineApp, GetModuleHandle(nil), lineCallback,
      'Test TAPI Application', dwNumDevs);
  hCommPort := SelectTAPIDevice(hLineApp, dwNumDevs, hLine, hCall);
  hConIn := CreateFile('CONIN$', GENERIC_READ or GENERIC_WRITE,
      FILE_SHARE_READ, nil, OPEN_EXISTING,
      FILE_ATTRIBUTE_NORMAL, 0);
  SetConsoleMode(hConIn, 0);
  hConOut := CreateFile('CONOUT$', GENERIC_WRITE,
      FILE_SHARE_WRITE, nil, OPEN_EXISTING,
      FILE_ATTRIBUTE_NORMAL, 0);
  with ctmoCommPort do
    begin
    ReadIntervalTimeout := MAXLongint;
    ReadTotalTimeoutMultiplier := MAXLongint;
    ReadTotalTimeoutConstant := MAXLongint;
    WriteTotalTimeoutMultiplier := 0;
    WriteTotalTimeoutConstant := 0;
    end;
  SetCommTimeouts(hCommPort, ctmoCommPort);
  dcbCommPort.DCBlength := SizeOf(TDcb);
  GetCommState(hCommPort, dcbCommPort);
  SetCommState(hCommPort, dcbCommPort);
  SetCommMask(hCommPort, EV_RXCHAR);
  with ov do
    begin
    Offset := 0;
    OffsetHigh := 0;
    hEvent := CreateEvent(nil, True, False, nil);
    end;
  hEvents[0] := ov.hEvent;
  hEvents[1] := hConIn;
  fInRead := False;
  while True do
    begin
    if not fInRead then
      while (ReadFile(hCommPort, c, 1, dwCount, @ov)) do
        if dwCount = 1 then
          WriteFile(hConOut, c, 1, dwCount, nil);
    fInRead := True;
    dwWait := WaitForMultipleObjects(2, @hEvents, False, INFINITE);
    case dwWait of
      WAIT_OBJECT_0:
        begin
        if GetOverlappedResult(hCommPort, ov, dwCount, False) then
          if dwCount = 1 then
            WriteFile(hConOut, c, 1, dwCount, nil);
        fInRead := False;
        end;
      WAIT_OBJECT_0 + 1:
        begin
        ReadConsoleInput(hConIn, irBuffer, 1, dwCount);
        if (dwCount = 1) and
            (irBuffer.EventType = KEY_EVENT) and
            (irBuffer.Event.KeyEvent.bKeyDown) then
          for i := 0 to irBuffer.Event.KeyEvent.wRepeatCount - 1 do
            begin
            if irBuffer.Event.KeyEvent.AsciiChar <> #0 then
              begin
              WriteFile(hCommPort, irBuffer.Event.KeyEvent.AsciiChar,
                  1, dwCount, nil);
              if irBuffer.Event.KeyEvent.AsciiChar = #24 then
                goto EndLoop;
              end;
            end;
        end;
      end;
    end;
EndLoop:
  CloseHandle(ov.hEvent);
  CloseHandle(hConIn);
  CloseHandle(hConOut);
  CloseHandle(hCommPort);
  lineDrop(hCall, nil, 0);
  lineClose(hLine);
  lineShutdown(hLineApp);
end.
