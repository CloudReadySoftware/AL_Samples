tableextension 70050090 ItemExtension extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50090;"Rental Item";Boolean) {}
    }

    procedure IsRentalItem() : Boolean;
    begin
        EXIT("Rental Item");
    end;
}