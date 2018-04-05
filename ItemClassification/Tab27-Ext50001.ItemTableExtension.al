tableextension 50001 ItemTableExtension extends Item //27
{
    fields
    {        
        field(50000;"Item Classification Code";Code[10]){
            TableRelation = "Item Classification"."Code";
        }
    }

    procedure CalcItemClassification();
    var
        CalcItemClassificationMeth: Codeunit "CalcItemClassification Meth.";
    begin
        CalcItemClassificationMeth.CalcItemClassification(Rec);
    end;
}

