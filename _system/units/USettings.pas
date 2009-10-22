unit USettings;

interface

uses
    { Vcl: }    Registry, IniFiles, SysUtils, Dialogs, Windows, SHFolder,
    { Self: }   Vars;

type
    TGameInfo = Record
        Name:         string;
        isInstalled:  boolean;
        gamePath:     string;
        version:      string;
        constructor Create (var IniFile: TIniFile; var Reg: TRegistry; const SecName: string);
    end;

    TCSettings = class (TObject)
        // ���������
        workDir:    string;
        workPath:   string;
        Games:      TGameList;

        sLauncher: packed record
            ShowOnStart: boolean;
            PositionLeft: SmallInt;
            PositionTop: SmallInt;
        end;

        sGameList: record
            bf2:    TGameInfo;
            cod4:   TGameInfo;
            cs:     TGameInfo;
            wow:    TGameInfo;
        end;

        // Procedures
        procedure LoadSettings ();
        //procedure SaveSettings ();

        procedure LoadGamesSettings ();
        //procedure SaveGamesSettings ();
    public
        constructor Create ();
    end;

implementation

uses
    WLauncher;

//  ����������� ������� ��������
//  ����� ������� �������� �������� �� ������, ����������� ����������
constructor TCSettings.Create ();
begin
    inherited Create ();

    Self.workDir  := ExtractFileDir  (ParamStr (0));
    Self.workPath := ExtractFilePath (ParamStr (0));

    LoadSettings ();
    LoadGamesSettings ();
end;

//  �������� �������� ��������� �� ����� ������������ / �������
procedure TCSettings.LoadSettings;
var
    IniFile: TIniFile;
begin
    // ��������� ������������� ����� ��������
    if (not FileExists (workPath + settingsFileName)) then exit;

    IniFile := TIniFile.Create (workPath + settingsFileName);

    try
        sLauncher.ShowOnStart       := IniFile.ReadBool    ('Launcher', 'ShowOnStart', true);
        sLauncher.PositionLeft      := IniFile.ReadInteger ('Launcher', 'PositionLeft', -1);
        sLauncher.PositionTop       := IniFile.ReadInteger ('Launcher', 'PositionTop', -1);
    finally
        FreeAndNil (IniFile);
    end;

end;

//  �������� �������� ��� �� ����� ������������ / �������
procedure TCSettings.LoadGamesSettings;
var
    IniFile: TIniFile;
    Reg: TRegistry;
begin
    // ��������� ������������� ����� ��������
    //if (FileExists (workPath + gamesInfoFileName))
    //    then IniFile := TIniFile.Create (workPath + gamesInfoFileName)
    //    else IniFile := nil;

    Reg := TRegistry.Create (KEY_READ);

    FreeAndNil (IniFile);
    FreeAndNil (Reg);
end;

{ TGameInfo }

constructor TGameInfo.Create (var IniFile: TIniFile; var Reg: TRegistry; const SecName: string);
begin

end;

end.
