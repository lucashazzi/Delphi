object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Gerador de DAC para Contas Banc'#225'rias'
  ClientHeight = 201
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object txtDac: TStaticText
    Left = 8
    Top = 8
    Width = 189
    Height = 23
    Caption = 'Insira o n'#250'mero da conta:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Roboto'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object edtNumConta: TEdit
    Left = 208
    Top = 8
    Width = 105
    Height = 21
    NumbersOnly = True
    TabOrder = 1
  end
  object StaticText1: TStaticText
    Left = 8
    Top = 47
    Width = 243
    Height = 23
    Caption = 'O n'#250'mero DAC para esta conta '#233':'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Roboto'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object edtDAC: TEdit
    Left = 257
    Top = 47
    Width = 56
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object btnGerarDac: TButton
    Left = 232
    Top = 160
    Width = 81
    Height = 33
    Caption = 'Gerar'
    TabOrder = 4
    OnClick = btnGerarDacClick
  end
end
