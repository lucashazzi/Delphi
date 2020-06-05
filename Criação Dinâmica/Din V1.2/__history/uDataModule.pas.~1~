unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.MySQLDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDataModule1 = class(TDataModule)
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    FDConnection1: TFDConnection;
    QueryLivros: TFDQuery;
    DataSourceLivros: TDataSource;
    QueryAutores: TFDQuery;
    DataSourceAutores: TDataSource;
    DataSourceLogin: TDataSource;
    QueryLogin: TFDQuery;
    QueryEditoras: TFDQuery;
    DataSourceEditoras: TDataSource;
    DataSourceLivrosEditoras: TDataSource;
    QueryLivrosEditoras: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
