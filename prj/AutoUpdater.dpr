program AutoUpdater;

uses
  Vcl.Forms,
  uAutoUpdater in '..\src\uAutoUpdater.pas' {FormAutoUpdater},
  uGitHub in '..\src\Helper\uGitHub.pas';

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  Application.Title := Application.Title + ' (DEBUG)';
{$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormAutoUpdater, FormAutoUpdater);
  Application.Run;
end.
