unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Funcoes;

type
  TForm1 = class(TForm)
    txtDac: TStaticText;
    edtNumConta: TEdit;
    StaticText1: TStaticText;
    edtDAC: TEdit;
    btnGerarDac: TButton;
    procedure btnGerarDacClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnGerarDacClick(Sender: TObject);
var
  _NumContaArray: TArray<char>;
begin
  _NumContaArray := ConverterStringEmArray(edtNumConta.Text);
  edtDAC.Text := CalculoDAC(_NumContaArray);
end;

end.
