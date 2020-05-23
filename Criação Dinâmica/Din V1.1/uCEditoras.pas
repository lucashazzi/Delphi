unit uCEditoras;

interface

type
  TEditora = class
  strict private
    procedure SetNomeEditora(const Value: String);
    procedure SetHoraLog(const Value: TTime);
    procedure SetDataLog(const Value: TDate);
  private
    FNomeEditora: String;
    FID: Integer;
    FHoraLog: TTime;
    FDataLog: TDate;

  public
    property NomeEditora: String read FNomeEditora write SetNomeEditora;
    property ID: Integer read FID;
    property HoraLog: TTime read FHoraLog write SetHoraLog;
    property DataLog: TDate read FDataLog write SetDataLog;
    class procedure Gravar(AEditora: TEditora);
    class procedure Apagar(AId: Integer);
  end;

  TEditoraDAO = class
  private
    class function ReturnSQLFromID(AId: Integer): String;
    class procedure Salvar(AEditora: TEditora);
    class procedure Deletar(AId: Integer);
  public
    class function Carregar(FID: Integer): TEditora;
  end;

implementation

uses
  FireDAC.Comp.Client, sysutils, uDataModule;

{ TEditora }

class procedure TEditora.Apagar(AId: Integer);
begin
TEditoraDAO.Deletar(AId);
end;

class procedure TEditora.Gravar(AEditora: TEditora);
begin
TEditoraDAO.Salvar(AEditora);
end;

procedure TEditora.SetDataLog(const Value: TDate);
begin
  FDataLog := Value;
end;

procedure TEditora.SetHoraLog(const Value: TTime);
begin
  FHoraLog := Value;
end;

procedure TEditora.SetNomeEditora(const Value: String);
begin
  FNomeEditora := Value;
end;

{ TEditoraDAO }

class function TEditoraDAO.Carregar(FID: Integer): TEditora;
var
  _qry: TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  _qry.Connection := DataModule1.FDConnection1;
  try
    _qry.SQL.Text := ReturnSQLFromID(FID);
    try
      _qry.Open();
    except
      raise Exception.Create('[TEditoraDAO]: Erro ao abrir conexão!');
    end;
    Result := TEditora.Create;

    Result.FNomeEditora := _qry.FieldByName('NomeEditora').AsString;
    Result.FID := _qry.FieldByName('idEditora').AsInteger;
    Result.FHoraLog := _qry.FieldByName('HoraLog').AsDateTime;
    Result.FDataLog := _qry.FieldByName('DataLog').AsDateTime;

  finally
    _qry.Free;
  end;
end;

class procedure TEditoraDAO.Deletar(AId: Integer);
begin
  try
    DataModule1.FDConnection1.ExecSQL('DELETE FROM Editoras WHERE idEditora = '
      + IntToStr(AId));
  except
    raise Exception.Create('Impossível encontrar o item especificado: ' +
      AId.ToString + '!');
  end;
end;

class procedure TEditoraDAO.Salvar(AEditora: TEditora);
var
  _qry: TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  try
    _qry.Connection := DataModule1.FDConnection1;
    _qry.SQL.Text := ReturnSQLFromID(AEditora.FID);
    try
      _qry.Open();
    except
      raise Exception.Create('[TEditoraDAO]: Erro ao abrir conexão!');
    end;

    _qry.FieldByName('idEditora').Required := False;

    if _qry.IsEmpty then
      _qry.Append
    else
      _qry.Edit;

    _qry.FieldByName('NomeEditora').Value := AEditora.FNomeEditora;
    _qry.FieldByName('DataLog').Value := Date;
    _qry.FieldByName('HoraLog').Value := Time;
    try
      _qry.Post;
      if AEditora.FID < 1 then
        AEditora.FID := _qry.FieldByName('IdEditora').AsInteger;
    except
      raise Exception.Create
        ('[TEditoraDAO]: Erro no armazenamento de arquivos (POST)!');

    end;

  finally
    _qry.Free;
  end;
end;

class function TEditoraDAO.ReturnSQLFromID(AId: Integer): string;
begin
  Result := 'SELECT * FROM Editoras WHERE IdEditora = ' + AId.ToString;
end;

end.
