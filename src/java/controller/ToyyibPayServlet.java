/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.*;
import java.net.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


@WebServlet("/ToyyibPayServlet")
public class ToyyibPayServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String bookingID =
            request.getParameter("bookingID");

        String amount = "";

        String customerName = "";
        String customerEmail = "";
        String customerPhone = "";

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn =
                DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/btarsystem",
                    "root",
                    "root123"
                );

            // =========================
            // GET BOOKING INFO
            // =========================

            String bookingSql =
                "SELECT totalAmount, userID " +
                "FROM booking WHERE bookingID=?";

            PreparedStatement bookingPs =
                conn.prepareStatement(bookingSql);

            bookingPs.setString(1, bookingID);

            ResultSet bookingRs =
                bookingPs.executeQuery();

            String userID = "";

            if(bookingRs.next()){

                amount =
                    bookingRs.getString("totalAmount");

                userID =
                    bookingRs.getString("userID");
            }
            
            if(amount == null || amount.trim().equals("")){
    
                response.getWriter().println(
                    "Booking amount not found!"
                );

                return;
            }

            System.out.println("AMOUNT = " + amount);
            System.out.println("USER ID = " + userID);

            // =========================
            // GET USER INFO
            // =========================

            String userSql =
                "SELECT * FROM user WHERE userID=?";

            PreparedStatement userPs =
                conn.prepareStatement(userSql);

            userPs.setString(1, userID);

            ResultSet userRs =
                userPs.executeQuery();

            if(userRs.next()){

                customerName =
                    userRs.getString("name");

                customerEmail =
                    userRs.getString("email");

                customerPhone =
                    userRs.getString("phone");
            }

            System.out.println(customerName);
            System.out.println(customerEmail);
            System.out.println(customerPhone);

            conn.close();

        } catch(Exception e){
            e.printStackTrace();
        }

        try {

            // =========================
            // TOYYIBPAY
            // =========================

            String userSecretKey =
                "b9snmega-1fjc-2cil-tu0p-2z5hlz0oiyhr";

            String categoryCode =
                "yhy7s88g";

            String billName =
                "Booking Payment #" + bookingID;

            String billDescription =
                "Traditional Attire Rental Payment";

            int amountCent =
                (int)(Double.parseDouble(amount) * 100);

            URL url = new URL(
                "https://dev.toyyibpay.com/index.php/api/createBill"
            );

            HttpURLConnection conn =
                (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            String returnURL =
                "http://localhost:8080/btarsystem/PaymentSuccessServlet";

            String postData =
                "userSecretKey=" + URLEncoder.encode(userSecretKey, "UTF-8")
                + "&categoryCode=" + URLEncoder.encode(categoryCode, "UTF-8")
                + "&billName=" + URLEncoder.encode(billName, "UTF-8")
                + "&billDescription=" + URLEncoder.encode(billDescription, "UTF-8")
                + "&billPriceSetting=1"
                + "&billPayorInfo=1"
                + "&billAmount=" + amountCent
                + "&billReturnUrl=" + URLEncoder.encode(returnURL, "UTF-8")
                + "&billExternalReferenceNo=" + bookingID
                + "&billTo=" + URLEncoder.encode(customerName, "UTF-8")
                + "&billEmail=" + URLEncoder.encode(customerEmail, "UTF-8")
                + "&billPhone=" + URLEncoder.encode(customerPhone, "UTF-8");

            OutputStream os =
                conn.getOutputStream();

            os.write(postData.getBytes());

            os.flush();
            os.close();

            BufferedReader br =
                new BufferedReader(
                    new InputStreamReader(conn.getInputStream())
                );

            String output;

            StringBuilder result =
                new StringBuilder();

            while((output = br.readLine()) != null){
                result.append(output);
            }

            br.close();

            String responseData =
                result.toString();

            System.out.println(responseData);

            // =========================
            // GET BILL CODE
            // =========================

            if(responseData.contains("\"BillCode\":\"")){

                String billCode =
                    responseData.split("\"BillCode\":\"")[1]
                                .split("\"")[0];

                response.sendRedirect(
                    "https://dev.toyyibpay.com/" + billCode
                );

            }else{

                System.out.println(responseData);

                response.getWriter().println(
                    "ToyyibPay Error: Invalid response from ToyyibPay"
                );
            }

        } catch(Exception e){

            e.printStackTrace();

            response.getWriter().println(
                "ToyyibPay Error: " + e.getMessage()
            );
        }
    }
}