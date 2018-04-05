tableextension 50001 ItemTableExtension extends Item
{
    fields
    {        
        field(50000;"Item Classification Code";Code[10]){
            TableRelation = "Item Classification"."Code";
        }
    }
}

