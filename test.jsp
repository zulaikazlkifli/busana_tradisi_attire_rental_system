<%-- 
    Document   : test
    Created on : Apr 18, 2026, 7:47:46 PM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>

<h2>FORM BERJAYA SUBMIT ✅</h2>

<%
out.println("BookingID: " + request.getParameter("bookingID") + "<br>");
out.println("Start: " + request.getParameter("eventStartDate") + "<br>");
out.println("End: " + request.getParameter("eventEndDate") + "<br>");
%>