<%-- 
    Document   : viewAttire
    Created on : Dec 26, 2025, 6:25:24 PM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>

<%
    if (session.getAttribute("role") == null || !"OWNER".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    ArrayList<String[]> attireList =
        (ArrayList<String[]>) request.getAttribute("attireList");
%>

<!DOCTYPE html>
<html>
<head>
<title>Manage Attire | Busana Tradisi</title>

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
    background:
    radial-gradient(circle at top left,
    #dbeafe 0%,
    #edf4ff 35%,
    #f8fbff 100%);
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
    margin-bottom:18px;
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
   HERO CARD
========================= */

.hero-card{
    background:
    linear-gradient(135deg,
    #020617 0%,
    #172554 45%,
    #2563eb 100%);
    border-radius:24px;
    padding:24px 30px;
    margin-bottom:18px;
    position:relative;
    overflow:hidden;
    box-shadow:0 18px 40px rgba(37,99,235,0.16);
    border:1px solid rgba(255,255,255,0.08);
}

.hero-card::before{
    content:'';
    position:absolute;
    width:220px;
    height:220px;
    border-radius:50%;
    background:rgba(255,255,255,0.05);
    top:-90px;
    right:-60px;
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
    font-size:28px;
    font-weight:800;
    color:white;
    letter-spacing:-1px;
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
   ACTION BAR
========================= */

.action-bar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:20px;
}

/* =========================
   TOTAL BOX
========================= */

.total-box{
    background:rgba(255,255,255,0.85);
    backdrop-filter:blur(12px);
    padding:16px 22px;
    border-radius:20px;
    box-shadow:0 12px 30px rgba(15,23,42,0.05);
    border:1px solid rgba(255,255,255,0.7);
}

.total-box h2{
    font-size:30px;
    color:#0f172a;
    margin-bottom:3px;
}

.total-box p{
    color:#64748b;
    font-size:13px;
}

/* =========================
   ADD BUTTON
========================= */

.add-btn{
    background:linear-gradient(135deg,#2563eb,#3b82f6);
    color:white;
    text-decoration:none;
    padding:14px 22px;
    border-radius:16px;
    display:flex;
    align-items:center;
    gap:10px;
    font-size:14px;
    font-weight:600;
    letter-spacing:0.3px;
    transition:0.3s;
    box-shadow:0 12px 25px rgba(37,99,235,0.22);
}

.add-btn:hover{
    transform:translateY(-3px);
}

/* =========================
   ALERT
========================= */

.alert{
    padding:16px;
    border-radius:18px;
    margin-bottom:20px;
    font-size:14px;
    font-weight:600;
}

.success{
    background:#dcfce7;
    color:#166534;
}

.danger{
    background:#fee2e2;
    color:#991b1b;
}

/* =========================
   TABLE CARD
========================= */

.table-card{
    background:rgba(255,255,255,0.88);
    backdrop-filter:blur(14px);
    border-radius:28px;
    padding:24px;
    box-shadow:0 20px 40px rgba(15,23,42,0.06);
    border:1px solid rgba(255,255,255,0.7);
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
    border-spacing:0 16px;
}

th{
    color:#64748b;
    font-size:13px;
    font-weight:700;
    padding-bottom:10px;
    text-align:center;
}

td{
    background:#ffffff;
    padding:18px 14px;
    text-align:center;
    font-size:14px;
    color:#334155;
    vertical-align:middle;
}

tr td:first-child{
    border-top-left-radius:20px;
    border-bottom-left-radius:20px;
}

tr td:last-child{
    border-top-right-radius:20px;
    border-bottom-right-radius:20px;
}

tr:hover td{
    background:#f8fbff;
    transition:0.3s;
    transform:translateY(-2px);
}

/* =========================
   IMAGE
========================= */

.attire-img{
    width:82px;
    height:105px;
    object-fit:cover;
    border-radius:16px;
    border:4px solid white;
    box-shadow:0 10px 25px rgba(0,0,0,0.08);
}

/* =========================
   STATUS
========================= */

.status{
    padding:8px 15px;
    border-radius:30px;
    font-size:11px;
    font-weight:700;
    display:inline-block;
}

.available{
    background:#dcfce7;
    color:#166534;
}

.unavailable{
    background:#fee2e2;
    color:#991b1b;
}

/* =========================
   BUTTONS
========================= */

.action-container{
    display:flex;
    justify-content:center;
    gap:10px;
}

.btn{
    padding:10px 15px;
    border-radius:12px;
    text-decoration:none;
    font-size:12px;
    font-weight:700;
    transition:0.3s;
}

.btn-edit{
    background:#dbeafe;
    color:#2563eb;
}

.btn-edit:hover{
    background:#2563eb;
    color:white;
}

.btn-delete{
    background:#fee2e2;
    color:#dc2626;
}

.btn-delete:hover{
    background:#dc2626;
    color:white;
}

.desc{
    max-width:170px;
    line-height:1.5;
    font-size:13px;
    color:#475569;
}

/* =========================
   RESPONSIVE
========================= */

@media(max-width:1200px){

.sidebar{
    width:220px;
}

.hero-title{
    font-size:24px;
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

                <a href="ViewAttireServlet" class="active">
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
                Manage Attire
            </div>

            <div class="owner-box">
                <i class="fa-solid fa-user"></i>
                Boutique Owner
            </div>

        </div>

        <!-- HERO -->

        <div class="hero-card">

            <div class="hero-tag">
                ATTIRE MANAGEMENT
            </div>

            <div class="hero-title">
                Traditional Attire Collection
            </div>

            <div class="hero-subtitle">
                Manage traditional outfit collections, rental pricing and attire availability professionally.
            </div>

        </div>

        <!-- ACTION BAR -->

        <div class="action-bar">

            <div class="total-box">

                <h2>
                    <%= attireList != null ? attireList.size() : 0 %>
                </h2>

                <p>Total Attire Collection</p>

            </div>

            <a class="add-btn" href="addAttire.jsp">
                <i class="fa-solid fa-plus"></i>
                Add New Attire
            </a>

        </div>

        <!-- ALERT -->

        <%
            String msg = request.getParameter("msg");

            if ("updated".equals(msg)) {
        %>

        <div class="alert success">
            ✅ Attire updated successfully
        </div>

        <%
            } else if ("deleted".equals(msg)) {
        %>

        <div class="alert danger">
            ❌ Attire deleted successfully
        </div>

        <%
            }
        %>

        <!-- TABLE -->

        <div class="table-card">

            <div class="table-container">

            <table>

                <tr>
                    <th>ID</th>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Size</th>
                    <th>Price</th>
                    <th>Status</th>
                    <th>Description</th>
                    <th>Action</th>
                </tr>

                <%
                if(attireList != null && !attireList.isEmpty()){

                    for(String[] a : attireList){
                %>

                <tr>

                    <td><%= a[0] %></td>

                    <td>

                    <% if(a[6] != null && !a[6].equals("null")){ %>

                    <img class="attire-img"
                    src="<%=request.getContextPath()%>/uploads/<%=a[6]%>">

                    <% } else { %>

                    No Image

                    <% } %>

                    </td>

                    <td><%= a[1] %></td>

                    <td><%= a[2] %></td>

                    <td><%= a[3] %></td>

                    <td>
                        RM <%= a[4] %>
                    </td>

                    <td>
                        <span class="status 
                        <%= "AVAILABLE".equalsIgnoreCase(a[5]) ? "available" : "unavailable" %>">

                        <%= a[5] %>

                        </span>

                    </td>

                    <td class="desc">
                        <%= a[7] %>
                    </td>

                    <td>

                        <div class="action-container">

                            <a class="btn btn-edit"
                            href="EditAttireServlet?attireID=<%= a[0] %>">
                                Edit
                            </a>

                            <a class="btn btn-delete"
                            href="DeleteAttireServlet?attireID=<%= a[0] %>"
                            onclick="return confirm('Delete this attire?')">
                                Delete
                            </a>

                        </div>

                    </td>

                </tr>

                <%
                    }

                } else {
                %>

                <tr>

                    <td colspan="9">
                        No attire found
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