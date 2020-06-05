program BibliotecaDinamica;

uses
  Vcl.Forms,
  frmGestaoAutores in 'frmGestaoAutores.pas' {FormAutores},
  uDataModule in 'uDataModule.pas' {DataModule1: TDataModule},
  uCLivros in 'uCLivros.pas',
  uCAutores in 'uCAutores.pas',
  uCEditoras in 'uCEditoras.pas',
  frmGestaoLivros in 'frmGestaoLivros.pas' {FormLivros},
  uREDAPP in 'uREDAPP.pas',
  frmGestaoEditoras in 'frmGestaoEditoras.pas' {FormEditoras};

{$R *.res}

begin
 // ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormAutores, FormAutores);
  Application.Run;
end.
