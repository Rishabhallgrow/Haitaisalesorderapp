//AGT.RP_05.28.2025..>>
page 50116 "Custom Sales Order Subpage"
{
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = "Custom Sales Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.") { ApplicationArea = All; }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("App Order No."; Rec."App Order No.") { ApplicationArea = all; }
                field("Description"; Rec."Description") { ApplicationArea = All; }
                field("Description 2"; Rec."Description 2") { ApplicationArea = All; }
                field("Price Type"; Rec."Price Type") { ApplicationArea = All; }
                field("Each Price"; Rec."Each Price") { ApplicationArea = All; }
                field("Item Category Code"; Rec."Item Category Code") { ApplicationArea = All; }
                field("Qty"; Rec."Qty") { ApplicationArea = All; }
                field("Product Size"; Rec."Product Size") { ApplicationArea = All; }
                field("Unit Price"; Rec."Unit Price") { ApplicationArea = All; }
            }
        }
    }
}
//AGT.RP_05.28.2025..<<