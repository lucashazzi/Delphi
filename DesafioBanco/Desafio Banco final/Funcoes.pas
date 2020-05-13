unit Funcoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;
function ConverterStringEmArray(edtNumConta: String): TArray<char>;
function CalculoDAC(NumContaArray: TArray<char>): String;

implementation

function ConverterStringEmArray(edtNumConta: String): TArray<char>;
begin
  // Inverte o numero da conta antes do cálculo, para que o padrão de 2,1,2,1 seja
  // aplicado "da direita para a Esquerda".
  Result := ReverseString(edtNumConta).ToCharArray;
end;

function CalculoDAC(NumContaArray: TArray<char>): String;
var
  i, _totalSomaNumConta, _restoDivisao, _DAC, multiplicador,
    _ResultadoMultiplicacao, _NumParaSoma1, _NumParaSoma2: Integer;
  _ArrayMultiplicada: TArray<String>;

begin
  // Multiplicação pelo padrão 2,1,2,1...
  _totalSomaNumConta := 0;
  _ResultadoMultiplicacao := 0;
  for i := 0 to (Length(NumContaArray) - 1) do
  begin
    if i mod 2 = 0 then
      multiplicador := 2
    else
      multiplicador := 1;
    _ResultadoMultiplicacao := StrToInt(NumContaArray[i]) * multiplicador;
    insert(IntToStr(_ResultadoMultiplicacao), _ArrayMultiplicada, i);
  end;

  // Processo de separação dos valores para a soma unitária que será feita posteriormente.
  for i := 0 to (Length(_ArrayMultiplicada) - 1) do
  begin
    if StrToInt(_ArrayMultiplicada[i]) >= 10 then
    begin
      // Dezena do número
      _NumParaSoma1 := StrToInt(_ArrayMultiplicada[i]) div 10;
      // Unidade do número
      _NumParaSoma2 := StrToInt(_ArrayMultiplicada[i]) mod 10;

      delete(_ArrayMultiplicada, i, 1);
      // Deleta o valor cheio que estava na Array.
      insert(IntToStr(_NumParaSoma1), _ArrayMultiplicada,
        Length(_ArrayMultiplicada));
      insert(IntToStr(_NumParaSoma2), _ArrayMultiplicada,
        Length(_ArrayMultiplicada) + 1);
    end
    else;
  end;

  // Processo da Soma unitária dos números.
  for i := 0 to (Length(_ArrayMultiplicada) - 1) do
  begin
    _totalSomaNumConta := _totalSomaNumConta + StrToInt(_ArrayMultiplicada[i]);
  end;
  _restoDivisao := _totalSomaNumConta mod 10;

  _DAC := 10 - _restoDivisao;
  if _DAC = 10 then
    Result := IntToStr(0)
  else
    Result := IntToStr(_DAC);
end;

end.
