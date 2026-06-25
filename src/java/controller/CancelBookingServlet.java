/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingID = request.getParameter("bookingID");

        try {
            // 🔥 Load driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 🔥 Connect database
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/btarsystem",
                    "root",
                    "root123"
            );

            // 🔥 Update status to CANCELLED
            String sql = "UPDATE booking SET bookingStatus='CANCELLED' WHERE bookingID=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, bookingID);

            ps.executeUpdate();

            // 🔥 Close connection
            conn.close();

            // 🔥 Redirect back
            response.sendRedirect("ViewBookingCustomerServlet");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}