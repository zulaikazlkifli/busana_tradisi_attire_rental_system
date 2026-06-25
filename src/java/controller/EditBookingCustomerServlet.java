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


@WebServlet("/EditBookingCustomerServlet")
public class EditBookingCustomerServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingID = request.getParameter("id");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/btarsystem","root","root123"
            );

            String sql = "SELECT * FROM booking WHERE bookingID=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, bookingID);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                String attireID = rs.getString("attireID");

                // ✅ ORIGINAL (tak ubah)
                request.setAttribute("bookingID", rs.getString("bookingID"));
                request.setAttribute("attireID", attireID);
                request.setAttribute("eventStartDate", rs.getString("eventStartDate"));
                request.setAttribute("eventEndDate", rs.getString("eventEndDate"));
                request.setAttribute("pickupDate", rs.getString("pickupDate"));
                request.setAttribute("returnDate", rs.getString("returnDate"));
                request.setAttribute("bookingStatus", rs.getString("bookingStatus"));

                // =========================
                // ✅ TAMBAH: GET ATTIRE
                // =========================
                String attireSQL = "SELECT attireName, imagePath FROM attire WHERE attireID=?";
                PreparedStatement psAttire = conn.prepareStatement(attireSQL);
                psAttire.setString(1, attireID);

                ResultSet rsAttire = psAttire.executeQuery();

                if(rsAttire.next()){
                    request.setAttribute("attireName", rsAttire.getString("attireName"));
                    request.setAttribute("attireImage", rsAttire.getString("imagePath"));
                }

                // =========================
                // ✅ TAMBAH: GET ACCESSORY
                // =========================
                ArrayList<String[]> accessoryList = new ArrayList<>();

                String accSQL = "SELECT a.accessoryName, a.pictureURL " +
                                "FROM booking_accessory ba " +
                                "JOIN accessory a ON ba.accessoryID = a.accessoryID " +
                                "WHERE ba.bookingID=?";

                PreparedStatement psAcc = conn.prepareStatement(accSQL);
                psAcc.setString(1, bookingID);

                ResultSet rsAcc = psAcc.executeQuery();

                while(rsAcc.next()){
                    String[] acc = new String[2];
                    acc[0] = rsAcc.getString("accessoryName");
                    acc[1] = rsAcc.getString("pictureURL");
                    accessoryList.add(acc);
                }

                request.setAttribute("accessoryList", accessoryList);
            }

            conn.close();

        } catch(Exception e){
            e.printStackTrace();
        }

        RequestDispatcher rd = request.getRequestDispatcher("editBookingCustomer.jsp");
        rd.forward(request, response);
    }
}