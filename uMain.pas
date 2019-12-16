unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  pngimage; // Vcl.Imaging.pngimage

type
  TFormMain = class(TForm)
    btnLoad: TButton;
    OpenDialog1: TOpenDialog;
    imgSrc: TImage;
    btnCreate: TButton;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    chbSingleSize: TCheckBox;
    edtSize: TEdit;
    procedure btnLoadClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
  private
    { Private declarations }
    SavePath: string;
  public
    { Public declarations }
    procedure PNG_ResizeAndSave(sizex, sizey: Integer);
  end;

var
  FormMain: TFormMain;

const
  ICON_SIZE: array [0 .. 20] of Integer = (36, 48, 72, 96, 144, 24, 57, 60,
    87, 114, 120, 180, 29, 40, 58, 80, 76, 152, 167, 100, 50);
  SAVE_DIR = 'ResizedPNG';

implementation

{$R *.dfm}

procedure TFormMain.btnCreateClick(Sender: TObject);
var
  i, size: Integer;
begin

  if chbSingleSize.Checked then
  begin
    if TryStrToInt(edtSize.Text, size) then
      PNG_ResizeAndSave(size, size); // square
  end
  else
  begin
    for i := Low(ICON_SIZE) to High(ICON_SIZE) do
    begin
      PNG_ResizeAndSave(ICON_SIZE[i], ICON_SIZE[i]); // square
    end;
  end;
end;

procedure TFormMain.btnLoadClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    imgSrc.Picture.LoadFromFile(OpenDialog1.FileName);
    SavePath := ExtractFilePath(OpenDialog1.FileName) + '\' + SAVE_DIR;
    if not DirectoryExists(SavePath) then
      CreateDir(SavePath);
  end;
end;

procedure TFormMain.PNG_ResizeAndSave(sizex, sizey: Integer);
var
  FileName: string;
  rect: TRect;
  pic_empty, pic_stamp, pic_result: TPicture;
  png: TPNGObject;
begin

  { TODO -oTony -cbug : 非透明的 png 黑色底圖時，會異常 }
  pic_stamp := TPicture.Create;
  pic_stamp.Assign(imgSrc.Picture);
  pic_stamp.Graphic.Transparent := True;

  pic_empty := TPicture.Create;
  pic_empty.Bitmap.Width := 3096;
  pic_empty.Bitmap.Height := 3096;

  pic_result := TPicture.Create;
  pic_result.Bitmap.Assign(pic_empty.Graphic);
  pic_result.Graphic.Transparent := True;

  rect.Left := 0;
  rect.Top := 0;
  rect.Right := rect.Left + sizex;
  rect.Bottom := rect.Top + sizey;

  pic_result.Bitmap.Canvas.StretchDraw(rect, pic_stamp.Graphic);
  pic_result.Bitmap.Width := sizex;
  pic_result.Bitmap.Height := sizey;

  png := TPNGObject.Create;
  png.Assign(pic_result.Bitmap);

  FileName := inttostr(sizex) + 'x' + inttostr(sizey) + '.png';
  png.SaveToFile(SavePath + '\' + FileName);
  Memo1.Lines.Add('save ' + FileName);

  pic_stamp.Free;
  pic_empty.Free;
  pic_result.Free;
  png.Free;
end;

end.
