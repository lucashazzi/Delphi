unit uSingletonLogin;

interface

uses
  Dialogs, SysUtils, uDataModule;

type
  TSingletonLogin = class
  private
    FNome: String;
    FSenha: String;
    constructor Create;
    procedure SetNome(const Value: String);
    procedure SetSenha(const Value: String);

  public
    property Nome: String read FNome write SetNome;
    property Senha: String read FSenha write SetSenha;
    class function GetInstance: TSingletonLogin;
    function ProcessoLogin(Nome, Senha: String): Boolean;
  end;

implementation

uses
  FireDAC.Comp.Client;

var
  _instancia: TSingletonLogin;

  { TSingletonLogin }

constructor TSingletonLogin.Create;
begin
  inherited;
end;

procedure TSingletonLogin.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TSingletonLogin.SetSenha(const Value: String);
begin
  FSenha := Value;
end;

class function TSingletonLogin.GetInstance: TSingletonLogin;
begin
  if _instancia = nil then
    _instancia := TSingletonLogin.Create;

  Result := _instancia;
end;

function TSingletonLogin.ProcessoLogin(Nome, Senha: String): Boolean;
var
  _qry: TFDQuery;
  _verNome: String;
  _verSenha: String;
  _id: String;
begin
  _qry := TFDQuery.Create(nil);
  _qry.Connection := DataModule1.FDConnection1;

  try
    _qry.SQL.Text := ('SELECT * FROM Usuarios WHERE NomeUsuario = ' +
      QuotedStr(Nome));
    _qry.Open();
    _verNome := _qry.FieldByName('NomeUsuario').AsString;

    _qry.SQL.Text := ('SELECT idUsuario FROM Usuarios WHERE NomeUsuario = ' +
      QuotedStr(Nome));
    _qry.Open();
    _id := _qry.FieldByName('idUsuario').AsString;
    _qry.SQL.Text := ('SELECT Senha FROM Usuarios WHERE idUsuario = ' +
      QuotedStr(_id));
    _qry.Open();
    _verSenha := _qry.FieldByName('Senha').AsString;

    if Senha = _verSenha then
    begin
      Result := True;
      ShowMessage('Sucesso!');
    end
    else
      raise Exception.Create('Login Inválidos');
    Result := False;

  except
    raise Exception.Create('Erro de Login!');
    Result := False;
  end;
end;

initialization

_instancia := nil;

finalization

if _instancia <> nil then
  _instancia.Free;

end.
