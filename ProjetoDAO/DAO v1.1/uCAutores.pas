unit uCAutores;

interface

uses
  uDataModule, SysUtils, data.db;

type
  TAutor = class
  strict private
    procedure SetDataLog(const Value: TDate);
    procedure SetHoraLog(const Value: TTime);
    procedure SetNomeAutor(const Value: String);
  private
    FNomeAutor: String;
    FDataLog: TDate;
    FID: Integer;
    FHoraLog: TTime;
  public
    property ID: Integer read FID;
    property NomeAutor: String read FNomeAutor write SetNomeAutor;
    property DataLog: TDate read FDataLog write SetDataLog;
    property HoraLog: TTime read FHoraLog write SetHoraLog;
    class procedure Gravar(AAutor: TAutor);
    class procedure Apagar(AId: Integer);
  end;

  TAutorDAO = class
  private
    class function ReturnSQLFromID(AId: Integer): string;
    class procedure Salvar(AAutor: TAutor);
    class procedure Deletar(AId: Integer);
  public
    class function Carregar(IdAutor: Integer): TAutor;

  end;

implementation

uses
  FireDAC.Comp.Client;

class procedure TAutor.Apagar(AId: Integer);
begin
  TAutorDAO.Deletar(Aid);
end;

class procedure TAutor.Gravar(AAutor: TAutor);
begin
  TAutorDAO.Salvar(AAutor);
end;

procedure TAutor.SetDataLog(const Value: TDate);
begin
  FDataLog := Value;
end;

procedure TAutor.SetHoraLog(const Value: TTime);
begin
  FHoraLog := Value;
end;

procedure TAutor.SetNomeAutor(const Value: String);
begin
  FNomeAutor := Value;
end;

{ TAutorDAO }

class function TAutorDAO.Carregar(IdAutor: Integer): TAutor;
var
  _qry: TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  Result := nil;
  try
    _qry.Connection := DataModule1.FDConnection1;
    _qry.SQL.text := ReturnSQLFromID(IdAutor);
    try
      _qry.open();
    except
      raise Exception.Create('[TAutorDAO]: Erro ao abrir conexão!');
    end;
    Result := TAutor.Create;

    Result.FID := _qry.FieldByName('idAutor').AsInteger;
    Result.DataLog := _qry.FieldByName('DataLog').AsDateTime;
    Result.HoraLog := _qry.FieldByName('HoraLog').AsDateTime;
    Result.NomeAutor := _qry.FieldByName('NomeAutor').AsString;

  finally
    _qry.Free;
  end;

end;

class procedure TAutorDAO.Deletar(AId: Integer);
begin
  try
    DataModule1.FDConnection1.ExecSQL('DELETE FROM Autores WHERE idAutor=' +
      IntToStr(AId))
  except
    raise Exception.Create('[TAutorDAO]: Erro ao excluir o item: ' +
      AId.ToString + '!');
  end;
end;

class procedure TAutorDAO.Salvar(AAutor: TAutor);
var
  _qry: TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  try
    _qry.Connection := DataModule1.FDConnection1;
    _qry.SQL.text := ReturnSQLFromID(AAutor.ID);
    try
      _qry.open();
    except
      raise Exception.Create('[TAutorDAO]: Erro ao abrir conexão!');
    end;

    _qry.FieldByName('IdAutor').Required := False;

    if _qry.IsEmpty then
      _qry.Append
    else
      _qry.Edit;

    _qry.FieldByName('NomeAutor').Value := AAutor.NomeAutor;
    _qry.FieldByName('DataLog').Value := Date;
    _qry.FieldByName('HoraLog').Value := Time;

    try
      _qry.Post;
      if AAutor.FID < 1 then
        AAutor.FID := _qry.FieldByName('IdAutor').AsInteger;
    except
      raise Exception.Create
        ('[TAutorDAO]: Erro no armazenamento de arquivos (POST)!');
    end;
  finally

    _qry.Free;
  end;
end;

class function TAutorDAO.ReturnSQLFromID(AId: Integer): string;
begin
  Result := 'SELECT * FROM autores WHERE IdAutor = ' + AId.ToString;
end;

end.
