page 50100 "Custom Sales Order"
{
    PageType = Document;
    SourceTable = "Custom Sales Header";
    ApplicationArea = All;
    UsageCategory = Documents; // Makes it appear in search/navigation
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
                SubPageLink = "Document Type" = field("Document Type"),
                              "Document No." = field("No.");
                UpdatePropagation = Both; // Ensures changes reflect both ways
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TransferToSalesOrder)
            {
                // Caption = 'Transfer to Sales Order';
                // Image = Transfer;
                // ApplicationArea = All;
                // trigger OnAction()
                // var
                //     CustomSalesHeader: Record "Custom Sales Header";
                // begin
                //     CustomSalesHeader.Get(Rec."Document Type", Rec."No.");
                //     Codeunit50100.TransferToSalesOrder(CustomSalesHeader);
                //     Message('Sales Order created successfully.');
                // end;
            }
        }
    }
}
