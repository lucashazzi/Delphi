object FormAutores: TFormAutores
  Left = 0
  Top = 0
  Caption = 'Gest'#227'o de Autores e Livros'
  ClientHeight = 405
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object edtNomeAutor: TEdit
    Left = 17
    Top = 28
    Width = 247
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 8
    Top = 105
    Width = 528
    Height = 50
    TabOrder = 2
    object btnIncluir: TSpeedButton
      Left = 10
      Top = 7
      Width = 66
      Height = 33
      Caption = 'Incluir'
      OnClick = btnIncluirClick
    end
    object btnAlterar: TSpeedButton
      Left = 82
      Top = 8
      Width = 66
      Height = 33
      Caption = 'Alterar'
      OnClick = btnAlterarClick
    end
    object btnExcluir: TSpeedButton
      Left = 154
      Top = 8
      Width = 66
      Height = 33
      Caption = 'Excluir'
      OnClick = btnExcluirClick
    end
  end
  object dbGrid: TDBGrid
    Left = 8
    Top = 151
    Width = 528
    Height = 207
    TabStop = False
    DataSource = DataModule1.DataSourceAutores
    ReadOnly = True
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = dbGridCellClick
    OnKeyDown = dbGridKeyDown
  end
  object Panel2: TPanel
    Left = 448
    Top = 105
    Width = 88
    Height = 48
    TabOrder = 3
    object btnAnterior: TSpeedButton
      Left = 8
      Top = 8
      Width = 33
      Height = 33
      Glyph.Data = {
        060A0000424D060A000000000000420000002800000019000000190000000100
        200003000000C4090000130B0000130B000000000000000000000000FF0000FF
        0000FF0000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000080000000800000008000000080000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0045000000610000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000FF000000FF000000FF000000FF0000
        00000000000000000000000000000000000000000000000000000000000F0000
        009A000000FE0000008000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000FF000000FF000000FF0000
        00FF0000000000000000000000000000000000000000000000000000004F0000
        00E3000000FF000000FF00000080000000000000000000000000000000000000
        00000000000000000000000000000000000000000000000000FF000000FF0000
        00FF000000FF0000000000000000000000000000000000000015000000A50000
        00FF000000FF000000FF000000FF000000800000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000FF0000
        00FF000000FF000000FF00000000000000000000000000000056000000EB0000
        00FF000000FF000000FF000000FF000000FF0000008000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00FF000000FF000000FF000000FF000000000000001A000000B3000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF00000080000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000FF000000FF000000FF000000FF00000065000000EF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000800000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        0080000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000800000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF0000008000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000FF000000FF000000FF0000
        00FF00000065000000EF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF00000080000000000000000000000000000000000000
        00000000000000000000000000000000000000000000000000FF000000FF0000
        00FF000000FF000000000000001A000000B3000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000800000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000FF0000
        00FF000000FF000000FF00000000000000000000000000000057000000EB0000
        00FF000000FF000000FF000000FF000000FF0000008000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00FF000000FF000000FF000000FF000000000000000000000000000000000000
        0015000000A5000000FF000000FF000000FF000000FF00000080000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000FF000000FF000000FF000000FF0000000000000000000000000000
        000000000000000000000000004F000000E5000000FF000000FF000000800000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000FF000000FF000000FF000000FF00000000000000000000
        0000000000000000000000000000000000000000000F0000009A000000FE0000
        0080000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000080000000800000008000000080000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0045000000610000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000}
      OnClick = btnAnteriorClick
    end
    object btnProximo: TSpeedButton
      Left = 48
      Top = 8
      Width = 33
      Height = 33
      Glyph.Data = {
        060A0000424D060A000000000000420000002800000019000000190000000100
        200003000000C4090000130B0000130B000000000000000000000000FF0000FF
        0000FF0000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000061000000490000000000000000000000000000
        0000000000000000000000000000000000000000000000000080000000800000
        0080000000800000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000080000000FF000000A1000000110000
        0000000000000000000000000000000000000000000000000000000000FF0000
        00FF000000FF000000FF00000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000080000000FF000000FF0000
        00EA000000530000000000000000000000000000000000000000000000000000
        00FF000000FF000000FF000000FF000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000080000000FF0000
        00FF000000FF000000FF000000AB0000001A0000000000000000000000000000
        0000000000FF000000FF000000FF000000FF0000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000800000
        00FF000000FF000000FF000000FF000000FF000000ED0000005D000000000000
        000000000000000000FF000000FF000000FF000000FF00000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0080000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00B70000001F00000000000000FF000000FF000000FF000000FF000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000080000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000F100000066000000FF000000FF000000FF000000FF0000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000080000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000080000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF0000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000080000000FF000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF00000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000080000000FF000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000F1000000660000
        00FF000000FF000000FF000000FF000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000080000000FF0000
        00FF000000FF000000FF000000FF000000FF000000FF000000B70000001F0000
        0000000000FF000000FF000000FF000000FF0000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000800000
        00FF000000FF000000FF000000FF000000FF000000ED0000005D000000000000
        000000000000000000FF000000FF000000FF000000FF00000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0080000000FF000000FF000000FF000000FF000000AB0000001A000000000000
        00000000000000000000000000FF000000FF000000FF000000FF000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000080000000FF000000FF000000EA0000005300000000000000000000
        0000000000000000000000000000000000FF000000FF000000FF000000FF0000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000080000000FF000000A10000001100000000000000000000
        000000000000000000000000000000000000000000FF000000FF000000FF0000
        00FF000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000061000000490000000000000000000000000000
        0000000000000000000000000000000000000000000000000080000000800000
        0080000000800000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000}
      OnClick = btnProximoClick
    end
  end
  object Panel3: TPanel
    Left = 381
    Top = 359
    Width = 155
    Height = 43
    TabOrder = 4
  end
  object StaticText2: TStaticText
    Left = 17
    Top = 5
    Width = 90
    Height = 19
    Caption = 'Nome do Autor'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Roboto'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object txtData: TStaticText
    Left = 17
    Top = 55
    Width = 101
    Height = 19
    Caption = 'Data de Registro'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Roboto'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object txtHora: TStaticText
    Left = 152
    Top = 55
    Width = 101
    Height = 19
    Caption = 'Hora de Registro'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Roboto'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object edtDataLog: TMaskEdit
    Left = 18
    Top = 80
    Width = 65
    Height = 21
    EditMask = '99/99/9999'
    MaxLength = 10
    ReadOnly = True
    TabOrder = 1
    Text = '  /  /    '
  end
  object Panel4: TPanel
    Left = 318
    Top = 106
    Width = 74
    Height = 46
    Caption = 'Panel4'
    TabOrder = 9
    object btnVerLivros: TSpeedButton
      Left = 5
      Top = 6
      Width = 65
      Height = 33
      Caption = 'Ver Livros'
      OnClick = btnVerLivrosClick
    end
  end
  object btnSalvar: TButton
    Left = 462
    Top = 365
    Width = 67
    Height = 32
    Caption = 'Salvar'
    Enabled = False
    TabOrder = 10
    OnClick = btnSalvarClick
  end
  object btnCancelar: TButton
    Left = 389
    Top = 365
    Width = 67
    Height = 32
    Caption = 'Cancelar'
    Enabled = False
    TabOrder = 11
    OnClick = btnCancelarClick
  end
  object ConnInfo: TStaticText
    Left = 8
    Top = 385
    Width = 49
    Height = 17
    Caption = 'ConnInfo'
    TabOrder = 12
  end
  object edtHoraLog: TMaskEdit
    Left = 152
    Top = 80
    Width = 51
    Height = 21
    EditMask = '99:99:99'
    MaxLength = 8
    ReadOnly = True
    TabOrder = 13
    Text = '  :  :  '
  end
  object edtIdAutor: TEdit
    Left = 323
    Top = 28
    Width = 33
    Height = 21
    TabOrder = 14
    Text = 'ID'
    Visible = False
  end
end