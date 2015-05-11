unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    IdHTTP2: TIdHTTP;
    IdHTTP3: TIdHTTP;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
      type 
        TMyDownLoad=class(TThread) 
        protected 
              procedure   Execute;override;
              procedure   Download; 
        end;
var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure   TMyDownLoad.Download; 
Var
    UnitName,PathName:String; 
    MyStream:TMemoryStream; 
    filepath:string;
     strlist_ParamPost : TStringList ;
    IDHTTP:   TIDHttp; 
begin

    strlist_ParamPost := TStringList.Create() ;
    strlist_ParamPost.Add('user_loginname=aa') ;
    strlist_ParamPost.Add('user_pwd=aaaaa') ;
    strlist_ParamPost.Add('user_comno=demo');
    IdHTTP:=TIDHttp.Create(nil);
    MyStream:=TMemoryStream.Create;
  while 1=1 do
  begin
     try
        IdHTTP.Get('http://www.716580.com/b2b/sns/index.asp',MyStream) ;
        MyStream.Clear;
      // IdHTTP.Post('http://i.716580.com/ytt_login/check.asp?user_loginname=aa&user_comno=demo&user_pwd=aaaaa', strlist_ParamPost,MyStream) ;
    except
    end;
   end
end;
procedure   TMyDownLoad.Execute;
begin
            inherited; 
            Download; 
end;


procedure TForm1.FormCreate(Sender: TObject);
  var
  i:integer;
begin
  for i:=0 to 2 do
       TMyDownLoad.Create(false);

end;

end.
