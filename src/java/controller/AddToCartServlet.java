/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String id = request.getParameter("accessoryID");
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));

        // 🔥 NEW (ambil image)
        String image = request.getParameter("image");

        // 🔥 Create item (STANDARD STRUCTURE)
        ArrayList<Object> item = new ArrayList<>();
        item.add(id);           // 0
        item.add(name);         // 1
        item.add(price);        // 2
        item.add("ACCESSORY");  // 3
        item.add(image);        // 4 🔥 IMPORTANT

        // Get cart
        ArrayList<ArrayList<Object>> cart =
                (ArrayList<ArrayList<Object>>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        cart.add(item);

        session.setAttribute("cart", cart);

        // redirect balik accessories page
        response.sendRedirect("ViewAccessoryCustomerServlet");
    }
}