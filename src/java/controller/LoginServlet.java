/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private Connection getConnection() throws Exception {

        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/btarsystem",
            "root",
            "root123"
        );
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email =
            request.getParameter("email");

        String password =
            request.getParameter("password");

        try (Connection con = getConnection()) {

            String sql =
                "SELECT userID, role " +
                "FROM user " +
                "WHERE email=? AND password_hash=?";

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                HttpSession session =
                    request.getSession();

                // remove old session
                session.invalidate();

                // create new session
                session =
                    request.getSession(true);

                // set new user session
                session.setAttribute(
                    "userID",
                    rs.getString("userID")
                );

                session.setAttribute(
                    "role",
                    rs.getString("role")
                );

                // redirect by role
                if ("CUSTOMER".equals(
                        rs.getString("role"))) {

                    response.sendRedirect(
                        "customerDashboard.jsp"
                    );

                }
                else if ("OWNER".equals(
                            rs.getString("role"))) {

                    response.sendRedirect(
                        "OwnerDashboardServlet"
                    );

                }
                else {

                    response.sendRedirect(
                        "login.jsp?error=1"
                    );
                }

            } else {

                response.sendRedirect(
                    "login.jsp?error=1"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "login.jsp?error=1"
            );
        }
    }
}