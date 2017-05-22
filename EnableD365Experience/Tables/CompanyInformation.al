tableextension 70000000 CompanyInformationExtension extends "Company Information"
{
    fields
    {
        field(70000000;EnableD365Mode;Boolean)
        {
            CaptionML = ENU='Enable Dynamics 365 Mode';
            trigger OnValidate();
            var
                ApplicationAreaSetup : Record 9178;
                ReSignInMsg : TextConst ENU='You must sign out and then sign in again to have the changes take effect.';
            begin
                if not ApplicationAreaSetup.Get(CompanyName,'','') then begin
                    ApplicationAreaSetup."Company Name" := CompanyName;
                    ApplicationAreaSetup.Insert;
                end;
                    
                ApplicationAreaSetup.Basic := false;
                ApplicationAreaSetup.Suite := false;
                ApplicationAreaSetup."Relationship Mgmt" := false;
                ApplicationAreaSetup.Assembly := false;
                ApplicationAreaSetup.Jobs := false;
                ApplicationAreaSetup."Fixed Assets" := false;
                ApplicationAreaSetup.Location := false;
                ApplicationAreaSetup.BasicHR := false;


                if EnableD365Mode then begin
                    ApplicationAreaSetup.Basic := true;
                    ApplicationAreaSetup."Relationship Mgmt" := true;
                end;

                ApplicationAreaSetup.Modify;
                Message(ReSignInMsg);

            end;
        }
    }
}