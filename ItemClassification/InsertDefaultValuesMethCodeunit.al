codeunit 50002 "InsertDefaultValues Meth."
{
    trigger OnRun();
    begin
    end;

    procedure InsertDefaultValues();
    var
        Handled: Boolean;
    begin
        OnBeforeInsertDefaultValues(Handled);

        DoInsertDefaultValues(Handled);

        OnAfterInsertDefaultValues;
    end;

    local procedure DoInsertDefaultValues(var Handled: Boolean);
    begin
        if Handled then exit;

        InsertDefaultValue('A','Sold often',5,FALSE);
        InsertDefaultValue('B','Sold rarely',3,TRUE);
        InsertDefaultValue('C','Sold never',0,TRUE);
    end;

    local procedure InsertDefaultValue(pcode: code[10];pDescription:text;pMinimumSalesCount:decimal;pWarning:Boolean);
    var
        ItemClassification: Record "Item Classification";
    begin
        WITH ItemClassification DO BEGIN
            Code := pCode;
            Description := pDescription;
            "Minimum Sales Count" := pMinimumSalesCount;
            Warning := pWarning;
            INSERT;
        END;
    end;

    [IntegrationEvent(false,false)]
    local procedure OnBeforeInsertDefaultValues(var Handled: Boolean); begin end;
    
    [IntegrationEvent(false,false)]
    local procedure OnAfterInsertDefaultValues(); begin end;
    
}
