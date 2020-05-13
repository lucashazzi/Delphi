unit uCAutores;

interface

uses
  uDataModule, SysUtils, data.db;

type
  TAutor = class
  private
    FNomeAutor: String;
    FDataLog: TDate;
    FID: Integer;
    FHoraLog: TTime;
    procedure SetDataLog(const Value: TDate);
    procedure SetHoraLog(const Value: TTime);
    procedure SetNomeAutor(const Value: String);
  public
    property ID: Integer read FID;
    property NomeAutor: String read FNomeAutor write SetNomeAutor;
    property DataLog: TDate read FDataLog write SetDataLog;
    property HoraLog: TTime read FHoraLog write SetHoraLog;
  end;

  TAutorDAO = class
  public
    class function GetIdSQL(AId: Integer): string;
    class function Carregar(IdAutor: Integer): TAutor;
    procedure Salvar(AAutor: TAutor);
    procedure Deletar(AId: Integer);

  end;

implementation

uses
  FireDAC.Comp.Client;

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
  _Autor: TAutor;
begin
  _Autor := TAutor.Create;
  _qry := TFDQuery.Create(nil);
  Result := nil;
  try
    _qry.Connection := DataModule1.FDConnection1;
    _qry.SQL.text := 'SELECT * FROM Autores WHERE IdAutor = ' +
      QuotedStr(IntToStr(IdAutor));
    _qry.open;
    _Autor.FID := _qry.FieldByName('idAutor').AsInteger;
    _Autor.DataLog := _qry.FieldByName('DataLog').AsDateTime;
    _Autor.HoraLog := _qry.FieldByName('HoraLog').AsDateTime;
    _Autor.NomeAutor := _qry.FieldByName('NomeAutor').AsString;
    Result := _Autor;
  finally
    _qry.Free;

  end;

end;

procedure TAutorDAO.Deletar(AId: Integer);
var
  _qry: TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  try
    _qry.Connection := DataModule1.FDConnection1;
  except
    raise Exception.Create
      ('[TAutorDAO]: Erro na conexão com o banco (deletar)');
  end;
  try
    _qry.ExecSQL('DELETE FROM Autores WHERE idAutor=' + IntToStr(AId))
  except
    raise Exception.Create('[TAutorDAO]: Erro ao excluir o item: ' +
      AId.ToString + '!');
  end;
  _qry.Free;
end;

procedure TAutorDAO.Salvar(AAutor: TAutor);
var
  _qry: TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  try
    _qry.Connection := DataModule1.FDConnection1;
    _qry.SQL.text := GetIdSQL(AAutor.ID);
    _qry.open();

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
      AAutor.FID := _qry.FieldByName('IdAutor').AsInteger;
    except
      raise Exception.Create
        ('[TAutorDAO]: Erro no armazenamento de arquivos (POST)!');
    end;
  finally

    _qry.Free;
  end;
end;

class function TAutorDAO.GetIdSQL(AId: Integer): string;
begin
  Result := ('SELECT * FROM autores WHERE IdAutor = ' + AId.ToString);
end;

end.
