program shualiuliang;

uses
  Windows, Messages, SysUtils, Variants, Classes, ShellAPI, Tlhelp32, IdIntercept, IdInterceptThrottler,
  IdHTTP,forms;

{$R *.res}
Function WinExecExW(CMD:Pchar; Visiable:integer):DWORD;
var
    StartupInfo : TStartupInfo;
    ProcessInfo : TProcessInformation;
begin
    FillChar( StartUpInfo, SizeOf(StartUpInfo), $00 );
    StartUpInfo.dwFlags := STARTF_USESHOWWINDOW;
    StartUpInfo.wShowWindow := SW_HIDE;
    if CreateProcess( nil, CMD, nil, nil, {运行批处理文件}
    False, IDLE_PRIORITY_CLASS, nil, nil, StartUpInfo,
    ProcessInfo ) then
    begin
        WaitForSingleObject(Processinfo.hProcess,INFINITE);
        GetExitCodeProcess(ProcessInfo.hProcess,Result);

        CloseHandle( ProcessInfo.hThread );
        CloseHandle( ProcessInfo.hProcess );
    end;
end;
 

var
  UserAgent, gongjiurl: string;
  idHTTP2: TIDHttp;
  userurllist, useragentlist: tstrings;
  xi: Integer;
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
  j1, j: Integer;
  poststr: string;
  postStream: TStringStream;


begin
  Randomize;
  idHTTP1 := TIDHTTP.Create;
  IdInterceptThrottler1 := TIdInterceptThrottler.create();
  IdInterceptThrottler1.BitsPerSec := 80000;
  idHTTP1.Intercept := IdInterceptThrottler1;
  IdHttp1.Request.UserAgent := useragentlist[Random(useragentlist.Count)];
  IdHTTP1.HandleRedirects:=true;
//  IdHttp1.AllowCookies := True;
//  IdHttp1.CookieManager := IdCookieManager1;
//  IdHttp1.Request.Referer := 'http://delphiskill.zhan.cn.yahoo.com/page/2030';

  while 1 = 1 do
  begin
//
WinExecExW('rasdial adsl 057105858542 909188 /phonebook:c:\rasphone.pbk',0);
//    idHTTP1.Get(userurllist[Random(userurllist.Count)]);
    Sleep(3600 * 1000);
winexec('%windir%\system32\rasdial.exe /d ',SW_SHOWNORMAL);
  end;
end;

procedure TMyDownLoad.Execute;
begin
  inherited;
  Download;
end;


begin
WinExecExW('rasdial adsl 057105858542 909188 /phonebook:c:\rasphone.pbk',0);
  idHTTP2 := TIDHTTP.Create;
  gongjiurl := idHTTP2.Get('http://www.caiwuhao.com/userurl.txt');
  userurllist := tstringlist.create;
  userurllist.CommaText := gongjiurl;
  gongjiurl := idHTTP2.Get('http://www.caiwuhao.com/useragent.txt');
  useragentlist := tstringlist.create;
  useragentlist.Text := StringReplace(gongjiurl, ',', #13#10, [rfReplaceAll]);
//  useragentlist.CommaText := gongjiurl;
  for xi := 0 to 0 do
  begin
    TMyDownLoad.Create(false);
    Sleep(3600 * 100000);
  end;
// ShellExecute(0, 'open',PChar(ParamStr(0)),nil,nil, SW_SHOWNORMAL);
  FillChar(ProcessInfo, sizeof(TProcessInformation), 0);
  FillChar(StartupInfo, Sizeof(TStartupInfo), 0);
  StartupInfo.cb := Sizeof(TStartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_SHOW;
  ExeName := PChar(ParamStr(0)); //所创建进程路径
  CreateProcess(ExeName, nil, nil, nil, False, NORMAL_PRIORITY_CLASS,
    nil, nil, StartupInfo, ProcessInfo)

//WinExec(PChar('m10.exe') ,SW_SHOW);
// WinExec(PChar( ParamStr(0)) ,SW_SHOWNORMAL);
end.

