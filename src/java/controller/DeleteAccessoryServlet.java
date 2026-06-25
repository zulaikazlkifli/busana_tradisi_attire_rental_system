/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.File;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


@WebServlet("/DeleteAccessoryServlet")
public class DeleteAccessoryServlet extends HttpServlet {

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

            // =========================
            // 1. GET IMAGE PATH
            // =========================
            String imagePath = "";

            String getImg = "SELECT pictureURL FROM accessory WHERE accessoryID=?";
            PreparedStatement ps1 = con.prepareStatement(getImg);
            ps1.setString(1, id);

            ResultSet rs = ps1.executeQuery();

            if (rs.next()) {
                imagePath = rs.getString("pictureURL");
            }

            // =========================
            // 2. DELETE IMAGE FILE
            // =========================
            if (imagePath != null && !imagePath.equals("")) {

                String fullPath = getServletContext().getRealPath("/") + imagePath;

                File file = new File(fullPath);

                if (file.exists()) {
                    file.delete();
                    System.out.println("Image deleted: " + fullPath);
                } else {
                    System.out.println("Image not found: " + fullPath);
                }
            }

            // =========================
            // 3. DELETE FROM DATABASE
            // =========================
            String sql = "DELETE FROM accessory WHERE accessoryID=?";
            PreparedStatement ps2 = con.prepareStatement(sql);
            ps2.setString(1, id);

            ps2.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        HttpSession session = request.getSession();
        session.setAttribute("msg", "Accessory deleted successfully!");
        
        // =========================
        // 4. REDIRECT
        // =========================
        response.sendRedirect("ViewAccessoryOwnerServlet");
    }
}