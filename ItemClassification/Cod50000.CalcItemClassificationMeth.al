codeunit 50000 "CalcItemClassification Meth."
{
    trigger OnRun();
    begin
    end;

    procedure CalcItemClassification(var Item:Record Item);    
    var
        Handled :Boolean;
    begin
        OnBeforeCalcItemClassification(Handled);

        DoCalcItemClassification(Item);

        OnAfterCalcItemClassification();
    end;

    local procedure DoCalcItemClassification(var Item:Record Item);    
    begin
        item."Item Classification Code" := GetItemClassificationCode(GetItemSalesCount(Item));    
        item.Modify;
    end;

    local procedure GetItemSalesCount(var Item:Record Item):Integer;
    var 
       ItemLedgerEntry :Record "Item Ledger Entry";
    begin
        WITH ItemLedgerEntry DO BEGIN
            SETRANGE("Item No.",Item."No.");
            SETRANGE("Entry Type","Entry Type"::Sale);
            EXIT(COUNT);
        END;
    end;

    local procedure GetItemClassificationCode(SalesCount : Integer):Code[10];    
    var
        ItemClassification:	Record "Item Classification";
    begin
        WITH ItemClassification DO BEGIN
            ItemClassification.SETFILTER("Minimum Sales Count", '<=%1', SalesCount);
            SETASCENDING(Code,TRUE);
            IF NOT FINDFIRST THEN
                EXIT('')
            ELSE
                EXIT(Code);
        END;
    end;

    [IntegrationEvent(false,false)]
    local procedure OnBeforeCalcItemClassification(var Handled: Boolean); begin end;
    [IntegrationEvent(false,false)]
    local procedure OnAfterCalcItemClassification(); begin end;
}
