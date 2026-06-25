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


@WebServlet("/EditAccessoryServlet")
public class EditAccessoryServlet extends HttpServlet {

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

        String id = request.getParameter("id");

        try (Connection con = getConnection()) {

            String sql = "SELECT * FROM accessory WHERE accessoryID=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                request.setAttribute("accessoryID", rs.getString("accessoryID"));
                request.setAttribute("name", rs.getString("accessoryName"));
                request.setAttribute("description", rs.getString("description"));
                request.setAttribute("image", rs.getString("pictureURL"));
                request.setAttribute("price", rs.getDouble("price"));
                request.setAttribute("quantity", rs.getInt("quantity"));
                request.setAttribute("attireID", rs.getString("attireID"));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        RequestDispatcher rd = request.getRequestDispatcher("editAccessory.jsp");
        rd.forward(request, response);
    }
}