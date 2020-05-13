program ValidadorCPF;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {Form1},
  Funcoes in 'Funcoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
