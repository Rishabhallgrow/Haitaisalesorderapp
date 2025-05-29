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
        SalesHeader.Validate("External Document No.", CustomHeader."PO Number");
        SalesHeader.Validate("Your Reference", CustomHeader."App Order No.");
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
                SalesLine.Insert(true);
                SalesLine.Validate("Each Price", CustomLine."Each Price");
                SalesLine.Modify(true);
            until CustomLine.Next() = 0;
        end else
            Message('No lines found for App Order No. %1', AppOrderNo);
    end;
    //AGT.RP_05.28.2025..<<
}
