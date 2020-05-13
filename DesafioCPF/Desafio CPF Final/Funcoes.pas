unit Funcoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask;
function TextoParaLista(strCPF: String): TArray<char>;
function ValidarDigitoUm(cpfEmLista: TArray<char>): Integer;
function ValidarDigitoDois(CPFAdaptado: TArray<char>): Integer;
function adaptarCpfEmLista(cpfEmLista: TArray<char>; digitoUm: Integer)
  : TArray<char>;
function validarCPF(digitoValidado: String; CPF: TArray<char>): Boolean;

implementation
function TextoParaLista(strCPF: String): TArray<char>;
var
  _cpfParaLista: TArray<char>;
begin
  _cpfParaLista := strCPF.ToCharArray;
  Result := _cpfParaLista;
end;

function ValidarDigitoUm(cpfEmLista: TArray<char>): Integer;
var
  i, _contador, _auxValidacao1, _restoDivisao, _DigitoVerificador: Integer;
begin
  _DigitoVerificador := 0;
  // Limpar qualquer lixo de dentro da variável.
  _contador := 10;

  for i := 0 to (Length(cpfEmLista) - 3) do
  begin
    _auxValidacao1 := StrToInt(cpfEmLista[i]) * _contador;
    _DigitoVerificador := _DigitoVerificador + _auxValidacao1;
    dec(_contador);
  end;

  _restoDivisao := _DigitoVerificador mod 11;
  _DigitoVerificador := 11 - _restoDivisao;

  if _DigitoVerificador > 9 then
    _DigitoVerificador := 0;

  Result := _DigitoVerificador;

end;

function adaptarCpfEmLista(cpfEmLista: TArray<char>; digitoUm: Integer)
  : TArray<char>;
var
  _digitoUmArray: TArray<char>;

begin
  _digitoUmArray := IntToStr(digitoUm).ToCharArray;
  delete(cpfEmLista, 9, 2);
  insert(_digitoUmArray, cpfEmLista, 9);
  Result := cpfEmLista;
end;

function ValidarDigitoDois(CPFAdaptado: TArray<char>): Integer;
var
  i, _contador, _auxValidacao2, _restoDivisao2,
    _SegundoDigitoVerificador: Integer;
begin
  _SegundoDigitoVerificador := 0;
  _contador := 11;
  for i := 0 to (Length(CPFAdaptado) - 1) do
  begin
    _auxValidacao2 := StrToInt(CPFAdaptado[i]) * _contador;
    _SegundoDigitoVerificador := _SegundoDigitoVerificador + _auxValidacao2;

    dec(_contador);
  end;

  _restoDivisao2 := _SegundoDigitoVerificador mod 11;
  _SegundoDigitoVerificador := 11 - _restoDivisao2;

  if _SegundoDigitoVerificador > 9 then
    _SegundoDigitoVerificador := 0;

  Result := _SegundoDigitoVerificador;

end;

function validarCPF(digitoValidado: String; CPF: TArray<char>): Boolean;
var
  _digitosSeparadosCPF: String;
begin
  _digitosSeparadosCPF := CPF[9] + CPF[10];
  if digitoValidado = _digitosSeparadosCPF then
    Result := True
  else
    Result := False;

end;

end.
