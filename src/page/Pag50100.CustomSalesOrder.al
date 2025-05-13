
page 50100 "Custom Sales Order"
{
    PageType = Document;
    SourceTable = "Custom Sales Header";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group("General")
            {
                field("Document Type"; Rec."Document Type") { }
                field("No."; Rec."No.") { }
                field("App Order No."; Rec."App Order No.") { }
                field("Customer No."; Rec."Customer No.") { }
                field("PO Number"; Rec."PO Number") { }
                field("BC Document No."; Rec."BC Document No.") { }
                field("Status"; Rec."Status") { }
            }

            part(Lines; "Custom Sales Order Subpage")
            {
                SubPageLink = "Document No." = field("No.");
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
                // trigger OnAction()
                // var
                //     CustomSalesHeader: Record "Custom Sales Header";
                // begin
                //     CustomSalesHeader.Get(Rec."No.");
                //     Codeunit50100.TransferToSalesOrder(CustomSalesHeader);
                //     Message('Sales Order created successfully.');
                // end;
            }
        }
    }
}
