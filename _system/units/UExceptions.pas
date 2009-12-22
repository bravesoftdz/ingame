unit UExceptions;

interface

type
    TErrorNames = (errnameTest, errnameNoKeysFileExists);

var
    StartedSuccessfully: Boolean = true;

procedure SimpleErrorShow (ErrorName: TErrorNames; IsCritical: Boolean);

implementation

uses
    WMain, Windows, Forms;

resourcestring
    error_Test_Caption = 'This is Test Error !';
    error_Test_Content = 'This error is specially for testing...'#10#13'Nothing Happend !';

    error_NoKeysFileExists_Caption = '������ ����� ������';
    error_NoKeysFileExists_Content = '���� ������ �� ���������� ��� �������� ������.' + #10#13 +
                                     '����������, �������������� ��������� ��� ��������� ������� ������������� �� �������� ����';

procedure SimpleErrorShow (ErrorName: TErrorNames; IsCritical: Boolean);
var
    errCaption: string;
    errContent: string;
begin
    case ErrorName of
        errnameTest: begin
            errCaption := error_Test_Caption;
            errContent := error_Test_Content;
        end;
        errnameNoKeysFileExists: begin
            errCaption := error_NoKeysFileExists_Caption;
            errContent := error_NoKeysFileExists_Content;
        end;
    end;

    if IsCritical then begin
        Application.MessageBox(PChar (errContent), PChar (errCaption), MB_OK + MB_ICONSTOP);
        StartedSuccessfully := false;
    end else
        Application.MessageBox(PChar (errContent), PChar (errCaption), MB_OK + MB_ICONWARNING);
end;


end.
