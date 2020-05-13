unit frmEditoras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDataModule, frmLivros, uCEditoras,
  Data.DB, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.Mask, uREDAPP;

type
  // TEstado = (Inclusao, Alteracao, Leitura);

  TFormEditoras = class(TForm)
    edtNomeEditora: TEdit;
    DBGrid1: TDBGrid;
    edtIdEditora: TEdit;
    StaticText1: TStaticText;
    txtData: TStaticText;
    txtHora: TStaticText;
    Panel1: TPanel;
    Panel2: TPanel;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnVoltar: TSpeedButton;
    btnAvancar: TSpeedButton;
    Panel3: TPanel;
    Panel4: TPanel;
    btnCancelar: TButton;
    btnSalvar: TButton;
    btnMostrarTudo: TButton;
    edtEDataLog: TMaskEdit;
    edtEHoraLog: TMaskEdit;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnMostrarTudoClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnAvancarClick(Sender: TObject);
  private
    FEditora: TEditoras;
    FEstado: uREDAPP.TEstado;
    BotaoAtivado: Boolean;
    procedure DesbloquearAcoes();
    procedure LimparEdits();
    procedure ExibirDataHora();
    procedure OcultarDataHora();
    procedure BloquearAcoes();
  public
    procedure MostrarEditoras();
    procedure CarregarTabelasDAO();
  end;

var
  FormEditoras: TFormEditoras;

implementation

{$R *.dfm}
{ TFormEditoras }

procedure TFormEditoras.MostrarEditoras;

begin
  Datamodule1.QueryEditoras.Active := False;
  Datamodule1.QueryEditoras.SQL.Text :=
    ('SELECT * FROM Editoras WHERE idEditora = ' + idEditora);
  Datamodule1.QueryLivrosEditoras.SQL.Text :=
    ('SELECT * FROM Livros WHERE Livros.IdEditora = ' + idEditora);
  try
    Datamodule1.QueryEditoras.Open;
    Datamodule1.QueryLivrosEditoras.Open();
    CarregarTabelasDAO;
  except
    MessageDlg('Falha ao consultar o Banco!', mtError, [mbOk], 0);
  end;
  Datamodule1.QueryLivros.FetchAll;
  Datamodule1.QueryLivros.First;
end;

procedure TFormEditoras.BloquearAcoes;
begin
  edtNomeEditora.ReadOnly := True;
  edtEDataLog.ReadOnly := True;
  edtEHoraLog.ReadOnly := True;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
end;

procedure TFormEditoras.btnAlterarClick(Sender: TObject);
begin
  FEstado := Alteracao;
  edtNomeEditora.SetFocus;
  Caption := 'Alterando Editoras';
  OcultarDataHora();
  DesbloquearAcoes();
end;

procedure TFormEditoras.btnAvancarClick(Sender: TObject);
begin
  Datamodule1.QueryEditoras.Next;
//  Datamodule1.QueryLivrosEditoras.Next;
  carregarTabelasDAO;
end;

procedure TFormEditoras.btnCancelarClick(Sender: TObject);
begin
  FEstado := Leitura;
  BloquearAcoes();
  ExibirDataHora();
  Caption := 'Editoras';
  CarregarTabelasDAO;
end;

procedure TFormEditoras.btnExcluirClick(Sender: TObject);
var
  _confirmacao: Integer;
  _EditoraDAO: TEditorasDAO;
begin
  _EditoraDAO := TEditorasDAO.Create();
  try
    _confirmacao := MessageDlg('Deseja realmente EXCLUIR?', mtWarning,
      [mbYes, mbNo], 0);

    if _confirmacao = 6 then
    begin
      _EditoraDAO.Deletar(StrToInt(edtIdEditora.Text));
      CarregarTabelasDAO();
      ShowMessage('Excluído com sucesso!');
    end;
  finally
    FreeAndNil(_EditoraDAO);
    Datamodule1.QueryEditoras.Refresh;
    Datamodule1.QueryLivrosEditoras.Refresh;
  end;
end;

procedure TFormEditoras.btnIncluirClick(Sender: TObject);
begin
  FEstado := Inclusao;
  edtNomeEditora.SetFocus;
  Caption := 'Incluindo Editoras';
  DesbloquearAcoes();
  LimparEdits();
  OcultarDataHora();
end;

procedure TFormEditoras.btnMostrarTudoClick(Sender: TObject);
begin
  if BotaoAtivado = False then
  begin
    Caption := ('Todas as Editoras');
    btnMostrarTudo.Caption := 'Modo Único';
    Datamodule1.QueryLivrosEditoras.Active := False;
    Datamodule1.QueryLivrosEditoras.SQL.Text := 'SELECT * FROM Editoras';
    try
      Datamodule1.QueryLivrosEditoras.Open;
      CarregarTabelasDAO;
    except
      MessageDlg('Falha ao consultar o Banco!', mtError, [mbOk], 0);
    end;
    Datamodule1.QueryLivrosEditoras.FetchAll;
    Datamodule1.QueryLivrosEditoras.First;
    BotaoAtivado := True;
  end
  else
  begin
    btnMostrarTudo.Caption := 'Mostrar Tudo';
    Caption := ('Livros do Autor');
    MostrarEditoras;
    BotaoAtivado := False;
  end;
end;

procedure TFormEditoras.btnSalvarClick(Sender: TObject);
var
  _EditoraDAO: TEditorasDAO;
begin
  _EditoraDAO := TEditorasDAO.Create;
  try
    if FEstado = Inclusao then
    begin
      FEditora := nil;
      FEditora := TEditoras.Create();
    end;
    FEditora.NomeEditora := edtNomeEditora.Text;
    _EditoraDAO.Salvar(FEditora);
    Caption := 'Gestão de Autores e Livros';
    BloquearAcoes();
  finally
    FreeAndNil(_EditoraDAO);
    Datamodule1.QueryEditoras.Refresh;
    Datamodule1.QueryLivrosEditoras.Refresh;
    ExibirDataHora();
    ShowMessage('Operação Concluída com Sucesso!');
  end;
end;

procedure TFormEditoras.btnVoltarClick(Sender: TObject);
begin
 // Datamodule1.QueryLivrosEditoras.Prior;
  Datamodule1.QueryEditoras.Prior;
  CarregarTabelasDAO;
end;

procedure TFormEditoras.CarregarTabelasDAO;
var
_idEditora: Integer;
begin
  _idEditora := (Datamodule1.QueryEditoras.FieldByName('IdEditora').AsInteger);
  FEditora := TEditorasDAO.Carregar(_idEditora);
  edtIdEditora.Text := IntToStr(FEditora.ID);
  edtNomeEditora.Text := FEditora.NomeEditora;
  edtEDataLog.Text := DateToStr(FEditora.DataLog);
  edtEHoraLog.Text := TimeToStr(FEditora.HoraLog);
end;

procedure TFormEditoras.DBGrid1CellClick(Column: TColumn);
var
  _idEditora: Integer;
begin
  _idEditora := Datamodule1.QueryLivrosEditoras.FieldByName('IdEditora')
    .AsInteger;
  FEditora := TEditorasDAO.Carregar(_idEditora);
  edtIdEditora.Text := IntToStr(FEditora.ID);
  edtNomeEditora.Text := FEditora.NomeEditora;
  edtEDataLog.Text := DateToStr(FEditora.DataLog);
  edtEHoraLog.Text := TimeToStr(FEditora.HoraLog)
end;

procedure TFormEditoras.DesbloquearAcoes;
begin
  edtNomeEditora.ReadOnly := False;
  edtEDataLog.ReadOnly := False;
  edtEHoraLog.ReadOnly := False;
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
end;

procedure TFormEditoras.ExibirDataHora;
begin
  edtEDataLog.Visible := True;
  edtEHoraLog.Visible := True;
  txtHora.Visible := True;
  txtData.Visible := True;
end;

procedure TFormEditoras.OcultarDataHora;
begin
  edtEDataLog.Visible := False;
  edtEHoraLog.Visible := False;
  txtHora.Visible := False;
  txtData.Visible := False;
end;

procedure TFormEditoras.LimparEdits;
begin
  edtNomeEditora.Clear;
  edtEDataLog.Clear;
  edtEHoraLog.Clear;
end;

end.
