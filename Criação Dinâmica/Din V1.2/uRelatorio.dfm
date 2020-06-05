object FormRelatorio: TFormRelatorio
  Left = 0
  Top = 0
  Caption = 'FormRelatorio'
  ClientHeight = 601
  ClientWidth = 782
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object rlReport: TRLReport
    Left = -3
    Top = 8
    Width = 794
    Height = 1123
    DataSource = DataModule1.DataSourceLivros
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Visible = False
    OnNeedData = rlReportNeedData
    object bndHeader: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 64
      BandType = btHeader
      Transparent = False
      object RLLabel1: TRLLabel
        Left = 247
        Top = 18
        Width = 224
        Height = 23
        Caption = 'Rela'#231#227'o de Editoras e Livros'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object bndHeaderDados: TRLBand
      Left = 38
      Top = 102
      Width = 718
      Height = 20
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      Visible = False
      object lblEditora: TRLLabel
        Left = 1
        Top = 1
        Width = 716
        Height = 18
        Align = faClient
        Caption = 'Editora'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object bndEspaco: TRLBand
      Left = 38
      Top = 138
      Width = 718
      Height = 19
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = False
    end
    object bndFooter: TRLBand
      Left = 38
      Top = 157
      Width = 718
      Height = 20
      BandType = btFooter
      object RLSystemInfo1: TRLSystemInfo
        Left = 608
        Top = 0
        Width = 110
        Height = 20
        Align = faRight
        Info = itLastPageNumber
        Text = ''
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 504
        Top = 0
        Width = 94
        Height = 20
        Align = faRight
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
      end
      object RLLabel2: TRLLabel
        Left = 598
        Top = 0
        Width = 10
        Height = 20
        Align = faRight
        Alignment = taJustify
        Caption = '/'
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 0
        Top = 0
        Width = 504
        Height = 20
        Align = faClient
        Info = itFullDate
        Text = ''
      end
    end
    object bndDados: TRLBand
      Left = 38
      Top = 122
      Width = 718
      Height = 16
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = False
      object rltxtDescricao: TRLLabel
        Left = 1
        Top = 1
        Width = 716
        Height = 15
        Align = faClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        BeforePrint = rltxtDescricaoBeforePrint
      end
    end
  end
end
