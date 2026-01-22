<%-- 
    Document   : dashboard
    Created on : 1 Jan 2026, 15:21:08
    Author     : joy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("emp_id") == null) 
    {
        response.sendRedirect("index.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mobile Shop - Dashboard</title>
        <style>
            /* ====== BASE STYLES ====== */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', 'Arial', sans-serif;
            }
            
            html, body {
                height: 100%;
                width: 100%;
            }
            
            body {
                background-color: #f5f7fa;
                color: #333;
                line-height: 1.6;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }
            
            /* ====== MAIN CONTAINER ====== */
            .main-container {
                flex: 1;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }
            
            /* ====== HEADER ====== */
            .header {
                background: white;
                padding: 20px 30px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-shrink: 0;
            }
            
            .header h2 {
                color: #2c3e50;
                font-size: 24px;
                font-weight: 600;
            }
            
            /* ====== LOGOUT BUTTON ====== */
            .logout-btn {
                background-color: #e74c3c;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
                font-weight: 500;
                transition: background-color 0.2s ease;
            }
            
            .logout-btn:hover {
                background-color: #c0392b;
            }
            
            /* ====== DASHBOARD CONTENT ====== */
            .dashboard-content {
                flex: 1;
                padding: 30px;
                max-width: 1400px;
                margin: 0 auto;
                width: 100%;
            }
            
            .welcome-section {
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
                margin-bottom: 40px;
            }
            
            .welcome-section h3 {
                color: #2c3e50;
                margin-bottom: 15px;
                font-size: 22px;
                font-weight: 600;
            }
            
            .welcome-section p {
                color: #7f8c8d;
                font-size: 16px;
                line-height: 1.8;
            }
            
            /* ====== MENU CARDS ====== */
            .menu-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
                gap: 30px;
                margin-top: 20px;
            }
            
            .menu-card {
                background: white;
                padding: 35px 30px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
                text-decoration: none;
                color: inherit;
                display: flex;
                flex-direction: column;
                height: 100%;
                min-height: 220px;
                transition: all 0.3s ease;
                border-left: 4px solid #3498db;
            }
            
            .menu-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(0,0,0,0.1);
                border-left-color: #2980b9;
            }
            
            .menu-card:nth-child(2) {
                border-left-color: #2ecc71;
            }
            
            .menu-card:nth-child(2):hover {
                border-left-color: #27ae60;
            }
            
            .menu-card:nth-child(3) {
                border-left-color: #9b59b6;
            }
            
            .menu-card:nth-child(3):hover {
                border-left-color: #8e44ad;
            }
            
            .card-icon {
                font-size: 32px;
                margin-bottom: 20px;
                color: #3498db;
            }
            
            .menu-card:nth-child(2) .card-icon {
                color: #2ecc71;
            }
            
            .menu-card:nth-child(3) .card-icon {
                color: #9b59b6;
            }
            
            .menu-card h3 {
                color: #2c3e50;
                margin-bottom: 15px;
                font-size: 20px;
                font-weight: 600;
            }
            
            .menu-card p {
                color: #7f8c8d;
                font-size: 15px;
                margin-bottom: 20px;
                flex: 1;
                line-height: 1.6;
            }
            
            .card-link {
                color: #3498db;
                text-decoration: none;
                font-weight: 500;
                font-size: 15px;
                display: inline-block;
                margin-top: auto;
            }
            
            .card-link:hover {
                text-decoration: underline;
            }
            
            /* ====== FOOTER ====== */
            .footer {
                background: #2c3e50;
                color: white;
                text-align: center;
                padding: 20px;
                margin-top: auto;
                flex-shrink: 0;
            }
            
            .footer p {
                font-size: 14px;
                opacity: 0.9;
            }
            
            /* ====== STATS SECTION (Optional - can add later) ====== */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 40px;
            }
            
            .stat-card {
                background: white;
                padding: 25px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
                text-align: center;
            }
            
            .stat-value {
                font-size: 28px;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 10px;
            }
            
            .stat-label {
                color: #7f8c8d;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            
            /* ====== RESPONSIVE ====== */
            @media (max-width: 1024px) {
                .menu-grid {
                    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                }
                
                .dashboard-content {
                    padding: 25px;
                }
            }
            
            @media (max-width: 768px) {
                .header {
                    flex-direction: column;
                    gap: 15px;
                    text-align: center;
                    padding: 20px;
                }
                
                .menu-grid {
                    grid-template-columns: 1fr;
                }
                
                .menu-card {
                    min-height: 200px;
                    padding: 25px;
                }
                
                .dashboard-content {
                    padding: 20px;
                }
            }
            
            @media (max-width: 480px) {
                .header h2 {
                    font-size: 20px;
                }
                
                .logout-btn {
                    width: 100%;
                }
                
                .welcome-section {
                    padding: 20px;
                }
                
                .menu-card {
                    min-height: 180px;
                    padding: 20px;
                }
                
                .dashboard-content {
                    padding: 15px;
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
            
            .welcome-section, .menu-card {
                animation: fadeIn 0.5s ease-out;
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <!-- HEADER -->
            <div class="header">
                <h2>Mobile Shop Management System</h2>
                <form action="Logouturl" method="get">
                    <input type="submit" value="Logout" class="logout-btn">
                </form>
            </div>
            
            <!-- DASHBOARD CONTENT -->
            <div class="dashboard-content">
                <!-- Welcome Section -->
                <div class="welcome-section">
                    <h3>Welcome to Your Dashboard</h3>
                    <p>Access all management tools from here. Monitor stock levels, process sales, and generate reports efficiently.</p>
                </div>
                
                <!-- Optional Stats Section (Uncomment if you want to add stats) -->
                <!--
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-value">152</div>
                        <div class="stat-label">Total Products</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">₹ 85,420</div>
                        <div class="stat-label">Today's Sales</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">24</div>
                        <div class="stat-label">Low Stock Items</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">₹ 12,45,800</div>
                        <div class="stat-label">Monthly Revenue</div>
                    </div>
                </div>
                -->
                
                <!-- Main Menu Cards -->
                <div class="menu-grid">
                    <a href="managestock.jsp" class="menu-card">
                        <div class="card-icon">📱</div>
                        <h3>Manage Stock</h3>
                        <p>Add new mobile phones to inventory, update existing stock levels, view current inventory, and manage suppliers.</p>
                        <span class="card-link">Go to Stock Management →</span>
                    </a>
                    
                    <a href="sellmobile.jsp" class="menu-card">
                        <div class="card-icon">💰</div>
                        <h3>Sell Mobile</h3>
                        <p>Process customer sales transactions, generate invoices, update inventory automatically, and manage payments.</p>
                        <span class="card-link">Process Sales →</span>
                    </a>
                    
                    <a href="ViewSalesurl" class="menu-card">
                        <div class="card-icon">📊</div>
                        <h3>View Sales Reports</h3>
                        <p>View detailed sales history, generate daily/weekly/monthly reports, and analyze business performance metrics.</p>
                        <span class="card-link">View Reports →</span>
                    </a>
                </div>
            </div>
            
            <!-- FOOTER -->
            <div class="footer">
                <p>Mobile Shop Management System | Logged in as Employee ID: <%= session.getAttribute("emp_id") %></p>
            </div>
        </div>
        
        <script>
            // Add current date to welcome message
            document.addEventListener('DOMContentLoaded', function() {
                const now = new Date();
                const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
                const dateString = now.toLocaleDateString('en-US', options);
                
                const welcomeSection = document.querySelector('.welcome-section p');
                welcomeSection.innerHTML += ` Today is ${dateString}.`;
                
                // Add animation to cards
                const cards = document.querySelectorAll('.menu-card');
                cards.forEach((card, index) => {
                    card.style.opacity = '0';
                    card.style.transform = 'translateY(30px)';
                    
                    setTimeout(() => {
                        card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                        card.style.opacity = '1';
                        card.style.transform = 'translateY(0)';
                    }, 150 * index);
                });
                
                // Update page title with employee ID
                const empId = '<%= session.getAttribute("emp_id") %>';
                if (empId && empId !== 'null') {
                    document.title = `Dashboard - Emp ID: ${empId}`;
                }
            });
        </script>
    </body>
</html>