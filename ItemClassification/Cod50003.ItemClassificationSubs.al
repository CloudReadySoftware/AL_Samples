codeunit 50003 "Item Classification Subs"
{
    trigger OnRun();
    begin
    end;

    [EventSubscriber(ObjectType::Table, 1808, 'OnRegisterAssistedSetup', '', false, false)]
    local procedure AddItemClassificationWizard_OnRegisterAssistedSetup(VAR TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup");
    var
        ItemClassification: Record "Item Classification";
    begin
        TempAggregatedAssistedSetup.AddExtensionAssistedSetup(PAGE::"Item Classification Wizard", 'Item Classification', TRUE, ItemClassification.RECORDID, GetItemClassificationSetupStatus(TempAggregatedAssistedSetup), '');
    end;

    [EventSubscriber(ObjectType::Table, 1808, 'OnUpdateAssistedSetupStatus', '', false, false)]
    local procedure UpdateItemClassificationSetupStatus_OnUpdateAssistedSetupStatus(VAR TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup");
    begin
        GetItemClassificationSetupStatus(TempAggregatedAssistedSetup);
    end;

    LOCAL PROCEDURE GetItemClassificationSetupStatus(VAR TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup"): Integer;
    var
        ItemClassification: Record "Item Classification";
    begin
        WITH TempAggregatedAssistedSetup DO BEGIN
            IF ItemClassification.ISEMPTY THEN
                Status := Status::"Not Started"
            ELSE
                Status := Status::Completed;
            EXIT(Status);
        END;
    end;

}
