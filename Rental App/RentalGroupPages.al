Page 70066092 "Rental Group FactBox"
{
    pagetype = ListPart;
    SourceTable = "Rental Group";
    layout
    {
        area(Content)
        {
            Group("Repeater")
            {
                repeater("RentalGroups")
                {
                    field("Code";"Code") {}
                    field(Description;Description) {}  
                }    
            }
        }
    }
}

pageextension 70066093 RentalGroupFactBoxOnItemList extends "Item List"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part("Rental Group FactBox";"Rental Group FactBox")
            {

            }
        }
    }    
}

page 70066094 RentalGroups
{
    Editable=true;
    SourceTable = "Rental Group";

    layout
    {
        area(content)
        {
            group("Repeater")
            {
                repeater(RentalGroups)
                {
                    field("code";"code") {}
                    field(Description;Description) {}
                }
            }
        }
    }
}

pageextension 70066095 RentalGroupsActionOnItemList extends "Item List"
{    
    Actions    
    {
        addlast(Item)
        {
            group("Rental")
            {
                action("Rental Groups")
                {
                    CaptionML=ENU='Rental Groups';
                    image=Group;
                    Promoted=true;
                    PromotedCategory=Process;
                    PromotedIsBig=true;
                    RunObject=page RentalGroups;
                }
            }
            
        }
    }
}