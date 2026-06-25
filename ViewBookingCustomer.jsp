<%-- 
    Document   : ViewBookingCustomer
    Created on : Apr 16, 2026, 8:59:42 PM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>

<%
ArrayList<String[]> bookingList =
(ArrayList<String[]>) request.getAttribute("bookingList");
%>

<!DOCTYPE html>
<html>
<head>
<title>Booking | Busana Tradisi</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
}

body{
font-family:'Inter',sans-serif;
background:#edf4ff;
overflow:hidden;
}

/* =========================
LAYOUT
========================= */

.wrapper{
display:flex;
height:100vh;
}

/* =========================
SIDEBAR
========================= */

.sidebar{
    width:260px;
    background:linear-gradient(180deg,#0f172a 0%, #172554 45%, #2563eb 100%);
    padding:30px 22px;
    display:flex;
    flex-direction:column;
    justify-content:space-between;
    box-shadow:8px 0 30px rgba(0,0,0,0.18);
}

.logo{
    color:white;
    font-size:34px;
    font-weight:800;
    line-height:1;
    letter-spacing:-1px;
    margin-bottom:55px;
}

.logo span{
    color:#93c5fd;
}

.menu{
display:flex;
flex-direction:column;
gap:14px;
}

.menu a{
text-decoration:none;
color:#dbeafe;
padding:16px 18px;
border-radius:18px;
transition:0.3s;
display:flex;
align-items:center;
gap:14px;
font-size:15px;
font-weight:500;
}

.menu a:hover{
background:rgba(255,255,255,0.12);
color:white;
transform:translateX(4px);
}

.menu a.active{
background:rgba(255,255,255,0.12);
color:white;
box-shadow:0 10px 25px rgba(0,0,0,0.18);
}

.logout-btn{
background:linear-gradient(135deg,#fb7185,#ef4444);
color:white;
text-decoration:none;
padding:15px;
border-radius:18px;
text-align:center;
font-weight:600;
transition:0.3s;
}

.logout-btn:hover{
transform:translateY(-3px);
}

/* =========================
MAIN
========================= */

.main{
flex:1;
padding:28px;
overflow-y:auto;
}

/* =========================
TOPBAR
========================= */

.topbar{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:26px;
}

.page-title{
    font-size:30px;
    font-weight:800;
    color:#0f172a;
    letter-spacing:-1px;
}

.customer-box{
background:white;
padding:14px 22px;
border-radius:18px;
display:flex;
align-items:center;
gap:12px;
box-shadow:0 10px 25px rgba(0,0,0,0.05);
font-weight:600;
}

.customer-box i{
color:#2563eb;
}

/* =========================
HERO
========================= */

.hero-card{
background:
linear-gradient(135deg,
#0f172a 0%,
#1d4ed8 50%,
#3b82f6 100%);
border-radius:28px;
padding:28px 32px;
position:relative;
overflow:hidden;
margin-bottom:26px;
box-shadow:0 20px 40px rgba(37,99,235,0.18);
}

.hero-card::before{
content:'';
position:absolute;
width:220px;
height:220px;
border-radius:50%;
background:rgba(255,255,255,0.05);
top:-100px;
right:-50px;
}

.hero-card::after{
    content:'';
    position:absolute;
    width:180px;
    height:180px;
    border-radius:50%;
    background:rgba(255,255,255,0.05);
    bottom:-60px;
    left:-60px;
}

.hero-tag{
font-size:11px;
font-weight:700;
letter-spacing:2px;
color:#bfdbfe;
margin-bottom:10px;
position:relative;
z-index:2;
}

.hero-title{
font-size:34px;
font-weight:800;
color:white;
letter-spacing:-1px;
margin-bottom:8px;
position:relative;
z-index:2;
}

.hero-subtitle{
font-size:14px;
color:#dbeafe;
line-height:1.7;
max-width:680px;
position:relative;
z-index:2;
}

/* =========================
TABLE CARD
========================= */

.table-card{
background:white;
border-radius:28px;
padding:26px;
box-shadow:0 18px 35px rgba(15,23,42,0.06);
overflow:auto;
}

/* =========================
TABLE
========================= */

table{
width:100%;
border-collapse:collapse;
}

th{
padding:16px 14px;
font-size:13px;
font-weight:700;
color:#64748b;
text-align:center;
border-bottom:1px solid #e2e8f0;
}

td{
padding:18px 14px;
font-size:14px;
text-align:center;
color:#334155;
border-bottom:1px solid #f1f5f9;
}

tr:hover{
background:#f8fbff;
}

/* =========================
STATUS
========================= */

.status{
display:inline-block;
padding:8px 16px;
border-radius:30px;
font-size:11px;
font-weight:700;
}

.pending{
background:#fef3c7;
color:#92400e;
}

.paid{
    background:#dcfce7;
color:#166534;
}

.completed{
background:#dbeafe;
color:#1d4ed8;
}

.cancelled{
background:#fee2e2;
color:#991b1b;
}

/* =========================
BUTTONS
========================= */

.pay-btn{
background:linear-gradient(135deg,#2563eb,#3b82f6);
color:white;
padding:10px 18px;
border-radius:12px;
text-decoration:none;
font-size:12px;
font-weight:700;
display:inline-block;
transition:0.3s;
box-shadow:0 10px 20px rgba(37,99,235,0.18);
}

.pay-btn:hover{
transform:translateY(-2px);
}

.action-text{
font-size:13px;
color:#94a3b8;
font-weight:500;
}

.action-buttons{
display:flex;
justify-content:center;
align-items:center;
gap:10px;
flex-wrap:nowrap;
}

td{
text-align:center;
vertical-align:middle;
}

.edit-btn{
background:#f59e0b;
color:white;
padding:8px 12px;
border-radius:10px;
text-decoration:none;
font-size:12px;
font-weight:600;
}

.edit-btn:hover{
opacity:0.9;
}

.pay-btn{
padding:8px 12px;
font-size:12px;
}

/* =========================
BACK BUTTON
========================= */

.back-btn{
display:inline-block;
margin-top:24px;
padding:12px 20px;
border-radius:14px;
background:#eff6ff;
color:#2563eb;
text-decoration:none;
font-size:14px;
font-weight:600;
transition:0.3s;
}

.back-btn:hover{
background:#dbeafe;
}

/* =========================
RESPONSIVE
========================= */

@media(max-width:768px){

.sidebar{
display:none;
}

.page-title{
font-size:28px;
}

.hero-title{
font-size:28px;
}

}

</style>
</head>

<body>

<div class="wrapper">

<!-- SIDEBAR -->

<div class="sidebar">
    

<div>

<div class="logo">
BUSANA<br>
<span>TRADISI</span>
</div>

<div class="menu">

<a href="customerDashboard.jsp">
<i class="fa-solid fa-house"></i>
Dashboard
</a>

<a href="ViewAttireCustomerServlet">
<i class="fa-solid fa-shirt"></i>
Attires

<a href="ViewAccessoryCustomerServlet?mode=all">
<i class="fa-solid fa-gem"></i>
Accessories
</a>

<a href="cart.jsp">
    <i class="fa-solid fa-cart-shopping"></i>
    My Cart
</a>
    
<a href="ViewBookingCustomerServlet" class="active">
<i class="fa-solid fa-calendar-check"></i>
My Booking
</a>

<a href="CustomerProfileServlet">
<i class="fa-solid fa-user"></i>
My Profile
</a>

</div>

</div>

<a href="LogoutServlet" class="logout-btn">
<i class="fa-solid fa-right-from-bracket"></i>
Logout
</a>

</div>

<!-- MAIN -->

<div class="main">

<!-- TOPBAR -->

<div class="topbar">

<div class="page-title">
My Booking
</div>

<div class="customer-box">
<i class="fa-solid fa-user"></i>
Customer
</div>

</div>

<!-- HERO -->

<div class="hero-card">

<div class="hero-tag">
BOOKING MANAGEMENT
</div>

<div class="hero-title">
Your Booking Records
</div>

<div class="hero-subtitle">
Track your booking status, payment progress and rental history professionally.
</div>

</div>

<!-- TABLE -->

<div class="table-card">

<table>

<tr>
<th>Booking ID</th>
<th>Attire</th>
<th>Accessory</th>
<th>Pickup</th>
<th>Return</th>
<th>Total</th>
<th>Status</th>
<th>Action</th>
</tr>

<%
if(bookingList != null && !bookingList.isEmpty()){

for(String[] b : bookingList){

String bookingID = b[0];
String status = b[6];

String statusClass = "";

if("PENDING".equalsIgnoreCase(status)){
statusClass = "pending";
}
else if("PAID".equalsIgnoreCase(status)){
statusClass = "paid";
}
else if("COMPLETED".equalsIgnoreCase(status)){
statusClass = "completed";
}
else if("CANCELLED".equalsIgnoreCase(status)){
statusClass = "cancelled";
}
%>

<tr>

<td>
B<%=String.format("%03d",
Integer.parseInt(b[0]))%>
</td>

<td>
<b><%=b[1]%></b>
</td>

<td><%=b[2]%></td>

<td><%=b[3]%></td>

<td><%=b[4]%></td>

<td>
<b>RM <%=b[5]%></b>
</td>

<td>

<span class="status <%=statusClass%>">
<%=status%>
</span>

</td>

<td>

<%
if("PENDING".equalsIgnoreCase(status)){
%>

<div class="action-buttons">

<a href="EditBookingCustomerServlet?id=<%=bookingID%>"
class="edit-btn">
✏️ Edit
</a>

<a href="payment.jsp?bookingID=<%=bookingID%>&total=<%=b[5]%>"
class="pay-btn">
💳 Pay
</a>

</div>

<%
}else if("PAID".equalsIgnoreCase(status)){
%>

<span class="action-text">
Payment Completed
</span>

<%
}else if("COMPLETED".equalsIgnoreCase(status)){
%>

<span class="action-text">
Renting Completed
</span>

<%
}else{
%>

<span class="action-text">
No Action
</span>

<%
}
%>

</td>
</tr>

<%
}

}else{
%>

<tr>

<td colspan="8"
style="padding:40px;color:#94a3b8;">

No bookings found

</td>

</tr>

<%
}
%>

</table>

<a href="customerDashboard.jsp"
class="back-btn">

← Back to Dashboard

</a>

</div>

</div>

</div>

</body>
</html>