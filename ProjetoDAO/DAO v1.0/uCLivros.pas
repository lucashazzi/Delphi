unit uCLivros;

interface

uses
  uDataModule, SysUtils;

type

  TLivro = class
  private
    FDescricao: String;
    FID: Integer;
    FLDataLog: TDate;
    FLHoraLog: TTime;
    FIDEditora: Integer;
    procedure SetDescricao(const Value: String);
    procedure SetLDataLog(const Value: TDate);
    procedure SetLHoraLog(const Value: TTime);
    procedure SetIDEditora(const Value: Integer);
  public
    property Descricao: String read FDescricao write SetDescricao;
    property ID: Integer read FID;
    property LDataLog: TDate read FLDataLog write SetLDataLog;
    property LHoraLog: TTime read FLHoraLog write SetLHoraLog;
    property IDEditora: Integer read FIDEditora write SetIDEditora;

  end;

  TLivroDAO = class
  public
    procedure Salvar(ALivro: TLivro);
    procedure Deletar(LId: Integer);
    class function Carregar(IdLivro: Integer): TLivro;
    class function GetIdSQL(AId: integer): string;
  end;

implementation

uses
  FireDAC.Comp.Client;

procedure TLivro.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TLivro.SetIDEditora(const Value: Integer);
begin
  FIDEditora := Value;
end;

procedure TLivro.SetLDataLog(const Value: TDate);
begin
  FLDataLog := Value;
end;

procedure TLivro.SetLHoraLog(const Value: TTime);
begin
  FLHoraLog := Value;
end;

class function TLivroDAO.Carregar(IdLivro: Integer): TLivro;
var
  _qry: TFDQuery;
  _Livro: TLivro;
begin
  _Livro := TLivro.Create;
  _qry := TFDQuery.Create(nil);
  try
    _qry.Connection := DataModule1.FDConnection1;
    _qry.SQL.text := 'SELECT * FROM Livros WHERE IdLivro = ' +
      QuotedStr(IntToStr(IdLivro));
    _qry.open;
    _Livro.FID := _qry.FieldByName('idLivro').AsInteger;
    _Livro.Descricao := _qry.FieldByName('descricao').AsString;
    _Livro.LDataLog := _qry.FieldByName('LdataLog').AsDateTime;
    _Livro.LHoraLog := _qry.FieldByName('LhoraLog').AsDateTime;
    _Livro.IDEditora := _qry.FieldByName('IdEditora').AsInteger;
    Result := _Livro;
  finally
    _qry.Free;
  end;
end;

procedure TLivroDAO.Deletar(LId: Integer);
var
  _qry: TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  try
    _qry.Connection := DataModule1.FDConnection1;
  except
    raise Exception.Create
      ('[TLivroDAO]: Erro na conexão com o banco (deletar)');
  end;

  try
    _qry.ExecSQL('DELETE FROM Livros WHERE idLivro = ' + IntToStr(LId));
  except
    raise Exception.Create('[TLivroDAO]: Erro ao excluir o item: ' +
      LId.ToString + '!');
  end;
  _qry.Free;
end;



procedure TLivroDAO.Salvar(ALivro: TLivro);
var
  _qry: TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  try
    _qry.Connection := DataModule1.FDConnection1;
    _qry.SQL.Text := GetIdSQL(ALivro.ID);
    _qry.open();

    if _qry.IsEmpty then
      _qry.Append
    else
      _qry.Edit;

    _qry.FieldByName('idAutor').Value := DataModule1.QueryAutores.FieldByName
      ('idAutor').AsInteger;
    _qry.FieldByName('Descricao').Value := ALivro.Descricao;
    _qry.FieldByName('LdataLog').Value := Date;
    _qry.FieldByName('LhoraLog').Value := Time;
    _qry.FieldByName('IdEditora').Value := Alivro.IDEditora;

    try
      _qry.Post;
    except
      raise Exception.Create
        ('[TLivroDAO]: Erro no armazenamento de arquivos (POST)!');
    end;
  finally
    ALivro.FID := _qry.FieldByName('IdLivro').AsInteger;
    _qry.Free;
  end;

end;

class function TLivroDAO.GetIdSQL(AId: integer): string;
begin
  result := ('SELECT * FROM livros WHERE IdLivro = ' + AId.ToString);
end;

end.
