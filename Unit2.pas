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
   Form2:=nil;           //Form����ָ��յ�ַ
  Action := cafree;     //Form�رպ��ͷ�ռ�õ��ڴ�
end;

end.
