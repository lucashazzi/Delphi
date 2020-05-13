unit frmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uSingletonLogin,
  frmAutores, uDataModule;

type
  TLogin = class(TForm)
    edtLNome: TEdit;
    edtLSenha: TEdit;
    btnAcessar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnAcessarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Function CriarDataModule: Boolean;
    procedure AtivarDataModule;

  public
    { Public declarations }
  end;

var
  Login: TLogin;

implementation

{$R *.dfm}

procedure TLogin.AtivarDataModule;
begin
  if Datamodule1.FDConnection1.Connected = False then
  begin
    Datamodule1.FDConnection1.Connected := True;
  end
end;

procedure TLogin.btnAcessarClick(Sender: TObject);
var
  SingletonLogin: TSingletonLogin;
  Val: Boolean;
  CriarAutores: TFormAutores;
begin
  SingletonLogin := TSingletonLogin.GetInstance;
  CriarAutores := TFormAutores.Create(nil);
  try
    Val := SingletonLogin.ProcessoLogin(edtLNome.Text, edtLSenha.Text);
    if Val = True then
    begin
      try
        CriarAutores.ShowModal;
      finally
        CriarAutores.Free;
      end;
    end;
  finally
    SingletonLogin.Free;
  end;
end;

function TLogin.CriarDataModule: Boolean;
begin
  if Datamodule1 = nil then
    Datamodule1 := TDataModule1.Create(application);
  Result := True;
end;

procedure TLogin.FormCreate(Sender: TObject);
begin
  CriarDataModule;
  AtivarDataModule;
end;

end.
