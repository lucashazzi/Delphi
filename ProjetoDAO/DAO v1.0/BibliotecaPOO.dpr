program BibliotecaPOO;

uses
  Vcl.Forms,
  frmGestaoAutores in '..\..\Documents\Delphi\DataModule em POO\DAO completo\frmGestaoAutores.pas' {FormAutores},
  uDataModule in '..\..\Documents\Delphi\DataModule em POO\DAO completo\uDataModule.pas' {DataModule1: TDataModule},
  uCLivros in '..\..\Documents\Delphi\DataModule em POO\DAO completo\uCLivros.pas',
  uCAutores in '..\..\Documents\Delphi\DataModule em POO\DAO completo\uCAutores.pas',
  uCEditoras in '..\..\Documents\Delphi\DataModule em POO\DAO completo\uCEditoras.pas',
  frmGestaoLivros in '..\..\Documents\Delphi\DataModule em POO\DAO completo\frmGestaoLivros.pas' {FormLivros},
  uREDAPP in '..\..\Documents\Delphi\DataModule em POO\DAO completo\uREDAPP.pas',
  frmGestaoEditoras in '..\..\Documents\Delphi\DataModule em POO\DAO completo\frmGestaoEditoras.pas' {FormEditoras};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormAutores, FormAutores);
  Application.Run;
end.
