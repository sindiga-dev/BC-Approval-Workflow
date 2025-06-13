page 50602 "Action Youtube Video List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Youtube Category Video";
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    CardPageId = "Action Youtube Video";
    SourceTableView = where("Video Category" = const(Action), Status = filter(Private | "Pending Approval"));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Video Id"; Rec."Video Id")
                {
                    ToolTip = 'Specifies the value of the Video Id field.';
                }
                field("Video Name"; Rec."Video Name")
                {
                    ToolTip = 'Specifies the value of the Video Name field.';
                }
                field("Video Description"; Rec."Video Description")
                {
                    ToolTip = 'Specifies the value of the Video Description field.';
                }
                field("Video Category"; Rec."Video Category")
                {
                    ToolTip = 'Specifies the value of the Video Category field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}