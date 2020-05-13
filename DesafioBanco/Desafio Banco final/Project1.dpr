program Project1;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  Funcoes in 'Funcoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
