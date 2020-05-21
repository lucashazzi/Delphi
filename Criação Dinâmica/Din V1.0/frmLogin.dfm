object Login: TLogin
  Left = 0
  Top = 0
  Caption = 'Login'
  ClientHeight = 201
  ClientWidth = 365
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 104
    Top = 29
    Width = 32
    Height = 15
    Caption = 'Login'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Roboto Bk'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 104
    Top = 80
    Width = 36
    Height = 15
    Caption = 'Senha'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Roboto Bk'
    Font.Style = []
    ParentFont = False
  end
  object edtLNome: TEdit
    Left = 104
    Top = 48
    Width = 153
    Height = 21
    TabOrder = 0
  end
  object edtLSenha: TEdit
    Left = 104
    Top = 99
    Width = 153
    Height = 21
    TabOrder = 1
  end
  object btnAcessar: TButton
    Left = 182
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Acessar'
    TabOrder = 2
    OnClick = btnAcessarClick
  end
end
