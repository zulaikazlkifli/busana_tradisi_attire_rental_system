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
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GoAddAccessoryServlet")
public class GoAddAccessoryServlet extends HttpServlet {

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

        ArrayList<String[]> attireList = new ArrayList<>();

        try (Connection con = getConnection()) {

            String sql = "SELECT attireID, attireName FROM attire";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String[] row = new String[2];
                row[0] = rs.getString("attireID");     // ID
                row[1] = rs.getString("attireName");   // Name

                attireList.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // hantar data ke JSP
        request.setAttribute("attireList", attireList);

        // forward ke page add accessory
        RequestDispatcher rd = request.getRequestDispatcher("addAccessory.jsp");
        rd.forward(request, response);
    }
}