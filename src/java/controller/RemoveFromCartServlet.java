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

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int index = Integer.parseInt(request.getParameter("index"));

        HttpSession session = request.getSession();
        ArrayList cart = (ArrayList) session.getAttribute("cart");

        if(cart != null){
            cart.remove(index);
        }

        session.setAttribute("cart", cart);

        response.sendRedirect("cart.jsp?removed=1");
    }
}