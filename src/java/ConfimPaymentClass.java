/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;

/**
 *
 * @author joy
 */
public class ConfimPaymentClass extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false);
        if (session.getAttribute("emp_id") == null) {
            response.sendRedirect("index.html");
            return;
        }

        int empId = (Integer) session.getAttribute("emp_id");
        int mobileId = Integer.parseInt(request.getParameter("mobile_id"));
        int qtySold = Integer.parseInt(request.getParameter("quantity"));
        int price = Integer.parseInt(request.getParameter("price"));
        String paymentMethod = request.getParameter("payment_method");


        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost/Mobiles", "root", "Joy@6404");

            conn.setAutoCommit(false);

            PreparedStatement psCheck = conn.prepareStatement(
                "SELECT quantity FROM mobilestocks WHERE mobile_id=?");
            psCheck.setInt(1, mobileId);
            ResultSet rs = psCheck.executeQuery();
            rs.next();

            int availableQty = rs.getInt("quantity");
            if (availableQty < qtySold) {
                throw new Exception("Stock changed. Retry.");
            }

            PreparedStatement psSale = conn.prepareStatement(
                "INSERT INTO sales (mobile_id, quantity_sold, sold_price, emp_id,payment_method) " +
                "VALUES (?, ?, ?, ?,?)");
            psSale.setInt(1, mobileId);
            psSale.setInt(2, qtySold);
            psSale.setInt(3, price);
            psSale.setInt(4, empId);
            psSale.setString(5, paymentMethod);
            psSale.executeUpdate();

            int newQty = availableQty - qtySold;
            String status = (newQty > 0) ? "available" : "out_of_stock";

            PreparedStatement psUpdate = conn.prepareStatement(
                "UPDATE mobilestocks SET quantity=?, status=? WHERE mobile_id=?");
            psUpdate.setInt(1, newQty);
            psUpdate.setString(2, status);
            psUpdate.setInt(3, mobileId);
            psUpdate.executeUpdate();

            conn.commit();

            response.sendRedirect("success.jsp");

        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) {}
            throw new ServletException(e);
        } finally {
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
