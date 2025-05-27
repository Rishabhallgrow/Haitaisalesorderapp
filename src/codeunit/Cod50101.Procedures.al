codeunit 50101 Procedures
{
    trigger OnRun()
    begin

    end;

    //AGT.AA_05.19.2025..>>
    procedure CreateSalesHeader(CustomHeader: Record "Custom Sales Header"; CustomLines: Record "Custom Sales Line")
    var
        SH: Record "Sales Header";
    begin
        SH.Init();
        SH.Validate("Document Type", SH."Document Type"::Order);
        // SH.Validate("No.", CustomHeader."No.");
        SH.Validate("Sell-to Customer No.", CustomHeader."Customer No.");
        SH.Validate("External Document No.", CustomHeader."App Order No.");
        SH.Insert(true);
        if CustomLines.FindSet() then
            repeat
                CreateSalesLine(CustomLines, SH);
            until CustomLines.Next() = 0;
    end;

    procedure CreateSalesLine(CustomLines: Record "Custom Sales Line"; SalesHeaderVar: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        LineNo: Integer;
        IsSuccess: Boolean;
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesHeaderVar."Document Type");
        SalesLine.SetRange("Document No.", SalesHeaderVar."No.");
        if SalesLine.FindLast() then
            LineNo := SalesLine."Line No." + 10000
        else
            LineNo := 10000;

        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesHeaderVar."Document Type");
        SalesLine.Validate("Document No.", SalesHeaderVar."No.");

        // IF SalesLine.FINDSET THEN
        //   REPEAT
        //     SalesLine.DELETE;
        //   UNTIL SalesLine.NEXT = 0;

        SalesLine.Validate("Line No.", LineNo);
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", CustomLines."Item No.");
        SalesLine.Validate(Quantity, CustomLines.Qty);
        SalesLine.Validate("Unit Price", CustomLines."Unit Price");

        IsSuccess := SalesLine.Insert(true);
        if not IsSuccess then
            Error('Failed to insert Sales Line.');
    end;
    //AGT.AA_05.19.2025..<<

}