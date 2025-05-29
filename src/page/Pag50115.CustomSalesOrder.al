//AGT.RP_05.28.2025..>>
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
                field("App Order No.1"; Rec."App Order No.") { ApplicationArea = All; }
                field("Customer No."; Rec."Customer No.") { ApplicationArea = All; }
                field("PO Number"; Rec."PO Number") { ApplicationArea = All; }
                field("BC Document No."; Rec."BC Document No.") { ApplicationArea = All; }
                field("Status"; Rec."Status") { ApplicationArea = All; }
                field("External document no"; Rec."External document no") { ApplicationArea = all; }
                field("Your refernece"; Rec."Your refernece") { ApplicationArea = all; }
            }

            part(Lines; "Custom Sales Order Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "App Order No." = field("App Order No.");
                UpdatePropagation = Both;
            }

        }
    }


    actions
    {
        area(Processing)
        {
            //AGT.AA_05.19.2025..>>

            // action(TransferToSalesOrder)
            // {
            //     Caption = 'Transfer to Sales Order';
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     var
            //         CustomHeader: Record "Custom Sales Header";
            //         CustomLines: Record "Custom Sales Line";
            //         Procedures: Codeunit 50101;
            //     begin
            //         CustomHeader := Rec;
            //         // CustomLines.SetRange("Document No.", CustomHeader."No.");
            //         CustomLines.SetRange("App Order No.", CustomHeader."App Order No.");
            //         Procedures.CreateSalesHeader(CustomHeader, CustomLines);
            //     end;
            // }
            //AGT.AA_05.19.2025..<<

            //AGT.RP_05.28.2025..>>

            action(TransferToSalesOrder)
            {
                Caption = 'Transfer to Sales Order';
                ApplicationArea = All;
                trigger OnAction()
                var
                    Procedures: Codeunit 50101;
                begin
                    // Call the new procedure using App Order No. as the key
                    Procedures.CreateSalesOrderFromAppOrderNo(Rec."App Order No.");
                end;
            }
            //AGT.AA_05.28.2025..<<


        }
    }
}
//AGT.RP_05.28.2025..<<
