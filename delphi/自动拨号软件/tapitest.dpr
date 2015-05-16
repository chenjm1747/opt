program Tapitest;

uses
  Forms,
  Callform in 'CALLFORM.PAS' {frmTAPICall};

{$R *.RES}

begin
{$IFDEF WIN32}
	Application.Initialize;
{$ENDIF}
	Application.CreateForm(TfrmTAPICall, frmTAPICall);
  Application.Run;
end.
