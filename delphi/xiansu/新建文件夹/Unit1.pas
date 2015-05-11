unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
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
 
procedure TForm1.FormCreate(Sender: TObject);
begin
 WinExecExW('rasdial /d',0);
 WinExecExW('rasdial adsl 057105858542 909188 /phonebook:c:\rasphone.pbk',0);
end;

end.
