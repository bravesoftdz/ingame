program InGame;

{$define UseCustomUses}
{$ifdef UseCustomUses}
uses
    {$ifdef Debug}
        { FastMM: } FastMM4,
    {$endif}
    { PreCheck: }
    UOneInstance    in '_system\units\UOneInstance.pas',

    { Vcl: } Forms, Windows, SysUtils,

    { Self: }
    { NotObject: }
    vars            in '_system\units\vars.pas',

    { Forms: }
    WMain           in '_system\forms\WMain.pas' {FMain},
    WLauncher       in '_system\forms\WLauncher.pas' {FLauncher},
    WSettings in '_system\forms\WSettings.pas' {FSettings},

    { Objects: }
    USettings       in '_system\units\USettings.pas',
    UCmdLine        in '_system\units\UCmdLine.pas',
    UGraphic        in '_system\units\UGraphic.pas',

    { Common Functions: }
    ULocalization   in '_system\units\formtools\ULocalization.pas';

{$else}{$region 'System Units'}
uses
  UOneInstance in '_system\units\UOneInstance.pas',
  Forms,
  Windows,
  Messages,
  Dialogs,
  SysUtils,
  vars in '_system\units\vars.pas',
  WMain in '_system\forms\WMain.pas' {FMain},
  WLauncher in '_system\forms\WLauncher.pas' {FLauncher},
  USettings in '_system\units\USettings.pas',
  UCmdLine in '_system\units\UCmdLine.pas',
  UGraphic in '_system\units\UGraphic.pas',
  WSettings in '_system\forms\WSettings.pas' {FSettings},
  ULocalization in '_system\units\formtools\ULocalization.pas';

{$endregion}{$endif}

// �������������� PE-����� ��� Release-�����
{$ifdef Release}{$I _includes\peflags.inc.pas}{$endif}
// �������
{$ifndef NoDFM}{$R *.res}{$endif}

var
    CInstanceDataSender: TInstanceDataSender;

begin
    {$ifdef Debug}
        ReportMemoryLeaksOnShutdown := DebugHook <> 0;
    {$endif}

    // �������������
    Application.Initialize;

    // ���� ���������� ������ ����� - �������� ��� ��������� ��, ����� �����������
    if (AnotherCopyRunning) then begin
        CInstanceDataSender := TInstanceDataSender.Create;
        try
            if (CInstanceDataSender.CanAccessReceiver)
                then CInstanceDataSender.SendData (Application.Handle)
                else CInstanceDataSender.RestartIfNeed;
        finally
            FreeAndNil (CInstanceDataSender);
        end;

        Application.Terminate;
    end else begin
        // ������������� �����
        Application.MainFormOnTaskbar := false;
        Application.ShowMainForm := false;
        Application.Title := 'InGame';

        // ������� � ������ ������� �����
        Application.CreateForm(TFMain, FMain);
        ShowWindow (Application.Handle, SW_HIDE);

        // ������ �������� �����
        Application.Run;
    end;

end.
