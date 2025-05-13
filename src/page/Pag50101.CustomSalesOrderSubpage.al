
page 50101 "Custom Sales Order Subpage"
{
    PageType = ListPart;
    SourceTable = "Custom Sales Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type") { }
                field("Document No."; Rec."Document No.") { }
                field("Line No."; Rec."Line No.") { }
                field("App Order No."; Rec."App Order No.") { }
                field("Item No."; Rec."Item No.") { }
                field("Description"; Rec."Description") { }
                field("Description 2"; Rec."Description 2") { }
                field("Price Type"; Rec."Price Type") { }
                field("Each Price"; Rec."Each Price") { }
                field("Item Category Code"; Rec."Item Category Code") { }
                field("Qty"; Rec."Qty") { }
                field("Product Size"; Rec."Product Size") { }
                field("Unit Price"; Rec."Unit Price") { }
            }
        }
    }
}
