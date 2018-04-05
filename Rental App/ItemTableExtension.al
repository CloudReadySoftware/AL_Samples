tableextension 70066090 ItemExtension extends Item
{
    fields
    {
        // Add changes to table fields here
        field(66090;"Rental Item";Boolean) {}
        field(66091;"Rental Group";Code[20]) {}
    }

    procedure IsRentalItem() : Boolean;
    begin
        EXIT("Rental Item");
    end;
}

