<%-- 
    Document   : paymentSuccess
    Created on : May 14, 2026, 10:32:54 AM
    Author     : user
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%
String bookingID = request.getParameter("bookingID");
%>

<!DOCTYPE html>
<html>
<head>

<title>Payment Success | Busana Tradisi</title>

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
height:100vh;
display:flex;
justify-content:center;
align-items:center;
background:
linear-gradient(135deg,#eff6ff 0%,#dbeafe 100%);
overflow:hidden;
position:relative;
padding:20px;
}

/* =========================
BACKGROUND
========================= */

body::before{
content:'';
position:absolute;
width:260px;
height:260px;
border-radius:50%;
background:rgba(37,99,235,0.08);
top:-100px;
left:-80px;
}

body::after{
content:'';
position:absolute;
width:220px;
height:220px;
border-radius:50%;
background:rgba(59,130,246,0.08);
bottom:-80px;
right:-60px;
}

/* =========================
ANIMATIONS
========================= */

@keyframes fadeUp{
from{
opacity:0;
transform:translateY(35px);
}
to{
opacity:1;
transform:translateY(0);
}
}

@keyframes pop{
0%{
transform:scale(0.4);
opacity:0;
}
70%{
transform:scale(1.08);
}
100%{
transform:scale(1);
opacity:1;
}
}

@keyframes pulse{
0%{
transform:scale(1);
box-shadow:0 16px 28px rgba(37,99,235,0.25);
}
50%{
transform:scale(1.06);
box-shadow:0 20px 35px rgba(37,99,235,0.35);
}
100%{
transform:scale(1);
box-shadow:0 16px 28px rgba(37,99,235,0.25);
}
}

@keyframes float{
0%{
transform:translateY(0px);
}
50%{
transform:translateY(-8px);
}
100%{
transform:translateY(0px);
}
}

@keyframes glow{
0%{
opacity:0.5;
transform:scale(1);
}
50%{
opacity:1;
transform:scale(1.08);
}
100%{
opacity:0.5;
transform:scale(1);
}
}

@keyframes slideText{
from{
opacity:0;
transform:translateY(15px);
}
to{
opacity:1;
transform:translateY(0);
}
}

@keyframes shimmer{
0%{
background-position:-200px 0;
}
100%{
background-position:200px 0;
}
}

/* =========================
CARD
========================= */

.card{
width:100%;
max-width:420px;
background:rgba(255,255,255,0.92);
backdrop-filter:blur(12px);
padding:28px;
border-radius:26px;
text-align:center;
box-shadow:0 18px 40px rgba(0,0,0,0.08);
position:relative;
overflow:hidden;
animation:fadeUp 0.7s ease;
z-index:2;
}

.card::before{
content:'';
position:absolute;
width:180px;
height:180px;
border-radius:50%;
background:rgba(37,99,235,0.06);
top:-80px;
right:-50px;
animation:glow 4s infinite ease-in-out;
}

/* =========================
SUCCESS ICON
========================= */

.success-icon{
width:85px;
height:85px;
border-radius:50%;
margin:auto;
display:flex;
justify-content:center;
align-items:center;
background:
linear-gradient(135deg,#2563eb,#3b82f6);
color:white;
font-size:38px;
position:relative;
z-index:2;

animation:
pop 0.7s ease,
pulse 2.5s infinite;
}

.success-icon i{
animation:float 2s infinite ease-in-out;
}

/* =========================
TEXT
========================= */

.tag{
margin-top:18px;
font-size:10px;
font-weight:800;
letter-spacing:2px;
color:#2563eb;
position:relative;
z-index:2;
animation:slideText 0.7s ease;
}

.title{
font-size:30px;
font-weight:800;
color:#0f172a;
margin-top:10px;
letter-spacing:-1px;
position:relative;
z-index:2;
animation:slideText 0.9s ease;
}

.subtitle{
margin-top:10px;
font-size:13px;
line-height:1.7;
color:#64748b;
position:relative;
z-index:2;
animation:slideText 1.1s ease;
}

/* =========================
BOOKING BOX
========================= */

.booking-box{
margin-top:22px;
background:#f8fbff;
padding:18px;
border-radius:18px;
position:relative;
z-index:2;
overflow:hidden;
animation:slideText 1.2s ease;
}

.booking-box::before{
content:'';
position:absolute;
top:0;
left:-200px;
width:200px;
height:100%;
background:
linear-gradient(
90deg,
transparent,
rgba(255,255,255,0.5),
transparent
);

animation:shimmer 3s infinite linear;
}

.booking-label{
font-size:11px;
font-weight:700;
color:#64748b;
margin-bottom:6px;
position:relative;
z-index:2;
}

.booking-id{
font-size:26px;
font-weight:800;
color:#111827;
letter-spacing:-1px;
position:relative;
z-index:2;
}

/* =========================
NOTICE
========================= */

.notice{
margin-top:18px;
background:#eff6ff;
padding:14px;
border-radius:14px;
font-size:12px;
line-height:1.7;
color:#475569;
position:relative;
z-index:2;
animation:slideText 1.3s ease;
}

/* =========================
BUTTON
========================= */

.btn{
display:block;
width:100%;
margin-top:20px;
padding:14px;
border-radius:14px;
text-decoration:none;
background:
linear-gradient(135deg,#2563eb,#3b82f6);
color:white;
font-size:14px;
font-weight:700;
transition:0.3s;
box-shadow:0 12px 24px rgba(37,99,235,0.22);
position:relative;
z-index:2;
overflow:hidden;
animation:slideText 1.4s ease;
}

.btn::before{
content:'';
position:absolute;
top:0;
left:-120px;
width:120px;
height:100%;
background:
linear-gradient(
90deg,
transparent,
rgba(255,255,255,0.45),
transparent
);

transition:0.5s;
}

.btn:hover::before{
left:100%;
}

.btn:hover{
transform:translateY(-3px) scale(1.01);
}

/* =========================
REDIRECT
========================= */

.redirect{
margin-top:12px;
font-size:11px;
color:#94a3b8;
position:relative;
z-index:2;
animation:slideText 1.5s ease;
}

</style>

<script>

setTimeout(function(){

window.location.href =
"ViewBookingCustomerServlet";

},5000);

</script>

</head>

<body>

<div class="card">

<!-- SUCCESS ICON -->

<div class="success-icon">
<i class="fa-solid fa-check"></i>
</div>

<!-- TEXT -->

<div class="tag">
PAYMENT COMPLETED
</div>

<div class="title">
Payment Successful
</div>

<div class="subtitle">

Your booking payment has been completed successfully.
Thank you for choosing Busana Tradisi rental services.

</div>

<!-- BOOKING INFO -->

<div class="booking-box">

<div class="booking-label">
BOOKING ID
</div>

<div class="booking-id">
B<%= String.format("%03d", Integer.parseInt(bookingID)) %>
</div>

</div>

<!-- NOTICE -->

<div class="notice">

✅ Your payment has been verified successfully.<br>

📦 Pickup details and booking updates can be viewed in your booking page.

</div>

<!-- BUTTON -->

<a href="ViewBookingCustomerServlet"
class="btn">

Back To My Bookings

</a>

<div class="redirect">
Redirecting automatically in 5 seconds...
</div>

</div>

</body>
</html>