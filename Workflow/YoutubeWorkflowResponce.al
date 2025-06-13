/// <summary>
/// Codeunit Youtube Workflow Response (ID 53534).
/// </summary>
codeunit 50110 "Youtube Workflow Response"
{
    trigger OnRun()
    begin

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(var Handled: Boolean; RecRef: RecordRef)
    Var
        Youtube: Record "Youtube Category Video";
    begin
        case
             RecRef.Number of
            DATABASE::"Youtube Category Video":
                BEGIN
                    RecRef.SetTable(Youtube);
                    Youtube.Status := Youtube.Status::Private;
                    Youtube.Modify();
                    Handled := true;
                END;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(var Handled: Boolean; RecRef: RecordRef)
    Var
        Youtube: Record "Youtube Category Video";
    begin
        case
             RecRef.Number of
            DATABASE::"Youtube Category Video":
                BEGIN
                    RecRef.SetTable(Youtube);
                    Youtube.Status := Youtube.Status::Public;
                    Youtube.Modify();
                    Handled := true;
                END;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(var IsHandled: Boolean; var Variant: Variant; RecRef: RecordRef)
    var
        Youtube: Record "Youtube Category Video";
    begin
        case
             RecRef.Number of
            DATABASE::"Youtube Category Video":
                BEGIN
                    RecRef.SetTable(Youtube);
                    Youtube.Status := Youtube.Status::"Pending Approval";
                    Youtube.Modify();
                    IsHandled := true;
                END;

        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    begin
        case ResponseFunctionName of
            workflowResponseHandling.SetStatusToPendingApprovalCode():
                workflowResponseHandling.AddResponsePredecessor(workflowResponseHandling.SetStatusToPendingApprovalCode(), workflowHandling.RunWorkflowOnSendYoutubeForApprovalCode());
            workflowResponseHandling.CancelAllApprovalRequestsCode():
                workflowResponseHandling.AddResponsePredecessor(workflowResponseHandling.CancelAllApprovalRequestsCode(), workflowHandling.RunWorkflowOnCancelYoutubeForApprovalCode());
            workflowResponseHandling.OpenDocumentCode():
                workflowResponseHandling.AddResponsePredecessor(workflowResponseHandling.OpenDocumentCode(), workflowHandling.RunWorkflowOnSendYoutubeForApprovalCode());
        end

    end;







    var
        workflowResponseHandling: Codeunit "Workflow Response Handling";
        workflowHandling: Codeunit "Yourtube Workflow Evt Handling";

}