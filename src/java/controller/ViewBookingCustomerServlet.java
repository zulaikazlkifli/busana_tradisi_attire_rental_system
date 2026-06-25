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


@WebServlet("/ViewBookingCustomerServlet")
public class ViewBookingCustomerServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<String[]> bookingList = new ArrayList<>();

        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("userID");

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/btarsystem",
                "root",
                "root123"
            );

            // 🔥 GET BOOKING + ATTIRE
            String sql =
                "SELECT b.*, a.attireName " +
                "FROM booking b " +
                "LEFT JOIN attire a ON b.attireID = a.attireID " +
                "WHERE b.userID=? " +
                "ORDER BY b.bookingID DESC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userID);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                String bookingID = rs.getString("bookingID");

                // =====================================
                // 🔥 GET ACCESSORY NAMES
                // =====================================

                String accSQL =
                    "SELECT a.accessoryName " +
                    "FROM booking_accessory ba " +
                    "JOIN accessory a ON ba.accessoryID = a.accessoryID " +
                    "WHERE ba.bookingID=?";

                PreparedStatement accPS = conn.prepareStatement(accSQL);
                accPS.setString(1, bookingID);

                ResultSet accRS = accPS.executeQuery();

                String accessoryText = "";

                while(accRS.next()){

                    if(!accessoryText.equals("")){
                        accessoryText += ", ";
                    }

                    accessoryText += accRS.getString("accessoryName");
                }

                // 🔥 IF NO ACCESSORY
                if(accessoryText.equals("")){
                    accessoryText = "-";
                }

                // =====================================
                // 🔥 STORE DATA
                // =====================================

                String[] b = new String[7];

                b[0] = bookingID;

                // attire
                String attireName = rs.getString("attireName");

                if(attireName == null){
                    attireName = "-";
                }

                b[1] = attireName;

                // accessories
                b[2] = accessoryText;

                // event dates
                b[3] = rs.getString("pickupDate");
                b[4] = rs.getString("returnDate");

                // total amount
                b[5] = rs.getString("totalAmount");

                // booking status
                b[6] = rs.getString("bookingStatus");

                bookingList.add(b);
            }

            conn.close();

        } catch(Exception e){
            e.printStackTrace();
        }

        request.setAttribute("bookingList", bookingList);

        RequestDispatcher rd =
            request.getRequestDispatcher("/ViewBookingCustomer.jsp");

        rd.forward(request, response);
    }
}