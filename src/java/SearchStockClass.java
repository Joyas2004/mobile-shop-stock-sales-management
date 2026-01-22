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
public class SearchStockClass extends HttpServlet {

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

        String brand = request.getParameter("brand");
        String model = request.getParameter("model");

        List<Map<String, Object>> stockList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost/Mobiles", "root", "Joy@6404");

            StringBuilder sql = new StringBuilder(
                "SELECT * FROM mobilestocks WHERE 1=1");

            if (brand != null && !brand.isEmpty()) {
                sql.append(" AND brand LIKE ?");
            }
            if (model != null && !model.isEmpty()) {
                sql.append(" AND model LIKE ?");
            }

            PreparedStatement ps = conn.prepareStatement(sql.toString());

            int index = 1;
            if (brand != null && !brand.isEmpty()) {
                ps.setString(index++, "%" + brand + "%");
            }
            if (model != null && !model.isEmpty()) {
                ps.setString(index++, "%" + model + "%");
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("mobile_id", rs.getInt("mobile_id"));
                row.put("brand", rs.getString("brand"));
                row.put("model", rs.getString("model"));
                row.put("ram", rs.getString("ram"));
                row.put("storage", rs.getString("storage"));
                row.put("price", rs.getInt("price"));
                row.put("quantity", rs.getInt("quantity"));
                row.put("status", rs.getString("status"));

                stockList.add(row);
            }

            conn.close();

        } catch (Exception e) {
            throw new ServletException(e);
        }

        request.setAttribute("searchstocks", stockList);
        RequestDispatcher rd = request.getRequestDispatcher("/managestock.jsp");
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
