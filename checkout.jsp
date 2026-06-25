<%-- 
    Document   : checkout
    Created on : Apr 14, 2026, 11:16:56 PM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>

<%
ArrayList<ArrayList<Object>> cart =
(ArrayList<ArrayList<Object>>) session.getAttribute("cart");

// base price
double baseTotal = 0;

if(cart != null){
    for(ArrayList item : cart){
        baseTotal += (double) item.get(2);
    }
}

double total = baseTotal;

// 🔥 ERROR MESSAGE
String error =
(String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
<title>Checkout | Busana Tradisi</title>

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
#edf4ff 40%,
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
display:flex;
align-items:center;
gap:14px;
font-size:15px;
font-weight:500;
transition:0.3s;
}

.menu a:hover{
background:rgba(255,255,255,0.1);
transform:translateX(5px);
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
margin-bottom:24px;
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
font-weight:600;
box-shadow:0 10px 25px rgba(0,0,0,0.05);
}

.customer-box i{
color:#2563eb;
}

/* =========================
ERROR BOX
========================= */

.error-box{
background:#fee2e2;
color:#b91c1c;
padding:14px 18px;
border-radius:14px;
margin-bottom:20px;
font-size:14px;
font-weight:600;
display:flex;
align-items:center;
gap:10px;
border:1px solid #fecaca;
}

/* =========================
HERO
========================= */

.hero-card{
background:
linear-gradient(135deg,
#0f172a 0%,
#1d4ed8 55%,
#2563eb 100%);
border-radius:26px;
padding:28px 32px;
margin-bottom:28px;
color:white;
box-shadow:0 18px 40px rgba(37,99,235,0.18);
}

.hero-tag{
font-size:11px;
font-weight:700;
letter-spacing:2px;
color:#bfdbfe;
margin-bottom:10px;
}

.hero-title{
font-size:38px;
font-weight:800;
margin-bottom:10px;
}

.hero-subtitle{
font-size:14px;
line-height:1.8;
color:#dbeafe;
max-width:700px;
}

/* =========================
CONTENT
========================= */

.checkout-layout{
display:grid;
grid-template-columns:0.95fr 1.1fr;
gap:24px;
}

/* =========================
SUMMARY
========================= */

.summary-box{
background:white;
padding:24px;
border-radius:24px;
box-shadow:0 18px 35px rgba(15,23,42,0.06);
}

.summary-title{
font-size:22px;
font-weight:800;
color:#0f172a;
margin-bottom:22px;
}

.item{
display:flex;
gap:14px;
padding:14px;
border-radius:18px;
background:#f8fbff;
margin-bottom:14px;
}

.item img{
width:85px;
height:100px;
object-fit:cover;
border-radius:14px;
}

.item-info{
flex:1;
}

.item-name{
font-size:15px;
font-weight:700;
color:#0f172a;
margin-bottom:4px;
}

.item-type{
font-size:12px;
color:#64748b;
margin-bottom:10px;
}

.item-price{
font-size:18px;
font-weight:800;
color:#2563eb;
}

.price-breakdown{
font-size:12px;
color:#94a3b8;
margin-top:4px;
}

.back-btn{
display:block;
margin-top:18px;
text-align:center;
padding:14px;
border-radius:16px;
background:#eff6ff;
color:#2563eb;
text-decoration:none;
font-weight:600;
}

/* =========================
FORM
========================= */

.form-box{
background:rgba(255,255,255,0.88);
backdrop-filter:blur(10px);
padding:28px;
border-radius:24px;
box-shadow:0 18px 35px rgba(15,23,42,0.06);
border:1px solid rgba(255,255,255,0.7);
}

.form-title{
font-size:24px;
font-weight:800;
color:#0f172a;
margin-bottom:22px;
}

label{
display:block;
margin-bottom:8px;
font-size:13px;
font-weight:700;
color:#334155;
}

input{
width:100%;
padding:14px 16px;
border:none;
outline:none;
border-radius:16px;
background:#f8fbff;
border:1px solid #e2e8f0;
margin-bottom:16px;
font-family:'Inter',sans-serif;
}

input:focus{
border-color:#3b82f6;
background:white;
box-shadow:0 0 0 4px rgba(59,130,246,0.08);
}

.note{
background:#f8fbff;
padding:16px;
border-radius:16px;
font-size:13px;
line-height:1.8;
color:#475569;
margin-top:10px;
}

.total{
margin-top:24px;
padding:20px;
border-radius:20px;
background:#eff6ff;
}

.total-label{
font-size:13px;
font-weight:600;
color:#64748b;
margin-bottom:6px;
}

.total-price{
font-size:34px;
font-weight:800;
color:#2563eb;
}

.btn{
width:100%;
padding:15px;
border:none;
border-radius:18px;
font-size:14px;
font-weight:700;
cursor:pointer;
transition:0.3s;
margin-top:18px;
}

.btn-submit{
background:linear-gradient(135deg,#2563eb,#3b82f6);
color:white;
box-shadow:0 14px 28px rgba(37,99,235,0.22);
}

.btn-submit:hover{
transform:translateY(-3px);
}

.btn-cancel{
display:block;
text-align:center;
text-decoration:none;
background:#e2e8f0;
color:#334155;
}

#errorMsg{
margin-top:10px;
font-size:12px;
color:#dc2626;
}

@media(max-width:900px){

.sidebar{
display:none;
}

.checkout-layout{
grid-template-columns:1fr;
}

}

</style>

<script>

let baseTotal = <%= baseTotal %>;

window.onload = function(){

let today = new Date().toISOString().split("T")[0];

document.getElementById("startDate").setAttribute("min", today);
document.getElementById("endDate").setAttribute("min", today);

};

function calculateDates(){

let start = document.getElementById("startDate").value;
let end = document.getElementById("endDate").value;

if(start && end){

document.getElementById("eventStartDate").value = start;
document.getElementById("eventEndDate").value = end;

let startDate = new Date(start);
let endDate = new Date(end);

let pickup = new Date(startDate);
pickup.setDate(pickup.getDate() - 2);

let ret = new Date(endDate);
ret.setDate(ret.getDate() + 1);

document.getElementById("pickupDate").value =
pickup.toISOString().split('T')[0];

document.getElementById("returnDate").value =
ret.toISOString().split('T')[0];

let diffTime = endDate - startDate;

let days =
diffTime / (1000 * 60 * 60 * 24) + 1;

if(days > 0){

let newTotal = baseTotal * days;

document.getElementById("totalPrice").innerHTML =
"RM " + newTotal.toFixed(2);

let prices =
document.querySelectorAll(".item-price");

let breakdowns =
document.querySelectorAll(".price-breakdown");

prices.forEach(function(p,index){

let basePrice =
parseFloat(p.getAttribute("data-price"));

let newPrice = basePrice * days;

p.innerHTML =
"RM " + newPrice.toFixed(2);

breakdowns[index].innerHTML =
"RM " + basePrice.toFixed(2)
+ " × " + days + " day(s)";

});

}

}

}

function validateForm(){

let start =
document.getElementById("startDate").value;

let end =
document.getElementById("endDate").value;

document.getElementById("errorMsg").innerHTML = "";

if(!start || !end){

document.getElementById("errorMsg").innerHTML =
"Please select both dates.";

return false;

}

if(new Date(end) < new Date(start)){

document.getElementById("errorMsg").innerHTML =
"End date cannot be earlier than start date.";

return false;

}

return true;

}

</script>

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
Checkout
</div>

<div class="customer-box">
<i class="fa-solid fa-user"></i>
Customer
</div>

</div>

<!-- 🔥 ERROR MESSAGE -->

<% if(error != null){ %>

<div class="error-box">
<i class="fa-solid fa-circle-exclamation"></i>
<%= error %>
</div>

<% } %>

<!-- HERO -->

<div class="hero-card">

<div class="hero-tag">
BOOKING CONFIRMATION
</div>

<div class="hero-title">
Complete Your Booking
</div>

<div class="hero-subtitle">
Review your selected attire and accessories before confirming your rental booking details.
</div>

</div>

<!-- CONTENT -->

<div class="checkout-layout">

<!-- LEFT -->

<div class="summary-box">

<div class="summary-title">
Booking Summary
</div>

<%
if(cart != null && !cart.isEmpty()){

for(ArrayList item : cart){

String name = (String) item.get(1);
double price = (double) item.get(2);

String type = "";
String image = "default.png";

if(item.size() > 3){
type = (String) item.get(3);
}

if(item.size() > 4 && item.get(4) != null){
image = item.get(4).toString();
}
%>

<div class="item">

<img src="<%=request.getContextPath()%>/uploads/<%=image%>">

<div class="item-info">

<div class="item-name">
<%=name%>
</div>

<div class="item-type">
<%=type%>
</div>

<div class="item-price"
data-price="<%=price%>">

RM <%=price%>

</div>

<div class="price-breakdown">
RM <%=price%> × 1 day
</div>

</div>

</div>

<%
}
}
%>

<a href="cart.jsp" class="back-btn">
← Back to Cart
</a>

</div>

<!-- RIGHT -->

<div class="form-box">

<div class="form-title">
Rental Details
</div>

<form action="CheckoutServlet"
method="post"
onsubmit="return validateForm()">

<label>Event Start Date</label>

<input type="date"
id="startDate"
name="startDate"
onchange="calculateDates()">

<label>Event End Date</label>

<input type="date"
id="endDate"
name="endDate"
onchange="calculateDates()">

<input type="hidden"
name="eventStartDate"
id="eventStartDate">

<input type="hidden"
name="eventEndDate"
id="eventEndDate">

<label>Pickup Date</label>

<input type="date"
id="pickupDate"
name="pickupDate"
readonly>

<label>Return Date</label>

<input type="date"
id="returnDate"
name="returnDate"
readonly>

<div id="errorMsg"></div>

<div class="note">

📦 Pickup is scheduled 2 days before your event date.<br>

🔁 Return must be completed 1 day after the event.<br>

⚠️ Late returns are subject to additional charges.

</div>

<div class="total">

<div class="total-label">
Estimated Total
</div>

<div class="total-price"
id="totalPrice">

RM <%=String.format("%.2f", total)%>

</div>

</div>

<button type="submit"
class="btn btn-submit">

Proceed to Payment

</button>

</form>

<a href="cart.jsp"
class="btn btn-cancel">

Cancel

</a>

</div>

</div>

</div>

</div>

</body>
</html>