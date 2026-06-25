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


@WebServlet("/ViewAccessoryCustomerServlet")
public class ViewAccessoryCustomerServlet extends HttpServlet {

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

        HttpSession session = request.getSession();

        // 🔥 jika customer klik sidebar Accessories
        String mode = request.getParameter("mode");

        if("all".equals(mode)){
            session.removeAttribute("selectedAttireID");
        }

        // ambil selected attire kalau ada
        String attireID =
            (String) session.getAttribute("selectedAttireID");

        ArrayList<ArrayList<String>> accessoryList =
            new ArrayList<>();

        try (Connection con = getConnection()) {

            PreparedStatement ps;

            // =========================
            // IF CUSTOMER SELECT ATTIRE
            // =========================
            if(attireID != null && !attireID.isEmpty()){

                String sql =
                "SELECT * FROM accessory WHERE attireID=?";

                ps = con.prepareStatement(sql);
                ps.setString(1, attireID);

            }

            // =========================
            // IF CUSTOMER CLICK SIDEBAR
            // =========================
            else{

                String sql =
                "SELECT * FROM accessory";

                ps = con.prepareStatement(sql);

            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                ArrayList row = new ArrayList();

                row.add(rs.getString("accessoryID"));      // 0
                row.add(rs.getString("accessoryName"));    // 1
                row.add(rs.getString("description"));      // 2
                row.add(rs.getString("pictureURL"));       // 3
                row.add(rs.getDouble("price") + "");       // 4
                row.add(rs.getInt("quantity") + "");       // 5

                accessoryList.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("accessoryList", accessoryList);

        RequestDispatcher rd =
            request.getRequestDispatcher("chooseAccessory.jsp");

        rd.forward(request, response);
    }
}