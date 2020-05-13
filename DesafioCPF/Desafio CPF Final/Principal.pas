unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Funcoes;

type
  TForm1 = class(TForm)
    mskCPF: TMaskEdit;
    btnValidarCPF: TButton;
    txtCPF: TStaticText;
    edtRespostaDaValidacao: TEdit;
    txtDigitoVer: TStaticText;
    txtObs: TStaticText;
    procedure btnValidarCPFClick(Sender: TObject);

  private
    procedure MensagemDeValidacao(cpfValidado: Boolean);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnValidarCPFClick(Sender: TObject);
var
  _digitoUm, _digitoDois: Integer;
  _digitoValidado: String;
  _cpfValido: Boolean;
  CPFAdaptado: TArray<char>;

begin
  try
    _digitoUm := ValidarDigitoUm(TextoParaLista(mskCPF.Text));
    CPFAdaptado := adaptarCpfEmLista(TextoParaLista(mskCPF.Text), _digitoUm);
    _digitoDois := ValidarDigitoDois(CPFAdaptado);
    _digitoValidado := IntToStr(_digitoUm) + IntToStr(_digitoDois);
    _cpfValido := validarCPF(_digitoValidado, TextoParaLista(mskCPF.Text));
    MensagemDeValidacao(_cpfValido);
  except
    MessageDlg('CPF preenchido incorretamente.', mtError, [mbOK], 0);
  end;
end;

procedure TForm1.MensagemDeValidacao(cpfValidado: Boolean);

begin
  if cpfValidado = True then
    edtRespostaDaValidacao.Text := ('Válido')
  else
    edtRespostaDaValidacao.Text := ('Inválido');
end;

end.
