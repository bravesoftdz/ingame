unit WSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinProvider, ComCtrls, sPageControl, StdCtrls, Mask, sMaskEdit, sCustomComboEdit,
  sTooledit, sLabel, ExtCtrls, sPanel, sTreeView, sGroupBox, Buttons, sSpeedButton, acAlphaHints,
  sRadioButton, sEdit, sComboBox, sFileCtrl;

type
    TFSettings = class(TForm)
        sSkinProvider: TsSkinProvider;
        pagesSettings: TsPageControl;
            pageBF2: TsTabSheet;
                labelPageCaption: TsLabelFX;
                grpPaths: TsGroupBox;
                    editBF2Exe: TsFilenameEdit;
                grpParams: TsGroupBox;
                    labelParamsInfo: TsLabel;
                    rbUseCustomParams: TsRadioButton;
                    rbUseSettings: TsRadioButton;
                    editPlayerName: TsEdit;
                    editPlayerPassword: TsEdit;
                    editCustomParams: TsEdit;
            pageCOD4: TsTabSheet;
            pageCS: TsTabSheet;
            pageWOW: TsTabSheet;

        sSpeedButton1: TsSpeedButton;
        sAlphaHints: TsAlphaHints;

        procedure FormCreate(Sender: TObject);
        // ��������� ������ � �������� �� �������������� �����
        procedure pagesSettingsDrawTab (Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
        // ������������ ��������� ����� ����� � ����������� �� ���������
        procedure settingsChangeParamsMethod(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

implementation

uses
    WMain;

{$R *.dfm}

procedure TFSettings.FormCreate(Sender: TObject);
begin
    sAlphaHints.Templates := FMain.sAlphaHints.Templates;
    sAlphaHints.TemplateName := 'Win7';
end;

// ��������� ������ � �������� �� �������������� �����
procedure TFSettings.pagesSettingsDrawTab (Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
    tabCaption: string;
    tabImgIndex: Integer;
    imgCenter: TPoint;
begin
    // ������������� ���������� ��� ��� �����
    Control.Canvas.Brush.Style := bsClear;

    // ���������� ��������� ���� � ��� ������
    with pagesSettings.Pages[TabIndex] do begin
        tabCaption := Caption;
        tabImgIndex := ImageIndex;
    end;

    // ������������ ������� ������ ������ �� ����
    imgCenter.Y := Rect.Top + ((Rect.Bottom - Rect.Top) div 2);
    imgCenter.X := Rect.Left + ((Rect.Bottom - Rect.Top) div 2);

    // ������ ������ � �����
    with FMain.imgGamesIconsX32 do begin
        Draw (Control.Canvas, imgCenter.X - (Width div 2), imgCenter.Y - (Height div 2), tabImgIndex);
        Control.Canvas.TextOut (imgCenter.X + (Width div 2) + 8, imgCenter.Y - (Control.Canvas.TextHeight (tabCaption) div 2), tabCaption);
    end;
end;

// ������������ ��������� ����� ����� � ����������� �� ���������
procedure TFSettings.settingsChangeParamsMethod (Sender: TObject);
begin
    editCustomParams.Enabled := rbUseCustomParams.Checked;
    editPlayerName.Enabled := rbUseSettings.Checked;
    editPlayerPassword.Enabled := rbUseSettings.Checked;
end;

end.
