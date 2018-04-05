codeunit 50001 MyCodeunit
{
    trigger OnRun();
    begin
    end;

    procedure ShowItemClassWarning(var Item:Record Item);
    var
        Handled: Boolean;
    begin
        OnBeforeShowItemClassWarning(item,Handled);

        DoShowItemClassWarning(Item, Handled);

        OnAfterShowItemClassWarning(Item);
    end;

    local procedure DoShowItemClassWarning(var Item:Record Item; var Handled: Boolean);
    begin
        IF Handled THEN EXIT;

        IF GetItemClassWarningStatus(Item) THEN
            SendItemClassWarning(Item);
    end;

    local procedure GetItemClassWarningStatus(var Item: Record Item): Boolean;
    var
        ItemClassification: Record "Item Classification";
    begin
        WITH ItemClassification DO BEGIN
            SETRANGE(Code,Item."Item Classification Code");
            FINDFIRST;
            EXIT(Warning);
        END;
    end;

     procedure HandleItemClassWarning_RunItemCard(ItemWarningNotification: Notification);
     var
        ItemNo: Code[20];
        ItemCard: Page "Item Card";
        Item: Record Item;
     begin
        ItemNo := ItemWarningNotification.GETDATA('ItemNumber');
        IF Item.GET(ItemNo) THEN BEGIN
            ItemCard.SETRECORD(Item);
            ItemCard.RUN;
        END ELSE
            ERROR('Could Not find Item: ' + ItemNo);
     end;

     procedure HandleItemClassWarning_RunItemLedgerEntries(ItemWarningNotification: Notification);
     var
        ItemNo: Code[20];
        ItemLedgerEntry: Record "Item Ledger Entry";        
     begin
        ItemNo := ItemWarningNotification.GETDATA('ItemNumber');
        ItemLedgerEntry.SETRANGE("Item No.",ItemNo);
        ItemLedgerEntry.FINDFIRST;
        IF ItemLedgerEntry.FINDFIRST THEN
            PAGE.RUN(PAGE::"Item Ledger Entries",ItemLedgerEntry)
        ELSE
            ERROR('Could Not find Item: ' + ItemNo);
     end;

     local procedure SendItemClassWarning(var Item: Record Item);
     var
        ItemWarningNotification: Notification;
        txtItemLabeledWithWarning: TextConst ENU='Item %1 has Item Classification %2';
     begin
        ItemWarningNotification.MESSAGE(STRSUBSTNO(txtItemLabeledWithWarning,Item.Description,Item."Item Classification Code"));
        ItemWarningNotification.SETDATA('ItemNumber',Item."No.");
        ItemWarningNotification.ADDACTION('Run Item Card',50001,'HandleItemClassWarning_RunItemCard');
        ItemWarningNotification.ADDACTION('Run Item Ledger Entries',50001,'HandleItemClassWarning_RunItemLedgerEntries');
        ItemWarningNotification.SEND;   
    end;
    
    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'No.', True, True)]
    local procedure ShowItemClassWarning_OnValidateItemNoOnSalesLine(Rec: Record "Sales Line");
    var
        Item: Record Item;
    begin
        WITH Rec DO BEGIN 
            IF NOT (type = type::Item) THEN EXIT;
            IF NOT item.get(rec."No.") THEN EXIT;
            
            ShowItemClassWarning(Item);
        END;
    End;

    [IntegrationEvent(false,false)]
    local procedure OnBeforeShowItemClassWarning(var Item: record Item;var Handled: Boolean); begin end;
    [IntegrationEvent(false,false)]
    local procedure OnAfterShowItemClassWarning(var Item: record Item); begin end;
}