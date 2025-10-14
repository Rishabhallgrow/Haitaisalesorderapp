table 54501 "Custom Sales Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "Custom Sales Document Type") { }
        field(2; "Document No."; Code[20]) { }

        field(3; "Line No."; Integer) { }

        field(4; "App Order No."; Code[20])
        {
            trigger OnValidate()
            var
                SalesLine: Record "Custom Sales Line";
                NextLineNo: Integer;
            begin
                if "Line No." = 0 then begin
                    SalesLine.SetRange("App Order No.", "App Order No.");
                    if SalesLine.FindLast() then
                        NextLineNo := SalesLine."Line No." + 10000
                    else
                        NextLineNo := 10000;

                    "Line No." := NextLineNo;
                end;
            end;
        }

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
    procedure InsertSalesLine(AppOrderNo: Code[20]; ItemNo: Code[20]; Qty: Decimal)
    var
        NewLine: Record "Custom Sales Line";
        ItemRec: Record Item;
    begin
        NewLine.Init();
        NewLine."App Order No." := AppOrderNo; // Triggers Line No. assignment
        NewLine."Item No." := ItemNo;
        NewLine."Qty" := Qty;

        if ItemRec.Get(ItemNo) then begin
            NewLine."Description" := ItemRec.Description;
            NewLine."Unit Price" := ItemRec."Unit Price";
        end;

        NewLine.Insert(true);
    end;
}