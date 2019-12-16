object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'ResizePNG'
  ClientHeight = 359
  ClientWidth = 512
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object imgSrc: TImage
    Left = 8
    Top = 128
    Width = 105
    Height = 105
    Stretch = True
  end
  object btnLoad: TButton
    Left = 24
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 0
    OnClick = btnLoadClick
  end
  object btnCreate: TButton
    Left = 24
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Create'
    TabOrder = 1
    OnClick = btnCreateClick
  end
  object Memo1: TMemo
    Left = 119
    Top = 96
    Width = 362
    Height = 251
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 119
    Top = 8
    Width = 362
    Height = 65
    Caption = 'Single Output'
    TabOrder = 3
    object chbSingleSize: TCheckBox
      Left = 14
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Single Size'
      TabOrder = 0
    end
    object edtSize: TEdit
      Left = 117
      Top = 22
      Width = 57
      Height = 21
      TabOrder = 1
      Text = '50'
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 17
    Top = 248
  end
end
