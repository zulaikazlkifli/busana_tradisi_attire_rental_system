<%-- 
    Document   : cart
    Created on : Apr 13, 2026, 9:28:11 PM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>

<%
ArrayList<ArrayList<Object>> cart =
(ArrayList<ArrayList<Object>>) session.getAttribute("cart");

double total = 0;
%>

<!DOCTYPE html>
<html>
<head>
<title>Your Cart | Busana Tradisi</title>

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
box-shadow:0 10px 25px rgba(0,0,0,0.05);
font-weight:600;
}

.customer-box i{
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
border-radius:24px;
padding:24px 28px;
margin-bottom:26px;
position:relative;
overflow:hidden;
box-shadow:0 18px 35px rgba(37,99,235,0.18);
max-width:980px;
}

.hero-card::before{
content:'';
position:absolute;
width:220px;
height:220px;
border-radius:50%;
background:rgba(255,255,255,0.05);
top:-100px;
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
font-size:10px;
font-weight:700;
letter-spacing:2px;
color:#bfdbfe;
margin-bottom:10px;
position:relative;
z-index:2;
}

.hero-title{
font-size:34px;
font-weight:800;
color:white;
letter-spacing:-1px;
margin-bottom:8px;
position:relative;
z-index:2;
}

.hero-subtitle{
font-size:14px;
color:#dbeafe;
line-height:1.7;
max-width:650px;
position:relative;
z-index:2;
}

/* =========================
CART CARD
========================= */

.cart-card{
background:white;
border-radius:28px;
padding:28px;
box-shadow:0 18px 35px rgba(15,23,42,0.06);
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
text-align:left;
border-bottom:1px solid #e2e8f0;
}

td{
padding:20px 16px;
font-size:14px;
color:#334155;
border-bottom:1px solid #f1f5f9;
}

tr:hover{
background:#f8fbff;
}

.price{
font-weight:700;
color:#2563eb;
}

/* =========================
REMOVE BUTTON
========================= */

.btn-remove{
background:#fee2e2;
color:#dc2626;
padding:8px 14px;
border-radius:10px;
text-decoration:none;
font-size:12px;
font-weight:700;
transition:0.3s;
}

.btn-remove:hover{
background:#fecaca;
}

/* =========================
TOTAL
========================= */

.total-box{
margin-top:28px;
background:#f8fbff;
padding:22px;
border-radius:22px;
display:flex;
justify-content:space-between;
align-items:center;
}

.total-label{
font-size:15px;
font-weight:600;
color:#64748b;
}

.total-amount{
font-size:30px;
font-weight:800;
color:#2563eb;
}

/* =========================
BUTTONS
========================= */

.button-group{
display:flex;
justify-content:space-between;
margin-top:26px;
gap:14px;
}

.btn{
flex:1;
padding:15px;
border-radius:16px;
text-decoration:none;
text-align:center;
font-size:14px;
font-weight:700;
transition:0.3s;
}

.btn-continue{
background:#eff6ff;
color:#2563eb;
}

.btn-continue:hover{
background:#dbeafe;
}

.btn-checkout{
background:linear-gradient(135deg,#2563eb,#3b82f6);
color:white;
box-shadow:0 12px 25px rgba(37,99,235,0.22);
}

.btn-checkout:hover{
transform:translateY(-2px);
}

/* =========================
EMPTY
========================= */

.empty-card{
background:white;
padding:70px 30px;
border-radius:28px;
text-align:center;
box-shadow:0 18px 35px rgba(15,23,42,0.06);
}

.empty-card i{
font-size:60px;
color:#cbd5e1;
margin-bottom:18px;
}

.empty-title{
font-size:24px;
font-weight:800;
color:#0f172a;
margin-bottom:10px;
}

.empty-subtitle{
font-size:14px;
color:#64748b;
margin-bottom:26px;
}

/* =========================
REMOVE NOTIFICATION
========================= */

.remove-notification{
background:#dcfce7;
color:#166534;
padding:16px 20px;
border-radius:16px;
margin-bottom:20px;
font-size:14px;
font-weight:700;
box-shadow:0 10px 20px rgba(22,101,52,0.08);
animation:fadeIn 0.4s ease;
}

@keyframes fadeIn{
from{
opacity:0;
transform:translateY(-10px);
}
to{
opacity:1;
transform:translateY(0);
}
}

/* =========================
RESPONSIVE
========================= */

@media(max-width:768px){

.sidebar{
display:none;
}

.page-title{
font-size:30px;
}

.hero-title{
font-size:28px;
}

.button-group{
flex-direction:column;
}

table{
font-size:12px;
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
My Cart
</div>

<div class="customer-box">
<i class="fa-solid fa-user"></i>
Customer
</div>

</div>

<%
String removed = request.getParameter("removed");
%>

<% if(removed != null){ %>

<div id="removeNotification" class="remove-notification">
    Item removed from cart successfully!
</div>

<% } %>

<!-- HERO -->

<div class="hero-card">

<div class="hero-tag">
SHOPPING CART
</div>

<div class="hero-title">
Ready for Checkout 
</div>

<div class="hero-subtitle">
Confirm your selected items and continue to secure your booking.
</div>

</div>

<%
if(cart != null && !cart.isEmpty()){
%>

<!-- CART -->

<div class="cart-card">

<table>

<tr>
<th>No</th>
<th>Accessory Name</th>
<th>Price</th>
<th>Action</th>
</tr>

<%
for(int i=0; i<cart.size(); i++){

ArrayList item = cart.get(i);

String name = (String) item.get(1);

double price =
Double.parseDouble(item.get(2).toString());

total += price;
%>

<tr>

<td><%=i+1%></td>

<td>
<%=name%>
</td>

<td class="price">
RM <%=String.format("%.2f", price)%>
</td>

<td>

<a href="RemoveFromCartServlet?index=<%=i%>"
class="btn-remove"
onclick="return confirm('Are you sure you want to remove this item from cart?');">

Remove

</a>

</td>

</tr>

<%
}
%>

</table>

<!-- TOTAL -->

<div class="total-box">

<div class="total-label">
Total Amount
</div>

<div class="total-amount">
RM <%=String.format("%.2f", total)%>
</div>

</div>

<!-- BUTTONS -->

<div class="button-group">

<a href="ViewAccessoryCustomerServlet"
class="btn btn-continue">

← Continue Shopping

</a>

<a href="checkout.jsp"
class="btn btn-checkout">

Proceed to Checkout →

</a>

</div>

</div>

<%
}else{
%>

<!-- EMPTY -->

<div class="empty-card">

<i class="fa-solid fa-cart-shopping"></i>

<div class="empty-title">
Your Cart is Empty
</div>
<div class="empty-subtitle">
Browse beautiful accessories and add them into your cart.
</div>

<a href="ViewAccessoryCustomerServlet"
class="btn btn-checkout"
style="display:inline-block; max-width:260px;">

Browse Accessories

</a>

</div>

<%
}
%>

</div>

</div>

<script>

setTimeout(function(){

    let notification =
        document.getElementById("removeNotification");

    if(notification){
        notification.style.display = "none";
    }

},3000);

</script>

</body>
</html>