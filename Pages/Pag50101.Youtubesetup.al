page 50101 "Youtube setup"
{
    Caption = 'Youtube setup';
    PageType = Card;
    SourceTable = "Youttube setup";
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Youtube Nos"; Rec."Youtube Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Youtube Nos field.', Comment = '%';
                }
            }
        }
    }
}
