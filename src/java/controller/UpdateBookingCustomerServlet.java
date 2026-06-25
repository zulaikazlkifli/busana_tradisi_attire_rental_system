/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


@WebServlet("/UpdateBookingCustomerServlet")
public class UpdateBookingCustomerServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("🔥 MASUK UPDATE SERVLET");

        String bookingID = request.getParameter("bookingID");
        String eventStart = request.getParameter("eventStartDate");
        String eventEnd = request.getParameter("eventEndDate");

        System.out.println("===== UPDATE BOOKING DEBUG =====");
        System.out.println("BookingID: " + bookingID);
        System.out.println("Event Start: " + eventStart);
        System.out.println("Event End: " + eventEnd);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/btarsystem",
                "root",
                "root123"
            );

            // ====================================
            // 🔥 CHECK STATUS (IMPORTANT)
            // ====================================
            String checkSQL = "SELECT bookingStatus FROM booking WHERE bookingID=?";
            PreparedStatement psCheck = conn.prepareStatement(checkSQL);
            psCheck.setString(1, bookingID);

            ResultSet rsCheck = psCheck.executeQuery();

            if (rsCheck.next()) {
                String status = rsCheck.getString("bookingStatus");

                if (!"PENDING".equalsIgnoreCase(status)) {
                    System.out.println("❌ EDIT BLOCKED - NOT PENDING");
                    conn.close();
                    response.sendRedirect("ViewBookingCustomerServlet");
                    return;
                }
            }

            // ====================================
            // 🔥 CALCULATE DAYS
            // ====================================
            LocalDate startDate = LocalDate.parse(eventStart);
            LocalDate endDate = LocalDate.parse(eventEnd);

            long days = ChronoUnit.DAYS.between(startDate, endDate) + 1;

            // ====================================
            // 🔥 GET BASE PRICE
            // ====================================
            String priceSQL = "SELECT a.rental_price FROM booking b JOIN attire a ON b.attireID = a.attireID WHERE b.bookingID=?";
            PreparedStatement psPrice = conn.prepareStatement(priceSQL);
            psPrice.setString(1, bookingID);

            ResultSet rsPrice = psPrice.executeQuery();

            double price = 0;
            if (rsPrice.next()) {
                price = rsPrice.getDouble("rental_price");
            }

            double total = price * days;

            // ====================================
            // 🔥 AUTO CALCULATE PICKUP & RETURN
            // ====================================
            Date pickupDate = Date.valueOf(startDate.minusDays(2));
            Date returnDate = Date.valueOf(endDate.plusDays(1));

            // ====================================
            // 🔥 UPDATE DATABASE
            // ====================================
            String updateSQL = "UPDATE booking SET eventStartDate=?, eventEndDate=?, pickupDate=?, returnDate=?, totalAmount=? WHERE bookingID=?";
            PreparedStatement psUpdate = conn.prepareStatement(updateSQL);

            psUpdate.setString(1, eventStart);
            psUpdate.setString(2, eventEnd);
            psUpdate.setDate(3, pickupDate);
            psUpdate.setDate(4, returnDate);
            psUpdate.setDouble(5, total);
            psUpdate.setString(6, bookingID);

            int rows = psUpdate.executeUpdate();
            System.out.println("✅ Rows Updated: " + rows);

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // 🔄 REDIRECT BACK
        response.sendRedirect("ViewBookingCustomerServlet");
    }
}