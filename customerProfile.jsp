<%-- 
    Document   : customerProfile
    Created on : Mar 4, 2026, 10:52:55 PM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>

<%
    if (session.getAttribute("role") == null || !"CUSTOMER".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String name = (String) request.getAttribute("name");
    String email = (String) request.getAttribute("email");
    String phone = (String) request.getAttribute("phone");
%>

<!DOCTYPE html>
<html>
<head>

<title>Customer Profile | Busana Tradisi</title>

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
PROFILE CARD
========================= */

.profile-card{
background:white;
border-radius:28px;
padding:35px;
box-shadow:0 18px 35px rgba(15,23,42,0.06);
max-width:500px;
margin:auto;
position:relative;
overflow:hidden;
animation:fadeUp 0.5s ease;
}

.profile-card::before{
content:'';
position:absolute;
width:220px;
height:220px;
border-radius:50%;
background:rgba(37,99,235,0.04);
top:-90px;
right:-70px;
}

/* =========================
ANIMATION
========================= */

@keyframes fadeUp{
from{
opacity:0;
transform:translateY(25px);
}
to{
opacity:1;
transform:translateY(0);
}
}
/* =========================
AVATAR
========================= */

.avatar{
width:110px;
height:110px;
border-radius:50%;
background:
linear-gradient(135deg,#2563eb,#3b82f6);
display:flex;
justify-content:center;
align-items:center;
margin:auto;
color:white;
font-size:42px;
box-shadow:0 20px 35px rgba(37,99,235,0.25);
position:relative;
z-index:2;
}

.profile-name{
margin-top:18px;
font-size:28px;
font-weight:800;
color:#0f172a;
text-align:center;
letter-spacing:-1px;
position:relative;
z-index:2;
}

.profile-role{
margin-top:6px;
text-align:center;
font-size:13px;
font-weight:600;
color:#2563eb;
position:relative;
z-index:2;
}

/* =========================
INFO BOX
========================= */

.info-container{
margin-top:30px;
display:flex;
flex-direction:column;
gap:16px;
position:relative;
z-index:2;
}

.info-box{
background:#f8fbff;
border-radius:18px;
padding:18px 22px;
display:flex;
justify-content:space-between;
align-items:center;
transition:0.3s;
border:1px solid #eef2ff;
}

.info-box:hover{
transform:translateY(-2px);
box-shadow:0 10px 25px rgba(37,99,235,0.08);
}

.info-left{
display:flex;
align-items:center;
gap:14px;
}

.info-icon{
width:45px;
height:45px;
border-radius:14px;
background:#dbeafe;
display:flex;
justify-content:center;
align-items:center;
color:#2563eb;
font-size:18px;
}

.info-label{
font-size:13px;
font-weight:600;
color:#64748b;
margin-bottom:4px;
}

.info-value{
font-size:15px;
font-weight:700;
color:#0f172a;
}

/* =========================
BUTTONS
========================= */

.btn-group{
margin-top:28px;
display:flex;
gap:14px;
position:relative;
z-index:2;
}

.btn{
flex:1;
padding:15px;
border-radius:16px;
text-decoration:none;
font-size:14px;
font-weight:700;
text-align:center;
transition:0.3s;
}

.primary-btn{
background:
linear-gradient(135deg,#2563eb,#3b82f6);
color:white;
box-shadow:0 14px 28px rgba(37,99,235,0.22);
}

.primary-btn:hover{
transform:translateY(-3px);
}

.secondary-btn{
background:#eff6ff;
color:#2563eb;
}

.secondary-btn:hover{
background:#dbeafe;
}

/* =========================
RESPONSIVE
========================= */

@media(max-width:768px){

.sidebar{
display:none;
}

.main{
padding:18px;
}

.hero-title{
font-size:28px;
}

.profile-card{
padding:25px;
}

.btn-group{
flex-direction:column;
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
    
<a href="ViewBookingCustomerServlet">
<i class="fa-solid fa-calendar-check"></i>
My Booking
</a>

<a href="CustomerProfileServlet" class="active">
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
Customer Profile
</div>

<div class="customer-box">
<i class="fa-solid fa-user"></i>
Customer
</div>

</div>

<!-- HERO -->

<div class="hero-card">

<div class="hero-tag">
PROFILE MANAGEMENT
</div>

<div class="hero-title">
Manage Your Account
</div>

<div class="hero-subtitle">
View and manage your personal information securely through your customer account dashboard.
</div>

</div>

<!-- PROFILE CARD -->

<div class="profile-card">

<div class="avatar">
<i class="fa-solid fa-user"></i>
</div>

<div class="profile-name">
<%= name %>
</div>

<div class="profile-role">
BUSANA TRADISI CUSTOMER
</div>

<!-- INFO -->

<div class="info-container">

<div class="info-box">

<div class="info-left">

<div class="info-icon">
<i class="fa-solid fa-id-card"></i>
</div>

<div>
<div class="info-label">
Full Name
</div>

<div class="info-value">
<%= name %>
</div>
</div>

</div>

</div>

<div class="info-box">

<div class="info-left">

<div class="info-icon">
<i class="fa-solid fa-envelope"></i>
</div>

<div>
    <div class="info-label">
Email Address
</div>

<div class="info-value">
<%= email %>
</div>
</div>

</div>

</div>

<div class="info-box">

<div class="info-left">

<div class="info-icon">
<i class="fa-solid fa-phone"></i>
</div>

<div>
<div class="info-label">
Phone Number
</div>

<div class="info-value">
<%= phone %>
</div>
</div>

</div>

</div>

</div>

<!-- BUTTONS -->

<div class="btn-group">

<a href="EditCustomerProfileServlet"
class="btn primary-btn">

<i class="fa-solid fa-pen"></i>
Edit Profile

</a>

<a href="customerDashboard.jsp"
class="btn secondary-btn">

← Back To Dashboard

</a>

</div>

</div>

</div>

</div>

</body>
</html>