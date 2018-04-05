pageextension 70050000 SetSelectionFilterTest extends "Item List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addfirst("&Purchases")
        {
            action("Show Selected Items")
            {            
                CaptionML=ENU='Show Selected Items';
                Promoted=true;
                PromotedIsBig=true;
                PromotedCategory=New;
                
                trigger OnAction();
                var
                    Item : Record Item;
                begin
                    //CurrPage.SetSelectionFilter(Item);
                    currpage.SetSelection(Item);                    
                    message('Test Extension');
                    message(format(Item.count));
                end;
            }
        }
    }
}