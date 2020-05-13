unit uCEditoras;

interface

type
  TEditoras = class
  private
    FNomeEditora: String;
    FID: Integer;
    FHoraLog: TTime;
    FDataLog: TDate;
    procedure SetNomeEditora(const Value: String);
    procedure SetHoraLog(const Value: TTime);
    procedure SetDataLog(const Value: TDate);
  public
    property NomeEditora: String read FNomeEditora write SetNomeEditora;
    property ID: Integer read FID;
    property HoraLog: TTime read FHoraLog write SetHoraLog;
    property DataLog: TDate read FDataLog write SetDataLog;
  end;

  TEditorasDAO = class
  public
    class procedure Salvar(AEditora: TEditoras);
    class procedure Deletar(AId: Integer);
    class function Carregar(FID: Integer): TEditoras;
  end;

implementation

uses
  FireDAC.Comp.Client, sysutils, uDataModule;

{ TEditoras }

procedure TEditoras.SetDataLog(const Value: TDate);
begin
  FDataLog := Value;
end;

procedure TEditoras.SetHoraLog(const Value: TTime);
begin
  FHoraLog := Value;
end;

procedure TEditoras.SetNomeEditora(const Value: String);
begin
  FNomeEditora := Value;
end;

{ TEditorasDAO }

class function TEditorasDAO.Carregar(FID: Integer): TEditoras;
var
  _qry: TFDQuery;
  _editoras: TEditoras;

begin
  _editoras := TEditoras.Create();
  _qry := TFDQuery.Create(nil);
  _qry.Connection := DataModule1.FDConnection1;
  try
    _qry.SQL.Text := ('SELECT * FROM Editoras WHERE idEditora = ' +
      QuotedStr(FID.ToString));
    _qry.Open();

    _editoras.FNomeEditora := _qry.FieldByName('NomeEditora').AsString;
    _editoras.FID := _qry.FieldByName('idEditora').AsInteger;
    _editoras.FHoraLog := _qry.FieldByName('HoraLog').AsDateTime;
    _editoras.FDataLog := _qry.FieldByName('DataLog').AsDateTime;
    Result := _editoras;
  finally
    _qry.Free;
  end;
end;

class procedure TEditorasDAO.Deletar(AId: Integer);
var
  _qry: TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  try
    _qry.Connection := DataModule1.FDConnection1;
  except
    raise Exception.Create('[TEditorasDAO]: Erro na conexão com o Banco!');
  end;
  try
    _qry.ExecSQL('DELETE FROM Editoras WHERE idEditora = ' +
      IntToStr(AId));
  except
    raise Exception.Create('Impossível encontrar o item especificado: ' +
      AId.ToString + '!');
  end;
  _qry.Free;
end;

class procedure TEditorasDAO.Salvar(AEditora: TEditoras);
var
  _qry: TFDQuery;

begin
  _qry := TFDQuery.Create(nil);
  try
    _qry.Connection := DataModule1.FDConnection1;
    _qry.SQL.Text := ('SELECT * FROM Editoras WHERE idEditora = ' +
      AEditora.FID.ToString);
    _qry.Open();

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
      AEditora.FID := _qry.FieldByName('IdEditora').AsInteger;
    except
    raise Exception.Create('[TEditorasDAO]: Erro no armazenamento de arquivos (POST)!');

    end;

  finally

    _qry.Free;
  end;
end;

end.
