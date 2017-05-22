pageextension 70000000 CompanyInformationExtension extends "Company Information"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast("System Settings")
        {
            action("Enable Dynamics 365 Mode")
            {
                Promoted = true;
                PromotedCategory = Category4;
                Image = EnableBreakpoint;
                ApplicationArea = All;
                Visible = NOT IsD365ModeEnabled;
                trigger OnAction();
                begin
                    Validate(EnableD365Mode, true);
                    modify;
                    CurrPage.Update;
                end;
            }

            action("Disable Dynamics 365 Mode")
            {
                Promoted = true;
                PromotedCategory = Category4;
                Image = DisableBreakpoint;
                ApplicationArea = All;
                Visible = IsD365ModeEnabled;
                trigger OnAction();
                begin
                    Validate(EnableD365Mode,false);
                    modify;
                    CurrPage.Update;
                end;
            }

        }
    }

    trigger OnAfterGetRecord();
    begin
        IsD365ModeEnabled := EnableD365Mode;
    end;

    var
    [InDataSet]
    IsD365ModeEnabled: Boolean;

}