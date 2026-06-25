<%-- 
    Document   : ownerProfile
    Created on : Jan 10, 2026, 3:57:41 PM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    if (session.getAttribute("role") == null || !"OWNER".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String userID = (String) session.getAttribute("userID");
    String name = "", email = "", phone = "";

    try {

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/btarsystem",
            "root",
            "root123"
        );

        String sql = "SELECT * FROM user WHERE userID=?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, userID);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){

            name = rs.getString("name");
            email = rs.getString("email");
            phone = rs.getString("phone");

        }

    } catch(Exception e){
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>

<title>Owner Profile | Busana Tradisi</title>

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

/* LAYOUT */

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

.menu a.active{
    background:rgba(255,255,255,0.12);
    color:white;
    box-shadow:0 8px 25px rgba(0,0,0,0.15);
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

/* MAIN */

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

/* PROFILE CARD */

.profile-card{
    background:white;
    border-radius:32px;
    padding:45px;
    box-shadow:0 20px 40px rgba(15,23,42,0.06);
}

.profile-top{
    display:flex;
    align-items:center;
    gap:30px;
    margin-bottom:40px;
}

.avatar{
    width:120px;
    height:120px;
    border-radius:30px;
    background:linear-gradient(135deg,#0f172a,#2563eb);
    display:flex;
    align-items:center;
    justify-content:center;
    color:white;
    font-size:48px;
    box-shadow:0 15px 35px rgba(37,99,235,0.25);
}

.profile-name{
    font-size:42px;
    font-weight:800;
    color:#0f172a;
    letter-spacing:-1px;
}

.profile-role{
    margin-top:10px;
    color:#64748b;
    font-size:16px;
}

/* INFO GRID */

.info-grid{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:25px;
    margin-bottom:40px;
}

.info-card{
    background:#f8fbff;
    border-radius:24px;
    padding:28px;
    border:1px solid #dbeafe;
    transition:0.3s;
}

.info-card:hover{
    transform:translateY(-4px);
    box-shadow:0 15px 30px rgba(37,99,235,0.08);
}

.info-icon{
    width:58px;
    height:58px;
    border-radius:18px;
    background:linear-gradient(135deg,#dbeafe,#bfdbfe);
    display:flex;
    align-items:center;
    justify-content:center;
    margin-bottom:18px;
}

.info-icon i{
    font-size:22px;
    color:#2563eb;
}

.info-label{
    font-size:14px;
    color:#64748b;
    margin-bottom:8px;
}

.info-value{
    font-size:18px;
    font-weight:700;
    color:#0f172a;
    word-break:break-word;
}

/* BUTTONS */

.button-group{
    display:flex;
    gap:18px;
}

.btn{
    padding:15px 24px;
    border-radius:18px;
    text-decoration:none;
    font-weight:600;
    font-size:14px;
    transition:0.3s;
    display:flex;
    align-items:center;
    gap:10px;
}

.btn-primary{
    background:linear-gradient(135deg,#2563eb,#3b82f6);
    color:white;
    box-shadow:0 12px 25px rgba(37,99,235,0.2);
}

.btn-primary:hover{
    transform:translateY(-2px);
}

.btn-secondary{
    background:#eff6ff;
    color:#2563eb;
}

.btn-secondary:hover{
    background:#dbeafe;
}

/* RESPONSIVE */

@media(max-width:1100px){

.info-grid{
    grid-template-columns:1fr;
}

.profile-top{
    flex-direction:column;
    align-items:flex-start;
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

                <a href="OwnerProfileServlet" class="active">
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

        <div class="topbar">

            <div class="page-title">
                My Profile
            </div>

            <div class="owner-box">
                <i class="fa-solid fa-user"></i>
                Boutique Owner
            </div>

        </div>

        <!-- PROFILE CARD -->

        <div class="profile-card">

            <div class="profile-top">

                <div class="avatar">
                    <i class="fa-solid fa-user"></i>
                </div>

                <div>

                    <div class="profile-name">
                        <%= name %>
                    </div>

                    <div class="profile-role">
                        Boutique Owner Account Information
                    </div>

                </div>

            </div>

            <!-- INFO -->

            <div class="info-grid">

                <div class="info-card">

                    <div class="info-icon">
                        <i class="fa-solid fa-id-card"></i>
                    </div>

                    <div class="info-label">
                        Full Name
                    </div>
                    <div class="info-value">
                        <%= name %>
                    </div>

                </div>

                <div class="info-card">

                    <div class="info-icon">
                        <i class="fa-solid fa-envelope"></i>
                    </div>

                    <div class="info-label">
                        Email Address
                    </div>

                    <div class="info-value">
                        <%= email %>
                    </div>

                </div>

                <div class="info-card">

                    <div class="info-icon">
                        <i class="fa-solid fa-phone"></i>
                    </div>

                    <div class="info-label">
                        Phone Number
                    </div>

                    <div class="info-value">
                        <%= phone %>
                    </div>

                </div>

            </div>

            <!-- BUTTON -->

            <div class="button-group">

                <a class="btn btn-primary"
                href="EditOwnerProfileServlet">

                    <i class="fa-solid fa-pen"></i>
                    Edit Profile

                </a>

                <a class="btn btn-secondary"
                href="OwnerDashboardServlet">

                    <i class="fa-solid fa-arrow-left"></i>
                    Back to Dashboard

                </a>

            </div>

        </div>

    </div>

</div>

</body>
</html>