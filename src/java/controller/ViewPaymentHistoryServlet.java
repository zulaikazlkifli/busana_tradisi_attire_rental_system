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

@WebServlet("/ViewPaymentHistoryServlet")
public class ViewPaymentHistoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<String[]> paymentList = new ArrayList<>();

        try{

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/btarsystem",
                "root",
                "root123"
            );

            String sql =
            "SELECT b.bookingID, u.name, a.attireName, " +
            "b.totalAmount, b.bookingStatus " +
            "FROM booking b " +
            "JOIN user u ON b.userID = u.userID " +
            "LEFT JOIN attire a ON b.attireID = a.attireID " +
            "WHERE b.bookingStatus IN ('PAID','COMPLETED') " +
            "ORDER BY b.bookingID DESC";

            PreparedStatement ps =
                conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                String[] p = new String[5];

                p[0] = rs.getString("bookingID");
                p[1] = rs.getString("name");
                String attireName = rs.getString("attireName");

                if(attireName == null){
                    attireName = "Deleted Attire";
                }

                p[2] = attireName;
                p[3] = rs.getString("totalAmount");
                p[4] = rs.getString("bookingStatus");

                paymentList.add(p);
            }

            conn.close();

        }catch(Exception e){
            e.printStackTrace();
        }

        request.setAttribute("paymentList", paymentList);

        RequestDispatcher rd =
            request.getRequestDispatcher(
                "/paymentHistory.jsp"
            );

        rd.forward(request, response);
    }
}