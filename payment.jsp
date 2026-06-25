<%-- 
    Document   : payment
    Created on : May 11, 2026, 9:58:04 PM
    Author     : user
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%
String bookingID = request.getParameter("bookingID");
String total = request.getParameter("total");
%>

<!DOCTYPE html>
<html>
<head>
<title>Payment | Busana Tradisi</title>

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
padding:20px;
display:flex;
justify-content:center;
align-items:center;
overflow-y:auto;
}

/* =========================
PAYMENT CARD
========================= */

.payment-card{
width:100%;
max-width:470px;
background:white;
border-radius:24px;
padding:26px;
box-shadow:0 15px 35px rgba(15,23,42,0.08);
position:relative;
overflow:hidden;
}

.payment-card::before{
content:'';
position:absolute;
width:180px;
height:180px;
border-radius:50%;
background:rgba(59,130,246,0.05);
top:-90px;
right:-50px;
}

/* =========================
HEADER
========================= */

.icon-box{
width:72px;
height:72px;
border-radius:20px;
margin:auto;
display:flex;
justify-content:center;
align-items:center;
background:linear-gradient(135deg,#2563eb,#3b82f6);
color:white;
font-size:28px;
box-shadow:0 12px 24px rgba(37,99,235,0.22);
position:relative;
z-index:2;
}

.title{
margin-top:18px;
font-size:26px;
font-weight:800;
color:#0f172a;
text-align:center;
letter-spacing:-1px;
position:relative;
z-index:2;
}

.subtitle{
margin-top:8px;
font-size:13px;
line-height:1.6;
color:#64748b;
text-align:center;
position:relative;
z-index:2;
}

/* =========================
PAYMENT INFO
========================= */

.info-box{
margin-top:22px;
background:#f8fbff;
padding:18px;
border-radius:18px;
position:relative;
z-index:2;
}

.info-row{
display:flex;
justify-content:space-between;
align-items:center;
padding:12px 0;
border-bottom:1px solid #e2e8f0;
}

.info-row:last-child{
border-bottom:none;
}

.label{
font-size:12px;
font-weight:600;
color:#64748b;
}

.value{
font-size:15px;
font-weight:700;
color:#0f172a;
}

.total{
font-size:30px;
font-weight:800;
color:#10b981;
}

/* =========================
NOTICE
========================= */

.notice{
margin-top:18px;
background:#eff6ff;
padding:14px;
border-radius:14px;
font-size:12px;
line-height:1.7;
color:#475569;
position:relative;
z-index:2;
}

/* =========================
BUTTON
========================= */

.btn{
display:block;
width:100%;
padding:14px;
margin-top:20px;
border-radius:14px;
text-decoration:none;
background:linear-gradient(135deg,#10b981,#059669);
color:white;
font-size:14px;
font-weight:700;
text-align:center;
transition:0.3s;
box-shadow:0 12px 24px rgba(16,185,129,0.22);
position:relative;
z-index:2;
}

.btn:hover{
transform:translateY(-2px);
}

/* =========================
BACK
========================= */

.back{
display:block;
margin-top:14px;
text-align:center;
text-decoration:none;
color:#2563eb;
font-size:13px;
font-weight:600;
position:relative;
z-index:2;
}

.back:hover{
text-decoration:underline;
}

/* =========================
RESPONSIVE
========================= */

@media(max-width:768px){

.sidebar{
display:none;
}

.main{
padding:20px;
}

.payment-card{
padding:28px;
}

.title{
font-size:28px;
}

.total{
font-size:32px;
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
</a>
    
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
My Bookings
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

<div class="payment-card">

<div class="icon-box">
<i class="fa-solid fa-credit-card"></i>
</div>

<div class="title">
Booking Payment
</div>

<div class="subtitle">
Complete your payment securely using ToyyibPay sandbox payment gateway.
</div>

<!-- PAYMENT INFO -->

<div class="info-box">

<div class="info-row">

<div class="label">
Booking ID
</div>

<div class="value">
B<%= String.format("%03d",
Integer.parseInt(bookingID)) %>
</div>

</div>

<div class="info-row">

<div class="label">
Payment Amount
</div>

<div class="total">
RM <%=total%>
</div>

</div>

</div>

<!-- NOTICE -->

<div class="notice">

💳 You will be redirected securely to ToyyibPay sandbox payment page.<br>

🔒 All payment transactions are encrypted and protected.

</div>

<!-- BUTTON -->

<a href="ToyyibPayServlet?bookingID=<%=bookingID%>&amount=<%=total%>"
class="btn">

Proceed To Payment

</a>

<a href="ViewBookingCustomerServlet"
class="back">

← Back to My Bookings

</a>

</div>

</div>

</div>

</body>
</html>