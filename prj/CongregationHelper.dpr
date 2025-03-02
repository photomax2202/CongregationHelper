program CongregationHelper;

uses
  Vcl.Forms,
  uCongregationHelper in '..\src\uCongregationHelper.pas' {FormCongregationHelper},
  uConfig in '..\src\Settings\uConfig.pas',
  uConfigCamera in '..\src\Settings\uConfigCamera.pas' {FormConfigCamera},
  uValidationAndHelper in '..\src\uValidationAndHelper.pas',
  uConfigMonitor in '..\src\Settings\uConfigMonitor.pas' {FormConfigMonitor},
  uPageMaster in '..\src\uPageMaster.pas' {FormPageMaster},
  uPageCamera in '..\src\FunctionPage\uPageCamera.pas' {FormPageCamera},
  uConfigFormMaster in '..\src\uConfigFormMaster.pas' {ForrmConfigMaster},
  uGitHub in '..\src\uGitHub.pas',
  uProgramList in '..\src\Helper\uProgramList.pas' {FormProgrammAdd},
  uPageApplication in '..\src\FunctionPage\uPageApplication.pas' {FormPageApplication},
  uMonitorHandler in '..\src\Helper\uMonitorHandler.pas',
  zoom_sdk in '..\src\Zoom\zoom_sdk.pas',
  zoom_sdk_def in '..\src\Zoom\zoom_sdk_def.pas',
  uPageFunctionSample in '..\src\FunctionPage\uPageFunctionSample.pas' {FormPageFunctionSample},
  uConfigPageSample in '..\src\Settings\uConfigPageSample.pas' {FormConfigPageSample},
  uConfigZoom in '..\src\Settings\uConfigZoom.pas' {FormConfigZoom},
  uLog in '..\src\Helper\uLog.pas' {FormLog};

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  Application.Title := Application.Title + ' (DEBUG)';
{$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormCongregationHelper, FormCongregationHelper);
  Application.CreateForm(TFormLog, FormLog);
  Application.Run;
end.
