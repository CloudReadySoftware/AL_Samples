codeunit 50000 "CalcItemClassification Meth."
{
    procedure CalcItemClassification(var Item: Record Item; var HideDialog: Boolean);
    var
        Handled: Boolean;
    begin
        if not ConfirmCalcItemClassification(Item, HideDialog) then exit;

        OnBeforeCalcItemClassification(Handled);
        DoCalcItemClassification(Item, Handled);
        OnAfterCalcItemClassification();

        AckCalcItemClassificaiton(Item, HideDialog);
    end;

    local procedure DoCalcItemClassification(var Item: Record Item; var Handled: Boolean);
    begin
        if Handled then exit;

        item."Item Classification Code" := GetItemClassificationCode(GetItemSalesCount(Item));
        item.Modify;
    end;

    local procedure GetItemSalesCount(var Item: Record Item): Integer;
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        WITH ItemLedgerEntry DO BEGIN
            SETRANGE("Item No.", Item."No.");
            SETRANGE("Entry Type", "Entry Type"::Sale);
            EXIT(COUNT);
        END;
    end;

    local procedure GetItemClassificationCode(SalesCount: Integer): Code[10];
    var
        ItemClassification: Record "Item Classification";
    begin
        WITH ItemClassification DO BEGIN
            ItemClassification.SETFILTER("Minimum Sales Count", '<=%1', SalesCount);
            SETASCENDING(Code, TRUE);
            IF NOT FINDFIRST THEN
                EXIT('')
            ELSE
                EXIT(Code);
        END;
    end;

    local procedure ConfirmCalcItemClassification(var Item: Record Item; var HideDialog: Boolean): Boolean
    var
        confirmTxt: label 'Are you sure?';
    begin
        if not GuiAllowed() or HideDialog then exit(true);

        exit(confirm(ConfirmTxt, False));
    end;

    local procedure AckCalcItemClassificaiton(var Item: Record Item; var HideDialog: Boolean): Boolean
    var
        AckTxt: Label 'Classification for item %1 calculated successfully';
    begin
        if not GuiAllowed() or HideDialog then exit(true);

        Message(AckTxt, Item."No.");
    end;

    [BusinessEvent(false)]
    local procedure OnBeforeCalcItemClassification(var Handled: Boolean);
    begin
    end;

    [BusinessEvent(false)]
    local procedure OnAfterCalcItemClassification();
    begin
    end;
}
