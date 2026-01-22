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
public class DeleteStockClass extends HttpServlet {

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

        int mobileId = Integer.parseInt(request.getParameter("mobile_id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/Mobiles", "root", "Joy@6404");

            // Check if mobile has sales
            PreparedStatement psCheck = conn.prepareStatement("SELECT COUNT(*) FROM sales WHERE mobile_id=?");
            psCheck.setInt(1, mobileId);
            ResultSet rs = psCheck.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                // Soft delete
                PreparedStatement ps1 = conn.prepareStatement(
                    "UPDATE mobilestocks SET status='discontinued' WHERE mobile_id=?");
                ps1.setInt(1, mobileId);
                ps1.executeUpdate();
            } else {
                // Hard delete
                PreparedStatement ps2 = conn.prepareStatement(
                    "DELETE FROM mobilestocks WHERE mobile_id=?");
                ps2.setInt(1, mobileId);
                ps2.executeUpdate();
            }

            conn.close();
            response.sendRedirect("managestock.jsp");

        }
        catch (ClassNotFoundException e) 
        {

            // JDBC Driver not found
            throw new ServletException("MySQL JDBC Driver not found. Check classpath.", e);

        } 
        catch (SQLException e) 
        {

            // Database-related errors
            throw new ServletException("Database error while fetching mobile stocks.", e);
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
