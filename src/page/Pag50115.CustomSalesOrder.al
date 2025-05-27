page 50115 "Custom Sales Order"
{
    PageType = Document;
    SourceTable = "Custom Sales Header";
    ApplicationArea = All;
    UsageCategory = Documents;
    Editable = true;

    layout
    {
        area(content)
        {
            group("General")
            {
                field("Document Type"; Rec."Document Type") { ApplicationArea = All; }
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("App Order No."; Rec."App Order No.") { ApplicationArea = All; }
                field("Customer No."; Rec."Customer No.") { ApplicationArea = All; }
                field("PO Number"; Rec."PO Number") { ApplicationArea = All; }
                field("BC Document No."; Rec."BC Document No.") { ApplicationArea = All; }
                field("Status"; Rec."Status") { ApplicationArea = All; }
            }

            part(Lines; "Custom Sales Order Subpage")
            {
                ApplicationArea = All;
                // SubPageLink = "App Order No." = field("App Order No.");
                SubPageLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action(TransferToSalesOrder)
            {
                Caption = 'Transfer to Sales Order';
                ApplicationArea = All;
                trigger OnAction()
                var
                    CustomHeader: Record "Custom Sales Header";
                    CustomLines: Record "Custom Sales Line";
                    Procedures: Codeunit 50101;
                begin
                    CustomHeader := Rec;
                    CustomLines.SetRange("Document No.", CustomHeader."No.");
                    Procedures.CreateSalesHeader(CustomHeader, CustomLines);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        CustomLines: Record "Custom Sales Line";
    begin
        CustomLines.SetRange("Document No.", Rec."No.");
        if CustomLines.FindFirst() then
            CustomLines.DeleteAll();
    end;


}
