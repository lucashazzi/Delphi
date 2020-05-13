unit frmAutores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  Vcl.ExtCtrls, uDataModule, Vcl.Mask, uCAutores, uREDAPP;

type
 // TEstado = (Leitura, Alteracao, Inclusao);

  TFormAutores = class(TForm)

    edtNomeAutor: TEdit;
    Panel1: TPanel;
    btnIncluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnExcluir: TSpeedButton;
    dbGrid: TDBGrid;
    Panel2: TPanel;
    btnAnterior: TSpeedButton;
    btnProximo: TSpeedButton;
    Panel3: TPanel;
    StaticText2: TStaticText;
    txtData: TStaticText;
    txtHora: TStaticText;
    edtDataLog: TMaskEdit;
    Panel4: TPanel;
    btnVerLivros: TSpeedButton;
    btnSalvar: TButton;
    btnCancelar: TButton;
    ConnInfo: TStaticText;
    edtHoraLog: TMaskEdit;
    edtIdAutor: TEdit;
    procedure CarregarTabelasDAO;
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnVerLivrosClick(Sender: TObject);
    procedure btnDataAtualClick(Sender: TObject);
    procedure btnHoraAtualClick(Sender: TObject);
    procedure dbGridCellClick(Column: TColumn);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure dbGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    FEstado: uREDAPP.TEstado;
    FAutor: TAutor;
    procedure ExibirDataHora();
    procedure OcultarDataHora();
    procedure DesbloquearAcoes();
    procedure BloquearAcoes();
    procedure CriarFormLivros();
    procedure LimparEdits();
    Function CriarDataModule(): Boolean;

  public
    procedure Consultar;

  end;

var
  FormAutores: TFormAutores;

implementation

uses
  frmLivros;
{$R *.dfm}

procedure TFormAutores.btnAlterarClick(Sender: TObject);
begin
  FEstado := Alteracao;
  edtNomeAutor.SetFocus;
  Caption := 'Alterando Autores';
  OcultarDataHora();
  DesbloquearAcoes();
end;

procedure TFormAutores.btnAnteriorClick(Sender: TObject);
var
  _idAutor: Integer;
begin
  Datamodule1.QueryAutores.Prior;
  CarregarTabelasDAO;
end;

procedure TFormAutores.btnCancelarClick(Sender: TObject);
begin

  FEstado := Leitura;
  Caption := 'Gestão de Autores e Livros';
  BloquearAcoes;
  ExibirDataHora();
  CarregarTabelasDAO;
end;

procedure TFormAutores.Consultar();
begin
  try
    Datamodule1.QueryAutores.Active := False;
    Datamodule1.QueryAutores.SQL.Text := 'SELECT * FROM Autores';
    Datamodule1.QueryAutores.Open;
    CarregarTabelasDAO;
  except
    MessageDlg('Falha ao consultar o Banco!', mtError, [mbOk], 0);
  end;
  Datamodule1.QueryAutores.FetchAll;
  Datamodule1.QueryAutores.First;
end;

procedure TFormAutores.btnExcluirClick(Sender: TObject);
var
  _confirmacao: Integer;
  _AutorDAO: TAutorDAO;
begin
  _AutorDAO := TAutorDAO.Create();
  try
    _confirmacao := MessageDlg('Deseja realmente EXCLUIR?', mtWarning,
      [mbYes, mbNo], 0);

    if _confirmacao = 6 then
    begin
      _AutorDAO.Deletar(StrToInt(edtIdAutor.Text));
      CarregarTabelasDAO();
      ShowMessage('Excluído com sucesso!');
    end;
  finally
    FreeAndNil(_AutorDAO);
    Datamodule1.QueryAutores.Refresh;
  end;
end;

procedure TFormAutores.btnHoraAtualClick(Sender: TObject);
begin
  edtHoraLog.Text := TimeToStr(Time());
end;

procedure TFormAutores.btnDataAtualClick(Sender: TObject);
begin
  edtDataLog.Text := DateToStr(Date());
end;

procedure TFormAutores.btnIncluirClick(Sender: TObject);
begin
  FEstado := Inclusao;
  edtNomeAutor.SetFocus;
  Caption := 'Incluindo Autores';
  DesbloquearAcoes();
  LimparEdits();
  OcultarDataHora();
end;

procedure TFormAutores.btnProximoClick(Sender: TObject);
begin
  Datamodule1.QueryAutores.Next;
  CarregarTabelasDAO;
end;

procedure TFormAutores.btnSalvarClick(Sender: TObject);
var
  _AutorDAO: TAutorDAO;

begin
  _AutorDAO := TAutorDAO.Create;

  try
    if FEstado = Inclusao then
    begin
      FAutor := nil;
      FAutor := TAutor.Create();
    end;
    FAutor.NomeAutor := edtNomeAutor.Text;
    FAutor.DataLog := Date;
    FAutor.HoraLog := Time;
    _AutorDAO.Salvar(FAutor);

    Caption := 'Gestão de Autores e Livros';
    BloquearAcoes();
    ExibirDataHora();
  finally
    FreeAndNil(_AutorDAO);
    Datamodule1.QueryAutores.Refresh;
    ShowMessage('Operação concluída com sucesso!');
  end;
end;

procedure TFormAutores.btnVerLivrosClick(Sender: TObject);
begin
  frmLivros.idAutorLivro := edtIdAutor.Text;
  CriarFormLivros;
end;

procedure TFormAutores.DesbloquearAcoes();
begin
  // edtIdAutor.ReadOnly := False;
  edtNomeAutor.ReadOnly := False;
  edtDataLog.ReadOnly := False;
  edtHoraLog.ReadOnly := False;
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
end;

procedure TFormAutores.FormActivate(Sender: TObject);
begin
  CriarDataModule;
  try
    Datamodule1.FDConnection1.Connected := False;
    ConnInfo.Caption := 'Conectado';
    Consultar();
  except
    raise Exception.Create('[frmAutores]: Erro na conexão com o banco!');
  end;
end;

procedure TFormAutores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FAutor.Free;
end;

procedure TFormAutores.FormDeactivate(Sender: TObject);
begin
  Datamodule1.FDConnection1.Connected := False;
end;

procedure TFormAutores.BloquearAcoes;
begin
  edtIdAutor.ReadOnly := True;
  edtNomeAutor.ReadOnly := True;
  edtDataLog.ReadOnly := True;
  edtHoraLog.ReadOnly := True;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
end;

procedure TFormAutores.CriarFormLivros;
var
  _CriarForm: TFormLivros;
begin
  _CriarForm := TFormLivros.Create(nil);
  try
    _CriarForm.mostrarLivros;
    _CriarForm.ShowModal;

  finally
    _CriarForm.Free;
  end;
end;

procedure TFormAutores.dbGridCellClick(Column: TColumn);
var
  _idDM: Integer;
begin
  _idDM := Datamodule1.QueryAutores.FieldByName('IdAutor').AsInteger;
  FAutor := TAutorDAO.Carregar(_idDM);
  edtIdAutor.Text := IntToStr(FAutor.id);
  edtNomeAutor.Text := FAutor.NomeAutor;
  edtDataLog.Text := DateToStr(FAutor.DataLog);
  edtHoraLog.Text := TimeToStr(FAutor.HoraLog);
end;

procedure TFormAutores.dbGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_delete then
    Abort;
end;

function TFormAutores.CriarDataModule: Boolean;
begin
  if Datamodule1 = nil then
    Datamodule1 := TDataModule1.Create(application);
  Result := True;
end;

procedure TFormAutores.LimparEdits;
begin
  edtIdAutor.Clear;
  edtNomeAutor.Clear;
  edtDataLog.Clear;
  edtHoraLog.Clear;
end;

procedure TFormAutores.ExibirDataHora;
begin
  edtDataLog.Visible := True;
  edtHoraLog.Visible := True;
  txtHora.Visible := True;
  txtData.Visible := True;
end;

procedure TFormAutores.OcultarDataHora;
begin
  edtDataLog.Visible := False;
  edtHoraLog.Visible := False;
  txtHora.Visible := False;
  txtData.Visible := False;
end;

procedure TFormAutores.CarregarTabelasDAO;
var

  _idAutor: Integer;
begin
  _idAutor := (Datamodule1.QueryAutores.FieldByName('IdAutor').AsInteger);
  FAutor := TAutorDAO.Carregar(_idAutor);
  edtIdAutor.Text := IntToStr(FAutor.id);
  edtNomeAutor.Text := FAutor.NomeAutor;
  edtDataLog.Text := DateToStr(FAutor.DataLog);
  edtHoraLog.Text := TimeToStr(FAutor.HoraLog);
end;

end.
