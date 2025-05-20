table 50101 "Custom Sales Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "Custom Sales Document Type") { }
        field(2; "Document No."; Code[20]) { TableRelation = "Custom Sales Header"."No."; }
        field(3; "Line No."; Integer) { }
        field(4; "App Order No."; Code[20]) { }
        field(5; "Item No."; Code[20]) { TableRelation = Item."No."; }
        field(6; "Description"; Text[100]) { }
        field(7; "Description 2"; Text[100]) { }
        field(8; "Price Type"; Option) { OptionMembers = "Retail","Wholesale","Discounted"; }
        field(9; "Each Price"; Decimal) { }
        field(10; "Item Category Code"; Code[20]) { TableRelation = "Item Category".Code; }
        field(11; "Qty"; Decimal) { }
        field(12; "Product Size"; Text[50]) { }
        field(13; "Unit Price"; Decimal) { }
    }

    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.") { Clustered = true; }
    }

    trigger OnInsert()
    begin
        if "Line No." = 0 then
            "Line No." := GetNextLineNo("Document Type", "Document No.");
    end;

    local procedure GetNextLineNo(DocumentType: Enum "Custom Sales Document Type"; DocumentNo: Code[20]): Integer
    var
        CustomLine: Record "Custom Sales Line";
    begin
        CustomLine.SetRange("Document Type", DocumentType);
        CustomLine.SetRange("Document No.", DocumentNo);
        if CustomLine.FindLast() then
            exit(CustomLine."Line No." + 10000)
        else
            exit(10000);
    end;
}
