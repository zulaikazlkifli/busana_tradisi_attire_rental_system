/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;


@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/btarsystem",
            "root",
            "root123"
        );
    }

    // ================= GET =================
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String attireID = request.getParameter("attireID");

        try(Connection conn = getConnection()){

            String sql = "SELECT * FROM attire WHERE attireID=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, attireID);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                request.setAttribute("attireID", attireID);
                request.setAttribute("attireName", rs.getString("attireName"));
                request.setAttribute("price", rs.getDouble("rental_price"));
                request.setAttribute("image", rs.getString("imagePath"));
            }

            request.getRequestDispatcher("booking.jsp").forward(request, response);

        }catch(Exception e){
            e.printStackTrace();
        }
    }

    // ================= POST =================
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("🔥 DOPOST JALAN");

        String attireID = request.getParameter("attireID");
        String pickupDate = request.getParameter("pickupDate");
        String returnDate = request.getParameter("returnDate");

        try(Connection conn = getConnection()){

            String sql = "SELECT * FROM booking WHERE attireID=? AND (pickupDate <= ? AND returnDate >= ?)";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, attireID);
            ps.setString(2, returnDate);
            ps.setString(3, pickupDate);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                request.setAttribute("error", "Not Available");
                request.getRequestDispatcher("booking.jsp").forward(request, response);
            }else{
                HttpSession session = request.getSession();
                session.setAttribute("attireID", attireID);

                response.sendRedirect(request.getContextPath() + "/ViewAccessoryCustomerServlet");
            }

        }catch(Exception e){
            e.printStackTrace();
        }
    }
}