/// <summary>
/// Codeunit yourtube workflow evt handling (ID 74743).
/// </summary>
codeunit 50111 "Yourtube Workflow Evt Handling"
{
    trigger OnRun()
    begin

    end;


    procedure RunWorkflowOnSendYoutubeForApprovalCode(): code[128]
    begin
        exit('RUNWORKFLOWONSENDYOURUBEFORAPPROVAL')
    end;

    procedure RunWorkflowOnCancelYoutubeForApprovalCode(): code[128]
    begin
        exit('RUNWORKFLOWONCANCELYOURUBEFORAPPROVAL')
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        workflowEventHandling.AddEventToLibrary(RunWorkflowOnSendYoutubeForApprovalCode(), DATABASE::"Youtube Category Video", youtubeSendApproval, 0, false);
        workflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelYoutubeForApprovalCode(), DATABASE::"Youtube Category Video", youtubeCancelApproval, 0, false);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Youtube Approval Mgmt", 'OnSendRequestForApproval', '', false, false)]
    local procedure OnSendRequestForApproval(var Youtube: Record "Youtube Category Video")
    begin
        workflowMgt.HandleEvent(RunWorkflowOnSendYoutubeForApprovalCode, Youtube);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Youtube Approval Mgmt", 'OnCancelRequestForApproval', '', false, false)]
    local procedure OnCancelRequestForApproval(var Youtube: Record "Youtube Category Video")
    begin
        workflowMgt.HandleEvent(RunWorkflowOnCancelYoutubeForApprovalCode, Youtube);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        case EventFunctionName of
            RunWorkflowOnCancelYoutubeForApprovalCode():
                workflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelYoutubeForApprovalCode(), RunWorkflowOnSendYoutubeForApprovalCode);
            workflowEventHandling.RunWorkflowOnApproveApprovalRequestCode():
                workflowEventHandling.AddEventPredecessor(workflowEventHandling.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendYoutubeForApprovalCode())
        end;
    end;

    procedure isYoutubeApprovalWorkflowEnabled(var Youtube: Record "Youtube Category Video"): Boolean
    var
        IsHandled: Boolean;
    begin
        exit(workflowMgt.CanExecuteWorkflow(Youtube, RunWorkflowOnSendYoutubeForApprovalCode()))
    end;


    procedure IsYoutubePendingApproval(var Youtube: Record "Youtube Category Video"): Boolean
    var
        myInt: Integer;
    begin

        exit(isYoutubeApprovalWorkflowEnabled(Youtube));
        if (Youtube.Status <> Youtube.Status::Private) then exit(false);
    end;



    procedure CheckInvcomingApprovalWorkFlowEnabled(var Youtube: Record "Youtube Category Video"): Boolean
    begin
        if not IsYoutubePendingApproval(Youtube) then error(youtubeApprovalExistEr);
        exit(true)
    end;

    var
        workflowMgt: Codeunit "Workflow Management";
        workflowEventHandling: Codeunit "Workflow Event Handling";
        youtubeSendApproval: Label ' Youtube Approval Requested';
        youtubeCancelApproval: Label ' Youtube Approval Cancelled';
        youtubeApprovalExistEr: Label 'No Approval Workflow For This Document';
}