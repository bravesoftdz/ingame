unit UOneInstance;

interface

uses
    { Vcl: }    Windows, SysUtils,
    { Self: }   UVars;

type
    TInstanceDataSender = class (TObject)
    private
        // ����� ���� ������ �����
        CopyMFHandle: HWnd;
    public
        constructor Create ();

        function CanAccessReceiver: boolean;
        function SendData (SenderHandle: HWnd): boolean;
        procedure RestartIfNeed;
    end;

var
    // ����� � ��� �������
    Mutex: THandle;
    MName: array [0..255] of char;

    // ������������� ������ ���������� �����
    AnotherCopyRunning: boolean;

implementation

uses
    UCmdLine;

//   ������� �������� ������������� ����� ���������
//   Result: true, ���� ����� ��������
function IsInstance: boolean;
begin
    // ���������� GUID � �������� �����
    // ��� WinNT ������ 4 - ��������� ���������� ������� (Win95/98 �� ��������)
    if ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion > 4))
        then MName := 'Global\' + programGUID
        else MName := programGUID;
    Mutex := CreateMutex (nil, false, MName);

    // ���������� true ���� �� ������� �������
    Result := ((Mutex = 0) or (GetLastError = ERROR_ALREADY_EXISTS) or (GetLastError = ERROR_ACCESS_DENIED));
end;

//  �����������
//  ��� �������� ������� ����� ���������� ����� (��. �����)
constructor TInstanceDataSender.Create;
begin
    CopyMFHandle := FindWindow (formMainCN, formMainWN);
end;

//  �������� �� ����������� �����
//  ������ false, � ������ ���� ������� ��� (����. �������� �� ������� ������������)
function TInstanceDataSender.CanAccessReceiver: boolean;
begin
    Result := (CopyMFHandle <> 0);
end;

//  ������� ������ � ���������� �����
//  �������� ������ �� ������ CmdLine, � ���������� ��
function TInstanceDataSender.SendData (SenderHandle: HWnd): boolean;
const
    WM_COPYDATA = $004A; // ����������, ����� �� ���������� Messages
var
    Data: TCopyDataStruct;
    CCmdLine: TCCmdLine;
    SendResult: Byte;
begin
    // �������������� ����� ���. ������ � ���������� ������
    CCmdLine := TCCmdLine.Create;
    try
        Data := CCmdLine.ParamMsgPrepare;
        SendResult := SendMessage (CopyMFHandle, WM_COPYDATA, Integer (SenderHandle), Integer (@Data));
    finally
        FreeAndNil (CCmdLine);
        Result := (SendResult <> 0);
    end;
end;

//  ������ �� ���������� ���������
//  � ������ ������������� ������������� - ���������� ��������� ����� �������
procedure TInstanceDataSender.RestartIfNeed;
var
    Answer: Integer;
begin
    Answer := MessageBox (0, PChar (errCantAccessText), PChar (errCantAccess), MB_RETRYCANCEL or MB_ICONERROR);
    if (Answer = idRetry)
        then WinExec (GetCommandLineA, SW_SHOWNORMAL);
end;

//  ��������� � �������� ���������
initialization

    // �� ������ ������������� ������������� ����
    if (IsInstance)
        then AnotherCopyRunning := true
        else AnotherCopyRunning := false;

finalization

    // ����������� ������, ���� �� ��� ������
    if (Mutex <> 0) then
        CloseHandle (Mutex);

end.
