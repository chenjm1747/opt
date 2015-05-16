unit MonForm;
{
	*** TAPI Monitor ***
        by Davide Moretti <dave@rimini.com>

	This is a TAPI Test
	It uses TAPI interface to monitor outgoing calls
	Open this program, and then make a call with
	Remote Access or something that uses TAPI

	I used TAPI only to monitor calls, since I am wriing
	a toll accounting program.
}

interface

uses
	WinTypes, WinProcs, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Tapi,
	StdCtrls;

type
	TfrmTAPIMon = class(TForm)
    Memo1: TMemo;
		procedure FormCreate(Sender: TObject);
		procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
	private
		{ Private declarations }
		lineApp: THLineApp;
		line: THLine;
	public
		{ Public declarations }
	end;

var
	frmTAPIMon: TfrmTAPIMon;

implementation

{$R *.DFM}

uses Main;

var
	buf:array[0..1023] of char;
	callinfo: TLineCallInfo absolute buf;
	{
		these two variables points to the same address.
		since lineGetCallInfo expects a buffer with a TLineCallInfo on top.
	}

{
	TAPI Callback procedure: called for TAPI messages
	you MUST use 'stdcall' since it is called by Windows
}
procedure lineCallback(hDevice, dwMsg, dwCallbackInstance,
		dwParam1, dwParam2, dwParam3: LongInt);
{$IFDEF WIN32}
		stdcall;
{$ELSE}
		export;
{$ENDIF}
	var
		s: string;
		hCall: THCall;
	begin
	if dwMsg = LINE_CALLSTATE then	{ change in line state }
		begin
		hCall := THCall(hDevice);
		case dwParam1 of
			LINECALLSTATE_IDLE:		{ call terminated }
				if hcall <> 0 then
					begin
					lineDeallocateCall(hCall);	{ you must deallocate the monitored call }
					frmTAPIMon.Memo1.Lines.Add( 'Idle - monitored call deallocated');
					end;
			LINECALLSTATE_CONNECTED:	{ Service connected }
				if hCall <> 0 then
					begin
					frmTAPIMon.Memo1.Lines.Add('Connected');
					callinfo.dwTotalSize := 4096;
					if lineGetCallInfo(hCall, callinfo) = 0 then
						begin
						if callinfo.dwAppNameSize > 0 then
							begin
{$IFDEF WIN32}
							s := ' * AppName: ' + (buf + callinfo.dwAppNameOffset); { this is more C-ish... }
{$ELSE}
							s := ' * AppName: ' + StrPas((buf + callinfo.dwAppNameOffset)); { this is more C-ish... }
{$ENDIF}
							frmTAPIMon.Memo1.Lines.Add(s);
							end;
						end;
					end;
			LINECALLSTATE_PROCEEDING:		{ call proceeding (dialing) }
				frmTAPIMon.Memo1.Lines.Add( 'Proceeding');
			LINECALLSTATE_DIALING:			{ call dialing }
				frmTAPIMon.Memo1.Lines.Add( 'Dialing');
			LINECALLSTATE_DISCONNECTED:	{ Disconnected }
				frmTAPIMon.Memo1.Lines.Add('Disconnected');
			end;
		end;
	end;

procedure TfrmTAPIMon.FormCreate(Sender: TObject);
	var
		nDevs, tapiVersion: Longint;
		extid: TLineExtensionID;
	begin
	{ Initialize TAPI }
	if lineInitialize(lineApp, HInstance,
			lineCallback, nil, nDevs) < 0 then		{ < 0 is an error }
		lineApp := 0
	else if nDevs = 0 then		{ no TAPI devices?? }
		begin
		lineShutDown(lineApp);
		lineApp := 0;
		end
	else if lineNegotiateAPIVersion(lineApp, 0, $00010000, $10000000,
			tapiVersion, extid) < 0 then	{ Check for version (copied from a TAPI sample) }
		begin
		lineShutDown(lineApp);
		lineApp := 0;
		end
	{ Open a line for monitor (here I use first device, normally the modem) }
	else if lineOpen(lineApp, 0, line, tapiVersion, 0, 0,
			LINECALLPRIVILEGE_MONITOR, LINEMEDIAMODE_DATAMODEM, nil) < 0 then
		begin
		lineShutDown(lineApp);
		lineApp := 0;
		line := 0;
		end;
	if lineApp <> 0 then
		Memo1.Lines.Add( 'Monitoring calls...')
	else
		Memo1.Lines.Add( 'Error!');
	end;

procedure TfrmTAPIMon.FormDestroy(Sender: TObject);
	begin
	{ Terminate TAPI }
	if line <> 0 then
		lineClose(line);
	if lineApp <> 0 then
		lineShutDown(lineApp);
	frmMain.Monitor := False;
	end;

procedure TfrmTAPIMon.FormClose(Sender: TObject; var Action: TCloseAction);
	begin
	Action := caFree;
	end;

end.
