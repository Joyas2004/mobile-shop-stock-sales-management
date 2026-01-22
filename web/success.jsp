<%-- 
    Document   : success
    Created on : 3 Jan 2026, 10:41:01
    Author     : joy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <title>Success - Mobile Shop</title>
    <style>
        /* ====== BASE STYLES ====== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Arial', sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e3e9f7 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        /* ====== SUCCESS CARD ====== */
        .success-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            padding: 40px;
            text-align: center;
        }
        
        /* ====== SUCCESS ICON ====== */
        .success-icon {
            width: 80px;
            height: 80px;
            background: #27ae60;
            border-radius: 50%;
            margin: 0 auto 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            animation: scaleIn 0.5s ease-out;
        }
        
        .success-icon::before {
            content: "✓";
            color: white;
            font-size: 40px;
            font-weight: bold;
        }
        
        @keyframes scaleIn {
            0% {
                transform: scale(0);
                opacity: 0;
            }
            70% {
                transform: scale(1.2);
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }
        
        /* ====== PULSE EFFECT ====== */
        .success-icon::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            border: 2px solid #27ae60;
            border-radius: 50%;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% {
                transform: scale(1);
                opacity: 0.8;
            }
            100% {
                transform: scale(1.5);
                opacity: 0;
            }
        }
        
        /* ====== TEXT CONTENT ====== */
        .success-title {
            color: #2c3e50;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 15px;
        }
        
        .success-message {
            color: #7f8c8d;
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        
        /* ====== SUCCESS DETAILS ====== */
        .success-details {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin: 25px 0;
            border-left: 4px solid #27ae60;
        }
        
        .detail-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #e8e8e8;
        }
        
        .detail-item:last-child {
            border-bottom: none;
        }
        
        .detail-label {
            color: #7f8c8d;
            font-weight: 500;
        }
        
        .detail-value {
            color: #2c3e50;
            font-weight: 600;
        }
        
        /* ====== ACTION BUTTONS ====== */
        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn-primary {
            background: #3498db;
            color: white;
            border: none;
            padding: 16px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .btn-primary:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }
        
        .btn-secondary {
            background: #2c3e50;
            color: white;
            border: none;
            padding: 16px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .btn-secondary:hover {
            background: #1a252f;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(44, 62, 80, 0.3);
        }
        
        /* ====== RECEIPT SUMMARY ====== */
        .receipt-summary {
            background: linear-gradient(135deg, #e8f5e9 0%, #d4edda 100%);
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
            text-align: center;
        }
        
        .summary-title {
            font-size: 18px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .summary-amount {
            font-size: 32px;
            font-weight: 800;
            color: #27ae60;
        }
        
        /* ====== RESPONSIVE ====== */
        @media (max-width: 600px) {
            .success-card {
                padding: 30px 20px;
                max-width: 100%;
            }
            
            .success-title {
                font-size: 24px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn-primary, .btn-secondary {
                width: 100%;
            }
        }
        
        /* ====== ANIMATIONS ====== */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .success-title, .success-message, .success-details, .action-buttons {
            animation: fadeIn 0.6s ease-out;
        }
        
        .success-title {
            animation-delay: 0.2s;
            animation-fill-mode: both;
        }
        
        .success-message {
            animation-delay: 0.4s;
            animation-fill-mode: both;
        }
        
        .success-details {
            animation-delay: 0.6s;
            animation-fill-mode: both;
        }
        
        .action-buttons {
            animation-delay: 0.8s;
            animation-fill-mode: both;
        }
    </style>
</head>
<body>
    <div class="success-card">
        <!-- SUCCESS ICON -->
        <div class="success-icon"></div>
        
        <!-- SUCCESS MESSAGE -->
        <h1 class="success-title">Payment Successful!</h1>
        <p class="success-message">
            ✅ Sale completed successfully<br>
            ✅ Stock and sales records updated<br>
            ✅ Transaction recorded in database
        </p>
        
        <!-- RECEIPT SUMMARY -->
        <%
            // Get transaction details from session or request if available
            String brand = (String) request.getAttribute("brand");
            String model = (String) request.getAttribute("model");
            String total = (String) request.getAttribute("total");
            
            if (brand != null && model != null && total != null) {
        %>
        <div class="receipt-summary">
            <div class="summary-title">Sale Completed</div>
            <div class="summary-amount">₹ <%= total %></div>
            <div style="margin-top: 10px; color: #7f8c8d; font-size: 14px;">
                <%= brand %> <%= model %>
            </div>
        </div>
        <%
            }
        %>
        
        <!-- SUCCESS DETAILS -->
        <div class="success-details">
            <div class="detail-item">
                <span class="detail-label">Transaction ID</span>
                <span class="detail-value">TXN-<%= System.currentTimeMillis() %></span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Date & Time</span>
                <span class="detail-value"><%= new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm a").format(new java.util.Date()) %></span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Employee ID</span>
                <span class="detail-value">#<%= session.getAttribute("emp_id") %></span>
            </div>
        </div>
        
        <!-- ACTION BUTTONS -->
        <div class="action-buttons">
            <a href="sellmobile.jsp" class="btn-primary">
                📱 Sell Another Mobile
            </a>
            <a href="dashboard.jsp" class="btn-secondary">
                🏠 Back to Dashboard
            </a>
        </div>
    </div>
</body>
</html>
