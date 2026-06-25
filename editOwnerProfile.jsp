<%-- 
    Document   : editOwnerProfile
    Created on : Jan 10, 2026, 4:00:54 PM
    Author     : Che Zulaika
--%>

<%@ page contentType="text/html; charset=UTF-8" %>

<%
    if (session.getAttribute("role") == null || !"OWNER".equals(session.getAttribute("role"))) {
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
    background:linear-gradient(135deg,#eef4ff,#dbeafe);
    overflow:hidden;
}

/* WRAPPER */

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
}

.menu a.active{
    background:linear-gradient(135deg,
    rgba(255,255,255,0.18),
    rgba(255,255,255,0.08));
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
    box-shadow:0 10px 20px rgba(239,68,68,0.25);
}

.logout-btn:hover{
    transform:translateY(-3px);
}

/* MAIN */

.main{
    flex:1;
    padding:35px;
    overflow-y:auto;
}

/* TOPBAR */

.topbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:28px;
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
    box-shadow:0 12px 30px rgba(0,0,0,0.06);
    font-weight:600;
}

.owner-box i{
    color:#2563eb;
}

/* PROFILE CONTAINER */

.edit-wrapper{
    display:flex;
    gap:28px;
    align-items:stretch;
}

/* LEFT CARD */

.profile-preview{
    width:340px;
    background:linear-gradient(160deg,#0f172a,#1e40af,#2563eb);
    border-radius:36px;
    padding:40px 30px;
    color:white;
    position:relative;
    overflow:hidden;
    box-shadow:0 25px 50px rgba(37,99,235,0.25);
}

.profile-preview::before{
    content:'';
    position:absolute;
    width:250px;
    height:250px;
    background:rgba(255,255,255,0.08);
    border-radius:50%;
    top:-100px;
    right:-80px;
}

.profile-preview::after{
    content:'';
    position:absolute;
    width:180px;
    height:180px;
    background:rgba(255,255,255,0.06);
    border-radius:50%;
    bottom:-70px;
    left:-50px;
}

.avatar{
    width:110px;
    height:110px;
    border-radius:30px;
    background:rgba(255,255,255,0.12);
    backdrop-filter:blur(10px);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:42px;
    margin-bottom:28px;
    position:relative;
    z-index:2;
}

.preview-name{
    font-size:30px;
    font-weight:800;
    line-height:1.1;
    margin-bottom:12px;
    position:relative;
    z-index:2;
}

.preview-role{
    color:#dbeafe;
    font-size:15px;
    line-height:1.7;
    position:relative;
    z-index:2;
}

.preview-info{
    margin-top:40px;
    display:flex;
    flex-direction:column;
    gap:18px;
    position:relative;
    z-index:2;
}

.preview-box{
    background:rgba(255,255,255,0.08);
    border:1px solid rgba(255,255,255,0.08);
    border-radius:18px;
    padding:18px;
    backdrop-filter:blur(10px);
}

.preview-label{
    font-size:13px;
    color:#bfdbfe;
    margin-bottom:6px;
}

.preview-value{
    font-size:15px;
    font-weight:600;
}

/* FORM CARD */

.edit-card{
    flex:1;
    background:white;
    border-radius:36px;
    padding:42px;
    box-shadow:0 20px 45px rgba(15,23,42,0.06);
}

/* TITLE */

.edit-title{
    font-size:42px;
    font-weight:800;
    color:#0f172a;
    letter-spacing:-1px;
    margin-bottom:10px;
}

.edit-subtitle{
    color:#64748b;
    margin-bottom:35px;
    font-size:15px;
}

/* FORM */

.form-grid{
    display:grid;
    gap:26px;
}

.group label{
    display:block;
    margin-bottom:10px;
    font-size:14px;
    font-weight:600;
    color:#334155;
}

.input-wrapper{
    position:relative;
}

.input-wrapper i{
    position:absolute;
    top:50%;
    left:18px;
    transform:translateY(-50%);
    color:#2563eb;
    font-size:16px;
}

.group input{
    width:100%;
    height:60px;
    border:none;
    border-radius:20px;
    background:#f8fbff;
    padding:0 20px 0 54px;
    font-size:15px;
    font-family:'Inter',sans-serif;
    color:#0f172a;
    border:2px solid transparent;
    transition:0.3s;
}

.group input:focus{
    outline:none;
    border-color:#93c5fd;
    background:white;
    box-shadow:0 0 0 5px rgba(147,197,253,0.18);
}

.group input[readonly]{
    background:#eff6ff;
    color:#64748b;
    cursor:not-allowed;
}

/* BUTTON */

.button-group{
    display:flex;
    gap:18px;
    margin-top:35px;
}

.btn{
    border:none;
    border-radius:18px;
    padding:16px 26px;
    font-size:14px;
    font-weight:600;
    cursor:pointer;
    transition:0.3s;
    display:flex;
    align-items:center;
    gap:10px;
    text-decoration:none;
    font-family:'Inter',sans-serif;
}

.btn-save{
    background:linear-gradient(135deg,#2563eb,#3b82f6);
    color:white;
    box-shadow:0 15px 30px rgba(37,99,235,0.25);
}

.btn-save:hover{
    transform:translateY(-3px);
}

.btn-back{
    background:#eff6ff;
    color:#2563eb;
}

.btn-back:hover{
    background:#dbeafe;
}

/* RESPONSIVE */

@media(max-width:1200px){

.edit-wrapper{
    flex-direction:column;
}

.profile-preview{
    width:100%;
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
                Edit Profile
            </div>

            <div class="owner-box">
                <i class="fa-solid fa-user"></i>
                Boutique Owner
            </div>

        </div>

        <!-- CONTENT -->

        <div class="edit-wrapper">

            <!-- LEFT -->

            <div class="profile-preview">

                <div class="avatar">
                    <i class="fa-solid fa-user-pen"></i>
                </div>

                <div class="preview-name">
                    <%= name %>
                </div>

                <div class="preview-role">
                    Boutique Owner Account Management Panel
                </div>

                <div class="preview-info">

                    <div class="preview-box">

                        <div class="preview-label">
                            Email Address
                        </div>

                        <div class="preview-value">
                            <%= email %>
                        </div>

                    </div>

                    <div class="preview-box">

                        <div class="preview-label">
                            Phone Number
                        </div>

                        <div class="preview-value">
                            <%= phone %>
                        </div>

                    </div>

                </div>

            </div>

            <!-- RIGHT -->

            <div class="edit-card">

                <div class="edit-title">
                    Update Information
                </div>

                <div class="edit-subtitle">
                    Edit your boutique owner profile details professionally.
                </div>

                <form action="EditOwnerProfileServlet" method="post">

                    <div class="form-grid">

                        <div class="group">

                            <label>Full Name</label>

                            <div class="input-wrapper">

                                <i class="fa-solid fa-user"></i>

                                <input type="text"
                                       name="name"
                                       value="<%= name %>"
                                       required>

                            </div>

                        </div>

                        <div class="group">

                            <label>Email Address</label>

                            <div class="input-wrapper">

                                <i class="fa-solid fa-envelope"></i>

                                <input type="email"
                                       value="<%= email %>"
                                       readonly>

                            </div>

                        </div>

                        <div class="group">

                            <label>Phone Number</label>

                            <div class="input-wrapper">

                                <i class="fa-solid fa-phone"></i>

                                <input type="text"
                                       name="phone"
                                       value="<%= phone %>"
                                       required>

                            </div>

                        </div>

                    </div>

                    <div class="button-group">

                        <button class="btn btn-save">

                            <i class="fa-solid fa-floppy-disk"></i>
                            Save Changes

                        </button>

                        <a href="OwnerProfileServlet"
                           class="btn btn-back">

                            <i class="fa-solid fa-arrow-left"></i>
                            Back

                        </a>

                    </div>

                </form>

            </div>

        </div>

    </div>

</div>

</body>
</html>