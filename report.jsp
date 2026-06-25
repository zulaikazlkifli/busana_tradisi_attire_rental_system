<%-- 
    Document   : report.jsp
    Created on : Jun 3, 2026, 12:12:18 PM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>

<%
ArrayList<String[]> reportList =
(ArrayList<String[]>) request.getAttribute("reportList");

String chartLabels =
(String) request.getAttribute("chartLabels");

String chartData =
(String) request.getAttribute("chartData");

String monthLabels =
(String) request.getAttribute("monthLabels");

String monthData =
(String) request.getAttribute("monthData");

String selectedMonth =
request.getParameter("month");

if(selectedMonth == null){
    selectedMonth = "0";
}

%>

<!DOCTYPE html>
<html>
<head>
<title>Rental Reports | Busana Tradisi</title>

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
margin-bottom:26px;
color:white;
box-shadow:0 20px 40px rgba(37,99,235,0.18);
}

.hero-tag{
font-size:11px;
font-weight:700;
letter-spacing:2px;
color:#bfdbfe;
margin-bottom:10px;
}

.hero-title{
font-size:34px;
font-weight:800;
margin-bottom:8px;
}

.hero-subtitle{
font-size:14px;
color:#dbeafe;
line-height:1.7;
max-width:650px;
}

.summary-container{
display:grid;
grid-template-columns:repeat(3,1fr);
gap:20px;
margin-bottom:25px;
}

.summary-card{
background:white;
padding:25px;
border-radius:24px;
text-align:center;
box-shadow:0 15px 30px rgba(15,23,42,0.06);
}

.summary-card i{
font-size:30px;
color:#2563eb;
margin-bottom:12px;
}

.summary-card h2{
font-size:28px;
font-weight:800;
color:#0f172a;
margin-bottom:8px;
}

.summary-card p{
font-size:14px;
color:#64748b;
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
padding:16px;
font-size:13px;
font-weight:700;
color:#64748b;
text-align:center;
border-bottom:1px solid #e2e8f0;
}

td{
padding:18px;
font-size:14px;
text-align:center;
color:#334155;
border-bottom:1px solid #f1f5f9;
}

tr:hover{
background:#f8fbff;
}

/* =========================
BADGE
========================= */

.rank{
display:inline-block;
padding:8px 16px;
border-radius:30px;
font-size:12px;
font-weight:700;
background:#dbeafe;
color:#1d4ed8;
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

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
                
                <a href="ViewReportServlet" class="active">
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
Rental Reports
</div>

<div class="owner-box">
                <i class="fa-solid fa-user"></i>
                Boutique Owner
            </div>

</div>

<!-- HERO -->

<div class="hero-card">

<div class="hero-tag">
BUSINESS ANALYTICS
</div>

<div class="hero-title">
Rental Performance Report
</div>

<div class="hero-subtitle">
Analyze rental performance, revenue and customer rental trends.
</div>

<br>

<form action="ViewReportServlet" method="get">

    <select name="year">

        <option value="2026">2026</option>

    </select>
    
    <select name="month">

<option value="0" <%=selectedMonth.equals("0") ? "selected" : ""%>>All Months</option>

<option value="1" <%=selectedMonth.equals("1") ? "selected" : ""%>>January</option>

<option value="2" <%=selectedMonth.equals("2") ? "selected" : ""%>>February</option>

<option value="3" <%=selectedMonth.equals("3") ? "selected" : ""%>>March</option>

<option value="4" <%=selectedMonth.equals("4") ? "selected" : ""%>>April</option>

<option value="5" <%=selectedMonth.equals("5") ? "selected" : ""%>>May</option>

<option value="6" <%=selectedMonth.equals("6") ? "selected" : ""%>>June</option>

<option value="7" <%=selectedMonth.equals("7") ? "selected" : ""%>>July</option>

<option value="8" <%=selectedMonth.equals("8") ? "selected" : ""%>>August</option>

<option value="9" <%=selectedMonth.equals("9") ? "selected" : ""%>>September</option>

<option value="10" <%=selectedMonth.equals("10") ? "selected" : ""%>>October</option>

<option value="11" <%=selectedMonth.equals("11") ? "selected" : ""%>>November</option>

<option value="12" <%=selectedMonth.equals("12") ? "selected" : ""%>>December</option>

</select>

    <button type="submit">
        Generate Report
    </button>

</form>
    
</div>

<%
int totalBookings = 0;
double totalRevenue = 0;
String topAttire = "-";

if(request.getAttribute("totalBookings") != null){
    totalBookings =
    (Integer) request.getAttribute("totalBookings");
}

if(request.getAttribute("totalRevenue") != null){
    totalRevenue =
    (Double) request.getAttribute("totalRevenue");
}

if(request.getAttribute("topAttire") != null){
    topAttire =
    (String) request.getAttribute("topAttire");
}
%>

<div class="summary-container">

    <div class="summary-card">

        <i class="fa-solid fa-calendar-check"></i>

        <h2><%=totalBookings%></h2>

        <p>Total Bookings</p>

    </div>

    <div class="summary-card">

        <i class="fa-solid fa-money-bill-wave"></i>

        <h2>RM <%=String.format("%.2f", totalRevenue)%></h2>

        <p>Total Revenue</p>

    </div>

    <div class="summary-card">

        <i class="fa-solid fa-crown"></i>

        <h2><%=topAttire%></h2>

        <p>Top Attire</p>

    </div>

</div>

<div class="table-card" style="margin-bottom:25px;">

    <h2 style="
    margin-bottom:20px;
    color:#0f172a;
    font-size:22px;">

        Attire Rental Distribution - 2026

    </h2>

    <p style="
    color:#64748b;
    margin-bottom:20px;">

        This chart visualizes customer rental demand for each attire in 2026.

    </p>

    <div style="
    width:300px;
    height:300px;
    margin:auto;">

    <canvas id="bookingChart"></canvas>

</div>

    </div>


<!-- MONTHLY REPORT -->

<div class="table-card" style="margin-bottom:25px;">

    <h2 style="
    margin-bottom:20px;
    color:#0f172a;
    font-size:22px;">

        Monthly Rental Report - 2026

    </h2>

    <p style="
    color:#64748b;
    margin-bottom:20px;">

        Number of rentals received each month.

    </p>

    <div style="
    width:100%;
    max-width:900px;
    height:300px;
    margin:auto;">

        <canvas id="monthlyChart"></canvas>

    </div>

 </div>

    </div>

    </div>

<script>

const ctx =
document.getElementById(
'bookingChart'
);

new Chart(ctx, {

type: 'pie',

data: {

labels: [
<%=chartLabels%>
],

datasets: [{

label: 'Total Rentals',

data: [
<%=chartData%>
],

backgroundColor: [

'#ef4444', // merah
'#f59e0b', // oren
'#22c55e', // hijau
'#3b82f6',
'#8b5cf6',
'#06b6d4',
'#ec4899'

],

borderWidth: 1

}]

},

options: {

responsive: true,
maintainAspectRatio:false,

plugins: {

legend: {
position: 'right'
},

tooltip: {

callbacks: {

label: function(context) {

let total =
context.dataset.data.reduce(
(a,b) => a+b, 0
);

let value = context.raw;

let percentage =
((value / total) * 100).toFixed(1);

return value +
' rentals (' +
percentage +
'%)';

}

}

}

}

}

});


const monthCtx =
document.getElementById('monthlyChart');

new Chart(monthCtx, {

type:'bar',

data:{

labels:[
<%=monthLabels%>
],

datasets:[{

label:'Total Rentals',

data:[
<%=monthData%>
],

backgroundColor:'#2563eb'

}]

},

options:{

responsive:true,
maintainAspectRatio:false,

scales:{
y:{
beginAtZero:true
}
}

}

});



</script>

</body>
</html>
