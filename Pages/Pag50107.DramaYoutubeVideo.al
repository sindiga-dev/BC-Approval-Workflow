
page 50107 "Drama Youtube Video"
{
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "Youtube Category Video";
    Caption = 'Drama Youtube Video';
    RefreshOnActivate = true;
    SourceTableView = where("Video Category" = const(Dramma));
    PromotedActionCategories = 'Approvals';


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
            group("Approvals")
            {
                Caption = 'Approvals';
                action(RequestApproval)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Request Approval';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = new;
                    Enabled = NOT OpenApprovalEntiesExist AND CanRequestApprovalForWorkflow;

                    trigger OnAction()
                    begin
                        Rec.TestField("Video Id");
                        Rec.TestField("Video Name");
                        Rec.TestField("Video Description");
                        if youtubeApprovalHandling.CheckInvcomingApprovalWorkFlowEnabled(Rec) then
                            youtubeApprovalsMgnt.OnSendRequestForApproval(Rec);

                    end;
                }

                action(CancelApproval)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = new;
                    Enabled = CanCancelApprovalForRecord OR CanRequestApprovalForWorkflow;

                    trigger OnAction()
                    begin
                        Rec.TestField("Video Id");
                        Rec.TestField("Video Name");
                        Rec.TestField("Video Description");
                        youtubeApprovalsMgnt.OnCancelRequestForApproval(Rec);

                    end;
                }
            }

        }
    }

    var
        CanCancelApprovalForWorkflow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanRequestApprovalForWorkflow: Boolean;
        OpenApprovalEntiesExist: Boolean;
        OpenApprovalEntriesForCurrUser: Boolean;
        youtubeApprovalsMgnt: codeunit "Youtube Approval Mgmt";
        youtubeApprovalHandling: Codeunit "Yourtube Workflow Evt Handling";
        workflowWebHookMgnt: Codeunit "Workflow Webhook Management";



    /// <summary>
    /// UpdateApprovalsProps.
    /// </summary>
    /// <returns>Return value of type begin.</returns>
    procedure UpdateApprovalsProps()
    begin
        OpenApprovalEntriesForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RecordId);
        OpenApprovalEntiesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        workflowWebHookMgnt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForWorkflow, CanCancelApprovalForWorkflow);

    end;


    trigger OnAfterGetCurrRecord()
    begin
        UpdateApprovalsProps();
    end;
}