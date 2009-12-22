unit UInstallation;

interface

//  ��������� ������������� ���������
procedure InstallSelf;
//  �������� ����� ������
procedure CreateKeysFile (filename: string);

implementation

uses
    { Vcl: }        SysUtils,
    { Self: }       WMain, USettings, UVars, UFileSystem, UCRC32,
    { LockBox: }    LbCipher, LbUtils;

//  ��������� ������������� ���������
//  �������� � ����:
//      1. ��������� ����� ������
procedure InstallSelf;
begin
    { TODO: ������� �������� �� ������ � ����������. ����� ������������ ����� �������������� }
    if (not FileExists (ExtractFilePath (ParamStr (0)) + mCrypt_keysDBFileName))
        then CreateKeysFile (ExtractFilePath (ParamStr (0)) + mCrypt_keysDBFileName);
end;

//  �������� ����� ������
//  ���� ������������ �� ���� ������������������ �� 1�� ����
//  ������� ������ � ��� ������������ �������� ���������� � ������ ����������
procedure CreateKeysFile (filename: string);
var
    F: file of byte;
    FullLength: integer;
    Buffer: array [0..4095] of Byte;
    i, j: Cardinal;
    Crc32: Cardinal;
    SHA1: TSHA1Digest;
begin
    // ������������� ��������� ����������
    Randomize;
    Crc32 := $FFFFFFFF;
    FullLength := mCrypt_KeysFileSize;
    AssignFile (F, filename);
    try
        Rewrite (F);
        // ���������� ���������� ����
        // ���������� ������ - �� 1 ������ ������������ ��� ������� ������
        for i := 1 to (Round (FullLength / Length (Buffer)) - 1) do begin
            // ��������� ������
            for j := 0 to Length (Buffer) - 1 do
                Buffer [j] := Random (256);
            BlockWrite (F, Buffer [0], Length (Buffer));
            // ��������� CRC
            Crc32 := GetBlockCRC32 (Crc32, Addr (Buffer [0]), Length (Buffer));
        end;
        // �������� �������� ������� CRC � ��� SHA1-���
        Crc32 := not Crc32;
        StringHashSHA1 (SHA1, IntToHex (Crc32, 8));
        // ���������� � ����� ��������� ����: ��������� ����� + SHA1 �� CRC32
        for j := 0 to (Length (Buffer) - Length (SHA1) - 1) do
            Buffer [j] := Random (High (Byte));
        BlockWrite (F, Buffer [0], Length (Buffer) - Length (SHA1));
        BlockWrite (F, SHA1, Length (SHA1));
    finally
        CloseFile (F);
    end;
    //ShowMessage ('File CRC: ' + IntToHex (Crc32, 8) + #10#13 + 'File SHA1: ' + BufferToHex (SHA1, Length (SHA1)));
end;

end.
