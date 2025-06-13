codeunit 50112 "Youtube Approval Mgmt"
{
    trigger OnRun()
    begin

    end;


    /// <summary>
    /// OnSendRequestForApproval.
    /// </summary>
    /// <param name="Var Youtube">Record "Youtube Category Video".</param>
    [IntegrationEvent(false, false)]
    procedure OnSendRequestForApproval(Var Youtube: Record "Youtube Category Video")
    begin
    end;

    /// <summary>
    /// OnCancelRequestForApproval.
    /// </summary>
    /// <param name="Var Youtube">Record "Youtube Category Video".</param>
    [IntegrationEvent(false, false)]
    procedure OnCancelRequestForApproval(Var Youtube: Record "Youtube Category Video")
    begin
    end;


    var
        myInt: Integer;
}