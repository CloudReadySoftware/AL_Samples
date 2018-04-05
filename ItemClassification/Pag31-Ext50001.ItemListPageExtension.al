pageextension 50001 ItemListPageExtension extends "Item List" //31
{
    layout
    {
        // Add changes to page layout here
        addfirst(Item){
            field("Item Classification Code";"Item Classification Code"){
                ApplicationArea=Basic,Suite;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
        addfirst(Item){
            action(CalcItemClassification){
                Promoted=true;
                PromotedCategory=Process;
                PromotedIsBig=true;
                Image=Calculate;
                ApplicationArea=Basic,Suite;

                trigger OnAction();
                begin
                    Rec.CalcItemClassification();
                end;
            }
        }
    }
}