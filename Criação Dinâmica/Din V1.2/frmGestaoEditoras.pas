unit frmGestaoEditoras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDataModule, uCEditoras,
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FEditora: TEditora;
    FEstado: uREDAPP.TEstado;
    BotaoAtivado: Boolean;
    procedure FillFormFieldsDAO;
    procedure DesbloquearAcoes();
    procedure LimparEdits();
    procedure ExibirDataHora();
    procedure OcultarDataHora();
    procedure BloquearAcoes();
  public
    procedure MostrarEditoras();

  end;

var
  FormEditoras: TFormEditoras;

implementation
uses
frmGestaoLivros;

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
    FillFormFieldsDAO();
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
  FillFormFieldsDAO();
end;

procedure TFormEditoras.btnCancelarClick(Sender: TObject);
begin
  FEstado := Leitura;
  BloquearAcoes();
  ExibirDataHora();
  Caption := 'Editoras';
  FillFormFieldsDAO();
end;

procedure TFormEditoras.btnExcluirClick(Sender: TObject);
var
  _confirmacao, _MsgDlgPositivo: Integer;
begin
 _MsgDlgPositivo := 6;
  try
    _confirmacao := MessageDlg('Deseja realmente EXCLUIR?', mtWarning,
      [mbYes, mbNo], 0);

    if _confirmacao = _MsgDlgPositivo then
    begin
      TEditora.Apagar(StrToInt(edtIdEditora.Text));
      FillFormFieldsDAO();
      ShowMessage('Excluído com sucesso!');
    end;
  finally
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
      FillFormFieldsDAO();
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
begin
  try
    if FEstado = Inclusao then
    begin
      FEditora := nil;
      FEditora := TEditora.Create();
    end;
    FEditora.NomeEditora := edtNomeEditora.Text;
    TEditora.Gravar(FEditora);
    Caption := 'Gestão de Autores e Livros';
    BloquearAcoes();
  finally
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
  FillFormFieldsDAO();
end;

procedure TFormEditoras.FillFormFieldsDAO();
var
_idEditora: Integer;
begin
  _idEditora := (Datamodule1.QueryEditoras.FieldByName('IdEditora').AsInteger);
  FEditora := TEditoraDAO.Carregar(_idEditora);
  edtIdEditora.Text := IntToStr(FEditora.ID);
  edtNomeEditora.Text := FEditora.NomeEditora;
  edtEDataLog.Text := DateToStr(FEditora.DataLog);
  edtEHoraLog.Text := TimeToStr(FEditora.HoraLog);
end;

procedure TFormEditoras.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FEditora.Free;
end;

procedure TFormEditoras.DBGrid1CellClick(Column: TColumn);
var
  _idEditora: Integer;
begin
  _idEditora := Datamodule1.QueryLivrosEditoras.FieldByName('IdEditora')
    .AsInteger;
  FEditora := TEditoraDAO.Carregar(_idEditora);
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
