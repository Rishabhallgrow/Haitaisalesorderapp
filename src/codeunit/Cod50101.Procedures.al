// codeunit 50101 Procedures
// {
//     trigger OnRun()
//     begin

//     end;

//     //AGT.AA_05.19.2025..>>
//     procedure CreateSalesHeader(CustomHeader: Record "Custom Sales Header"; CustomLines: Record "Custom Sales Line")
//     var
//         SH: Record "Sales Header";
//     begin
//         SH.Init();
//         SH.Validate("Document Type", SH."Document Type"::Order);
//         // SH.Validate("No.", CustomHeader."No.");
//         SH.Validate("Sell-to Customer No.", CustomHeader."Customer No.");
//         SH.Validate("External Document No.", CustomHeader."App Order No.");
//         SH.Insert(true);
//         if CustomLines.FindSet() then
//             repeat
//                 CreateSalesLine(CustomLines, SH);
//             until CustomLines.Next() = 0;
//     end;

//     procedure CreateSalesLine(CustomLines: Record "Custom Sales Line"; SalesHeaderVar: Record "Sales Header")
//     var
//         SalesLine: Record "Sales Line";
//         LineNo: Integer;
//         IsSuccess: Boolean;
//     begin
//         SalesLine.Reset();
//         SalesLine.SetRange("Document Type", SalesHeaderVar."Document Type");
//         SalesLine.SetRange("Document No.", SalesHeaderVar."No.");
//         // if SalesLine.FindLast() then
//         //     LineNo := SalesLine."Line No." + 10000
//         // else
//         //     LineNo := 10000;

//         SalesLine.Init();
//         SalesLine.Validate("Document Type", SalesHeaderVar."Document Type");
//         SalesLine.Validate("Document No.", SalesHeaderVar."No.");

//         IF SalesLine.FINDSET THEN
//             REPEAT
//                 SalesLine.DELETE;
//             UNTIL SalesLine.NEXT = 0;

//         SalesLine.Validate("Line No.", LineNo);
//         SalesLine.Validate(Type, SalesLine.Type::Item);
//         SalesLine.Validate("No.", CustomLines."Item No.");
//         SalesLine.Validate(Quantity, CustomLines.Qty);
//         SalesLine.Validate("Unit Price", CustomLines."Unit Price");

//         IsSuccess := SalesLine.Insert(true);
//         if not IsSuccess then
//             Error('Failed to insert Sales Line.');
//     end;
//     //AGT.AA_05.19.2025..<<

// }
codeunit 50101 Procedures
{
    //AGT.RP_05.28.2025..>>
    procedure CreateSalesOrderFromAppOrderNo(AppOrderNo: Code[20])
    var
        CustomHeader: Record "Custom Sales Header";
        CustomLine: Record "Custom Sales Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
    begin
        // Get the custom header for the given App Order No.
        if not CustomHeader.Get(AppOrderNo) then
            Error('Custom Sales Header with App Order No. %1 not found.', AppOrderNo);

        // Create Sales Header
        SalesHeader.Init();
        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.Validate("Sell-to Customer No.", CustomHeader."Customer No.");
        SalesHeader.Validate("External Document No.", CustomHeader."App Order No.");
        SalesHeader.Insert(true);

        // Filter and loop through custom lines
        CustomLine.SetRange("App Order No.", AppOrderNo);
        if CustomLine.FindSet() then begin
            repeat
                // Determine next available Line No.
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                if SalesLine.FindLast() then
                    LineNo := SalesLine."Line No." + 10000
                else
                    LineNo := 10000;

                // Create Sales Line
                SalesLine.Init();
                SalesLine.Validate("Document Type", SalesHeader."Document Type");
                SalesLine.Validate("Document No.", SalesHeader."No.");
                SalesLine.Validate("Line No.", LineNo);
                SalesLine.Validate(Type, SalesLine.Type::Item);
                SalesLine.Validate("No.", CustomLine."Item No.");
                SalesLine.Validate(Quantity, CustomLine.Qty);
                SalesLine.Validate("Unit Price", CustomLine."Unit Price");
                SalesLine.Insert(true);
                SalesLine.Validate("Each Price", CustomLine."Each Price");
                // SalesLine."Each Price" := CustomLine."Each Price";
                Message('data %1', CustomLine."Each Price");
                SalesLine.Modify(true);

                Message('Each price is %1', SalesLine."Each Price");
            until CustomLine.Next() = 0;
        end else
            Message('No lines found for App Order No. %1', AppOrderNo);
    end;
    //AGT.RP_05.28.2025..<<
}
