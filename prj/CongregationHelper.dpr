program CongregationHelper;

uses
  Vcl.Forms,
  uCongregationHelper in '..\src\uCongregationHelper.pas' {Form1},
  uConfig in '..\src\Settings\uConfig.pas',
  uConfigCamera in '..\src\Settings\uConfigCamera.pas' {FormConfigCamera},
  uValidationAndHelper in '..\src\uValidationAndHelper.pas',
  uConfigMonitor in '..\src\Settings\uConfigMonitor.pas' {FormConfigMonitor},
  uPageMaster in '..\src\uPageMaster.pas' {FormPageMaster},
  uPageFunctionSample in '..\src\FunctionPage\uPageFunctionSample.pas' {FormPageFunctionSample},
  uConfigFormMaster in '..\src\uConfigFormMaster.pas' {ForrmConfigMaster},
  uGitHub in '..\src\uGitHub.pas',
  uProgramList in '..\src\Helper\uProgramList.pas' {FormProgrammAdd},
  uPageApplication in '..\src\FunctionPage\uPageApplication.pas' {FormPageApplication};

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  Application.Title := Application.Title + ' (DEBUG)';
{$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormCongregationHelper, FormCongregationHelper);
  Application.CreateForm(TFormConfigCamera, FormConfigCamera);
  Application.CreateForm(TFormConfigMonitor, FormConfigMonitor);
  Application.CreateForm(TFormPageFunctionSample, FormPageFunctionSample);
  Application.CreateForm(TFormPageApplication, FormPageApplication);
  Application.Run;
end.
