/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;
import java.util.*;

/**
 *
 * @author joy
 */
public class ViewSalesClass extends HttpServlet {

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
        if (session == null || session.getAttribute("emp_id") == null) {
            response.sendRedirect("index.html");
            return;
        }

        List<Map<String, Object>> salesList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost/Mobiles", "root", "Joy@6404");

            String sql =
                "SELECT s.sale_id, m.brand, m.model, " +
                "s.quantity_sold, s.sold_price, " +
                "(s.quantity_sold * s.sold_price) AS total, " +
                "s.payment_method,s.sale_datetime, e.username " +
                "FROM sales s " +
                "JOIN mobilestocks m ON s.mobile_id = m.mobile_id " +
                "JOIN employee e ON s.emp_id = e.emp_id " +
                "ORDER BY s.sale_datetime DESC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("sale_id", rs.getInt("sale_id"));
                row.put("brand", rs.getString("brand"));
                row.put("model", rs.getString("model"));
                row.put("quantity_sold", rs.getInt("quantity_sold"));
                row.put("sold_price", rs.getInt("sold_price"));
                row.put("total", rs.getInt("total"));
                row.put("payment_method", rs.getString("payment_method"));
                row.put("sale_datetime", rs.getTimestamp("sale_datetime"));
                row.put("username", rs.getString("username"));

                salesList.add(row);
            }

            conn.close();

        } catch (Exception e) {
            throw new ServletException(e);
        }

        request.setAttribute("sales", salesList);
        RequestDispatcher rd =request.getRequestDispatcher("/viewsales.jsp");
        rd.forward(request, response);
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
