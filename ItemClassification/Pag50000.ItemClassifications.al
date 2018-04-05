page 50000 "Item Classifications"
{
    PageType = List;
    SourceTable = "Item Classification";

    layout
    {
        area(content)
        {
            repeater(ItemClassifications)
            {
                field("Code"; "Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Sales Count"; "Minimum Sales Count")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Warning"; "Warning")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}