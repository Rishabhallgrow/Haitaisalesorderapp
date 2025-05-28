//AGT.RP_05.28.2025..>>
table 50100 "Custom Sales Header"
{
    //
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Document Type"; Enum "Custom Sales Document Type") { }
        field(2; "No."; Code[20]) { }
        field(3; "App Order No."; Code[20]) { }
        field(4; "Customer No."; Code[20]) { TableRelation = Customer."No."; }
        field(5; "PO Number"; Code[35]) { }
        field(6; "BC Document No."; Code[20]) { }
        field(7; "Status"; Option)
        {
            OptionMembers = Open,Submitted;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "App Order No.") { Clustered = true; }
    }
}
//AGT.RP_05.28.2025..<<
