unit UFileSystem;

interface

uses
    SysUtils, Windows, SHFolder;

//
// �������� ���������� � ���������� �� ���������� ��������������
function GetSpecialFolderPath (FolderName: integer): string;

//
// ��������, ���� �� ����� �� ������ � ����������
function IsDirWritable (FolderName: string): boolean;

//
// ����������� ���� (� ��������� � �����) �� ����� ����������
function DirToPath (DirName: string): string;

implementation

//
// �������� ���������� � ���������� �� ���������� ��������������
//
function GetSpecialFolderPath (FolderName: integer): string;
var
    path: array [0..MAX_PATH] of char;
begin
    // �������� �������� ����, � ������ ������ - ���������� ������ ������
    if Succeeded (SHGetFolderPath (0, FolderName, 0, 0, @path[0]))
        then Result := path
        else Result := '';
end;

//
// ��������, ���� �� ����� �� ������ � ����������
//
function IsDirWritable (FolderName: string): boolean;
var
    testFile: file;
    testFileName: string;
begin
    // ��������� ����������
    FolderName := ExtractFileDir (FolderName);
    testFileName := DirToPath (FolderName) + 'ingame-test-dir-file';
    if (DirectoryExists (FolderName)) then begin
        AssignFile (testFile, testFileName);
        try
            // �������� ������� ���� �� ������, �������� ��������� �� �������
            {$I-}
            Rewrite (testFile);
            {$I+}
            // �� ���������� ���������� �������� �� ������ � ����������
            if IOResult <> 0
                then Result := false
                else Result := true;
        finally
            // ��������� ����� �����, ���� �� ������
            if TFileRec(testFile).Mode <> fmClosed
                then CloseFile (testFile);
            // ������� ��������� ����, ���� �� ��� ������
            if FileExists (testFileName)
                then DeleteFile (PChar (testFileName));
        end;
    end else
        Result := false;
end;

//
// ����������� ���� (� ��������� � �����) �� ����� ����������
//
function DirToPath (DirName: string): string;
begin
    if (DirName [StrLen (PChar (DirName))] = '\')
        then Result := DirName
        else Result := DirName + '\';
end;

end.
