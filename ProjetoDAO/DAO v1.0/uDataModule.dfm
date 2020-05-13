object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 290
  Width = 416
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    Left = 191
    Top = 190
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=admin'
      'Database=Biblioteca'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 191
    Top = 142
  end
  object QueryLivros: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM Livros WHERE Livros.idAutor = 2')
    Left = 47
    Top = 30
  end
  object DataSourceLivros: TDataSource
    DataSet = QueryLivros
    Left = 47
    Top = 78
  end
  object QueryAutores: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM Autores WHERE Autores.idAutor = 2')
    Left = 239
    Top = 30
  end
  object DataSourceAutores: TDataSource
    DataSet = QueryAutores
    Left = 239
    Top = 78
  end
  object DataSourceLogin: TDataSource
    DataSet = QueryLogin
    Left = 144
    Top = 80
  end
  object QueryLogin: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM Usuarios;')
    Left = 144
    Top = 32
  end
  object QueryEditoras: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM editoras')
    Left = 336
    Top = 32
  end
  object DataSourceEditoras: TDataSource
    DataSet = QueryEditoras
    Left = 336
    Top = 80
  end
  object DataSourceLivrosEditoras: TDataSource
    DataSet = QueryLivrosEditoras
    Left = 328
    Top = 224
  end
  object QueryLivrosEditoras: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM Livros WHERE Livros.IdEditora = Editoras.IdEditora')
    Left = 328
    Top = 160
  end
end
