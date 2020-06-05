unit uRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, FireDAC.Comp.Client;

type
  TFormRelatorio = class(TForm)
    RLReport: TRLReport;
    bndHeader: TRLBand;
    RLLabel1: TRLLabel;
    bndHeaderDados: TRLBand;
    lblEditora: TRLLabel;
    bndEspaco: TRLBand;
    bndFooter: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel2: TRLLabel;
    bndDados: TRLBand;
    RLSystemInfo3: TRLSystemInfo;
    rltxtDescricao: TRLLabel;
    procedure rlReportNeedData(Sender: TObject; var MoreData: Boolean);
    procedure rltxtDescricaoBeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
  private
    FQryRelatorio: TFDQuery;
    check: Boolean;
    procedure OcultarBandas();
    procedure PrintarBanda(ABanda: TRLBand);
  public
    procedure ImprimirRelatorio();
    constructor Create(AOwner: TComponent; ADataSet: TFDQuery); overload;
  end;

var
  FormRelatorio: TFormRelatorio;

implementation

{$R *.dfm}

uses uDataModule;

constructor TFormRelatorio.Create(AOwner: TComponent; ADataSet: TFDQuery);
begin
  Inherited Create(AOwner);
  Self.FQryRelatorio := ADataSet;
end;

procedure TFormRelatorio.ImprimirRelatorio;
begin
  check := True;
  RLReport.PreviewModal;
end;

procedure TFormRelatorio.rlReportNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData := check;
  if MoreData then
  begin
    OcultarBandas();
    FQryRelatorio.First;
    while not FQryRelatorio.Eof do
    begin
      PrintarBanda(bndDados);
      FQryRelatorio.Next;
    end;

    check := False;
  end;
end;


procedure TFormRelatorio.rltxtDescricaoBeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin
  AText := FQryRelatorio.FieldByName('Descricao').AsString;
end;

procedure TFormRelatorio.OcultarBandas;
begin
  bndHeader.Visible := False;
  bndHeaderDados.Visible := False;
  bndEspaco.Visible := False;
  bndFooter.Visible := False;
end;

procedure TFormRelatorio.PrintarBanda(ABanda: TRLBand);
begin
  ABanda.Visible := True;
  RLReport.PrintBand(ABanda);
  ABanda.Visible := False;
end;

end.
