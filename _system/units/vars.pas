unit vars;

interface

type
    // ���������� �� �����
    TGameInfo1 = Record
        fullGameName: string;

        isInstalled:  boolean;

        gamePath:     string;
        version:      string;
    end;

    // �������������� ���� (��������)
    TGameList = Record
        bf2:    TGameInfo1;
        cod4:   TGameInfo1;
        cs:     TGameInfo1;
        wow:    TGameInfo1;
    end;

    TCopyDataType = (cdtArray = 0);

const
    // ���������� ID
    programGUID = '{A3AECEB2-860B-49A5-BDA6-B191E48CFE48}';

    // ��� ����� ��������
    settingsFileName = 'settings.ini';

    // ��� ����� � ����������� �� �����
    gamesInfoFileName = 'games.ini';

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
