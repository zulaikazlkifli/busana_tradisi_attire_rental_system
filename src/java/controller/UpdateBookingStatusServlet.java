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


@WebServlet("/UpdateBookingStatusServlet")
public class UpdateBookingStatusServlet extends HttpServlet {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/btarsystem",
            "root",
            "root123"
        );
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingID = request.getParameter("bookingID");
        String status = request.getParameter("bookingStatus");

        try (Connection conn = getConnection()) {

            String sql = "UPDATE booking SET bookingStatus=? WHERE bookingID=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, status);
            ps.setString(2, bookingID);

            int rows = ps.executeUpdate();

            if(rows > 0){
                System.out.println("✅ Booking updated successfully!");
            } else {
                System.out.println("❌ Update failed!");
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        // 🔁 redirect balik ke page booking
        response.sendRedirect("ViewBookingOwnerServlet");
    }
}