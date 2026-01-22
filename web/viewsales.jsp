<%-- 
    Document   : viewsales
    Created on : 3 Jan 2026, 10:53:36
    Author     : joy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<%
    if (session.getAttribute("emp_id") == null) {
        response.sendRedirect("index.html");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Report - Mobile Shop</title>
    <style>
        /* ====== BASE STYLES ====== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Arial', sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
            padding: 20px;
            min-height: 100vh;
        }
        
        /* ====== HEADER ====== */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
        }
        
        .header h2 {
            color: #2c3e50;
            font-size: 28px;
            font-weight: 600;
        }
        
        .back-link {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s ease;
        }
        
        .back-link:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }
        
        /* ====== MAIN CONTAINER ====== */
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        /* ====== SUMMARY CARDS ====== */
        .summary-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .summary-card {
            background: white;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.08);
            text-align: center;
            border-top: 4px solid;
        }
        
        .summary-card:nth-child(1) {
            border-top-color: #3498db;
        }
        
        .summary-card:nth-child(2) {
            border-top-color: #2ecc71;
        }
        
        .summary-card:nth-child(3) {
            border-top-color: #9b59b6;
        }
        
        .summary-card:nth-child(4) {
            border-top-color: #e74c3c;
        }
        
        .summary-value {
            font-size: 32px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .summary-label {
            font-size: 14px;
            color: #7f8c8d;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        /* ====== TABLE-LIKE UI ====== */
        .sales-table-ui {
            background: white;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            overflow-x: auto;
        }
        
        .section-title {
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 20px;
            font-weight: 600;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-title::before {
            content: "📊";
            font-size: 24px;
        }
        
        /* ====== TABLE HEADER ====== */
        .table-header {
            display: grid;
            grid-template-columns: 60px 1fr 1fr 80px 100px 100px 100px 150px 120px;
            gap: 15px;
            padding: 16px;
            background-color: #2c3e50;
            border-radius: 6px;
            margin-bottom: 10px;
        }
        
        .header-cell {
            color: white;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        /* ====== TABLE BODY ====== */
        .table-body {
            max-height: 600px;
            overflow-y: auto;
            border: 1px solid #e8e8e8;
            border-radius: 6px;
        }
        
        .table-row {
            display: grid;
            grid-template-columns: 60px 1fr 1fr 80px 100px 100px 100px 150px 120px;
            gap: 15px;
            padding: 16px;
            border-bottom: 1px solid #eee;
            align-items: center;
            transition: background-color 0.2s ease;
        }
        
        .table-row:hover {
            background-color: #f8f9fa;
        }
        
        .table-row:last-child {
            border-bottom: none;
        }
        
        /* ====== TABLE CELLS ====== */
        .table-cell {
            font-size: 14px;
            color: #555;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .cell-id {
            font-weight: 600;
            color: #3498db;
        }
        
        .cell-brand {
            font-weight: 600;
            color: #2c3e50;
        }
        
        .cell-amount {
            font-weight: 600;
            color: #27ae60;
        }
        
        /* ====== DATE TIME FORMATTING ====== */
        .date-time-cell {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        
        .date-part {
            font-size: 14px;
            color: #555;
        }
        
        .time-part {
            font-size: 12px;
            color: #7f8c8d;
        }
        
        /* ====== PAYMENT BADGES ====== */
        .payment-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            display: inline-block;
            text-align: center;
            min-width: 70px;
        }
        
        .payment-cash {
            background-color: #d4edda;
            color: #155724;
        }
        
        .payment-upi {
            background-color: #d1ecf1;
            color: #0c5460;
        }
        
        .payment-card {
            background-color: #e2e3e5;
            color: #383d41;
        }
        
        /* ====== EMPTY STATE ====== */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
        }
        
        .empty-icon {
            font-size: 48px;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        
        /* ====== RESPONSIVE TABLE ====== */
        @media (max-width: 1200px) {
            .table-header,
            .table-row {
                grid-template-columns: 50px 1fr 1fr 70px 90px 90px 90px 130px 100px;
                gap: 12px;
                padding: 14px;
            }
        }
        
        @media (max-width: 992px) {
            .table-header,
            .table-row {
                grid-template-columns: 40px 1fr 1fr 60px 80px 80px 80px 110px 90px;
                gap: 10px;
                padding: 12px;
            }
            
            .header-cell,
            .table-cell {
                font-size: 13px;
            }
        }
        
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .summary-cards {
                grid-template-columns: repeat(2, 1fr);
            }
            
            /* Switch to vertical layout on mobile */
            .table-header {
                display: none; /* Hide header on mobile */
            }
            
            .table-body {
                max-height: none;
                overflow-y: visible;
            }
            
            .table-row {
                display: flex;
                flex-direction: column;
                gap: 12px;
                padding: 20px;
                border: 1px solid #e8e8e8;
                border-radius: 8px;
                margin-bottom: 15px;
                background: white;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            }
            
            .table-row:hover {
                background-color: #f8f9fa;
            }
            
            .mobile-row {
                display: grid;
                grid-template-columns: 120px 1fr;
                gap: 10px;
                width: 100%;
                padding: 8px 0;
                border-bottom: 1px solid #f0f0f0;
            }
            
            .mobile-row:last-child {
                border-bottom: none;
            }
            
            .mobile-label {
                font-weight: 600;
                color: #7f8c8d;
                font-size: 13px;
            }
            
            .mobile-value {
                color: #2c3e50;
                text-align: right;
            }
            
            .mobile-value.amount {
                color: #27ae60;
                font-weight: 600;
            }
            
            .mobile-date-time {
                display: flex;
                flex-direction: column;
                align-items: flex-end;
                gap: 4px;
            }
        }
        
        @media (max-width: 480px) {
            .summary-cards {
                grid-template-columns: 1fr;
            }
            
            body {
                padding: 15px;
            }
            
            .sales-table-ui {
                padding: 20px;
            }
        }
        
        @media print {
            .header, .summary-cards, .back-link {
                display: none;
            }
            
            .sales-table-ui {
                box-shadow: none;
                padding: 0;
            }
            
            .table-header {
                background-color: #2c3e50 !important;
                -webkit-print-color-adjust: exact;
            }
        }
        
        /* ====== ANIMATIONS ====== */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .table-row {
            animation: fadeIn 0.3s ease-out;
        }
        
        /* Mobile-only rows initially hidden */
        .table-row.mobile-only {
            display: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- HEADER -->
        <div class="header">
            <h2>📊 Sales Report</h2>
            <a href="dashboard.jsp" class="back-link">⬅ Back to Dashboard</a>
        </div>
        
        <%
            List<Map<String, Object>> sales =
                (List<Map<String, Object>>) request.getAttribute("sales");

            if (sales != null && !sales.isEmpty()) {
                // Calculate summary stats
                int totalSales = sales.size();
                int totalUnits = 0;
                double totalRevenue = 0;
                double avgSaleValue = 0;
                
                for (Map<String, Object> sale : sales) {
                    totalUnits += Integer.parseInt(sale.get("quantity_sold").toString());
                    totalRevenue += Double.parseDouble(sale.get("total").toString());
                }
                
                if (totalSales > 0) {
                    avgSaleValue = totalRevenue / totalSales;
                }
        %>
        
        <!-- SUMMARY CARDS -->
        <div class="summary-cards">
            <div class="summary-card">
                <div class="summary-value"><%= totalSales %></div>
                <div class="summary-label">Total Sales</div>
            </div>
            <div class="summary-card">
                <div class="summary-value"><%= totalUnits %></div>
                <div class="summary-label">Units Sold</div>
            </div>
            <div class="summary-card">
                <div class="summary-value">₹ <%= String.format("%.2f", totalRevenue) %></div>
                <div class="summary-label">Total Revenue</div>
            </div>
            <div class="summary-card">
                <div class="summary-value">₹ <%= String.format("%.2f", avgSaleValue) %></div>
                <div class="summary-label">Avg Sale Value</div>
            </div>
        </div>
        
        <!-- TABLE-LIKE UI -->
        <div class="sales-table-ui">
            <div class="section-title">Sales History</div>
            
            <!-- TABLE HEADER -->
            <div class="table-header">
                <div class="header-cell">Sale ID</div>
                <div class="header-cell">Brand</div>
                <div class="header-cell">Model</div>
                <div class="header-cell">Quantity</div>
                <div class="header-cell">Price</div>
                <div class="header-cell">Total</div>
                <div class="header-cell">Payment</div>
                <div class="header-cell">Date & Time</div>
                <div class="header-cell">Sold By</div>
            </div>
            
            <!-- TABLE BODY -->
            <div class="table-body">
                <%
                    for (Map<String, Object> row : sales) {
                        String paymentMethod = (String) row.get("payment_method");
                        String paymentClass = "payment-cash";
                        if ("UPI".equals(paymentMethod)) {
                            paymentClass = "payment-upi";
                        } else if ("Card".equals(paymentMethod)) {
                            paymentClass = "payment-card";
                        }
                        
                        // Get and format date
                        Object dateObj = row.get("sale_datetime");
                        String dateDisplay = "";
                        String timeDisplay = "";
                        
                        if (dateObj != null) {
                            String dateStr = dateObj.toString();
                            // Try to parse and format the date
                            try {
                                // If it's a timestamp string
                                if (dateStr.contains(" ")) {
                                    String[] parts = dateStr.split(" ");
                                    dateDisplay = parts[0];
                                    if (parts.length > 1) {
                                        timeDisplay = parts[1];
                                        // Format time if it looks like a timestamp
                                        if (timeDisplay.contains(":")) {
                                            String[] timeParts = timeDisplay.split(":");
                                            if (timeParts.length >= 2) {
                                                int hour = Integer.parseInt(timeParts[0]);
                                                String ampm = hour >= 12 ? "PM" : "AM";
                                                hour = hour % 12;
                                                hour = hour == 0 ? 12 : hour;
                                                timeDisplay = hour + ":" + timeParts[1] + " " + ampm;
                                            }
                                        }
                                    }
                                } else {
                                    dateDisplay = dateStr;
                                }
                            } catch (Exception e) {
                                dateDisplay = dateStr;
                                timeDisplay = "";
                            }
                        } else {
                            dateDisplay = "N/A";
                        }
                %>
                
                <!-- DESKTOP ROW -->
                <div class="table-row">
                    <div class="table-cell cell-id">#<%= row.get("sale_id") %></div>
                    <div class="table-cell cell-brand"><%= row.get("brand") %></div>
                    <div class="table-cell"><%= row.get("model") %></div>
                    <div class="table-cell"><%= row.get("quantity_sold") %></div>
                    <div class="table-cell">₹ <%= row.get("sold_price") %></div>
                    <div class="table-cell cell-amount">₹ <%= row.get("total") %></div>
                    <div class="table-cell">
                        <span class="payment-badge <%= paymentClass %>">
                            <%= paymentMethod %>
                        </span>
                    </div>
                    <div class="table-cell date-time-cell">
                        <div class="date-part"><%= dateDisplay %></div>
                        <% if (!timeDisplay.isEmpty()) { %>
                        <div class="time-part"><%= timeDisplay %></div>
                        <% } %>
                    </div>
                    <div class="table-cell"><%= row.get("username") %></div>
                </div>
                
                <!-- MOBILE ROW (hidden on desktop) -->
                <div class="table-row mobile-only">
                    <div class="mobile-row">
                        <div class="mobile-label">Sale ID:</div>
                        <div class="mobile-value cell-id">#<%= row.get("sale_id") %></div>
                    </div>
                    <div class="mobile-row">
                        <div class="mobile-label">Product:</div>
                        <div class="mobile-value"><%= row.get("brand") %> <%= row.get("model") %></div>
                    </div>
                    <div class="mobile-row">
                        <div class="mobile-label">Quantity:</div>
                        <div class="mobile-value"><%= row.get("quantity_sold") %></div>
                    </div>
                    <div class="mobile-row">
                        <div class="mobile-label">Unit Price:</div>
                        <div class="mobile-value">₹ <%= row.get("sold_price") %></div>
                    </div>
                    <div class="mobile-row">
                        <div class="mobile-label">Total:</div>
                        <div class="mobile-value amount">₹ <%= row.get("total") %></div>
                    </div>
                    <div class="mobile-row">
                        <div class="mobile-label">Payment:</div>
                        <div class="mobile-value">
                            <span class="payment-badge <%= paymentClass %>">
                                <%= paymentMethod %>
                            </span>
                        </div>
                    </div>
                    <div class="mobile-row">
                        <div class="mobile-label">Date:</div>
                        <div class="mobile-value mobile-date-time">
                            <div><%= dateDisplay %></div>
                            <% if (!timeDisplay.isEmpty()) { %>
                            <div style="font-size: 11px; color: #7f8c8d;"><%= timeDisplay %></div>
                            <% } %>
                        </div>
                    </div>
                    <div class="mobile-row">
                        <div class="mobile-label">Sold By:</div>
                        <div class="mobile-value"><%= row.get("username") %></div>
                    </div>
                </div>
                
                <%
                    }
                %>
            </div>
        </div>
        
        <%
            } else {
        %>
        
        <!-- EMPTY STATE -->
        <div class="sales-table-ui">
            <div class="section-title">Sales History</div>
            <div class="empty-state">
                <div class="empty-icon">📊</div>
                <h3>No Sales Found</h3>
                <p>No sales transactions have been recorded yet.</p>
            </div>
        </div>
        
        <%
            }
        %>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Show/hide mobile/desktop rows based on screen size
            function adjustLayout() {
                const isMobile = window.innerWidth <= 768;
                const desktopRows = document.querySelectorAll('.table-row:not(.mobile-only)');
                const mobileRows = document.querySelectorAll('.table-row.mobile-only');
                
                if (isMobile) {
                    desktopRows.forEach(row => row.style.display = 'none');
                    mobileRows.forEach(row => row.style.display = 'flex');
                } else {
                    desktopRows.forEach(row => row.style.display = 'grid');
                    mobileRows.forEach(row => row.style.display = 'none');
                }
            }
            
            // Initial adjustment
            adjustLayout();
            
            // Adjust on resize
            window.addEventListener('resize', adjustLayout);
            
            // Add zebra striping
            const desktopRows = document.querySelectorAll('.table-row:not(.mobile-only)');
            desktopRows.forEach((row, index) => {
                if (index % 2 === 0) {
                    row.style.backgroundColor = '#f8f9fa';
                }
            });
        });
    </script>
    
    <style>
        /* Hide/show based on screen size */
        @media (max-width: 768px) {
            .table-row:not(.mobile-only) {
                display: none !important;
            }
            
            .table-row.mobile-only {
                display: flex !important;
            }
        }
    </style>
</body>
</html>