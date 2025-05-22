page 50116 "Custom Sales Order Subpage"
{
    PageType = ListPart;
    SourceTable = "Custom Sales Line";
    ApplicationArea = All;
    Editable = true;
    DelayedInsert = true;

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

                    trigger OnValidate()
                    begin
                        if Rec."Line No." = 0 then
                            Rec."Line No." := GetNextLineNo(Rec."Document Type", Rec."Document No.");
                    end;
                }
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

    procedure GetNextLineNo(DocumentType: Enum "Custom Sales Document Type"; DocumentNo: Code[20]): Integer
    var
        CustomLine: Record "Custom Sales Line";
    begin
        CustomLine.SetRange("Document Type", DocumentType);
        CustomLine.SetRange("Document No.", DocumentNo);
        if CustomLine.FindLast() then
            exit(CustomLine."Line No." + 2000)
        else
            exit(1000);
    end;
}
