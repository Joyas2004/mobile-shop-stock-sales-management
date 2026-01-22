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

/**
 *
 * @author joy
 */
public class SellMobileClass extends HttpServlet {

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

        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String paymentMethod = request.getParameter("payment_method");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost/Mobiles", "root", "Joy@6404");

            PreparedStatement ps = conn.prepareStatement(
                "SELECT mobile_id, price, quantity FROM mobilestocks " +
                "WHERE brand=? AND model=? AND status='available'");

            ps.setString(1, brand);
            ps.setString(2, model);
            ResultSet rs = ps.executeQuery();

            

            if (!rs.next()) 
            {
                request.setAttribute("error", "Mobile not found or out of stock");
                RequestDispatcher rd =request.getRequestDispatcher("/sellmobile.jsp");
                rd.forward(request, response);
                return;
            }

            int availableQty = rs.getInt("quantity");

            if (availableQty < quantity) 
            {
                request.setAttribute("error", "Requested quantity is not available");
                RequestDispatcher rd =request.getRequestDispatcher("/sellmobile.jsp");
                rd.forward(request, response);
                return;
            }


            int mobileId = rs.getInt("mobile_id");
            int price = rs.getInt("price");
            int total = price * quantity;

            conn.close();

            // Send data to bill page (NO DB UPDATE)
            request.setAttribute("mobileId", mobileId);
            request.setAttribute("brand", brand);
            request.setAttribute("model", model);
            request.setAttribute("quantity", quantity);
            request.setAttribute("price", price);
            request.setAttribute("total", total);
            request.setAttribute("paymentMethod", paymentMethod);

            RequestDispatcher rd =
                request.getRequestDispatcher("/bill.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
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
