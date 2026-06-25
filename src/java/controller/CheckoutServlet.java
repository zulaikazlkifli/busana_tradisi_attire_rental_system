/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.sql.*;
import java.util.ArrayList;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;


@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        try {

            String eventStart = request.getParameter("eventStartDate");
            String eventEnd = request.getParameter("eventEndDate");
            String pickup = request.getParameter("pickupDate");
            String ret = request.getParameter("returnDate");

            HttpSession session = request.getSession();

            String userID =
                (String) session.getAttribute("userID");

            ArrayList<ArrayList<Object>> cart =
                (ArrayList<ArrayList<Object>>) session.getAttribute("cart");

            if(cart == null || cart.isEmpty()){

                response.sendRedirect("viewCart.jsp");
                return;
            }

            // =========================
            // DATE CALCULATION
            // =========================

            LocalDate startDate =
                LocalDate.parse(eventStart);

            LocalDate endDate =
                LocalDate.parse(eventEnd);

            long days =
                ChronoUnit.DAYS.between(startDate, endDate) + 1;

            // =========================
            // DATABASE
            // =========================

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn =
                DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/btarsystem",
                    "root",
                    "root123"
                );

            double total = 0;

            String selectedAttireID = null;
            String selectedAttireName = "";

            // =========================
            // CHECK AVAILABILITY
            // =========================

            for(ArrayList item : cart){

                String type =
                    (String) item.get(3);

                double price =
                    (double) item.get(2);

                total += price * days;

                // 🔥 SKIP ACCESSORY
                if(type.equals("ACCESSORY")){
                    continue;
                }

                String attireID =
                    (String) item.get(0);

                String attireName =
                    (String) item.get(1);

                selectedAttireID = attireID;
                selectedAttireName = attireName;

                String checkSql =
                "SELECT * FROM booking " +
                "WHERE attireID=? " +
                "AND bookingStatus IN ('PENDING','PAID') " +
                "AND (eventStartDate <= ? AND eventEndDate >= ?)";

                PreparedStatement checkPs =
                    conn.prepareStatement(checkSql);

                checkPs.setString(1, attireID);
                checkPs.setString(2, eventEnd);
                checkPs.setString(3, eventStart);

                ResultSet checkRs =
                    checkPs.executeQuery();

                // =========================
                // IF DATE NOT AVAILABLE
                // =========================

                if(checkRs.next()){

                    request.setAttribute(
                        "error",
                        "Sorry, " + attireName +
                        " is already booked for the selected dates."
                    );

                    RequestDispatcher rd =
                        request.getRequestDispatcher("checkout.jsp");

                    rd.forward(request, response);

                    return;
                }
            }

            // =========================
            // INSERT BOOKING (ONCE ONLY)
            // =========================

            int bookingID = 0;
            String insertSql =
                "INSERT INTO booking " +
                "(bookingDate,userID,attireID," +
                "eventStartDate,eventEndDate," +
                "pickupDate,returnDate," +
                "totalAmount,bookingStatus) " +
                "VALUES (?,?,?,?,?,?,?,?,?)";

            PreparedStatement ps =
                conn.prepareStatement(
                    insertSql,
                    Statement.RETURN_GENERATED_KEYS
                );

            ps.setDate(
                1,
                new java.sql.Date(System.currentTimeMillis())
            );

            ps.setString(2, userID);

            // 🔥 IF ACCESSORY ONLY
            if(selectedAttireID == null){

                ps.setNull(3, java.sql.Types.VARCHAR);

            }else{

                ps.setString(3, selectedAttireID);
            }

            ps.setString(4, eventStart);
            ps.setString(5, eventEnd);
            ps.setString(6, pickup);
            ps.setString(7, ret);
            ps.setDouble(8, total);
            ps.setString(9, "PENDING");

            ps.executeUpdate();

            // =========================
            // GET BOOKING ID
            // =========================

            ResultSet rs =
                ps.getGeneratedKeys();

            if(rs.next()){

                bookingID = rs.getInt(1);
            }

            // =========================
            // INSERT ACCESSORY
            // =========================

            for(ArrayList item : cart){

                String type =
                    (String) item.get(3);

                // 🔥 ACCESSORY ONLY
                if(type.equals("ACCESSORY")){

                    String accessoryID =
                        (String) item.get(0);

                    double price =
                        (double) item.get(2);

                    double accessoryTotal =
                        price * days;

                    String accessorySql =
                        "INSERT INTO booking_accessory " +
                        "(bookingID,accessoryID,quantity,additionalPrice) " +
                        "VALUES (?,?,?,?)";

                    PreparedStatement accessoryPs =
                        conn.prepareStatement(accessorySql);

                    accessoryPs.setInt(1, bookingID);
                    accessoryPs.setString(2, accessoryID);
                    accessoryPs.setInt(3, 1);
                    accessoryPs.setDouble(4, accessoryTotal);

                    accessoryPs.executeUpdate();
                }
            }

            // =========================
            // CLEAR CART
            // =========================

            session.removeAttribute("cart");

            session.removeAttribute("selectedAttireID");

            // =========================
            // GO PAYMENT PAGE
            // =========================

            response.sendRedirect(
                "payment.jsp?bookingID=" +
                bookingID +
                "&total=" + total
            );

            conn.close();

        }

        catch(Exception e){

            e.printStackTrace();

            response.getWriter().println(
                "Error: " + e.getMessage()
            );
        }
    }
}