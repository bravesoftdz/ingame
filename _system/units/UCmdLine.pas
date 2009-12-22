unit UCmdLine;

interface

uses
    { Vcl: }    Windows, SysUtils,
    { Self: }   UVars;

type
    TCCmdLine = class (TObject)
    private
        // ������ ����������
        params: array of string;
        fullParamStr: string;
        SilentMode: boolean;

        // ��������� ���������� � ����������� �� ���������� ���. ������
        procedure SetOptions (param: string; index: integer = -1);
    public
        // �����������
        constructor Create ();

        // ����������� ���������� ����������
        function ParamsCount: integer;
        // �������� �� "��������� �����"
        function IsSilentMode: boolean;
        // ���������� ParamMsg
        function ParamMsgPrepare (): TCopyDataStruct;
    end;

implementation

const
    paramPrefix = '--';
    paramSilentKey = 'silent';

//  �����������
constructor TCCmdLine.Create;
var
    I: integer;
begin
    { TODO : �����������, ����� �� ��� FullParamStr }
    fullParamStr := '';
    // ��������� ��� ��������� � ������ ��
    for I := 0 to System.ParamCount do begin
        // ��������� ������ ����������
        SetLength (params, Length (params) + 1);
        params [I] := LowerCase (paramStr (I));
        // ��������� ������ ����������
        fullParamStr := ' ' + fullParamStr + params [I];
        // ���������� ����� ���������
        SetOptions (params [I], I);
    end;
end;

//  ��������� ����� ������� �� ����������
procedure TCCmdLine.SetOptions (param: string; index: integer = -1);
begin
    if (param = paramPrefix + paramSilentKey) then
        SilentMode := true;
end;

//  ����������� ���������� ����������
function TCCmdLine.ParamsCount;
begin
    Result := Length (params);
end;

//  �������� �� "��������� �����"
function TCCmdLine.IsSilentMode;
begin
    Result := SilentMode;
end;

//  ���������� ParamMsg
function TCCmdLine.ParamMsgPrepare: TCopyDataStruct;
begin
    Result.dwData := Integer (cdtArray);
    Result.cbData := SizeOf (params);
    Result.lpData := @params;
end;

end.
