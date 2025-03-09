unit uValidationAndHelper;

interface

uses
  Vcl.ExtCtrls;

function ValidateToken(AToken: String): Boolean;
function ValidateIp(AIPAddress: String): Boolean;
function ValidateUrl(AUrl: String): Boolean;
function ValidatePosition(APosition: String): Boolean;

procedure MarkValidation(AField: TLabeledEdit; AValid: Boolean);

implementation

uses
  SysUtils,
  Vcl.Graphics,
  RegularExpressions;

procedure MarkValidation(AField: TLabeledEdit; AValid: Boolean);
begin
  if AValid then
    AField.Font.Color := clWindowText
  else
    AField.Font.Color := clRed;
end;

function ValidateToken(AToken: String): Boolean;
var
  Regex: TRegEx;
begin
  Regex  := TRegEx.Create('^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=)?$');
  Result := Regex.IsMatch(AToken) or (AToken = EmptyStr);
end;

function ValidateIp(AIPAddress: String): Boolean;
var
  Regex: TRegEx;
begin
  Regex := TRegEx.Create('^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.' + '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.' +
    '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.' + '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
  Result := Regex.IsMatch(AIPAddress) or (AIPAddress = EmptyStr);
end;

function ValidateUrl(AUrl: String): Boolean;
var
  Regex: TRegEx;
begin
  // Regulärer Ausdruck zur Validierung des mittleren Teils einer URL (Domainname und Pfad)
  Regex  := TRegEx.Create('^[^\s/$.?#].[^\s]*$');
  Result := Regex.IsMatch(AUrl) or (AUrl = EmptyStr);
end;

function ValidatePosition(APosition: String): Boolean;
var
  Regex: TRegEx;
begin
  // Regulärer Ausdruck zur Validierung einer Zahl zwischen 0 und 99
  Regex  := TRegEx.Create('^(?:[0-9]|[1-9][0-9])$');
  Result := Regex.IsMatch(APosition) or (APosition = EmptyStr);
end;

end.
