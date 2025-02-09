program AutoUpdater;

uses
  Vcl.Forms,
  uAutoUpdater in '..\src\uAutoUpdater.pas' {FormAutoUpdater},
  uGitHub in '..\src\uGitHub.pas';

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormAutoUpdater, FormAutoUpdater);
  Application.Run;
end.
