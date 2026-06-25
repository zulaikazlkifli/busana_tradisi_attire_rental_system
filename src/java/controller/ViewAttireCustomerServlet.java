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


@WebServlet("/ViewAttireCustomerServlet")
public class ViewAttireCustomerServlet extends HttpServlet {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/btarsystem",
            "root",
            "root123"
        );
    }

    // ================= DISPLAY ATTIRE =================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"CUSTOMER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        ArrayList<String[]> attireList = new ArrayList<>();

        try (Connection con = getConnection()) {
            String sql = "SELECT * FROM attire WHERE availabilityStatus='AVAILABLE'";
            PreparedStatement ps = con.prepareStatement(sql);
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
        request.getRequestDispatcher("/viewAttireCustomer.jsp")
               .forward(request, response);
    }

    // ================= SELECT ATTIRE =================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        System.out.println("MASUK DOPOST");

        HttpSession session = request.getSession();

        String attireID = request.getParameter("attireID");
        String attireName = request.getParameter("attireName");
        double price = Double.parseDouble(request.getParameter("price"));

        // 🔥 NEW
        String imagePath = request.getParameter("imagePath");

        // simpan untuk accessories filter
        session.setAttribute("selectedAttireID", attireID);

        // ambil cart
        ArrayList<ArrayList<Object>> cart =
            (ArrayList<ArrayList<Object>>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        // remove attire lama
        for (int i = 0; i < cart.size(); i++) {
            ArrayList item = cart.get(i);

            String type = "";
            if (item.size() > 3) {
                type = (String) item.get(3);
            }

            if ("ATTIRE".equals(type)) {
                cart.remove(i);
                break;
            }
        }

        // tambah attire baru
        ArrayList<Object> newItem = new ArrayList<>();
        newItem.add(attireID);     
        newItem.add(attireName);   
        newItem.add(price);        
        newItem.add("ATTIRE");     
        newItem.add(imagePath);   // 🔥 IMPORTANT FIX

        cart.add(newItem);

        session.setAttribute("cart", cart);

        response.sendRedirect("ViewAccessoryCustomerServlet");
    }
}