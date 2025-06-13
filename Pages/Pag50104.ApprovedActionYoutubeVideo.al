
page 50104 "Approved Action Youtube Video"
{
    PageType = Card;
    UsageCategory = Administration;
    Caption = 'Approved Action Youtube Video';
    SourceTable = "Youtube Category Video";
    RefreshOnActivate = true;
    SourceTableView = where("Video Category" = const(Action), Status = const(Public));


    layout
    {
        area(Content)
        {
            group(General)
            {

                field("Video Id"; Rec."Video Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Video Id field.';
                }
                field("Video Name"; Rec."Video Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Video Name field.';
                }
                field("Video Description"; Rec."Video Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Video Description field.';
                }
                field("Video Category"; Rec."Video Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Video Category field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}