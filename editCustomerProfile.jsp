<%-- 
    Document   : editCustomerProfile
    Created on : Mar 4, 2026, 10:54:16 PM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>

<%
if (session.getAttribute("role") == null || !"CUSTOMER".equals(session.getAttribute("role"))) {
    response.sendRedirect("login.jsp");
    return;
}

String name  = (String) request.getAttribute("name");
String email = (String) request.getAttribute("email");
String phone = (String) request.getAttribute("phone");
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Profile | Busana Tradisi</title>

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
background:
linear-gradient(135deg,#fb7185,#ef4444);
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
font-size:32px;
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
margin-bottom:28px;
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
}.hero-card::after{
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
max-width:650px;
position:relative;
z-index:2;
}

/* =========================
FORM CARD
========================= */

.form-card{
max-width:650px;
margin:auto;
background:white;
border-radius:30px;
padding:40px;
box-shadow:0 18px 35px rgba(15,23,42,0.06);
animation:fadeUp 0.5s ease;
}

@keyframes fadeUp{
from{
opacity:0;
transform:translateY(20px);
}
to{
opacity:1;
transform:translateY(0);
}
}

/* =========================
PROFILE ICON
========================= */

.profile-icon{
width:110px;
height:110px;
margin:auto;
border-radius:50%;
background:
linear-gradient(135deg,#2563eb,#3b82f6);
display:flex;
justify-content:center;
align-items:center;
font-size:42px;
color:white;
box-shadow:0 18px 35px rgba(37,99,235,0.25);
margin-bottom:25px;
animation:float 3s ease-in-out infinite;
}

@keyframes float{
0%{
transform:translateY(0);
}
50%{
transform:translateY(-8px);
}
100%{
transform:translateY(0);
}
}

/* =========================
FORM
========================= */

.group{
margin-bottom:22px;
}

.group label{
display:block;
font-size:13px;
font-weight:700;
color:#64748b;
margin-bottom:8px;
}

.input-box{
position:relative;
}

.input-box i{
position:absolute;
left:16px;
top:50%;
transform:translateY(-50%);
color:#3b82f6;
font-size:14px;
}

.group input{
width:100%;
height:54px;
border-radius:16px;
border:1px solid #dbeafe;
padding-left:48px;
padding-right:15px;
font-size:14px;
font-family:'Inter',sans-serif;
background:#f8fbff;
transition:0.3s;
}

.group input:focus{
outline:none;
border-color:#3b82f6;
background:white;
box-shadow:0 0 0 4px rgba(59,130,246,0.12);
}

.group input[readonly]{
background:#eef2ff;
color:#64748b;
cursor:not-allowed;
}

/* =========================
BUTTONS
========================= */

.btn{
width:100%;
height:54px;
border:none;
border-radius:18px;
background:
linear-gradient(135deg,#2563eb,#3b82f6);
color:white;
font-size:15px;
font-weight:700;
cursor:pointer;
transition:0.3s;
box-shadow:0 12px 25px rgba(37,99,235,0.2);
}

.btn:hover{
transform:translateY(-2px);
}

.back-btn{
display:inline-block;
margin-top:18px;
text-decoration:none;
color:#2563eb;
font-size:14px;
font-weight:600;
}

.back-btn:hover{
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
padding:18px;
}

.form-card{
padding:28px;
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
My Bookings
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
Edit Profile
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
Update Your Profile
</div>

<div class="hero-subtitle">
Manage and update your personal account information securely through your customer dashboard.
</div>

</div>

<!-- FORM CARD -->

<div class="form-card">

<div class="profile-icon">
<i class="fa-solid fa-user-pen"></i>
</div>

<form action="EditCustomerProfileServlet" method="post">

<div class="group">

<label>Full Name</label>

<div class="input-box">

<i class="fa-solid fa-id-card"></i>

<input type="text"
name="name"
value="<%= name %>"
required>

</div>

</div>

<div class="group">

<label>Email Address</label>

<div class="input-box">

<i class="fa-solid fa-envelope"></i>

<input type="email"
value="<%= email %>"
readonly>

</div>

</div>

<div class="group">

<label>Phone Number</label>

<div class="input-box">

<i class="fa-solid fa-phone"></i>

<input type="text"
name="phone"
value="<%= phone %>"
required>

</div>

</div>

<button class="btn">
<i class="fa-solid fa-floppy-disk"></i>
Update Profile
</button>

</form>

<a href="CustomerProfileServlet"
class="back-btn">

← Back to Profile

</a>

</div>

</div>

</div>

</body>
</html>