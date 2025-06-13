codeunit 54435 "Youtube Publish Page"
{
    trigger OnRun()
    begin

    end;

    procedure ConditionalPageID(RecordRef: RecordRef): Integer
    var
        Youtube: Record "Youtube Category Video";
    begin
        case RecordRef.Number of
            DATABASE::"Youtube Category Video":
                BEGIN
                    RecordRef.SetTable(Youtube);

                    case
                         Youtube."Video Category" of
                        Youtube."Video Category"::Action:
                            begin
                                exit(Page::"Action Youtube Video");
                            end;
                        Youtube."Video Category"::Dramma:
                            begin
                                exit(Page::"Drama Youtube Video");
                            end;
                        Youtube."Video Category"::Frictional:
                            begin
                                exit(Page::"Frictional Youtube Video");
                            end;
                    end;

                END;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(var PageID: Integer; var RecordRef: RecordRef)
    begin
        if PageID = 0 then
            PageID := ConditionalPageID(RecordRef)
    end;

    var
        myInt: Integer;
}