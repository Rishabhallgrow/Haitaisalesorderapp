//AGT.RP_05.28.2025..>>
page 50117 "Custom Sales Order List"
{
    PageType = List;
    SourceTable = "Custom Sales Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    CardPageID = "Custom Sales Order";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type") { ApplicationArea = All; }
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("App Order No.1"; Rec."App Order No.") { ApplicationArea = All; }
                field("Customer No."; Rec."Customer No.") { ApplicationArea = All; }
                field("PO Number"; Rec."PO Number") { ApplicationArea = All; }
                field("BC Document No."; Rec."BC Document No.") { ApplicationArea = All; }
                field("Status"; Rec."Status") { ApplicationArea = All; }
            }
        }
    }
}
//AGT.RP_05.28.2025..<<
