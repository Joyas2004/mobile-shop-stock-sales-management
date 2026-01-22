<%-- 
    Document   : sellmobile
    Created on : 3 Jan 2026, 10:06:15
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
    <title>Sell Mobile - Mobile Shop</title>
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
            font-weight: 600;
            transition: all 0.2s ease;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        
        .back-link:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.25);
        }
        
        /* ====== MAIN CONTAINER ====== */
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        /* ====== MESSAGE STYLES ====== */
        .message-container {
            margin-bottom: 25px;
        }
        
        .message {
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 15px;
            font-size: 14px;
            border-left: 4px solid;
        }
        
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border-left-color: #dc3545;
        }
        
        .info-message {
            background-color: #d1ecf1;
            color: #0c5460;
            border-left-color: #17a2b8;
        }
        
        .success-message {
            background-color: #d4edda;
            color: #155724;
            border-left-color: #28a745;
        }
        
        /* ====== SEARCH SECTION ====== */
        .section {
            background: white;
            border-radius: 10px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
        }
        
        .section h3 {
            color: #2c3e50;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
            font-size: 22px;
            font-weight: 600;
        }
        
        /* ====== FORM STYLES ====== */
        .search-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            align-items: end;
        }
        
        .form-group {
            margin-bottom: 0;
        }
        
        label {
            display: block;
            margin-bottom: 10px;
            color: #34495e;
            font-weight: 600;
            font-size: 14px;
        }
        
        input[type="text"],
        input[type="number"],
        select {
            width: 100%;
            padding: 14px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 15px;
            background-color: #f9f9f9;
        }
        
        input[type="text"]:focus,
        input[type="number"]:focus,
        select:focus {
            outline: none;
            border-color: #3498db;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        /* ====== BUTTONS ====== */
        .btn-primary {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 14px 28px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.2s ease;
            width: 100%;
            box-shadow: 0 2px 5px rgba(52, 152, 219, 0.3);
        }
        
        .btn-primary:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.4);
        }
        
        /* ====== RESULTS SECTION ====== */
        .results-section {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
            min-height: 400px;
        }
        
        .results-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .results-title {
            color: #2c3e50;
            font-size: 22px;
            font-weight: 600;
        }
        
        .results-count {
            background: #3498db;
            color: white;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }
        
        /* ====== MOBILE CARDS ====== */
        .mobile-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 30px;
        }
        
        .mobile-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 3px 20px rgba(0,0,0,0.1);
            border: 1px solid #e8e8e8;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            min-height: 320px;
        }
        
        .mobile-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            border-color: #3498db;
        }
        
        .mobile-card.out-of-stock {
            opacity: 0.8;
            border-top: 4px solid #e74c3c;
        }
        
        .mobile-card.low-stock {
            border-top: 4px solid #f39c12;
        }
        
        .mobile-card.available {
            border-top: 4px solid #27ae60;
        }
        
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }
        
        .mobile-title {
            font-size: 20px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 5px;
        }
        
        .mobile-id {
            color: #7f8c8d;
            font-size: 13px;
        }
        
        .status-badge {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .status-available {
            background: #d4edda;
            color: #155724;
        }
        
        .status-low {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-out {
            background: #f8d7da;
            color: #721c24;
        }
        
        .specs-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin: 20px 0;
        }
        
        .spec-item {
            text-align: center;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 6px;
        }
        
        .spec-label {
            font-size: 12px;
            color: #7f8c8d;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }
        
        .spec-value {
            font-size: 18px;
            font-weight: 700;
            color: #2c3e50;
        }
        
        .price-display {
            text-align: center;
            margin: 20px 0;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .price-label {
            font-size: 14px;
            color: #7f8c8d;
            margin-bottom: 8px;
        }
        
        .price-value {
            font-size: 28px;
            font-weight: 800;
            color: #27ae60;
        }
        
        /* ====== SELL FORM ====== */
        .sell-form-container {
            margin-top: auto;
        }
        
        .sell-form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        
        .form-input-group {
            display: flex;
            flex-direction: column;
        }
        
        .form-input-group label {
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
        }
        
        .sell-btn {
            grid-column: span 2;
            background: linear-gradient(135deg, #27ae60 0%, #219653 100%);
            color: white;
            border: none;
            padding: 16px;
            border-radius: 8px;
            font-size: 17px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
            box-shadow: 0 2px 5px rgba(39, 174, 96, 0.3);
        }
        
        .sell-btn:hover {
            background: linear-gradient(135deg, #219653 0%, #1e8449 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(39, 174, 96, 0.4);
        }
        
        .sell-btn:disabled {
            background: #95a5a6;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .total-display {
            grid-column: span 2;
            text-align: center;
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin: 15px 0;
            border: 2px solid #e0e0e0;
        }
        
        .total-label {
            font-size: 14px;
            color: #7f8c8d;
            margin-bottom: 8px;
        }
        
        .total-value {
            font-size: 26px;
            font-weight: 800;
            color: #2c3e50;
        }
        
        /* ====== UNAVAILABLE MESSAGE ====== */
        .unavailable-message {
            text-align: center;
            padding: 25px;
            background: #f8d7da;
            border-radius: 8px;
            color: #721c24;
            margin-top: 20px;
        }
        
        /* ====== EMPTY STATE ====== */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
        }
        
        .empty-icon {
            font-size: 60px;
            margin-bottom: 20px;
            opacity: 0.4;
        }
        
        .empty-state h3 {
            font-size: 22px;
            margin-bottom: 15px;
            color: #2c3e50;
        }
        
        .empty-state p {
            font-size: 16px;
            max-width: 500px;
            margin: 0 auto;
            line-height: 1.6;
        }
        
        /* ====== RESPONSIVE ====== */
        @media (max-width: 1024px) {
            .mobile-grid {
                grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            }
        }
        
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .search-form {
                grid-template-columns: 1fr;
            }
            
            .mobile-grid {
                grid-template-columns: 1fr;
            }
            
            .sell-form-grid {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            
            .sell-btn {
                grid-column: span 1;
            }
            
            .total-display {
                grid-column: span 1;
            }
            
            .specs-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 480px) {
            .specs-grid {
                grid-template-columns: 1fr;
            }
            
            .mobile-card {
                min-height: auto;
            }
            
            body {
                padding: 15px;
            }
        }
        
        /* ====== ANIMATIONS ====== */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .mobile-card {
            animation: fadeInUp 0.5s ease-out;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- HEADER (Now matches stock/sales report style) -->
        <div class="header">
            <h2>💰 Sell Mobile</h2>
            <a href="dashboard.jsp" class="back-link">⬅ Back to Dashboard</a>
        </div>
        
        <!-- MESSAGES -->
        <div class="message-container">
            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
                <div class="message error-message">
                    <strong>Error:</strong> <%= error %>
                </div>
            <%
                }

                String info = (String) request.getAttribute("info");
                if (info != null) {
            %>
                <div class="message info-message">
                    <strong>Info:</strong> <%= info %>
                </div>
            <%
                }
            %>
        </div>
        
        <!-- SEARCH SECTION -->
        <div class="section">
            <h3>Search Mobile for Sale</h3>
            <form action="SearchSellMobileurl" method="get" class="search-form">
                <div class="form-group">
                    <label for="brand">Brand</label>
                    <input type="text" id="brand" name="brand" placeholder="Samsung, Apple, etc." autofocus>
                </div>
                
                <div class="form-group">
                    <label for="model">Model / Series</label>
                    <input type="text" id="model" name="model" placeholder="Galaxy S23, iPhone 15, etc.">
                </div>
                
                <div class="form-group">
                    <label for="searchType">Search Type</label>
                    <select id="searchType" name="searchType">
                        <option value="exact" selected>Exact Match</option>
                        <option value="broad">Brand / Series</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <input type="submit" value="Search Mobile" class="btn-primary">
                </div>
            </form>
        </div>
        
        <!-- RESULTS SECTION -->
        <%
            List<Map<String, Object>> sellSearch =
                (List<Map<String, Object>>) request.getAttribute("sellSearch");

            if (sellSearch != null && !sellSearch.isEmpty()) {
        %>
        
        <div class="results-section">
            <div class="results-header">
                <h3 class="results-title">Available Mobiles for Sale</h3>
                <div class="results-count"><%= sellSearch.size() %> mobiles found</div>
            </div>
            
            <div class="mobile-grid">
                <%
                    for (Map<String, Object> row : sellSearch) {
                        String status = (String) row.get("status");
                        int qty = (Integer) row.get("quantity");
                        String statusClass = "status-available";
                        String cardClass = "available";
                        
                        if ("available".equalsIgnoreCase(status)) {
                            statusClass = "status-available";
                        } else if (qty <= 0) {
                            statusClass = "status-out";
                            cardClass = "out-of-stock";
                        } else {
                            statusClass = "status-low";
                            cardClass = "low-stock";
                        }
                %>
                
                <div class="mobile-card <%= cardClass %>">
                    <div class="card-header">
                        <div>
                            <div class="mobile-title"><%= row.get("brand") %> <%= row.get("model") %></div>
                            <div class="mobile-id">ID: #<%= row.get("mobile_id") %></div>
                        </div>
                        <div class="status-badge <%= statusClass %>"><%= status %></div>
                    </div>
                    
                    <div class="specs-grid">
                        <div class="spec-item">
                            <div class="spec-label">RAM</div>
                            <div class="spec-value"><%= row.get("ram") != null ? row.get("ram") : "N/A" %></div>
                        </div>
                        <div class="spec-item">
                            <div class="spec-label">Storage</div>
                            <div class="spec-value"><%= row.get("storage") != null ? row.get("storage") + " GB" : "N/A" %></div>
                        </div>
                        <div class="spec-item">
                            <div class="spec-label">Available</div>
                            <div class="spec-value"><%= qty %> units</div>
                        </div>
                        <div class="spec-item">
                            <div class="spec-label">Max Qty</div>
                            <div class="spec-value"><%= qty %></div>
                        </div>
                    </div>
                    
                    <div class="price-display">
                        <div class="price-label">Unit Price</div>
                        <div class="price-value">₹ <%= row.get("price") %></div>
                    </div>
                    
                    <%
                        if ("available".equalsIgnoreCase(status) && qty > 0) {
                    %>
                    <div class="sell-form-container">
                        <form action="SellMobileurl" method="post" class="sell-form" id="sell-form-<%= row.get("mobile_id") %>">
                            <input type="hidden" name="brand" value="<%= row.get("brand") %>">
                            <input type="hidden" name="model" value="<%= row.get("model") %>">
                            
                            <div class="sell-form-grid">
                                <div class="form-input-group">
                                    <label for="quantity-<%= row.get("mobile_id") %>">Quantity</label>
                                    <input type="number" 
                                           id="quantity-<%= row.get("mobile_id") %>"
                                           name="quantity"
                                           min="1"
                                           max="<%= qty %>"
                                           value="1"
                                           required
                                           oninput="updateTotalPrice(this, <%= row.get("price") %>, '<%= row.get("mobile_id") %>')">
                                </div>
                                
                                <div class="form-input-group">
                                    <label for="payment-<%= row.get("mobile_id") %>">Payment Method</label>
                                    <select id="payment-<%= row.get("mobile_id") %>" name="payment_method" required>
                                        <option value="Cash">Cash</option>
                                        <option value="UPI">UPI</option>
                                        <option value="Card">Card</option>
                                    </select>
                                </div>
                                
                                <div class="total-display" id="total-<%= row.get("mobile_id") %>">
                                    <div class="total-label">Total Amount</div>
                                    <div class="total-value">₹ <%= row.get("price") %></div>
                                </div>
                                
                                <button type="submit" class="sell-btn">
                                    ✅ Process Sale
                                </button>
                            </div>
                        </form>
                    </div>
                    <%
                        } else {
                    %>
                    <div class="unavailable-message">
                        <strong>⛔ Not Available for Sale</strong>
                        <p style="margin-top: 10px; font-size: 14px;">
                            <%= qty <= 0 ? "This product is currently out of stock." : "Product status: " + status %>
                        </p>
                    </div>
                    <%
                        }
                    %>
                </div>
                
                <%
                    }
                %>
            </div>
        </div>
        
        <%
            } else if (sellSearch != null && sellSearch.isEmpty()) {
        %>
        
        <div class="results-section">
            <div class="empty-state">
                <div class="empty-icon">🔍</div>
                <h3>No Mobiles Found</h3>
                <p>Your search didn't return any results. Try searching with different brand names or model series.</p>
            </div>
        </div>
        
        <%
            } else {
        %>
        
        <div class="results-section">
            <div class="empty-state">
                <div class="empty-icon">📱</div>
                <h3>Search for Mobiles</h3>
                <p>Enter a brand or model name in the search form above to view available mobile phones for sale.</p>
            </div>
        </div>
        
        <%
            }
        %>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Real-time price calculation
            window.updateTotalPrice = function(input, unitPrice, mobileId) {
                const quantity = parseInt(input.value) || 1;
                const maxQty = parseInt(input.getAttribute('max'));
                
                // Validate quantity
                if (quantity > maxQty) {
                    input.value = maxQty;
                    return updateTotalPrice(input, unitPrice, mobileId);
                }
                
                const total = quantity * unitPrice;
                const totalElement = document.getElementById('total-' + mobileId);
                if (totalElement) {
                    totalElement.querySelector('.total-value').textContent = '₹ ' + total.toLocaleString('en-IN');
                }
            };
            
            // Form validation and submission
            const sellForms = document.querySelectorAll('.sell-form');
            sellForms.forEach(form => {
                form.addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    const quantityInput = this.querySelector('input[name="quantity"]');
                    const submitBtn = this.querySelector('.sell-btn');
                    const maxQty = parseInt(quantityInput.getAttribute('max'));
                    const enteredQty = parseInt(quantityInput.value);
                    
                    // Validate quantity
                    if (enteredQty > maxQty) {
                        alert(`Quantity cannot exceed available stock of ${maxQty} units.`);
                        quantityInput.focus();
                        quantityInput.select();
                        return false;
                    }
                    
                    if (enteredQty < 1) {
                        alert('Please enter a valid quantity (minimum 1 unit).');
                        quantityInput.focus();
                        return false;
                    }
                    
                    // Show processing state
                    const originalText = submitBtn.innerHTML;
                    submitBtn.innerHTML = '🔄 Processing...';
                    submitBtn.disabled = true;
                    
                    // Submit form after 500ms to show loading
                    setTimeout(() => {
                        this.submit();
                    }, 500);
                    
                    return false;
                });
            });
            
            // Add animations to cards
            const cards = document.querySelectorAll('.mobile-card');
            cards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
            });
            
            // Auto-focus search input
            const searchInput = document.getElementById('brand');
            if (searchInput) {
                searchInput.focus();
            }
        });
    </script>
</body>
</html>