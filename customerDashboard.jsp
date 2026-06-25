<%-- 
    Document   : customerDashboard
    Created on : Dec 26, 2025, 3:29:49 PM
    Author     : Che Zulaika  
--%>

<%@ page contentType="text/html; charset=UTF-8" %>

<%
String role = (String) session.getAttribute("role");

if (role == null || !"CUSTOMER".equals(role)) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<title>Customer Dashboard | Busana Tradisi</title>

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
    transform:translateX(5px);
}

.menu a.active{
    background:rgba(255,255,255,0.12);
    color:white;
    box-shadow:0 10px 25px rgba(0,0,0,0.18);
}

.menu i{
    width:18px;
}

/* LOGOUT */

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
    overflow-y:auto;
    padding:28px;
}

/* =========================
   TOPBAR
========================= */

.topbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
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
    color:#0f172a;
}

.customer-box i{
    color:#2563eb;
}

/* =========================
   HERO CARD
========================= */

.hero-card{
    background:
    linear-gradient(135deg,
    #0f172a 0%,
    #1d4ed8 50%,
    #3b82f6 100%);
    border-radius:30px;
    padding:34px;
    margin-bottom:28px;
    position:relative;
    overflow:hidden;
    box-shadow:0 18px 40px rgba(37,99,235,0.18);
}

.hero-card::before{
    content:'';
    position:absolute;
    width:250px;
    height:250px;
    border-radius:50%;
    background:rgba(255,255,255,0.05);
    top:-110px;
    right:-80px;
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
    color:#bfdbfe;
    font-size:11px;
    font-weight:700;
    letter-spacing:2px;
    margin-bottom:10px;
    position:relative;
    z-index:2;
}

.hero-title{
    font-size:38px;
    font-weight:800;
    color:white;
    margin-bottom:10px;
    letter-spacing:-1px;
    position:relative;
    z-index:2;
}

.hero-subtitle{
    font-size:14px;
    color:#dbeafe;
    line-height:1.8;
    max-width:700px;
    position:relative;
    z-index:2;
}

/* =========================
   CARDS
========================= */

.card-grid{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:24px;
}

.card{
    background:white;
    border-radius:28px;
    padding:30px 26px;
    box-shadow:0 18px 40px rgba(15,23,42,0.06);
    transition:0.35s;
    position:relative;
    overflow:hidden;
}

.card::before{
    content:'';
    position:absolute;
    width:160px;
    height:160px;
    border-radius:50%;
    background:#eff6ff;
    top:-70px;
    right:-70px;
}

.card:hover{
    transform:translateY(-8px);
    box-shadow:0 22px 45px rgba(37,99,235,0.12);
}

.card-icon{
    width:68px;
    height:68px;
    border-radius:20px;
    background:linear-gradient(135deg,#dbeafe,#bfdbfe);
    display:flex;
    align-items:center;
    justify-content:center;
    margin-bottom:24px;
    position:relative;
    z-index:2;
}

.card-icon i{
    font-size:28px;
    color:#2563eb;
}

.card-title{
    font-size:22px;
    font-weight:700;
    color:#0f172a;
    margin-bottom:10px;
    position:relative;
    z-index:2;
}

.card-desc{
    font-size:13px;
    color:#64748b;
    line-height:1.7;
    margin-bottom:24px;
    position:relative;
    z-index:2;
}

.card-btn{
    display:inline-flex;
    align-items:center;
    gap:8px;
    padding:12px 18px;
    border-radius:14px;
    text-decoration:none;
    background:linear-gradient(135deg,#2563eb,#3b82f6);
    color:white;
    font-size:13px;
    font-weight:700;
    transition:0.3s;
    position:relative;
    z-index:2;
}

.card-btn:hover{
    transform:translateY(-2px);
}

.contact-card{
    background:white;
    border-radius:28px;
    padding:25px 30px;
    margin-top:25px;
    box-shadow:0 18px 35px rgba(15,23,42,0.06);
}

.contact-title{
    font-size:26px;
    font-weight:700;
    color:#0f172a;
    margin-bottom:8px;
}

.contact-subtitle{
    color:#64748b;
    font-size:14px;
    margin-bottom:25px;
}

.contact-info{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:20px;
}

.contact-box{
    background:#f8fbff;
    border:1px solid #eef2ff;
    border-radius:22px;
    padding:25px;
    display:flex;
    align-items:flex-start;
    gap:18px;
    transition:.3s;
}

.contact-box:hover{
    transform:translateY(-3px);
    box-shadow:0 12px 25px rgba(37,99,235,0.08);
}

.contact-icon{
    width:60px;
    height:60px;
    border-radius:18px;
    background:#dbeafe;
    color:#2563eb;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:24px;
    flex-shrink:0;
}

.contact-label{
    color:#64748b;
    font-size:13px;
    margin-bottom:6px;
}

.contact-value{
    color:#0f172a;
    font-size:16px;
    font-weight:700;
    line-height:1.7;
}

.contact-btn{
    display:inline-block;
    margin-top:15px;
    padding:10px 18px;
    border-radius:14px;
    background:#eff6ff;
    color:#2563eb;
    text-decoration:none;
    font-size:13px;
    font-weight:600;
}

.contact-btn:hover{
    background:#dbeafe;
}

/* =========================
   RESPONSIVE
========================= */

@media(max-width:1200px){

.card-grid{
    grid-template-columns:repeat(2,1fr);
}

}

@media(max-width:768px){

.wrapper{
    flex-direction:column;
}

.sidebar{
    width:100%;
    height:auto;
}

.main{
    padding:20px;
}

.card-grid{
    grid-template-columns:1fr;
}

.hero-title{
    font-size:28px;
}

.page-title{
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

                <a href="customerDashboard.jsp" class="active">
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
                Dashboard
            </div>

            <div class="customer-box">

                <i class="fa-solid fa-user"></i>
                Customer

            </div>

        </div>

        <!-- HERO -->

        <div class="hero-card">

            <div class="hero-tag">
                BUSANA TRADISI BOUTIQUE
            </div>

            <div class="hero-title">
                Welcome Back ✨
            </div>

            <div class="hero-subtitle">
                Browse elegant traditional attire, manage your bookings and enjoy a seamless boutique rental experience.
            </div>

        </div>

        <!-- CARDS -->

        <div class="card-grid">

            <!-- ATTIRE -->

            <div class="card">

                <div class="card-icon">
                    <i class="fa-solid fa-shirt"></i>
                </div>

                <div class="card-title">
                    Browse Attire
                </div>

                <div class="card-desc">
                    Explore beautiful traditional attire collections available for rental.
                </div>

                <a href="ViewAttireCustomerServlet"
                   class="card-btn">

                   Explore Now

                </a>

            </div>

            <!-- BOOKINGS -->

            <div class="card">

                <div class="card-icon">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>

                <div class="card-title">
                    My Booking
                </div>

                <div class="card-desc">
                    View your booking history, payment status and rental details.
                </div>

                <a href="ViewBookingCustomerServlet"
                   class="card-btn">

                   View Booking

                </a>

            </div>

            <!-- PROFILE -->

            <div class="card">

                <div class="card-icon">
                    <i class="fa-solid fa-user"></i>
                </div>

                <div class="card-title">
                    My Profile
                </div>

                <div class="card-desc">
                    Manage your personal information and account details securely.
                </div>

                <a href="CustomerProfileServlet"
                   class="card-btn">

                   Open Profile

                </a>

            </div>

        </div>
        
        <div class="contact-card">

    <div class="contact-title">
        📍 Boutique Information
    </div>

    <div class="contact-subtitle">
        Need help or have any questions? Contact us or visit our boutique.
    </div>

    <div class="contact-info">

        <div class="contact-box">

            <div class="contact-icon">
                <i class="fa-solid fa-phone"></i>
            </div>

            <div>
                <div class="contact-label">
                    Contact Number
                </div>

                <div class="contact-value">
                    011-33256003
                </div>

                <a href="https://wa.me/601133256003"
                   class="contact-btn">
                    <i class="fa-brands fa-whatsapp"></i>
                    Chat on WhatsApp
                </a>
            </div>

        </div>

        <div class="contact-box">

            <div class="contact-icon">
                <i class="fa-solid fa-location-dot"></i>
            </div>

            <div>
                <div class="contact-label">
                    Pickup Address
                </div>

                <div class="contact-value">
                    Busana Tradisi Boutique<br>
                    PT 1276 Kg Rupek, Jalan Pasir Hor<br>
                    15100 Kota Bharu, Kelantan.
                </div>

                <a href="https://maps.app.goo.gl/xojwjbKD69U1cAyt9"
                    class="contact-btn"
                    target="_blank">
                    <i class="fa-solid fa-map-location-dot"></i>
                    View on Map
                 </a>
            </div>

        </div>

    </div>

</div>

    </div>

</div>

</body>
</html>