Codeunit 70066091 RentalSubscriptions
{
    [EventSubscriber(ObjectType::Table, 27, 'OnAfterModifyEvent', '', true, true)]
    local procedure TestMessage();
    begin
        message('You just changed an Item!');
        OnAfterTestMessage();
    end;

    [Integration(false, false)]
    PROCEDURE OnAfterTestMessage();
    begin
    end;
        
    [EventSubscriber(ObjectType::Codeunit,70066091, 'OnAfterTestMessage', '', true, true)]
    local procedure TestMessage2();
    begin
        message('Published event Event is working!')                
    end;
}
