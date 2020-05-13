object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Validador de CPF'
  ClientHeight = 116
  ClientWidth = 252
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object mskCPF: TMaskEdit
    Left = 160
    Top = 8
    Width = 82
    Height = 21
    TabOrder = 0
    Text = ''
  end
  object btnValidarCPF: TButton
    Left = 152
    Top = 80
    Width = 92
    Height = 28
    Caption = 'Validar'
    TabOrder = 1
    OnClick = btnValidarCPFClick
  end
  object txtCPF: TStaticText
    Left = 8
    Top = 8
    Width = 146
    Height = 21
    Caption = 'Insira o CPF desejado*:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object edtRespostaDaValidacao: TEdit
    Left = 160
    Top = 35
    Width = 49
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object txtDigitoVer: TStaticText
    Left = 8
    Top = 35
    Width = 121
    Height = 20
    Caption = 'D'#237'gito Verificador:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object txtObs: TStaticText
    Left = 8
    Top = 91
    Width = 96
    Height = 17
    Caption = '*Somente n'#250'meros'
    TabOrder = 5
  end
end
