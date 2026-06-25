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

@WebServlet("/CompleteBookingServlet")
public class CompleteBookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // get booking id
        String bookingID =
            request.getParameter("bookingID");

        try {

            // database connection
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn =
                DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/btarsystem",
                    "root",
                    "root123"
                );

            // update status
            String sql =
                "UPDATE booking " +
                "SET bookingStatus='COMPLETED' " +
                "WHERE bookingID=?";

            PreparedStatement ps =
                conn.prepareStatement(sql);

            ps.setString(1, bookingID);

            ps.executeUpdate();

            conn.close();

        } catch(Exception e){
            e.printStackTrace();
        }

        // back owner booking page
        response.sendRedirect(
            "ViewBookingOwnerServlet"
        );
    }
}