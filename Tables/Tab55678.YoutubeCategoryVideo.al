/// <summary>
/// Table Youtube Category Video (ID 55678).
/// </summary>
table 55678 "Youtube Category Video"
{


    fields
    {
        field(50000; "Video Id"; code[20])
        {


        }

        field(50001; "Video Category"; enum VCategory)
        {


        }

        field(50002; "Video Name"; code[20])
        {


        }

        field(50003; "Video Description"; Text[1000])
        {


        }
        field(50004; Status; enum Status)
        {


        }
        field(50005; "No Series."; code[20])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Video Id", "Video Category")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        NoseriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin

        if ("Video Id" = '') then begin

            case "Video Category" of

                "Video Category"::Action:
                    begin
                        NoseriesMgt.InitSeries('Action', xRec."Video Id", 0D, "Video Id", "No Series.");
                    end;
                "Video Category"::Dramma:
                    begin
                        NoseriesMgt.InitSeries('Dramma', xRec."Video Id", 0D, "Video Id", "No Series.");
                    end;
                "Video Category"::Frictional:
                    begin
                        NoseriesMgt.InitSeries('Frictional', xRec."Video Id", 0D, "Video Id", "No Series.");
                    end;

            end
        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}