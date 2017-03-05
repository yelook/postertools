unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TForm2 = class(TForm)
    img1: TImage;
    procedure CLOS(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}


procedure TForm2.CLOS(Sender: TObject; var Action: TCloseAction);
begin
   Form2:=nil;           //Form对象指向空地址
  Action := cafree;     //Form关闭后释放占用的内存
end;

end.
