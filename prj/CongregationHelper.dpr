program CongregationHelper;

uses
  Vcl.Forms,
  uCongregationHelper in '..\src\uCongregationHelper.pas' {Form1},
  uConfig in '..\src\Settings\uConfig.pas',
  uConfigCamera in '..\src\Settings\uConfigCamera.pas' {FormConfigCamera},
  uValidation in '..\src\uValidation.pas',
  uConfigMonitor in '..\src\Settings\uConfigMonitor.pas' {FormConfigMonitor},
  uPageMaster in '..\src\uPageMaster.pas' {FormPageMaster},
  uPageFunctionSample in '..\src\FunctionPage\uPageFunctionSample.pas' {FormPageFunctionSample};

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormCongregationHelper, FormCongregationHelper);
  Application.CreateForm(TFormConfigCamera, FormConfigCamera);
  Application.CreateForm(TFormConfigMonitor, FormConfigMonitor);
  Application.CreateForm(TFormPageFunctionSample, FormPageFunctionSample);
  Application.Run;
end.
