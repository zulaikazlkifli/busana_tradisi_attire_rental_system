/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewBookingOwnerServlet")
public class ViewBookingOwnerServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<String[]> bookingList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/btarsystem","root","root123"
            );

            String sql = "SELECT bookingID, userID, attireID, pickupDate, returnDate, totalAmount, bookingStatus FROM booking ORDER BY bookingID DESC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                String[] b = new String[7];

                b[0] = rs.getString("bookingID");
                b[1] = rs.getString("userID");
                b[2] = rs.getString("attireID");
                b[3] = rs.getString("pickupDate");
                b[4] = rs.getString("returnDate");
                b[5] = rs.getString("totalAmount");
                b[6] = rs.getString("bookingStatus");

                bookingList.add(b);
            }

            conn.close();

        } catch(Exception e){
            e.printStackTrace();
        }

        request.setAttribute("bookingList", bookingList);
        RequestDispatcher rd = request.getRequestDispatcher("/viewBookingOwner.jsp");
        rd.forward(request, response);
    }
}