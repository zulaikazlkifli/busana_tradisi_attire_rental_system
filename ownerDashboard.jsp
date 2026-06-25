<%-- 
    Document   : ownerDashboard
    Created on : Dec 26, 2025, 3:37:03 PM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Owner Dashboard | Busana Tradisi</title>

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

/* MAIN LAYOUT */

.wrapper{
    display:flex;
    height:100vh;
}

/* SIDEBAR */

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
    transform:translateX(5px);
    color:white;
}

.menu i{
    width:18px;
}

/* LOGOUT */

.logout-btn{
    background:linear-gradient(135deg,#ef4444,#f87171);
    color:white;
    text-decoration:none;
    padding:15px;
    border-radius:18px;
    text-align:center;
    font-weight:600;
    transition:0.3s;
    box-shadow:0 10px 20px rgba(239,68,68,0.25);
}

.logout-btn:hover{
    transform:translateY(-2px);
}

/* MAIN CONTENT */

.main{
    flex:1;
    padding:28px;
    overflow-y:auto;
}

/* TOPBAR */

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

.owner-box{
    background:white;
    padding:14px 22px;
    border-radius:18px;
    display:flex;
    align-items:center;
    gap:12px;
    box-shadow:0 10px 25px rgba(0,0,0,0.06);
    font-weight:600;
    color:#0f172a;
}

.owner-box i{
    color:#2563eb;
}

/* HERO CARD */

.hero-card{
    background:linear-gradient(135deg,#0f172a,#1e3a8a,#2563eb);
    border-radius:32px;
    padding:38px;
    color:white;
    position:relative;
    overflow:hidden;
    margin-bottom:28px;
    box-shadow:0 20px 45px rgba(37,99,235,0.25);
}

.hero-card::before{
    content:'';
    position:absolute;
    width:300px;
    height:300px;
    border-radius:50%;
    background:rgba(255,255,255,0.06);
    top:-80px;
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

.hero-title{
    font-size:36px;
    font-weight:700;
    letter-spacing:-1px;
    margin-bottom:10px;
    position:relative;
    z-index:2;
}

.hero-subtitle{
    font-size:15px;
    color:#dbeafe;
    position:relative;
    z-index:2;
}

/* STATS */

.stats-grid{
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:22px;
}

.stat-card{
    background:white;
    border-radius:26px;
    padding:28px;
    box-shadow:0 15px 35px rgba(15,23,42,0.06);
    transition:0.3s;
    position:relative;
    overflow:hidden;
}

.stat-card:hover{
    transform:translateY(-8px);
    box-shadow:0 20px 40px rgba(37,99,235,0.12);
}

.stat-card::before{
    content:'';
    position:absolute;
    width:140px;
    height:140px;
    background:#eff6ff;
    border-radius:50%;
    top:-55px;
    right:-55px;
}

.stat-icon{
    width:62px;
    height:62px;
    border-radius:18px;
    background:linear-gradient(135deg,#dbeafe,#bfdbfe);
    display:flex;
    align-items:center;
    justify-content:center;
    margin-bottom:22px;
    position:relative;
    z-index:2;
}

.stat-icon i{
    font-size:24px;
    color:#2563eb;
}

.stat-number{
    font-size:36px;
    font-weight:700;
    color:#0f172a;
    margin-bottom:6px;
    position:relative;
    z-index:2;
}

.stat-label{
    font-size:14px;
    color:#64748b;
    position:relative;
    z-index:2;
}

/* RESPONSIVE */

@media(max-width:1200px){

.stats-grid{
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

.stats-grid{
    grid-template-columns:1fr;
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

                <a href="OwnerProfileServlet">
                    <i class="fa-solid fa-user"></i>
                    My Profile
                </a>

                <a href="ViewAttireServlet">
                    <i class="fa-solid fa-shirt"></i>
                    Attires
                </a>

                <a href="ViewAccessoryOwnerServlet">
                    <i class="fa-solid fa-gem"></i>
                    Accessories
                </a>

                <a href="ViewBookingOwnerServlet">
                    <i class="fa-solid fa-calendar-check"></i>
                    Bookings
                </a>

                <a href="ViewPaymentHistoryServlet">
                    <i class="fa-solid fa-credit-card"></i>
                    Payment History
                </a>
                
                <a href="ViewReportServlet">
                <i class="fa-solid fa-chart-column"></i>
                Reports
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

            <div class="owner-box">
                <i class="fa-solid fa-user"></i>
                Boutique Owner
            </div>

        </div>

        <!-- HERO -->

        <div class="hero-card">

            <div class="hero-title">
                Welcome Back, Hafiza !
            </div>

            <div class="hero-subtitle">
                Monitor your boutique rentals, customer payments and rental activities professionally.
            </div>

        </div>

        <!-- STATS -->

        <div class="stats-grid">

            <div class="stat-card">

                <div class="stat-icon">
                    <i class="fa-solid fa-calendar-days"></i>
                </div>

                <div class="stat-number">
                    <%=request.getAttribute("totalBookings")%>
                </div>

                <div class="stat-label">
                    Total Rentals
                </div>

            </div>

            <div class="stat-card">

                <div class="stat-icon">
                    <i class="fa-solid fa-wallet"></i>
                </div>

                <div class="stat-number">
                    <%=request.getAttribute("pendingPayments")%>
                </div>

                <div class="stat-label">
                    Pending Payments
                </div>

            </div>

            <div class="stat-card">

                <div class="stat-icon">
                    <i class="fa-solid fa-circle-check"></i>
                </div>

                <div class="stat-number">
                    <%=request.getAttribute("completedBookings")%>
                </div>

                <div class="stat-label">
                    Completed Rentals
                </div>

            </div>

            <div class="stat-card">

                <div class="stat-icon">
                    <i class="fa-solid fa-money-bill-wave"></i>
                </div>

                <div class="stat-number">
                    RM <%=request.getAttribute("totalRevenue")%>
                </div>

                <div class="stat-label">
                    Total Revenue
                </div>

            </div>

        </div>

    </div>

</div>
                </body>
</html>