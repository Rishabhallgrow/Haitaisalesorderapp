page 58000 "Custom Sales Order_test"
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

            part(Lines; "Custom Sales Order Subpage_t")
            {
                ApplicationArea = All;
                SubPageLink =
                            "App Order No." = field("App Order No.");
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
                Image = Transfer;
                ApplicationArea = All;
                trigger OnAction()
                var
                    CustomSalesHeader: Record "Custom Sales Header";
                begin
                    CustomSalesHeader.Get(Rec."Document Type", Rec."No.");
                    // Codeunit50100.TransferToSalesOrder(CustomSalesHeader);
                    Message('Sales Order created successfully.');
                end;
            }
        }
    }


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        NoSeriesMgt: Codeunit "No. Series";
    begin
        Rec.Init();
        Rec."Document Type" := Rec."Document Type"::Order;
        Rec."No." := NoSeriesMgt.GetNextNo('S-ORD', Today, true);
    end;

}
