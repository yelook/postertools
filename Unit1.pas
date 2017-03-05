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
  statusbar1.Panels[0].Text := '生成中';
  Randomize;
  serial := inttostr(random(99999999));
  pojo := memo1.Text;
  temp := pojo;
//自动判断报文类型
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
  statusbar1.Panels[0].Text := '成功';
  statusbar1.Panels[1].text:='嗯，确实成功了';
  if (trim(res) = '}') then
  begin
    statusbar1.Panels[0].Text := '失败';
    statusbar1.Panels[1].Text := '你好像用的假pojo';
    res := '{}';
  end;
// 此处增加注解的搜索
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
    res:= jie1+'必填'+jie2;
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
  statusbar1.Panels[0].Text := '就绪';
  statusbar1.Panels[1].Text := '复制Pojo到上方生成json格式报文.点击复制可清除Pojo并复制报文到剪切板';
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
  statusbar1.Panels[0].Text := '复制成功';
  statusbar1.panels[1].text := '没错，确实复制成功了';
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  statusbar1.Panels[0].Text := '就绪';
  statusbar1.Panels[1].Text := '包含 bizDate/bizTime/serialNo 流水号随机生成';
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  statusbar1.Panels[0].Text := '就绪';
  statusbar1.Panels[1].Text := '包含 bizDate/bizTime/serialNo/transOrgNo/accountOrgNo/custNo 流水号随机生成';
end;

procedure TForm1.RadioButton3Click(Sender: TObject);
begin
  statusbar1.Panels[0].Text := '就绪';
  statusbar1.Panels[1].Text := '包含 bizDate/bizTime/serialNo/transOrgNo 流水号随机生成';
end;

end.


