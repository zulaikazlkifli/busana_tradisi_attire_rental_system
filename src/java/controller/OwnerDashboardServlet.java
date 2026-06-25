/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/OwnerDashboardServlet")
public class OwnerDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int totalBookings = 0;
        int pendingPayments = 0;
        int completedBookings = 0;

        double totalRevenue = 0;

        try{

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/btarsystem",
                "root",
                "root123"
            );

            // TOTAL BOOKINGS
            String totalSQL =
                "SELECT COUNT(*) FROM booking";

            PreparedStatement totalPS =
                conn.prepareStatement(totalSQL);

            ResultSet totalRS =
                totalPS.executeQuery();

            if(totalRS.next()){
                totalBookings = totalRS.getInt(1);
            }

            // PENDING PAYMENTS
            String pendingSQL =
                "SELECT COUNT(*) FROM booking " +
                "WHERE bookingStatus='PENDING'";

            PreparedStatement pendingPS =
                conn.prepareStatement(pendingSQL);

            ResultSet pendingRS =
                pendingPS.executeQuery();

            if(pendingRS.next()){
                pendingPayments = pendingRS.getInt(1);
            }

            // COMPLETED BOOKINGS
            String completedSQL =
                "SELECT COUNT(*) FROM booking " +
                "WHERE bookingStatus='COMPLETED'";

            PreparedStatement completedPS =
                conn.prepareStatement(completedSQL);

            ResultSet completedRS =
                completedPS.executeQuery();

            if(completedRS.next()){
                completedBookings = completedRS.getInt(1);
            }

            // TOTAL REVENUE
            String revenueSQL =
                "SELECT SUM(totalAmount) FROM booking " +
                "WHERE bookingStatus='PAID' " +
                "OR bookingStatus='COMPLETED'";

            PreparedStatement revenuePS =
                conn.prepareStatement(revenueSQL);

            ResultSet revenueRS =
                revenuePS.executeQuery();

            if(revenueRS.next()){
                totalRevenue = revenueRS.getDouble(1);
            }

            conn.close();

        }catch(Exception e){
            e.printStackTrace();
        }

        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("pendingPayments", pendingPayments);
        request.setAttribute("completedBookings", completedBookings);
        request.setAttribute("totalRevenue", totalRevenue);

        RequestDispatcher rd =
            request.getRequestDispatcher(
                "/ownerDashboard.jsp"
            );

        rd.forward(request, response);
    }
}