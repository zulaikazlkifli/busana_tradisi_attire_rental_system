/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/btarsystem",
            "root",
            "root123"
        );
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        // Role auto CUSTOMER
        String role = "CUSTOMER";

        String userID = "U" + System.currentTimeMillis();

        try (Connection conn = getConnection()) {

            String sqlUser =
                "INSERT INTO user (userID, name, email, password_hash, phone, role) VALUES (?,?,?,?,?,?)";

            PreparedStatement psUser = conn.prepareStatement(sqlUser);
            psUser.setString(1, userID);
            psUser.setString(2, name);
            psUser.setString(3, email);
            psUser.setString(4, password);
            psUser.setString(5, phone);
            psUser.setString(6, role);
            psUser.executeUpdate();

            String sqlCustomer =
                "INSERT INTO customer (customerID, address) VALUES (?, ?)";

            PreparedStatement psCustomer = conn.prepareStatement(sqlCustomer);
            psCustomer.setString(1, userID);
            psCustomer.setString(2, "");
            psCustomer.executeUpdate();

            response.sendRedirect("login.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("signup.jsp?error=1");
        }
    }
}