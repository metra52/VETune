object Form2: TForm2
  Left = 0
  Top = 0
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 232
  ClientWidth = 257
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 62
    Top = 198
    Width = 129
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 16
    Top = 8
    Width = 233
    Height = 89
    TabOrder = 1
    object Label1: TLabel
      Left = 72
      Top = 8
      Width = 95
      Height = 13
      Caption = #1055#1091#1090#1100' '#1082' Log '#1092#1072#1081#1083#1072#1084
    end
    object Button2: TButton
      Left = 72
      Top = 54
      Width = 75
      Height = 25
      Caption = #1059#1082#1072#1079#1072#1090#1100
      TabOrder = 0
      OnClick = Button2Click
    end
    object Edit1: TEdit
      Left = 8
      Top = 27
      Width = 217
      Height = 21
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 16
    Top = 103
    Width = 233
    Height = 89
    TabOrder = 2
    object Label2: TLabel
      Left = 56
      Top = 8
      Width = 119
      Height = 13
      Caption = #1055#1091#1090#1100' '#1082' EEPROM '#1092#1072#1081#1083#1072#1084
    end
    object Button3: TButton
      Left = 72
      Top = 54
      Width = 75
      Height = 25
      Caption = #1059#1082#1072#1079#1072#1090#1100
      TabOrder = 0
      OnClick = Button3Click
    end
    object Edit2: TEdit
      Left = 8
      Top = 27
      Width = 217
      Height = 21
      TabOrder = 1
    end
  end
  object DirDialog1: TDirDialog
    NewFolder = True
    Left = 152
    Top = 256
  end
end
