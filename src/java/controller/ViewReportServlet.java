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

@WebServlet("/ViewReportServlet")
public class ViewReportServlet extends HttpServlet {

    private Connection getConnection() throws Exception {

        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/btarsystem",
            "root",
            "root123"
        );
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<String[]> reportList =
            new ArrayList<>();
        
        StringBuilder labels =
        new StringBuilder();

        StringBuilder data =
        new StringBuilder();
        
        StringBuilder monthLabels =
        new StringBuilder();

        StringBuilder monthData =
        new StringBuilder();
        
        int totalBookings = 0;

        double totalRevenue = 0;

        String topAttire = "-";

        String year =
        request.getParameter("year");

        String month =
        request.getParameter("month");

        if(year == null){
            year = "2026";
        }

        if(month == null){
            month = "0";
        }
        
        try(Connection con = getConnection()){
   
            // =========================
            // MOST POPULAR ATTIRE
            // =========================

            String sql;

            if(month.equals("0")){

                sql =
                "SELECT a.attireName, " +
                "COUNT(b.bookingID) AS totalBooking " +
                "FROM attire a " +
                "LEFT JOIN booking b " +
                "ON a.attireID=b.attireID " +
                "AND YEAR(b.bookingDate)=? " +
                "GROUP BY a.attireID " +
                "ORDER BY totalBooking DESC";

            }else{

                sql =
                "SELECT a.attireName, " +
                "COUNT(b.bookingID) AS totalBooking " +
                "FROM attire a " +
                "LEFT JOIN booking b " +
                "ON a.attireID=b.attireID " +
                "AND YEAR(b.bookingDate)=? " +
                "AND MONTH(b.bookingDate)=? " +
                "GROUP BY a.attireID " +
                "ORDER BY totalBooking DESC";
            }

            PreparedStatement ps =
            con.prepareStatement(sql);
            
            ps.setString(1, year);

            if(!month.equals("0")){
                ps.setString(2, month);
            }

            ResultSet rs =
                ps.executeQuery();

            while(rs.next()){
                System.out.println(
                "ATTIRE = " +
                rs.getString("attireName")
                +
                " TOTAL = " +
                rs.getInt("totalBooking")
                );

                String[] row = new String[2];

                row[0] =
                    rs.getString("attireName");

                row[1] =
                    rs.getString("totalBooking");

                reportList.add(row);
                
                labels.append("'")
                .append(rs.getString("attireName"))
                .append("',");

          data.append(
                rs.getInt("totalBooking"))
                .append(",");
                
                totalBookings +=
                Integer.parseInt(
                rs.getString("totalBooking")
                );
            }

            if(!reportList.isEmpty()){

                topAttire =
                    reportList.get(0)[0];
            }
            
                        String monthSql =
            "SELECT MONTH(bookingDate) AS month, " +
            "COUNT(*) AS total " +
            "FROM booking " +
            "GROUP BY MONTH(bookingDate) " +
            "ORDER BY MONTH(bookingDate)";

            PreparedStatement psMonth =
            con.prepareStatement(monthSql);

            ResultSet rsMonth =
            psMonth.executeQuery();
            
            System.out.println("MONTH REPORT RUNNING");

            while(rsMonth.next()){
                
                System.out.println(
                    "MONTH = " + rsMonth.getInt("month")
                    + " TOTAL = " + rsMonth.getInt("total")
                );

                int monthNumber =
                rsMonth.getInt("month");

                String monthName = "";

                switch(monthNumber){
                case 1: monthName="Jan"; break;
                case 2: monthName="Feb"; break;
                case 3: monthName="Mar"; break;
                case 4: monthName="Apr"; break;
                case 5: monthName="May"; break;
                case 6: monthName="Jun"; break;
                case 7: monthName="Jul"; break;
                case 8: monthName="Aug"; break;
                case 9: monthName="Sep"; break;
                case 10: monthName="Oct"; break;
                case 11: monthName="Nov"; break;
                case 12: monthName="Dec"; break;
            }

                monthLabels.append("'")
                .append(monthName)
                .append("',");

                monthData
                .append(rsMonth.getInt("total"))
                .append(",");
            }

            // =========================
            // TOTAL BOOKING & REVENUE
            // =========================

            String bookingSql;

            if(month.equals("0")){

                bookingSql =
                "SELECT COUNT(*) AS totalBooking, " +
                "SUM(totalAmount) AS totalRevenue " +
                "FROM booking " +
                "WHERE YEAR(bookingDate)=?";

            }else{

                bookingSql =
                "SELECT COUNT(*) AS totalBooking, " +
                "SUM(totalAmount) AS totalRevenue " +
                "FROM booking " +
                "WHERE YEAR(bookingDate)=? " +
                "AND MONTH(bookingDate)=?";
            }

            PreparedStatement ps2 =
                con.prepareStatement(bookingSql);
            
            ps2.setString(1, year);

            if(!month.equals("0")){
                ps2.setString(2, month);
            }

            ResultSet rs2 =
                ps2.executeQuery();

            if(rs2.next()){

                totalBookings =
                    rs2.getInt("totalBooking");

                totalRevenue =
                    rs2.getDouble("totalRevenue");
            }

        }catch(Exception e){

            e.printStackTrace();
        }

        request.setAttribute(
            "reportList",
            reportList
        );

        request.setAttribute(
            "totalBookings",
            totalBookings
        );

        request.setAttribute(
            "totalRevenue",
            totalRevenue
        );

        request.setAttribute(
            "topAttire",
            topAttire
        );
        System.out.println("LABELS = " + labels.toString());
        System.out.println("DATA = " + data.toString());
        
        
        request.setAttribute(
        "chartLabels",
        labels.toString()
        );

        request.setAttribute(
        "chartData",
        data.toString()
        );
        
        request.setAttribute(
        "monthLabels",
        monthLabels.toString()
        );

        request.setAttribute(
        "monthData",
        monthData.toString()
        );
        
        RequestDispatcher rd =
            request.getRequestDispatcher(
                "report.jsp"
            );
        
        if(!reportList.isEmpty()){

            topAttire =
            reportList.get(0)[0];

        }

        request.setAttribute(
            "totalBookings",
            totalBookings
        );

        request.setAttribute(
            "totalRevenue",
            totalRevenue
        );

        request.setAttribute(
            "topAttire",
            topAttire
        );
        
        rd.forward(request, response);
    }
} 