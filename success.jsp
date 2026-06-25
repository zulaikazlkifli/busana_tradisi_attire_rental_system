<%-- 
    Document   : success
    Created on : Apr 15, 2026, 6:30:35 PM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>

<%
String bookingID = String.valueOf(request.getAttribute("bookingID"));
String total = String.valueOf(request.getAttribute("total"));

if(bookingID == null || "null".equals(bookingID)){
    bookingID = "BT" + System.currentTimeMillis();
}

if(total == null || "null".equals(total)){
    total = "0.00";
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Booking Success | Busana Tradisi</title>

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
min-height:100vh;
display:flex;
justify-content:center;
align-items:center;
padding:40px 20px;
background:
radial-gradient(circle at top left,
#dbeafe 0%,
#edf4ff 40%,
#f8fbff 100%);
overflow:auto;
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

@keyframes pulse{
0%{
transform:scale(1);
}
50%{
transform:scale(1.05);
}
100%{
transform:scale(1);
}
}

@keyframes spin{
to{
transform:rotate(360deg);
}
}

/* =========================
LOADER
========================= */

.loader-wrapper{
text-align:center;
}

.loader{
width:60px;
height:60px;
border:5px solid rgba(37,99,235,0.12);
border-top:5px solid #2563eb;
border-radius:50%;
animation:spin 0.8s linear infinite;
margin:auto;
}

.loading-text{
margin-top:20px;
font-size:15px;
font-weight:600;
color:#64748b;
}

/* =========================
SUCCESS BOX
========================= */

.hidden{
display:none;
}

.success-box{
width:100%;
max-width:560px;
background:rgba(255,255,255,0.88);
backdrop-filter:blur(14px);
padding:30px;
border-radius:32px;
text-align:center;
box-shadow:0 25px 50px rgba(15,23,42,0.08);
border:1px solid rgba(255,255,255,0.7);
animation:fadeUp 0.5s ease;
position:relative;
overflow:hidden;
}

.success-box::before{
content:'';
position:absolute;
width:260px;
height:260px;
border-radius:50%;
background:rgba(59,130,246,0.05);
top:-120px;
right:-70px;
}

/* =========================
ICON
========================= */

.success-icon{
width:75px;
height:75px;
margin:auto;
border-radius:50%;
display:flex;
align-items:center;
justify-content:center;
background:linear-gradient(135deg,#22c55e,#16a34a);
color:white;
font-size:30px;
box-shadow:0 20px 35px rgba(34,197,94,0.22);
animation:pulse 1.6s infinite;
position:relative;
z-index:2;
}

/* =========================
TEXT
========================= */

.success-tag{
margin-top:28px;
font-size:11px;
font-weight:700;
letter-spacing:2px;
color:#2563eb;
position:relative;
z-index:2;
}

.success-title{
font-size:28px;
font-weight:800;
color:#0f172a;
margin-top:10px;
margin-bottom:10px;
letter-spacing:-1px;
position:relative;
z-index:2;
}

.success-subtitle{
font-size:13px;
line-height:1.6;
color:#64748b;
margin-bottom:34px;
position:relative;
z-index:2;
max-width:560px;
margin-left:auto;
margin-right:auto;
}

/* =========================
INFO BOX
========================= */

.info-box{
background:#f8fbff;
border-radius:24px;
padding:26px;
margin-bottom:26px;
position:relative;
z-index:2;
}

.details{
display:grid;
grid-template-columns:1fr 1fr;
gap:18px;
margin-bottom:20px;
}

.info-card{
background:white;
padding:18px;
border-radius:18px;
border:1px solid #e2e8f0;
text-align:left;
}

.info-label{
font-size:12px;
font-weight:600;
color:#64748b;
margin-bottom:8px;
}

.info-value{
font-size:18px;
font-weight:800;
color:#0f172a;
}

.status{
display:inline-block;
padding:8px 14px;
border-radius:30px;
background:#fef3c7;
color:#92400e;
font-size:11px;
font-weight:700;
}

/* =========================
TOTAL
========================= */

.total-box{
background:white;
padding:24px;
border-radius:20px;
border:1px solid #e2e8f0;
}

.total-label{
font-size:13px;
font-weight:600;
color:#64748b;
margin-bottom:8px;
}

.total-price{
font-size:28px;
font-weight:800;
color:#2563eb;
}

/* =========================
NOTICE
========================= */

.notice{
background:#eff6ff;
padding:18px;
border-radius:18px;
font-size:13px;
line-height:1.9;
color:#475569;
margin-bottom:26px;
position:relative;
z-index:2;
}

/* =========================
BUTTON
========================= */

.btn{
display:block;
width:100%;
padding:17px;
border-radius:18px;
text-decoration:none;
background:linear-gradient(135deg,#2563eb,#3b82f6);
color:white;
font-size:14px;
font-weight:700;
transition:0.3s;
box-shadow:0 14px 28px rgba(37,99,235,0.22);
position:relative;
z-index:2;
}

.btn:hover{
transform:translateY(-3px);
}

.redirect{
margin-top:16px;
font-size:12px;
color:#94a3b8;
position:relative;
z-index:2;
}

@media(max-width:768px){

.success-box{
padding:30px 24px;
}

.success-title{
font-size:32px;
}

.details{
grid-template-columns:1fr;
}

.total-price{
font-size:34px;
}

}

</style>

<script>

window.onload = function(){

setTimeout(function(){

document.getElementById("loaderSection").style.display =
"none";

document.getElementById("successContent").style.display =
"block";

},1200);

setTimeout(function(){

window.location.href =
"customerDashboard.jsp";

},5000);

};

</script>

</head>

<body>

<!-- LOADER -->

<div id="loaderSection" class="loader-wrapper">

<div class="loader"></div>

<div class="loading-text">
Processing your booking...
</div>

</div>

<!-- SUCCESS CONTENT -->

<div id="successContent"
class="success-box hidden">

<div class="success-icon">
<i class="fa-solid fa-check"></i>
</div>

<div class="success-tag">
BOOKING CONFIRMED
</div>

<div class="success-title">
Booking Submitted
</div>

<div class="success-subtitle">
Your rental booking has been successfully created and is now awaiting payment confirmation.
</div>

<!-- INFO -->

<div class="info-box">

<div class="details">

<div class="info-card">

<div class="info-label">
Booking ID
</div>

<div class="info-value">
#<%= bookingID %>
</div>

</div>

<div class="info-card">

<div class="info-label">
Booking Status
</div>

<div class="status">
Pending Payment
</div>

</div>

</div>

<div class="total-box">

<div class="total-label">
Estimated Total
</div>

<div class="total-price">
RM <%= total %>
</div>

</div>

</div>

<!-- NOTICE -->

<div class="notice">

💳 Please proceed with payment to secure your booking reservation.<br>

📦 Pickup details will be available once payment has been completed successfully.

</div>

<!-- BUTTON -->

<a href="customerDashboard.jsp"
class="btn">

Back to Dashboard

</a>

<div class="redirect">
Redirecting automatically in a few seconds...
</div>

</div>

</body>
</html>
