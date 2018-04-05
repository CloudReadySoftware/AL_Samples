page 50002 "Item Classification Wizard"
{
    PageType = NavigatePage;
    SourceTable = "Item Classification";

    layout
    {
        area(content)
        {
            group("<MediaStandard>")
            {
                Editable = false;
                visible = TopBannerVisible AND NOT SecondStepVisible;
                field("MediaRepositoryStandard.Image"; MediaRepositoryStandard.Image)
                {
                    Editable = false;
                    ShowCaption = false;
                    ApplicationArea = Basic, Suite;
                }
            }
            group("<MediaDone>")
            {
                Editable = false;
                visible = TopBannerVisible AND SecondStepVisible;

                field("MediaRepositoryDone.Image"; MediaRepositoryDone.Image)
                {
                    Editable = false;
                    ShowCaption = false;
                    ApplicationArea = Basic, Suite;
                }
            }
            group(FirstStep)
            {
                Visible = FirstStepVisible;

                group(Welcome)
                {
                    InstructionalTextML = ENU = 'Welcome';
                }
                group(DataExists)
                {
                    Visible = TablehasData;
                    InstructionalTextML = ENU = 'there is already data in the Item Classification Table';
                }
                group(DataEmpty)
                {
                    Visible = NOT TablehasData;
                    InstructionalTextML = ENU = 'There is no data in the Item Classification table, so we have provided some default values. Click Next and review the data.';
                }
            }
            group(SecondStep)
            {
                Visible = SecondStepVisible;

                repeater(ItemClassificationData)
                {
                    Visible = true;

                    field("Code"; "Code") { }
                    field(Description; Description) { }
                    field("Minimum Sales Count"; "Minimum Sales Count") { }
                    field("Warning"; "Warning") { }

                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            Action(ActionBack)
            {
                CaptionML = ENU = 'Back';
                Enabled = BackActionEnabled;
                Image = PreviousRecord;
                InFooterBar = true;
                ApplicationArea = Basic, Suite;

                trigger OnAction();
                begin
                    NextAction(TRUE);
                end;
            }
            Action(ActionNext)
            {
                CaptionML = ENU = 'Next';
                Enabled = NextActionEnabled;
                image = NextRecord;
                InFooterBar = true;
                ApplicationArea = Basic, Suite;

                trigger OnAction();
                begin
                    NextAction(FALSE);
                end;
            }
            Action(ActionFinish)
            {
                CaptionML = ENU = 'Finish';
                Enabled = FinishActionEnabled;
                image = Approve;
                InFooterBar = true;
                ApplicationArea = Basic, Suite;

                trigger OnAction();
                begin
                    FinishAction;
                end;
            }
        }

    }

    trigger OnInit();
    begin
        LoadTopBanners;
    end;

    trigger OnOpenPage();
    begin
        Step := Step::First;
        EnableControls;
    end;

    var
        [InDataSet]
        FirstStepVisible: Boolean;
        [InDataSet]
        SecondStepVisible: Boolean;
        [InDataSet]
        TablehasData: boolean;
        Step: Option First,Second;
        [InDataSet]
        BackActionEnabled: Boolean;
        [InDataSet]
        NextActionEnabled: Boolean;
        [InDataSet]
        FinishActionEnabled: Boolean;
        MediaRepositoryStandard: Record "Media Repository";
        MediaRepositoryDone: record "Media Repository";
        [InDataSet]
        TopBannerVisible: Boolean;

    local procedure ResetControls();
    begin
        FinishActionEnabled := TRUE;
        BackActionEnabled := TRUE;
        NextActionEnabled := TRUE;
        FirstStepVisible := FALSE;
        SecondStepVisible := FALSE;

    end;

    local procedure EnableControls();
    begin
        ResetControls;
        CASE Step of
            Step::First:
                ShowFirstStep;
            Step::Second:
                ShowSecondStep;

        END;
    end;

    local procedure ShowFirstStep();
    var
        ItemClassification: record "Item Classification";
    begin
        FirstStepVisible := TRUE;
        IF ItemClassification.ISEMPTY THEN BEGIN
            TableHasData := FALSE;
            FinishActionEnabled := FALSE;
            BackActionEnabled := FALSE;

            ItemClassification.InsertDefaultValues;
        END ELSE BEGIN
            TableHasData := TRUE;
            NextActionEnabled := FALSE;
            BackActionEnabled := FALSE;
        END;
    end;

    local procedure ShowSecondStep();
    begin
        SecondStepVisible := TRUE;
        NextActionEnabled := FALSE;
        BackActionEnabled := FALSE;
    end;

    local procedure NextAction(Backwards: Boolean);
    begin
        if Backwards then
            Step := Step - 1
        ELSE
            Step := Step + 1;
        EnableControls;
    end;

    local procedure FinishAction();
    begin
        CurrPage.CLOSE;
    end;

    LOCAL PROCEDURE LoadTopBanners();
    begin
        IF MediaRepositoryStandard.GET('AssistedSetup-NoText-400px.png', FORMAT(CURRENTCLIENTTYPE)) AND
            MediaRepositoryDone.GET('AssistedSetupDone-NoText-400px.png', FORMAT(CURRENTCLIENTTYPE))
        THEN
            TopBannerVisible := MediaRepositoryDone.Image.HASVALUE;
    end;

}