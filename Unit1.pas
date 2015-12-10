unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls,Masks, Grids, ExtCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    MainMenu1: TMainMenu;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    N1: TMenuItem;
    N5: TMenuItem;
    N8: TMenuItem;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    OpenDialog2: TOpenDialog;
    N10: TButton;
    Label2: TLabel;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N7: TMenuItem;
    procedure N8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure Parse(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);

    procedure StringGrid2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);




  private
    { Private declarations }


  public
    { Public declarations }
    a:integer; s:string;
  end;
     type
  TSave = record
    FontColor : TColor;
    FontStyle : TFontStyles;
    BrColor : TColor;
  end;

var
  Form1: TForm1;
  List:TStringList;
  Lst:TStringList;
  ar: array of array of string;
  rash:array of array of real;
  rc:integer;
  gEditCol : Integer = -1;
  gEditRow : Integer = -1;


implementation
Const
Ix=50;  Iy=50;  //�������� �������� �� ����� ���� ������
//nt=100; //����� ���������� �� ��� x
ndx=10;
ndy=50; //����� ��������� �� ���� (x, y), ����� �������
nc=7; mc=2; // ��������� ��� ������ ��������� ����

{$R *.dfm}
procedure TabClear(n,r,k:integer);
var iStroki,iStolbca:integer;
begin
if k=1 then  begin
//������� ����� �������
for iStolbca:=n to Form1.StringGrid1.ColCount do
for iStroki:=r to Form1.StringGrid1.RowCount do
  Form1.StringGrid1.Cells[iStolbca,iStroki]:='';
end;
if k=2 then  begin
//������� ����� �������
for iStolbca:=n to Form1.StringGrid2.ColCount do
for iStroki:=r to Form1.StringGrid2.RowCount do
  Form1.StringGrid2.Cells[iStolbca,iStroki]:='';
end;
end;


procedure TForm1.StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var Flag : Integer;
begin
//������ �������� �����, ������� �������� ��� ����� ��������� �� ������.
  Flag := Integer(StringGrid2.Rows[ARow].Objects[ACol]);
  //���� ���� �� �����
  if (Flag <> 1) then Exit;
with StringGrid2 do
  begin
  if (ACol>0) and(ARow>0) then begin
   try
    if not (edit1.Text = Cells[ACol, ARow])then
Canvas.Brush.Color:=clYellow;
   except
   end;
   Canvas.FillRect(Rect); //����� ���� ����� ��������, ��� ����� ������������:
   Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[ACol, ARow]);
  end;
  end;
end;


procedure TForm1.StringGrid2MouseUP(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Col, Row : Integer;
begin
//���������� ���������� ������, �� ������� ��������� ������ ����.
  StringGrid2.MouseToCell(X, Y, Col, Row);
  with StringGrid2 do
  begin
  //���� ��������� ������ ����� ������� ���� - ������������� ����.
  if Button = mbLeft then begin
    //��� ����� ��������� �� ������, ������� ������ � �������, ����������
    //�������� �����. �������� �����, ������ 1, ��������, ��� ���� ������ �������.
    Rows[Row].Objects[Col] := TObject(1); //���: := Pointer(1);
  //���� ��������� ������ ������ ������� ���� - ���������� ����.
  end else if Button = mbRight then begin
    Rows[Row].Objects[Col] := TObject(0); //���: := Pointer(0);
  end;
  end; 
end;

procedure TForm1.Button1Click(Sender: TObject);
var i,j,k:integer;
begin
Button3.Enabled:=true;
   //��������� � ������� ������ �������� �� edit1
for i:= 1 to 15 do begin
    k:=1;
      for j:=1 to 17 do begin
      stringGrid2.Cells[k,i]:=edit1.Text;
        inc(k)
      end;
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i, j,iTmp: Integer;
  f1:textfile;
  st:string;
begin
Button3.Enabled:=true;
N4.Enabled:=true;
//�������� ���� ������� ����.������� ��� ������ �����
//� �����, ����� �� �������� �������
// ��������� ��������� ����� ���� .txt � .doc
  OpenDialog2.Filter := 'Text file|*.txt|Word file|*.doc';

  // ��������� ���������� �� ���������
 OpenDialog2.DefaultExt := '*.txt';

  // ����� ��������� ������ ��� ��������� ��� �������
 OpenDialog2.FilterIndex := 1;
//��������� � Memo1 - ������� ������� ���������.
if Form1.OpenDialog2.Execute then begin //���� ������ ����
  S:=OpenDialog2.FileName;//�� S ��������� ������������ �����,
   //� � ��������� ����� �������� ������������ �����
AssignFile(F1, s);
Reset(F1);
TabClear(1,1,2);   //������� ����
with StringGrid2 do
   begin
     // Get number of columns
    Readln(f1, iTmp);
     ColCount := iTmp;
     // Get number of rows
    Readln(f1, iTmp);
     RowCount := iTmp;
     // loop through cells & fill in values
    for i := 1 to ColCount - 1 do
       for j := 1 to RowCount - 1 do
       begin
         Readln(f1, st);
         Cells[i, j] := st;
       end;
   end;


CloseFile(F1);
    end;

end;

procedure TForm1.Button3Click(Sender: TObject);
var
   i, k: Integer;
  f1:textfile;

begin
//���������� ������ �� ������ ���� ����.��������� ���...
//�������� ���� ������� ��� ������ ����� �
//������� ����� � ���� �����, � ������� �������
// ��������� ��������� ����� ���� .txt � .doc
  saveDialog1.Filter := 'Text file|*.txt|Word file|*.doc';

  // ��������� ���������� �� ���������
  saveDialog1.DefaultExt := '*.txt';

  // ����� ��������� ������ ��� ��������� ��� �������
  saveDialog1.FilterIndex := 1;
//��������� ����� �� Memo1-������� ������� ���������
if Form1.SaveDialog1.Execute then begin
  //���� ���� ������,
  //�� S ��������� ������������ �����,

  S:=SaveDialog1.FileName;
  //��������� ����� � ����� � �����
AssignFile(F1, s);
Rewrite(F1);
with StringGrid2 do
   begin
     // Write number of Columns/Rows
    Writeln(f1, ColCount);
     Writeln(f1, RowCount);
     // loop through cells
    for i := 1 to ColCount - 1 do
       for k := 1 to RowCount - 1 do
         Writeln(F1, Cells[i, k]);
   end;


CloseFile(F1);

end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i,j,k:integer;
begin
// ��������� ��������� ����� ���� .txt � .doc
  OpenDialog1.Filter := 'Secu3 Logfile|*.csv|';

  // ��������� ���������� �� ���������
 OpenDialog1.DefaultExt := '*.csv';

  // ����� ��������� ������ ��� ��������� ��� �������
 OpenDialog1.FilterIndex := 1;
//���������� ������� �������� �����
//��� �������� ����� ������� ����� ��
//Memo1 - ������� ������� ���������
Memo1.Clear;
//��������� ������� �������� ���������
//(�� ���� ���������� ������� Memo1 ��)
//��� ���������� ������� ���� �����
Memo1.Align:=alClient;
//� ���������� ������������� ����� Courier
Memo1.Font.Name:='Courier';
//���� S ='',  ������������� ����� �� �������� � �����
S:='';
//� � ���������� S ����� ������������
//������������ �����.
//�������, ��� ����� �� �������������
Memo1.Modified:=false;
//���������� �������� stringGrid2
//�������� �����
stringGrid2.Cells[0,0]:='��.\����.';
j:=1;
for i:= 1 to 16 do begin
    k:=0;
      stringGrid2.Cells[i,k]:=inttostr(j);
      inc(j)
    end;
//�������� ��������
j:=1;
 for i:= 1 to 16 do begin
    k:=0;
    case i of
    1:j:=600;
    2:j:=720;
    3:j:=840;
    4:j:=990;
    5:j:=1170;
    6:j:=1380;
    7:j:=1650;
    8:j:=1950;
    9:j:=2310;
    10:j:=2730;
    11:j:=3210;
    12:j:=3840;
    13:j:=4530;
    14:j:=5370;
    15:j:=6360;
    end;
      stringGrid2.Cells[k,i]:=inttostr(j);
    end;

//��������� � ������� ������ ��������� ��������
for i:= 1 to 15 do begin
    k:=1;
      for j:=1 to 17 do begin
      stringGrid2.Cells[k,i]:=edit1.Text;
      form1.StringGrid2.Rows[k].Objects[i] := TObject(1);
        inc(k)
      end;
    end;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
if Memo1.Modified then begin //���� ����� Memo1 ���
  // �������, �� ���������� ������ ��� ������ �����
  case MessageDlg('����� ��� �������. ��������� ������'+
         ' � ����� �� ������?',   mtConfirmation,
        [mbYes, mbNo, mbCancel], 0) of
    6{idYes}: begin   // ��������� ����� � �����, ������ ���
        //� ������� ����.��������� ���...
        N7Click(Self);
        S:='';
memo1.Lines.Clear;
        //������� � ������� ����.�������
        end;
    7{idYes}: begin   // ��������� ����� � �����, ������ ���
        //� ������� ����.��������� ���...
        begin
S:='';
memo1.Lines.Clear; end;
        //������� � ������� ����.�������
        end;
  end;
end
else begin
S:='';
memo1.Lines.Clear; end;
end;

procedure TForm1.N4Click(Sender: TObject);
var s:string;
begin
TabClear(0,0,1);
memo1.Clear;
//���������� ������ �� ������ ���� ����.�������...
if Memo1.Modified then begin //���� ����� Memo1 ���
  // �������, �� ���������� ������ ��� ������ �����
  case MessageDlg('����� ��� �������. ��������� ������'+
         ' � ����� �� ������?',   mtConfirmation,
        [mbYes, mbNo, mbCancel], 0) of
    6{idYes}: begin   // ��������� ����� � �����, ������ ���
        //� ������� ����.��������� ���...
        N7Click(Self);
        //������� � ������� ����.�������
        end;
    {2}idCancel: exit;//����� �� ������� ����.�������
                                 //� �������� ��� ����������
    {7}idNo:;//�� ��������� ����� � ����� �
                    //������� � ������� ����. �������
    end; //case
  end;//if Memo1.Modified
//�������� ���� ������� ����.������� ��� ������ �����
//� �����, ����� �� �������� �������
//��������� � Memo1 - ������� ������� ���������.
if Form1.OpenDialog1.Execute then begin //���� ������ ����
  S:=OpenDialog1.FileName;//�� S ��������� ������������ �����,
  Memo1.Lines.LoadFromFile(S);//��������� ����� �� ����� � Memo1
  Memo1.Modified:=false;//�������, ��� ����� �� �������������,
  //� � ��������� ����� �������� ������������ �����
  Form1.Caption:='Form1' + '  ' + S;
  end;//if Form1.OpenDialog1.Execute
  a := Memo1.Lines.Count;// ���-�� ����� Memo1
  //������� ������ ���� �������
{Form1.StringGrid1.Width:=0;
for i:=0 to Form1.StringGrid1.ColCount -1 do
Form1.StringGrid1.Width:=Form1.StringGrid1.Width
  +Form1.StringGrid1.ColWidths[i];}

memo1.Visible:=false;
rc:=Form1.StringGrid1.RowCount;
Parse(Sender);
n10.Enabled:=true;
end;


procedure TForm1.N5Click(Sender: TObject);
var k,s:TStringList;i:integer; fname:string;
begin
TabClear(0,0,1);
 i:=0;
//��������� � Memo1 - ������� ������� ���������.
if Form1.OpenDialog1.Execute then begin //���� ������ ����
  fname:=OpenDialog1.FileName;

s:=TStringList.Create;k:=TStringList.Create;

k.LoadFromFile(fname);
Form1.Caption:='Form1' + '  ' + fname;
s.Delimiter:=','; // ��� ����������� ����� ����������
StringGrid1.Rows[i].Delimiter:=s.Delimiter;
StringGrid1.RowCount:=k.Count;
StringGrid1.ColCount:=1;
for i:=0 to k.Count-1 do begin
 s.DelimitedText:=k[i];
 if StringGrid1.ColCount<s.Count then
  StringGrid1.ColCount:=s.Count;
  StringGrid1.Rows[i].DelimitedText:=s.DelimitedText;
end;
s.free;k.Free;
n10.Enabled:=true;
N7.Enabled:=true;
 end;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
if s='' then N7Click(Self) else Memo1.Lines.SaveToFile(S);

end;

procedure TForm1.N7Click(Sender: TObject);
begin
//���������� ������ �� ������ ���� ����.��������� ���...
//�������� ���� ������� ��� ������ ����� �
//������� ����� � ���� �����, � ������� �������
//��������� ����� �� Memo1-������� ������� ���������
if Form1.SaveDialog1.Execute then begin
  //���� ���� ������,
  //�� S ��������� ������������ �����,
  S:=SaveDialog1.FileName;
  //��������� ����� � ����� � �����
  Memo1.Lines.SaveToFile(S);
  //�������, ��� ����� �� �������������,
  Memo1.Modified:=false;
  //� � ��������� ����� ��������
  //������������ �����
  Form1.Caption:='Form1' + '  ' +  S;
  end;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
if Memo1.Modified then begin //���� ����� Memo1 ���
  // �������, �� ���������� ������ ��� ������ �����
  case MessageDlg('����� ��� �������. ��������� ������'+
         ' � ����� �� ������?',   mtConfirmation,
        [mbYes, mbNo, mbCancel], 0) of
    6{idYes}: begin   // ��������� ����� � �����, ������ ���
        //� ������� ����.��������� ���...
        N7Click(Self);
        //������� � ������� ����.�������
        end;
    7{idYes}: begin   // ��������� ����� � �����, ������ ���
        //� ������� ����.��������� ���...
        close;
        //������� � ������� ����.�������
        end;
  end;
end
else close;

end;

function zero(s:string):string;
var i:integer; p,p1:char;
begin
i:=1;
p:=s[i];
p1:=s[i+1];
while p=p1 do begin
 inc(i);
p:=s[i];
p1:=s[i+1];
end;
if i=5 then i:=i-1;
Delete(s, 1, i);
result :=s

end;

procedure TForm1.Parse(Sender: TObject);
var i,j,k:integer;
begin
with TStringList.Create do
  begin
    Delimiter:=',';
    { for j := 0 to Count - 1 do
      ShowMessage(Strings[j]);}
    /////��������� � ���� ���������� ��
    for i:= 0 to a-1 do begin
    k:=0;
    DelimitedText:=memo1.Lines[i];
      for j:=0 to count -1 do begin
     stringGrid1.Cells[k,i]:=Strings[k]; ;inc(k)
      end;
    end;
  Free;
  end;
end;



procedure smlst(arh:Pointer;n:integer;k:integer);
var i:integer; n1:array [0..13] of integer;
 s1:array [0..13] of real;
  sr1:array [0..13] of real;
  arr: array of array of real;
  znac:string;
  zn:real;
begin
Pointer(arr) := arh;

for i:=0 to 13 do  begin
  n1[i]:=0;
  s1[i]:=0;
  sr1[i]:=0;
end;

for i:=0 to n do
 begin
 if (arr[0,i]>=600) and (arr[0,i]<720) then begin
  s1[0]:=s1[0]+arr[1,i];
  inc(n1[0]);
 end;
  if (arr[0,i]>=720) and (arr[0,i]<840) then begin
  s1[1]:=s1[1]+arr[1,i];
  inc(n1[1]);
 end;
  if (arr[0,i]>=840) and (arr[0,i]<990) then begin
  s1[2]:=s1[2]+arr[1,i];
  inc(n1[2]);
 end;
  if (arr[0,i]>=990) and (arr[0,i]<1170) then begin
  s1[3]:=s1[3]+arr[1,i];
  inc(n1[3]);
 end;
  if (arr[0,i]>=1170) and (arr[0,i]<1380) then begin
  s1[4]:=s1[4]+arr[1,i];
  inc(n1[4]);
 end;
  if (arr[0,i]>=1380) and (arr[0,i]<1650) then begin
  s1[5]:=s1[5]+arr[1,i];
  inc(n1[5]);
 end;
  if (arr[0,i]>=1650) and (arr[0,i]<1950) then begin
  s1[6]:=s1[6]+arr[1,i];
  inc(n1[6]);
 end;
  if (arr[0,i]>=1950) and (arr[0,i]<2310) then begin
  s1[7]:=s1[7]+arr[1,i];
  inc(n1[7]);
 end;
  if (arr[0,i]>=2310) and (arr[0,i]<2730) then begin
  s1[8]:=s1[8]+arr[1,i];
  inc(n1[8]);
 end;
  if (arr[0,i]>=2730) and (arr[0,i]<3210) then begin
  s1[9]:=s1[9]+arr[1,i];
  inc(n1[9]);
 end;
  if (arr[0,i]>=3210) and (arr[0,i]<3840) then begin
  s1[10]:=s1[10]+arr[1,i];
  inc(n1[10]);
 end;
  if (arr[0,i]>=3840) and (arr[0,i]<4530) then begin
  s1[11]:=s1[11]+arr[1,i];
  inc(n1[11]);
 end;
 if (arr[0,i]>=4530) and (arr[0,i]<5370) then begin
  s1[12]:=s1[12]+arr[1,i];
  inc(n1[12]);
 end;
 if (arr[0,i]>=5370) and (arr[0,i]<6360) then begin
  s1[13]:=s1[13]+arr[1,i];
  inc(n1[13]);
 end;


 end;
 //////��������
//   for i:= 0 to 11 do
// form1.Memo2.Lines.Add(inttostr(n1[i]));
///////////////
//���������� �������� ��������������� � ������� � �����
for i := 0 to 13 do
 begin
   if n1[i]> 0 then
   sr1[i]:=(s1[i]/n1[i])/100
 end;
   //////��������
   ///
 {  i:=0;
   for i:= 0 to 13 do begin
   form1.Memo2.Lines.Add(FormatFloat('0.00', sr1[i]));
   if i=13 then
    form1.Memo2.Lines.Add('/////////');

   end;  }
///////////////
/// �������� ���� ���� ��������� ��������
for i:= 2 to form1.stringGrid2.Rowcount do begin
if (sr1[i-2]>0) or (sr1[i-2]<0) then begin
//array[�������,������]
 zn:=strtofloat(form1.stringGrid2.Cells[k,i-1])+sr1[i-2];
 znac:=FormatFloat( '0.##',(zn));
    if form1.stringGrid2.Cells[k,i-1]<> znac then
    begin
      form1.stringGrid2.Cells[k,i-1]:=znac;
    end;
end;
end;

znac:='';
arr:=nil;
for i:=0 to 13 do  begin
  n1[i]:=0;
  s1[i]:=0;
  sr1[i]:=0;
end;

end;


procedure dk(s:integer);
var i,j,k,n:integer; f:string; b,b1:real;
begin
SetLength(rash,2,Form1.StringGrid1.RowCount);
FormatSettings.DecimalSeparator:='.';
    k:=8;
    j:=0;
      if s<10 then f:='0'+inttostr(s)
      else
      f:=inttostr(s);

for i:= 0 to Form1.StringGrid1.RowCount do begin
      //array[�������,������]
        if form1.stringGrid1.Cells[k,i]= f then begin
          rash[0,j]:=strtofloat(zero(form1.stringGrid1.Cells[k-7,i]));
          rash[1,j]:=strtofloat(form1.stringGrid1.Cells[k+23,i]);
          inc(j);
        end

end;

//���� �� �������,��������� ������
  for i:=0 to j-2 do
  for n:=i+1 to j-1 do
  if rash[0,i]>rash[0,n] then begin
  //��������� �� 0 �������
  b:=rash[0,i];
  rash[0,i]:=rash[0,n];
  rash[0,n]:=b;
  //������������ ������ � ��� 1-�
   b1:=rash[1,i];
  rash[1,i]:=rash[1,n];
  rash[1,n]:=b1;
  end;
  //��������-����� � ����
// for i := 0 to j-1 do
 // form1.Memo2.Lines.Add(rash[0,i]+' '+rash[1,i]);
  /////////////////////////
//
smlst(rash,j,s);
SetLength(rash,0,0);
Finalize(rash);
//FillChar(rash, SizeOf(rash), #0);
end;

procedure TForm1.N10Click(Sender: TObject);
var i:integer;
begin
   for i:= 1 to Form1.StringGrid2.ColCount-1 do
   try
    dk(i);
   except
    on E : Exception do
      ShowMessage(E.ClassName+' ������ � ���������� : '+E.Message+' ���������� ����� '+inttostr(i));
   end;

     form1.Caption:=form1.Caption+ ' - ��������';
     Button3.Enabled:=true;
end;


end.

