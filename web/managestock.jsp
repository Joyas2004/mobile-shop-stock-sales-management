<%-- 
    Document   : managestock
    Created on : 1 Jan 2026, 15:35:35
    Author     : joy
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
    <title>Stock Management - Mobile Shop</title>
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
            background-color: #2980b9;
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
            background-color: #1c5a87;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.25);
        }
        
        /* ====== MAIN CONTAINER ====== */
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        /* ====== SECTION STYLES ====== */
        .section {
            background: white;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
        }
        
        .section h3 {
            color: #2c3e50;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
            font-size: 20px;
            font-weight: 600;
        }
        
        /* ====== FULL-WIDTH TABLE DISPLAY ====== */
        .table-container {
            overflow-x: auto;
            margin-top: 20px;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            width: 100%;
        }
        
        .stock-table {
            width: 100%;
            table-layout: fixed;
        }
        
        /* VIEW STOCK TABLE - Full width, 8 columns */
        .table-header-view {
            display: grid;
            grid-template-columns: 8fr 12fr 15fr 8fr 8fr 10fr 8fr 10fr;
            background: #2c3e50;
            color: white;
            font-weight: 600;
            font-size: 14px;
            border-bottom: 2px solid #1a252f;
            width: 100%;
        }
        
        .table-row-view {
            display: grid;
            grid-template-columns: 8fr 12fr 15fr 8fr 8fr 10fr 8fr 10fr;
            border-bottom: 1px solid #e0e0e0;
            transition: background-color 0.2s;
            width: 100%;
        }
        
        /* SEARCH RESULTS TABLE - Same as View Stock */
        .table-header-search {
            display: grid;
            grid-template-columns: 8fr 12fr 15fr 8fr 8fr 10fr 8fr 10fr;
            background: #2c3e50;
            color: white;
            font-weight: 600;
            font-size: 14px;
            border-bottom: 2px solid #1a252f;
            width: 100%;
        }
        
        .table-row-search {
            display: grid;
            grid-template-columns: 8fr 12fr 15fr 8fr 8fr 10fr 8fr 10fr;
            border-bottom: 1px solid #e0e0e0;
            transition: background-color 0.2s;
            width: 100%;
        }
        
        /* RED ROW STYLES FOR out_of_stock AND discontinued */
        .table-row-view.out-of-stock,
        .table-row-search.out-of-stock {
            background-color: #fff5f5;
            color: #721c24;
            border-left: 4px solid #e74c3c;
        }
        
        .table-row-view.out-of-stock:hover,
        .table-row-search.out-of-stock:hover {
            background-color: #ffeaea;
        }
        
        .table-row-view.out-of-stock:nth-child(even),
        .table-row-search.out-of-stock:nth-child(even) {
            background-color: #ffeaea;
        }
        
        .table-row-view.out-of-stock:nth-child(even):hover,
        .table-row-search.out-of-stock:nth-child(even):hover {
            background-color: #ffdada;
        }
        
        /* RED TEXT FOR out_of_stock AND discontinued */
        .table-row-view.out-of-stock .table-cell,
        .table-row-search.out-of-stock .table-cell {
            color: #721c24;
            font-weight: 500;
        }
        
        .table-row-view.out-of-stock .mobile-brand,
        .table-row-search.out-of-stock .mobile-brand {
            color: #c0392b;
            font-weight: 600;
        }
        
        .table-row-view.out-of-stock .mobile-model,
        .table-row-search.out-of-stock .mobile-model {
            color: #e74c3c;
        }
        
        .table-row-view.out-of-stock .price-cell,
        .table-row-search.out-of-stock .price-cell {
            color: #c0392b;
            font-weight: 600;
        }
        
        .table-row-view:hover,
        .table-row-search:hover {
            background-color: #f8f9fa;
        }
        
        .table-row-view:nth-child(even),
        .table-row-search:nth-child(even) {
            background-color: #f8f9fa;
        }
        
        .table-row-view:nth-child(even):hover,
        .table-row-search:nth-child(even):hover {
            background-color: #e9ecef;
        }
        
        .table-cell {
            padding: 15px 12px;
            display: flex;
            align-items: center;
            font-size: 14px;
            color: #333;
            border-right: 1px solid #f0f0f0;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .header-cell {
            padding: 15px 12px;
            display: flex;
            align-items: center;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 13px;
            border-right: 1px solid #3a506b;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        /* Remove right border from last cell */
        .header-cell:last-child,
        .table-cell:last-child {
            border-right: none;
        }
        
        /* Status badges */
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-align: center;
            min-width: 100px;
            max-width: 120px;
        }
        
        .status-available {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .status-out {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .status-discontinued {
            background: #721c24;
            color: white;
            border: 1px solid #491217;
        }
        
        /* Price styling */
        .price-cell {
            color: #27ae60;
            font-weight: 600;
        }
        
        /* Mobile info */
        .mobile-info {
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }
        
        .mobile-brand {
            font-weight: 600;
            color: #2c3e50;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .mobile-model {
            color: #7f8c8d;
            font-size: 13px;
            margin-top: 3px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        /* ====== BUTTON COLOR SCHEME ====== */
        /* BLUE - For View/Refresh/Search buttons */
        .btn-blue {
            background-color: #2980b9;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
            box-shadow: 0 2px 5px rgba(41, 128, 185, 0.3);
        }
        
        .btn-blue:hover {
            background-color: #1c5a87;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(41, 128, 185, 0.4);
        }
        
        /* GREEN - For Add/Create buttons */
        .btn-green {
            background-color: #27ae60;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
            box-shadow: 0 2px 5px rgba(39, 174, 96, 0.3);
        }
        
        .btn-green:hover {
            background-color: #1e8449;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(39, 174, 96, 0.4);
        }
        
        /* ORANGE - For Update/Edit buttons */
        .btn-orange {
            background-color: #f39c12;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
            box-shadow: 0 2px 5px rgba(243, 156, 18, 0.3);
        }
        
        .btn-orange:hover {
            background-color: #d68910;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(243, 156, 18, 0.4);
        }
        
        /* RED - For Delete/Remove buttons */
        .btn-red {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
            box-shadow: 0 2px 5px rgba(231, 76, 60, 0.3);
        }
        
        .btn-red:hover {
            background-color: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(231, 76, 60, 0.4);
        }
        
        /* ====== FORM STYLES ====== */
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-row {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            margin-bottom: 15px;
        }
        
        .form-row .form-group {
            flex: 1;
            min-width: 200px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #34495e;
            font-weight: 500;
            font-size: 14px;
        }
        
        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            background-color: #f9f9f9;
        }
        
        input[type="text"]:focus,
        input[type="number"]:focus {
            outline: none;
            border-color: #3498db;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        /* ====== FORM SUBMIT BUTTONS ====== */
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            color: white;
        }
        
        /* View Stock button - BLUE */
        form[action="viewstockurl"] input[type="submit"] {
            background-color: #2980b9;
            box-shadow: 0 2px 5px rgba(41, 128, 185, 0.3);
        }
        
        form[action="viewstockurl"] input[type="submit"]:hover {
            background-color: #1c5a87;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(41, 128, 185, 0.4);
        }
        
        /* Search button - BLUE */
        form[action="SearchStockurl"] input[type="submit"] {
            background-color: #2980b9;
            box-shadow: 0 2px 5px rgba(41, 128, 185, 0.3);
        }
        
        form[action="SearchStockurl"] input[type="submit"]:hover {
            background-color: #1c5a87;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(41, 128, 185, 0.4);
        }
        
        /* Add Stock button - GREEN */
        form[action="AddStockurl"] input[type="submit"] {
            background-color: #27ae60;
            box-shadow: 0 2px 5px rgba(39, 174, 96, 0.3);
        }
        
        form[action="AddStockurl"] input[type="submit"]:hover {
            background-color: #1e8449;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(39, 174, 96, 0.4);
        }
        
        /* Update Stock button - ORANGE */
        form[action="UpdateStockurl"] input[type="submit"] {
            background-color: #f39c12;
            box-shadow: 0 2px 5px rgba(243, 156, 18, 0.3);
        }
        
        form[action="UpdateStockurl"] input[type="submit"]:hover {
            background-color: #d68910;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(243, 156, 18, 0.4);
        }
        
        /* Delete Stock button - RED */
        form[action="DeleteStockurl"] input[type="submit"] {
            background-color: #e74c3c;
            box-shadow: 0 2px 5px rgba(231, 76, 60, 0.3);
        }
        
        form[action="DeleteStockurl"] input[type="submit"]:hover {
            background-color: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(231, 76, 60, 0.4);
        }
        
        /* ====== ACTION GRID ====== */
        .action-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-top: 30px;
        }
        
        .action-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
        }
        
        .action-card h3 {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
            color: #2c3e50;
            font-size: 18px;
        }
        
        /* Color-coded action card titles */
        .add-card h3 { color: #27ae60; }
        .update-card h3 { color: #f39c12; }
        .delete-card h3 { color: #e74c3c; }
        
        /* ====== EMPTY STATE ====== */
        .empty-state {
            text-align: center;
            padding: 50px 20px;
            color: #7f8c8d;
        }
        
        .empty-icon {
            font-size: 48px;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        
        /* ====== RESPONSIVE ====== */
        @media (max-width: 1024px) {
            .table-header-view,
            .table-header-search,
            .table-row-view,
            .table-row-search {
                grid-template-columns: 7fr 11fr 14fr 7fr 7fr 9fr 7fr 9fr;
            }
        }
        
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .action-grid {
                grid-template-columns: 1fr;
            }
            
            .form-row {
                flex-direction: column;
                gap: 10px;
            }
            
            .table-container {
                font-size: 13px;
            }
            
            .header-cell,
            .table-cell {
                padding: 10px 8px;
                font-size: 12px;
            }
            
            .status-badge {
                min-width: 80px;
                font-size: 11px;
                padding: 4px 8px;
            }
        }
        
        /* ====== SEARCH FORM ====== */
        .search-form {
            display: flex;
            gap: 15px;
            align-items: flex-end;
            flex-wrap: wrap;
        }
        
        .search-form .form-group {
            flex: 1;
            min-width: 200px;
            margin-bottom: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- HEADER -->
        <div class="header">
            <h2>📱 Mobile Stock Management</h2>
            <a href="dashboard.jsp" class="back-link">⬅ Back to Dashboard</a>
        </div>
        
        <!-- ================= VIEW STOCK SECTION ================= -->
        <div class="section" id="viewStockSection">
            <h3>📋 Current Stock Inventory</h3>
            <form action="viewstockurl#viewStockSection" method="get">
                <input type="submit" value="Refresh Stock List" class="btn-blue">
            </form>
            
            <%
                List<Map<String, Object>> stocks =
                    (List<Map<String, Object>>) request.getAttribute("viewstocks");
                
                if (stocks != null && !stocks.isEmpty()) {
            %>
            
            <div class="table-container">
                <div class="stock-table">
                    <!-- Table Header - 8 columns full width -->
                    <div class="table-header-view">
                        <div class="header-cell">ID</div>
                        <div class="header-cell">Brand</div>
                        <div class="header-cell">Model</div>
                        <div class="header-cell">RAM</div>
                        <div class="header-cell">Storage</div>
                        <div class="header-cell">Price (₹)</div>
                        <div class="header-cell">Quantity</div>
                        <div class="header-cell">Status</div>
                    </div>
                    
                    <!-- Table Rows -->
                    <%
                        for (Map<String, Object> row : stocks) {
                            String status = (String) row.get("status");
                            String statusClass = "status-available";
                            boolean isOutOfStock = false;
                            
                            // Check for out_of_stock or discontinued status
                            if ("out_of_stock".equalsIgnoreCase(status)) {
                                statusClass = "status-out";
                                isOutOfStock = true;
                            } else if ("discontinued".equalsIgnoreCase(status)) {
                                statusClass = "status-discontinued";
                                isOutOfStock = true;
                            }
                            // "available" status keeps the default green
                    %>
                    <div class="table-row-view <%= isOutOfStock ? "out-of-stock" : "" %>">
                        <div class="table-cell"><strong><%= row.get("mobile_id") %></strong></div>
                        <div class="table-cell mobile-info">
                            <span class="mobile-brand"><%= row.get("brand") %></span>
                        </div>
                        <div class="table-cell mobile-info">
                            <span class="mobile-model"><%= row.get("model") %></span>
                        </div>
                        <div class="table-cell"><%= row.get("ram") != null ? row.get("ram") : "N/A" %></div>
                        <div class="table-cell"><%= row.get("storage") != null ? row.get("storage") + " GB" : "N/A" %></div>
                        <div class="table-cell price-cell">₹ <%= row.get("price") %></div>
                        <div class="table-cell"><%= row.get("quantity") %></div>
                        <div class="table-cell">
                            <span class="status-badge <%= statusClass %>"><%= status %></span>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
            
            <%
                } else if (stocks != null && stocks.isEmpty()) {
            %>
                <div class="empty-state">
                    <div class="empty-icon">📱</div>
                    <h3>No Stock Available</h3>
                    <p>Add mobile phones to your inventory to get started.</p>
                </div>
            <%
                }
            %>
        </div>
        
        <!-- ================= SEARCH STOCK SECTION ================= -->
        <div class="section" id="searchStockSection">
            <h3>🔍 Search Mobile Phones</h3>
            <form action="SearchStockurl#searchStockSection" method="get" class="search-form">
                <div class="form-group">
                    <label for="brand">Brand</label>
                    <input type="text" id="brand" name="brand" placeholder="e.g., Samsung, Apple, Xiaomi">
                </div>
                <div class="form-group">
                    <label for="model">Model</label>
                    <input type="text" id="model" name="model" placeholder="e.g., Galaxy S23, iPhone 15">
                </div>
                <div class="form-group">
                    <input type="submit" value="Search" class="btn-blue">
                </div>
            </form>
            
            <%
                List<Map<String, Object>> searchStocks =
                    (List<Map<String, Object>>) request.getAttribute("searchstocks");
                    
                if (searchStocks != null && !searchStocks.isEmpty()) {
            %>
            
            <div style="margin-top: 30px;">
                <h4 style="margin-bottom: 20px; color: #2c3e50;">Search Results (<%= searchStocks.size() %> found)</h4>
                <div class="table-container">
                    <div class="stock-table">
                        <!-- Table Header - Same 8 columns -->
                        <div class="table-header-search">
                            <div class="header-cell">ID</div>
                            <div class="header-cell">Brand</div>
                            <div class="header-cell">Model</div>
                            <div class="header-cell">RAM</div>
                            <div class="header-cell">Storage</div>
                            <div class="header-cell">Price (₹)</div>
                            <div class="header-cell">Quantity</div>
                            <div class="header-cell">Status</div>
                        </div>
                        
                        <!-- Table Rows -->
                        <%
                            for (Map<String, Object> row : searchStocks) {
                                String status = (String) row.get("status");
                                String statusClass = "status-available";
                                boolean isOutOfStock = false;
                                
                                // Check for out_of_stock or discontinued status
                                if ("out_of_stock".equalsIgnoreCase(status)) {
                                    statusClass = "status-out";
                                    isOutOfStock = true;
                                } else if ("discontinued".equalsIgnoreCase(status)) {
                                    statusClass = "status-discontinued";
                                    isOutOfStock = true;
                                }
                                // "available" status keeps the default green
                        %>
                        <div class="table-row-search <%= isOutOfStock ? "out-of-stock" : "" %>">
                            <div class="table-cell"><strong><%= row.get("mobile_id") %></strong></div>
                            <div class="table-cell mobile-info">
                                <span class="mobile-brand"><%= row.get("brand") %></span>
                            </div>
                            <div class="table-cell mobile-info">
                                <span class="mobile-model"><%= row.get("model") %></span>
                            </div>
                            <div class="table-cell"><%= row.get("ram") != null ? row.get("ram") : "N/A" %></div>
                            <div class="table-cell"><%= row.get("storage") != null ? row.get("storage") + " GB" : "N/A" %></div>
                            <div class="table-cell price-cell">₹ <%= row.get("price") %></div>
                            <div class="table-cell"><%= row.get("quantity") %></div>
                            <div class="table-cell">
                                <span class="status-badge <%= statusClass %>"><%= status %></span>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
            
            <%
                } else if (searchStocks != null && searchStocks.isEmpty()) {
            %>
                <div class="empty-state" style="margin-top: 30px;">
                    <div class="empty-icon">🔍</div>
                    <h3>No Results Found</h3>
                    <p>Try searching with different brand or model names.</p>
                </div>
            <%
                }
            %>
        </div>
        
        <!-- ================= ACTION CARDS ================= -->
        <div class="action-grid">
            <!-- ADD NEW MOBILE -->
            <div class="action-card add-card">
                <h3>➕ Add New Mobile</h3>
                <form action="AddStockurl" method="post" id="addForm">
                    <div class="form-group">
                        <label for="add-brand">Brand *</label>
                        <input type="text" id="add-brand" name="brand" required placeholder="Samsung, Apple, etc.">
                    </div>
                    <div class="form-group">
                        <label for="add-model">Model *</label>
                        <input type="text" id="add-model" name="model" required placeholder="Galaxy S23, iPhone 15">
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="add-ram">RAM (GB)</label>
                            <input type="text" id="add-ram" name="ram" placeholder="8, 12">
                        </div>
                        <div class="form-group">
                            <label for="add-storage">Storage (GB)</label>
                            <input type="text" id="add-storage" name="storage" placeholder="128, 256">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="add-price">Price (₹) *</label>
                            <input type="number" id="add-price" name="price" required placeholder="59999">
                        </div>
                        <div class="form-group">
                            <label for="add-quantity">Quantity *</label>
                            <input type="number" id="add-quantity" name="quantity" required placeholder="10">
                        </div>
                    </div>
                    <input type="submit" value="Add to Stock" class="btn-green">
                </form>
            </div>
            
            <!-- UPDATE MOBILE -->
            <div class="action-card update-card">
                <h3>✏️ Update Mobile</h3>
                <form action="UpdateStockurl" method="post" id="updateForm">
                    <div class="form-group">
                        <label for="update-id">Mobile ID *</label>
                        <input type="number" id="update-id" name="mobile_id" required placeholder="Enter Mobile ID">
                    </div>
                    <div class="form-group">
                        <label for="update-price">New Price (₹)</label>
                        <input type="number" id="update-price" name="price" placeholder="Leave empty for no change">
                    </div>
                    <div class="form-group">
                        <label for="update-quantity">New Quantity</label>
                        <input type="number" id="update-quantity" name="quantity" placeholder="Leave empty for no change">
                    </div>
                    <input type="submit" value="Update Mobile" class="btn-orange">
                </form>
            </div>
            
            <!-- DELETE MOBILE -->
            <div class="action-card delete-card">
                <h3>🗑️ Delete Mobile</h3>
                <form action="DeleteStockurl" method="post" id="deleteForm">
                    <div class="form-group">
                        <label for="delete-id">Mobile ID *</label>
                        <input type="number" id="delete-id" name="mobile_id" required placeholder="Enter Mobile ID">
                    </div>
                    <input type="submit" value="Delete Mobile" class="btn-red">
                </form>
            </div>
        </div>
    </div>
    
    <script>
        // Simple form validation for delete
        document.getElementById('deleteForm').addEventListener('submit', function(e) {
            const mobileId = document.getElementById('delete-id').value;
            if (!mobileId || mobileId <= 0) {
                e.preventDefault();
                alert('Please enter a valid Mobile ID');
                document.getElementById('delete-id').focus();
            } else if (!confirm('⚠️ Are you sure you want to delete this mobile?')) {
                e.preventDefault();
            }
        });
        
        // Auto-focus on first search input
        document.getElementById('brand').focus();
    </script>
</body>
</html>