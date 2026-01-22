<%-- 
    Document   : bill
    Created on : 3 Jan 2026, 10:36:03
    Author     : joy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("emp_id") == null) {
        response.sendRedirect("index.html");
        return;
    }
%>

<<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sale Invoice - Mobile Shop</title>
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
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        /* ====== INVOICE CONTAINER ====== */
        .invoice-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            overflow: hidden;
        }
        
        /* ====== HEADER SECTION ====== */
        .invoice-header {
            background: #2c3e50;
            color: white;
            padding: 25px 30px;
            text-align: center;
        }
        
        .invoice-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .invoice-subtitle {
            font-size: 14px;
            opacity: 0.9;
            margin-bottom: 15px;
        }
        
        .invoice-date {
            font-size: 14px;
            opacity: 0.8;
        }
        
        /* ====== CONTENT SECTION ====== */
        .invoice-content {
            padding: 30px;
        }
        
        /* ====== SALE DETAILS ====== */
        .sale-details {
            margin-bottom: 30px;
        }
        
        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .details-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .details-table td {
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .details-table td:first-child {
            color: #7f8c8d;
            font-weight: 500;
            width: 40%;
        }
        
        .details-table td:last-child {
            color: #2c3e50;
            font-weight: 600;
            text-align: right;
        }
        
        .details-table tr:last-child td {
            border-bottom: none;
        }
        
        /* ====== PAYMENT METHOD ====== */
        .payment-method {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin: 25px 0;
            border-left: 4px solid #3498db;
        }
        
        .payment-title {
            font-size: 16px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .payment-display {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .payment-icon {
            font-size: 24px;
        }
        
        .payment-name {
            font-size: 18px;
            font-weight: 700;
            color: #2c3e50;
        }
        
        /* ====== TOTAL SECTION ====== */
        .total-section {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 8px;
            margin: 30px 0;
            text-align: center;
            border: 2px solid #e0e0e0;
        }
        
        .total-label {
            font-size: 14px;
            color: #7f8c8d;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .total-amount {
            font-size: 42px;
            font-weight: 800;
            color: #27ae60;
        }
        
        /* ====== ACTION BUTTONS ====== */
        .action-buttons {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-top: 30px;
        }
        
        .btn-confirm {
            background: #27ae60;
            color: white;
            border: none;
            padding: 16px;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-confirm:hover {
            background: #219653;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(39, 174, 96, 0.3);
        }
        
        .btn-cancel {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 16px;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
        }
        
        .btn-cancel:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }
        
        /* ====== FOOTER ====== */
        .invoice-footer {
            background: #f8f9fa;
            padding: 20px 30px;
            border-top: 2px solid #e9ecef;
            text-align: center;
        }
        
        .footer-text {
            color: #7f8c8d;
            font-size: 13px;
            margin-bottom: 10px;
        }
        
        .invoice-id {
            color: #95a5a6;
            font-size: 12px;
        }
        
        /* ====== RESPONSIVE ====== */
        @media (max-width: 768px) {
            .invoice-container {
                max-width: 100%;
            }
            
            .invoice-header {
                padding: 20px;
            }
            
            .invoice-content {
                padding: 25px 20px;
            }
            
            .action-buttons {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            
            .total-amount {
                font-size: 36px;
            }
        }
        
        @media print {
            body {
                background: white;
                padding: 0;
            }
            
            .invoice-container {
                box-shadow: none;
                max-width: 100%;
            }
            
            .btn-cancel {
                display: none;
            }
            
            .invoice-header {
                background: #2c3e50 !important;
                -webkit-print-color-adjust: exact;
            }
        }
    </style>
</head>
<body>
    <div class="invoice-container">
        <!-- HEADER -->
        <div class="invoice-header">
            <div class="invoice-title">SALE INVOICE</div>
            <div class="invoice-subtitle">Mobile Shop Management System</div>
            <div class="invoice-date">
                <%= new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm a").format(new java.util.Date()) %>
            </div>
        </div>
        
        <!-- CONTENT -->
        <div class="invoice-content">
            <!-- SALE DETAILS -->
            <div class="sale-details">
                <div class="section-title">Sale Details</div>
                <table class="details-table">
                    <tr>
                        <td>Brand:</td>
                        <td><%= request.getAttribute("brand") %></td>
                    </tr>
                    <tr>
                        <td>Model:</td>
                        <td><%= request.getAttribute("model") %></td>
                    </tr>
                    <tr>
                        <td>Mobile ID:</td>
                        <td>#<%= request.getAttribute("mobileId") %></td>
                    </tr>
                    <tr>
                        <td>Quantity:</td>
                        <td><%= request.getAttribute("quantity") %> units</td>
                    </tr>
                    <tr>
                        <td>Unit Price:</td>
                        <td>₹ <%= request.getAttribute("price") %></td>
                    </tr>
                    <tr>
                        <td>Sold By:</td>
                        <td>Employee #<%= session.getAttribute("emp_id") %></td>
                    </tr>
                </table>
            </div>
            
            <!-- PAYMENT METHOD -->
            <div class="payment-method">
                <div class="payment-title">Payment Method</div>
                <div class="payment-display">
                    <%
                        String paymentMethod = (String) request.getAttribute("paymentMethod");
                        String paymentIcon = "💰";
                        if ("UPI".equals(paymentMethod)) paymentIcon = "📱";
                        else if ("Card".equals(paymentMethod)) paymentIcon = "💳";
                    %>
                    <div class="payment-icon"><%= paymentIcon %></div>
                    <div class="payment-name"><%= paymentMethod %></div>
                </div>
            </div>
            
            <!-- TOTAL SECTION -->
            <div class="total-section">
                <div class="total-label">Total Amount</div>
                <div class="total-amount">₹ <%= request.getAttribute("total") %></div>
            </div>
            
            <!-- ACTION BUTTONS -->
            <form action="ConfimPaymenturl" method="post">
                <input type="hidden" name="mobile_id" value="<%= request.getAttribute("mobileId") %>">
                <input type="hidden" name="quantity" value="<%= request.getAttribute("quantity") %>">
                <input type="hidden" name="price" value="<%= request.getAttribute("price") %>">
                <input type="hidden" name="payment_method" value="<%= request.getAttribute("paymentMethod") %>">
                
                <div class="action-buttons">
                    <button type="submit" class="btn-confirm">
                        ✅ Confirm Payment
                    </button>
                    <a href="sellmobile.jsp" class="btn-cancel">
                        ❌ Cancel
                    </a>
                </div>
            </form>
        </div>
        
        <!-- FOOTER -->
        <div class="invoice-footer">
            <div class="footer-text">
                Thank you for your business
            </div>
            <div class="invoice-id">
                Invoice #<%= System.currentTimeMillis() %>
            </div>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Confirmation dialog
            document.querySelector('form').addEventListener('submit', function(e) {
                e.preventDefault();
                
                const brand = '<%= request.getAttribute("brand") %>';
                const model = '<%= request.getAttribute("model") %>';
                const quantity = '<%= request.getAttribute("quantity") %>';
                const total = '<%= request.getAttribute("total") %>';
                const paymentMethod = '<%= request.getAttribute("paymentMethod") %>';
                
                if (confirm(`Confirm Sale:\n\n${brand} ${model}\nQuantity: ${quantity}\nPayment: ${paymentMethod}\nTotal: ₹ ${total}\n\nProceed?`)) {
                    // Show processing state
                    const submitBtn = this.querySelector('.btn-confirm');
                    submitBtn.innerHTML = 'Processing...';
                    submitBtn.disabled = true;
                    
                    // Submit form after 1 second
                    setTimeout(() => {
                        this.submit();
                    }, 1000);
                }
            });
            
            // Add print button
            const printButton = document.createElement('button');
            printButton.innerHTML = '🖨️ Print';
            printButton.style.cssText = `
                position: fixed;
                bottom: 20px;
                right: 20px;
                background: #3498db;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-weight: 600;
                box-shadow: 0 3px 10px rgba(0,0,0,0.2);
                z-index: 1000;
            `;
            
            printButton.addEventListener('click', function() {
                window.print();
            });
            
            document.body.appendChild(printButton);
        });
    </script>
</body>
</html>