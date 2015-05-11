unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure WebBrowser1DocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure WebBrowser1NewWindow2(Sender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
var

tempWB : TWebBrowser;//ÁÙÊ±TWeb
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
webbrowser1.Navigate('http://search.newhua.com/search_list.php?searchsid=1&searchname=%E6%97%85%E7%A8%8B%E5%90%8C%E8%A1%8C%E6%97%85%E8%A1%8C%E7%A4%BE&button=');
end;

procedure TForm1.WebBrowser1DocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
x: integer;
ovLinks: OleVariant;
begin
// get all anchors
ovLinks := WebBrowser1.OleObject.Document.all.tags('A');
if ovLinks.Length > 0 then
begin
for x := 0 to ovLinks.Length-1 do
begin
// only operate on the /threads/ link 
if Pos('/softdown/565228_2.htm', ovLinks.Item(x).href) > 0 then
begin
ovLinks.Item(x).click;
Break;
end;
end;
end;
end;


procedure TForm1.WebBrowser1NewWindow2(Sender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
begin

if not Assigned(tempWB) then tempWB := TWebBrowser.Create(Self);

tempWB.OnBeforeNavigate2 := Self.tempWBBeforeNavigate2;

ppDisp := tempWB.OleObject;

end;
end.
