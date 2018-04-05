table 50000 "Item Classification"
{
    fields
    {
        field(1; "Code"; Code[10]) { }
        field(2; "Description"; Text[50]) { }
        field(3; "Minimum Sales Count"; Decimal) { }
        field(4; "warning"; Boolean) { }
    }

    keys
    {

        key(PK; "Code")
        {
            Clustered = true;
        }

    }

    procedure InsertDefaultValues();
    var
        InsertDefaultValuesMeth: Codeunit "InsertDefaultValues Meth.";
    begin
        InsertDefaultValuesMeth.InsertDefaultValues;
    end;
}


