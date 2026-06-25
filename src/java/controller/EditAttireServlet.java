/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


@WebServlet("/EditAttireServlet")
public class EditAttireServlet extends HttpServlet {

    // DATABASE CONNECTION
    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/btarsystem",
            "root",
            "root123"
        );
    }


    // ==============================
    // OPEN EDIT PAGE
    // ==============================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !"OWNER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String attireID = request.getParameter("attireID");

        try (Connection con = getConnection()) {

            String sql = "SELECT * FROM attire WHERE attireID=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, attireID);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                request.setAttribute("attireID", rs.getString("attireID"));
                request.setAttribute("attireName", rs.getString("attireName"));
                request.setAttribute("category", rs.getString("category"));
                request.setAttribute("size", rs.getString("size"));

                // GET DESCRIPTION FROM DATABASE
                request.setAttribute("description", rs.getString("description"));

                request.setAttribute("rentalPrice", rs.getDouble("rental_price"));
                request.setAttribute("status", rs.getString("availabilityStatus"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("editAttire.jsp")
               .forward(request, response);
    }



    // ==============================
    // UPDATE ATTIRE DATA
    // ==============================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String attireID = request.getParameter("attireID");
        String attireName = request.getParameter("attireName");
        String category = request.getParameter("category");
        String size = request.getParameter("size");

        // GET DESCRIPTION FROM FORM
        String description = request.getParameter("description");

        double rentalPrice =
                Double.parseDouble(request.getParameter("rentalPrice"));

        String status = request.getParameter("status");


        try (Connection con = getConnection()) {

            // UPDATE DATABASE INCLUDING DESCRIPTION
            String sql =
            "UPDATE attire SET attireName=?, category=?, size=?, description=?, rental_price=?, availabilityStatus=? WHERE attireID=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, attireName);
            ps.setString(2, category);
            ps.setString(3, size);

            // SAVE DESCRIPTION
            ps.setString(4, description);

            ps.setDouble(5, rentalPrice);
            ps.setString(6, status);
            ps.setString(7, attireID);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }


        // REDIRECT BACK TO MANAGE ATTIRE PAGE
        response.sendRedirect("ViewAttireServlet?msg=updated");
    }
}