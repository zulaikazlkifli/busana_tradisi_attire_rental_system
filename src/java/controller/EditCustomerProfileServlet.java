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


@WebServlet("/EditCustomerProfileServlet")
public class EditCustomerProfileServlet extends HttpServlet {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/btarsystem",
            "root","root123"
        );
    }

    // OPEN EDIT PAGE
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !"CUSTOMER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userID = (String) session.getAttribute("userID");

        try (Connection con = getConnection()) {

            String sql = "SELECT * FROM user WHERE userID=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, userID);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("email", rs.getString("email"));
                request.setAttribute("phone", rs.getString("phone"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("editCustomerProfile.jsp")
               .forward(request, response);
    }

    // UPDATE PROFILE
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("userID");

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");

        try (Connection con = getConnection()) {

            String sql = "UPDATE user SET name=?, phone=? WHERE userID=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, userID);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("CustomerProfileServlet");
    }
}