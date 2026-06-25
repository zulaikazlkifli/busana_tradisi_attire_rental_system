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

@WebServlet("/PaymentSuccessServlet")
public class PaymentSuccessServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("MASUK PAYMENT SUCCESS SERVLET");

        // 🔥 GET DATA FROM TOYYIBPAY
        String statusID =
            request.getParameter("status_id");

        String bookingID =
            request.getParameter("order_id");

        System.out.println("STATUS = " + statusID);
        System.out.println("BOOKING ID = " + bookingID);

        try{

            // 🔥 PAYMENT SUCCESS
            if("1".equals(statusID)){

                Class.forName("com.mysql.cj.jdbc.Driver");

                Connection conn =
                    DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/btarsystem",
                        "root",
                        "root123"
                    );

                String sql =
                    "UPDATE booking " +
                    "SET bookingStatus='PAID' " +
                    "WHERE bookingID=?";

                PreparedStatement ps =
                    conn.prepareStatement(sql);

                ps.setString(1, bookingID);

                ps.executeUpdate();

                conn.close();
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        // 🔥 GO SUCCESS PAGE
        response.sendRedirect(
            "paymentSuccess.jsp?bookingID="
            + bookingID
        );
    }
}