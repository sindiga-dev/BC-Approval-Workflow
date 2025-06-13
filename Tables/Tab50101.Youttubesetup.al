table 50101 "Youttube setup"
{
    Caption = 'Youttube setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; primary; Code[20])
        {
            Caption = 'primary';
        }
        field(2; "Youtube Nos"; Code[20])
        {
            Caption = 'Youtube Nos';
            TableRelation = "No. Series";
        }
        field(3; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; primary)
        {
            Clustered = true;
        }
    }
}
