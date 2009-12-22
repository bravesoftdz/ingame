unit UVars;

interface

type
    TCopyDataType = (cdtArray = 0);
    TGames = (gamesBF2, gamesCOD4, gamesCS, gamesWOW);
    Games = set of TGames;

const
    // ���������� ID
    programGUID = '{A3AECEB2-860B-49A5-BDA6-B191E48CFE48}';

    // ������ ��������
    // ���� ��������
    mSettings_iniMain = 'settings.ini';
    // ���� � ����������� �� �����
    mSettings_iniGames = 'games.ini';

    // ������ ������������
    // ���� ������
    mCrypt_keysDBFileName = 'keys.db';
    // ������ ����� ������
    mCrypt_keysFileSize = 64 * 1024;
    // ������ ��� ��������� ������
    offset_SettingsPasswords = $000100; // 32b to $00011F

    // ����� � ����������� � �������
    regFolder = 'Software\SevGames.net';
    regInGameFolder = regFolder + '\InGame';


    // ���������� � ������:
    // ������� ����� ����������
    formMainCN = 'TFMain';
    formMainWN = 'InGame';
    // ����� Launcher'a
    formLauncherCN = 'TFLauncher';
    formLauncherWN = 'FLauncher';

resourcestring
    // ������ ��� ���������� �������, �� ����������� ����
    errCantAccess = '������� ���������� �����. ������ #IG00001.';
    errCantAccessText = '������� ���������� ����� ���������, �� � ��� ���������� �������� ������.' + #10#13#10#13 +
                        '���������, ��� ��������� �� �������� �� ������� ������������.';

implementation

end.
