codeunit 70000000 D365ModeManagement
{
    trigger OnRun();
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 1, 'OnBeforeCompanyOpen', '', TRUE, TRUE)]
    local procedure Enable();
    var
        CompanyInformation : Record 79;
        PermissionManager : Codeunit 9002;
    begin
        if CompanyInformation.FindFirst then
            PermissionManager.SetTestabilitySoftwareAsAService(CompanyInformation.EnableD365Mode);
    end;

}
