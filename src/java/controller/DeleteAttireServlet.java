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


@WebServlet("/DeleteAttireServlet")
public class DeleteAttireServlet extends HttpServlet {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/btarsystem",
            "root",
            "root123"
        );
    }

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
            
            String sql = "DELETE FROM attire WHERE attireID=?";
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setString(1, attireID);
             
            System.out.println("ATTIRE ID = " + attireID);

            int result = ps.executeUpdate();

            System.out.println("DELETE RESULT = " + result);

            System.out.println("DELETE RESULT = " + result);

        } catch (Exception e) {
            e.printStackTrace();
        }

        // ❌ mesej delete
        response.sendRedirect("ViewAttireServlet?msg=deleted");
    }
}