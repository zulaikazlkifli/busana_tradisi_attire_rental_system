/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewAttireServlet")
public class ViewAttireServlet extends HttpServlet {

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

        String ownerID = (String) session.getAttribute("userID");
        ArrayList<String[]> attireList = new ArrayList<>();

        try (Connection con = getConnection()) {
            String sql = "SELECT * FROM attire WHERE ownerID=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, ownerID);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] a = new String[8];
                a[0] = rs.getString("attireID");
                a[1] = rs.getString("attireName");
                a[2] = rs.getString("category");
                a[3] = rs.getString("size");
                a[4] = rs.getString("rental_price");
                a[5] = rs.getString("availabilityStatus");
                a[6] = rs.getString("imagePath");
                a[7] = rs.getString("description");
                attireList.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("attireList", attireList);
        request.getRequestDispatcher("viewAttire.jsp").forward(request, response);
    }
}