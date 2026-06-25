/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


@WebServlet("/ViewAccessoryOwnerServlet")
public class ViewAccessoryOwnerServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList accessoryList = new ArrayList();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/btarsystem",
                "root",
                "root123"
            );

            String sql = "SELECT * FROM accessory";
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                ArrayList data = new ArrayList();

                data.add(rs.getString("accessoryID"));
                data.add(rs.getString("accessoryName"));
                data.add(rs.getString("description"));
                data.add(rs.getString("pictureURL"));
                data.add(rs.getDouble("price"));
                data.add(rs.getInt("quantity"));
                data.add(rs.getString("attireID"));

                accessoryList.add(data);
            }

            request.setAttribute("accessoryList", accessoryList);

            RequestDispatcher rd = request.getRequestDispatcher("manageAccessory.jsp");
            rd.forward(request, response);

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}