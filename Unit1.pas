unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, Math;

type
  TForm1 = class(TForm)
    Button1: TButton;
    memo1: TMemo;
    memo2: TMemo;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Button2: TButton;
    Button3: TButton;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure yes(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ys(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure alls(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Unit2;

{$R *.dfm}
procedure TForm1.Button1Click(Sender: TObject);
var
  pojo, c, temp, c1, res, npojo, serial, zhenbaowen: string;
  j, fen, t1, i, baowen, baowen2: integer;
  zhu1, zhu2, zhu3, finzhu, finzhu1, fenhao, pri,kong,cha1: integer;
  duan1,xx,jie1,jie2: string;
begin
  statusbar1.Panels[0].Text := '������';
  Randomize;
  serial := inttostr(random(99999999));
  pojo := memo1.Text;
  temp := pojo;
//�Զ��жϱ�������
  baowen := pos('extends', pojo);
  baowen2 := pos('{', pojo);
  zhenbaowen := trim(copy(pojo, baowen + 7, baowen2 - baowen - 7));
  if zhenbaowen = 'BaseNormalReqPojo' then
  begin
    npojo := '"bizDate":"20170707",' + #13#10 + '"bizTime":"150128",' + #13#10 + '"serialNo":"' + serial + '",' + #13#10#13#10;
  end
  else if zhenbaowen = 'BasePayReqPojo' then
  begin
    npojo := '"bizDate":"20170707",' + #13#10 + '"bizTime":"150128",' + #13#10 + '"serialNo":"' + serial + '",' + #13#10 + '"transOrgNo":"100",' + #13#10 + '"accountOrgNo":"100",' + #13#10 + '"custNo":"10010",' + #13#10#13#10;
  end
  else if zhenbaowen = 'BaseQueryReqPojo' then
  begin
    npojo := '"bizDate":"20170707",' + #13#10 + '"bizTime":"150128",' + #13#10 + '"serialNo":"' + serial + '",' + #13#10 + '"transOrgNo":"100",' + #13#10#13#10;
  end;
  if radiobutton1.Checked then
  begin
    npojo := '"bizDate":"20170707",' + #13#10 + '"bizTime":"150128",' + #13#10 + '"serialNo":"' + serial + '",' + #13#10#13#10;
  end;
  if radiobutton2.Checked then
  begin
    npojo := '"bizDate":"20170707",' + #13#10 + '"bizTime":"150128",' + #13#10 + '"serialNo":"' + serial + '",' + #13#10 + '"transOrgNo":"100",' + #13#10 + '"accountOrgNo":"100",' + #13#10 + '"custNo":"10010",' + #13#10#13#10;
  end;
  if radiobutton3.Checked then
  begin
    npojo := '"bizDate":"20170707",' + #13#10 + '"bizTime":"150128",' + #13#10 + '"serialNo":"' + serial + '",' + #13#10 + '"transOrgNo":"100",' + #13#10#13#10;
  end;

  res := '{' + #13#10 + npojo;
  repeat
    j := pos('private ', pojo);
    if j = 0 then
      break;
    fen := pos(';', pojo);
    c := trim(copy(pojo, j + 7, fen - j - 7));
    t1 := pos(' ', c);
    c1 := trim(copy(c, 0, t1));
    i := 0;
    if ((c1 <> 'static') and (c1 <> '')) then
    begin
      res := res + '"' + trim(copy(c, t1, length(c) - t1 + 1)) + '":"",' + #13#10;
      i := i + 1;
    end;
    delete(pojo, 1, fen);
  until j = 0;
  delete(res, length(res) - 2, 1);
  res := res + '}';
  statusbar1.Panels[0].Text := '�ɹ�';
  statusbar1.Panels[1].text:='�ţ�ȷʵ�ɹ���';
  if (trim(res) = '}') then
  begin
    statusbar1.Panels[0].Text := 'ʧ��';
    statusbar1.Panels[1].Text := '������õļ�pojo';
    res := '{}';
  end;
// �˴�����ע�������
  repeat
  zhu1 := Pos('@NotNull', temp);
  zhu2 := Pos('@NotEmpty', temp);
  zhu3 := Pos('@NotBlank', temp);
  if (zhu1 = 0) then
    zhu1 := zhu2 + zhu3;
  if (zhu2 = 0) then
    zhu2 := zhu1 + zhu3;
  if (zhu3 = 0) then
    zhu3 := zhu2 + zhu1;
  finzhu1 := Min(zhu1, zhu2);
  finzhu := Min(finzhu1, zhu3);
  if (finzhu <> 0) then
  begin
    Delete(temp, 1, finzhu);
    fenhao := Pos(';', temp);
    pri := Pos('private ', temp);
    duan1 := copy(temp, 1, fenhao);
    xx:=Trim(Copy(duan1,pri+7,Length(duan1)-pri-7));
    kong := Pos(' ',xx);
    xx := trim(copy(xx, kong, length(xx)-kong+1));
    cha1 := Pos(xx,res);
    jie1 := Copy(res,1,cha1+length(xx)+2);
    jie2 := Copy(res,cha1+length(xx)+3,Length(res)-cha1+length(xx));
    res:= jie1+'����'+jie2;
  end;
  until finzhu = 0;
  memo2.Text := res;
end;

procedure TForm1.yes(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = 65) then
    Memo1.SelectAll;
end;

procedure TForm1.ys(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = 83) then
    button1.Click;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  radiobutton4.Checked := true;
  statusbar1.Panels[0].Text := '����';
  statusbar1.Panels[1].Text := '����Pojo���Ϸ�����json��ʽ����.������ƿ����Pojo�����Ʊ��ĵ����а�';
end;

procedure TForm1.alls(Sender: TObject);
begin
  memo1.SelectAll;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if not assigned(Form2) then
  begin
    Form2 := TForm2.Create(nil);
    Form2.Show;
  end
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  memo2.SelectAll;
  memo2.CopyToClipboard;
  memo1.Clear;
  statusbar1.Panels[0].Text := '���Ƴɹ�';
  statusbar1.panels[1].text := 'û��ȷʵ���Ƴɹ���';
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  statusbar1.Panels[0].Text := '����';
  statusbar1.Panels[1].Text := '���� bizDate/bizTime/serialNo ��ˮ���������';
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  statusbar1.Panels[0].Text := '����';
  statusbar1.Panels[1].Text := '���� bizDate/bizTime/serialNo/transOrgNo/accountOrgNo/custNo ��ˮ���������';
end;

procedure TForm1.RadioButton3Click(Sender: TObject);
begin
  statusbar1.Panels[0].Text := '����';
  statusbar1.Panels[1].Text := '���� bizDate/bizTime/serialNo/transOrgNo ��ˮ���������';
end;

end.


