//AGT.RP_05.28.2025..>>
table 50101 "Custom Sales Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "Custom Sales Document Type") { }
        field(2; "Document No."; Code[20]) { }
        field(3; "Line No."; Integer) { AutoIncrement = true; }
        field(4; "App Order No."; Code[20]) { }
        field(5; "Item No."; Code[20])
        {
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                ItemRec: Record Item;
            begin
                if ItemRec.Get("Item No.") then
                    "Unit Price" := ItemRec."Unit Price";
            end;


        }
        field(6; "Description"; Text[100]) { }
        field(7; "Description 2"; Text[100]) { }
        field(8; "Price Type"; Option) { OptionMembers = "M","P1","P2"; }
        field(9; "Each Price"; Decimal) { }
        field(10; "Item Category Code"; Code[20]) { }
        field(11; "Qty"; Decimal) { }
        field(12; "Product Size"; Text[50]) { }
        field(13; "Unit Price"; Decimal) { }
    }

    keys
    {
        key(PK; "App Order No.", "Line No.") { Clustered = true; }
    }

}
//AGT.RP_05.28.2025..<<
