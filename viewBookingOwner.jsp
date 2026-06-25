<%-- 
    Document   : viewBookingOwner
    Created on : Apr 15, 2026, 10:43:16 PM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>

<%
if(session.getAttribute("role")==null || !"OWNER".equals(session.getAttribute("role"))){
    response.sendRedirect("login.jsp");
    return;
}

ArrayList<String[]> bookingList =
(ArrayList<String[]>) request.getAttribute("bookingList");
%>

<!DOCTYPE html>
<html>
<head>
<title>Rentals | Busana Tradisi</title>

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

.owner-box{
    background:white;
    padding:14px 22px;
    border-radius:18px;
    display:flex;
    align-items:center;
    gap:12px;
    box-shadow:0 10px 25px rgba(0,0,0,0.05);
    font-weight:600;
}

.owner-box i{
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
    border-radius:26px;
    padding:28px 34px;
    margin-bottom:22px;
    position:relative;
    overflow:hidden;
    box-shadow:0 16px 35px rgba(37,99,235,0.18);
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
    font-size:10px;
    font-weight:700;
    letter-spacing:2px;
    margin-bottom:10px;
    position:relative;
    z-index:2;
}

.hero-title{
    font-size:32px;
    font-weight:800;
    color:white;
    margin-bottom:8px;
    position:relative;
    z-index:2;
}

.hero-subtitle{
    font-size:13px;
    color:#dbeafe;
    line-height:1.7;
    max-width:650px;
    position:relative;
    z-index:2;
}

/* =========================
   TABLE CARD
========================= */

.table-card{
    background:white;
    border-radius:30px;
    padding:26px;
    box-shadow:0 20px 45px rgba(15,23,42,0.06);
}

.table-container{
    overflow-x:auto;
}

/* =========================
   TABLE
========================= */

table{
    width:100%;
    border-collapse:separate;
    border-spacing:0 18px;
}

th{
    color:#64748b;
    font-size:13px;
    font-weight:700;
    padding-bottom:8px;
    text-align:center;
}

td{
    background:#f8fbff;
    padding:18px 14px;
    text-align:center;
    font-size:14px;
    color:#334155;
    vertical-align:middle;
}

tr td:first-child{
    border-top-left-radius:22px;
    border-bottom-left-radius:22px;
}

tr td:last-child{
    border-top-right-radius:22px;
    border-bottom-right-radius:22px;
}

tr:hover td{
    background:#f1f7ff;
    transition:0.3s;
}

/* =========================
   STATUS
========================= */

.status{
    padding:9px 15px;
    border-radius:30px;
    font-size:11px;
    font-weight:700;
    display:inline-block;
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

.btn-complete{
    border:none;
    background:linear-gradient(135deg,#2563eb,#3b82f6);
    color:white;
    padding:10px 16px;
    border-radius:14px;
    font-size:12px;
    font-weight:700;
    cursor:pointer;
    transition:0.3s;
    box-shadow:0 10px 20px rgba(37,99,235,0.2);
}

.btn-complete:hover{
    transform:translateY(-2px);
}

.no-action{
    color:#94a3b8;
    font-size:12px;
    font-weight:600;
}

/* =========================
   RESPONSIVE
========================= */

@media(max-width:1100px){

.sidebar{
    width:220px;
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

.hero-title{
    font-size:24px;
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

                <a href="ViewBookingOwnerServlet" class="active">
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
                Bookings
            </div>

            <div class="owner-box">
                <i class="fa-solid fa-user"></i>
                Boutique Owner
            </div>

        </div>

        <!-- HERO -->

        <div class="hero-card">

            <div class="hero-tag">
                BOOKING MANAGEMENT
            </div>

            <div class="hero-title">
                Boutique Booking Records
            </div>

            <div class="hero-subtitle">
                Monitor customer bookings, payment progress and rental completion professionally.
            </div>

        </div>

        <!-- TABLE -->

        <div class="table-card">

            <div class="table-container">

            <table>
                <tr>
                    <th>Booking ID</th>
                    <th>User</th>
                    <th>Attire ID</th>
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

                    String statusClass="";

                    if("PENDING".equalsIgnoreCase(status))
                        statusClass="pending";

                    else if("PAID".equalsIgnoreCase(status))
                        statusClass="paid";

                    else if("COMPLETED".equalsIgnoreCase(status))
                        statusClass="completed";

                    else if("CANCELLED".equalsIgnoreCase(status))
                        statusClass="cancelled";
                %>

                <tr>

                    <td>
                    B<%= String.format("%03d",
                    Integer.parseInt(b[0])) %>
                    </td>
                    <td><%=b[1]%></td>
                    <td><%=b[2]%></td>
                    <td><%=b[3]%></td>
                    <td><%=b[4]%></td>
                    <td>RM <%=b[5]%></td>

                    <td>

                        <span class="status <%=statusClass%>">
                            <%=status%>
                        </span>

                    </td>

                    <td>

                    <% if("PENDING".equalsIgnoreCase(status)){ %>

                        <span class="no-action">
                            Waiting Payment
                        </span>

                    <% } else if("PAID".equalsIgnoreCase(status)){ %>

                        <form action="CompleteBookingServlet"
                              method="post">

                            <input type="hidden"
                                   name="bookingID"
                                   value="<%=bookingID%>">

                            <button class="btn-complete">
                                Complete Renting
                            </button>

                        </form>

                    <% } else { %>

                        <span class="no-action">
                            No Action
                        </span>

                    <% } %>

                    </td>

                </tr>

                <%
                    }

                } else {
                %>

                <tr>

                    <td colspan="8">
                        No bookings found
                    </td>

                </tr>

                <%
                }
                %>

            </table>

            </div>

        </div>

    </div>

</div>

</body>
</html>
