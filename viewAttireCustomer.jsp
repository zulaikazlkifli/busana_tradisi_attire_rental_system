<%-- 
    Document   : viewAttireCustomer
    Created on : Jan 1, 2026, 12:59:20 PM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>

<%
if (session.getAttribute("role") == null ||
!"CUSTOMER".equals(session.getAttribute("role"))) {
response.sendRedirect("login.jsp");
return;
}

ArrayList<String[]> attireList =
(ArrayList<String[]>) request.getAttribute("attireList");
%>

<!DOCTYPE html>
<html>
<head>
<title>Browse Attire | Busana Tradisi</title>

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
padding:13px 20px;
border-radius:16px;
display:flex;
align-items:center;
gap:10px;
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
#1d4ed8 55%,
#3b82f6 100%);
border-radius:22px;
padding:26px 30px;
position:relative;
overflow:hidden;
margin-bottom:24px;
box-shadow:0 14px 28px rgba(37,99,235,0.14);
width:100%;
}

.hero-card::before{
content:'';
position:absolute;
width:220px;
height:220px;
border-radius:50%;
background:rgba(255,255,255,0.05);
top:-110px;
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
margin-bottom:8px;
position:relative;
z-index:2;
letter-spacing:-1px;
}

.hero-subtitle{
font-size:14px;
line-height:1.8;
max-width:700px;
color:#dbeafe;
position:relative;
z-index:2;
}

/* =========================
GRID
========================= */

.grid{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
gap:22px;
}

/* =========================
CARD
========================= */

.card{
background:white;
border-radius:18px;
overflow:hidden;
border:1px solid #e2e8f0;
transition:0.3s;
box-shadow:0 8px 20px rgba(15,23,42,0.05);
}

.card:hover{
transform:translateY(-5px);
box-shadow:0 16px 28px rgba(37,99,235,0.10);
}

/* IMAGE */

.img-box{
width:100%;
height:320px;
overflow:hidden;
background:#f8fafc;
}

.attire-img{
width:100%;
height:100%;
object-fit:cover;
transition:0.35s;
}

.card:hover .attire-img{
transform:scale(1.03);
}

/* CONTENT */

.card-content{
padding:18px;
}

/* CATEGORY */

.category{
display:inline-block;
font-size:11px;
font-weight:600;
color:#2563eb;
margin-bottom:12px;
}

/* NAME */

.name{
font-size:18px;
font-weight:800;
color:#0f172a;
margin-bottom:14px;
line-height:1.4;
min-height:52px;
}

/* INFO */

.info-row{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:14px;
padding-bottom:12px;
border-bottom:1px solid #e2e8f0;
}

.size{
font-size:13px;
font-weight:500;
color:#64748b;
}

.price{
font-size:24px;
font-weight:800;
color:#2563eb;
}

/* STATUS */

.status{
display:inline-block;
font-size:11px;
font-weight:700;
margin-bottom:16px;
padding:5px 12px;
border-radius:8px;
}

.available{
background:#dcfce7;
color:#166534;
}

.unavailable{
background:#fee2e2;
color:#991b1b;
}

/* BUTTONS */

.button-group{
display:flex;
gap:10px;
}

.btn{
flex:1;
padding:12px;
border:none;
border-radius:10px;
font-size:13px;
font-weight:700;
cursor:pointer;
transition:0.3s;
text-decoration:none;
text-align:center;
}

.btn-size{
background:#f1f5f9;
color:#334155;
}

.btn-size:hover{
background:#e2e8f0;
}

.btn-book{
background:#2563eb;
color:white;
}

.btn-book:hover{
background:#1d4ed8;
}

.btn-disabled{
background:#cbd5e1;
color:white;
cursor:not-allowed;
}

/* =========================
MODAL
========================= */

.modal{
display:none;
position:fixed;
z-index:999;
left:0;
top:0;
width:100%;
height:100%;
background:rgba(15,23,42,0.45);
backdrop-filter:blur(5px);
justify-content:center;
align-items:center;
padding:20px;
}

.modal-content{
background:white;
width:100%;
max-width:420px;
border-radius:22px;
padding:30px;
position:relative;
animation:popup 0.3s ease;
box-shadow:0 25px 50px rgba(0,0,0,0.18);
}

@keyframes popup{
from{
opacity:0;
transform:scale(0.8);
}
to{
opacity:1;
transform:scale(1);
}
}

.close{
position:absolute;
top:18px;
right:22px;
font-size:22px;
cursor:pointer;
color:#94a3b8;
}

.modal-title{
font-size:22px;
font-weight:800;
color:#0f172a;
margin-bottom:18px;
}

.modal-desc{
background:#f8fbff;
padding:18px;
border-radius:14px;
line-height:1.8;
font-size:14px;
color:#475569;
white-space:pre-line;
}

/* =========================
RESPONSIVE
========================= */

@media(max-width:768px){

.sidebar{
display:none;
}

.hero-title{
font-size:24px;
}

.page-title{
font-size:28px;
}

.grid{
grid-template-columns:1fr;
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

<a href="ViewAttireCustomerServlet" class="active">
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
Browse Attire
</div>

<div class="customer-box">
<i class="fa-solid fa-user"></i>
Customer
</div>

</div>

<!-- HERO -->

<div class="hero-card">

<div class="hero-tag">
TRADITIONAL COLLECTION
</div>

<div class="hero-title">
Elegant Traditional Attire
</div>

<div class="hero-subtitle">
Explore beautiful traditional attire collections crafted for weddings, cultural celebrations and memorable occasions.
</div>

</div>

<!-- GRID -->

<div class="grid">

<%
if(attireList != null && !attireList.isEmpty()){

for(String[] a : attireList){

String status = a[5];
%>

<div class="card">

<div class="img-box">

<img class="attire-img"
src="<%=request.getContextPath()%>/uploads/<%=a[6]%>">

</div>

<div class="card-content">

<div class="category">
<%=a[2]%>
</div>

<div class="name">
<%=a[1]%>
</div>

<div class="info-row">

<div class="size">
Size : <%=a[3]%>
</div>

<div class="price">
RM <%=a[4]%>
</div>

</div>

<div>

<span class="status
<%= "AVAILABLE".equalsIgnoreCase(status)
? "available"
: "unavailable" %>">

<%=status%>

</span>

</div>

<div class="button-group">

<button type="button"
class="btn btn-size"
data-title="<%=a[1]%>"
data-desc="<%= a.length>7 ? a[7] : "" %>"
onclick="openModalFromBtn(this)">

Size Chart

</button>

<% if("AVAILABLE".equalsIgnoreCase(status)){ %>

<form action="ViewAttireCustomerServlet"
method="post"
style="flex:1;">

<input type="hidden"
name="attireID"
value="<%=a[0]%>">

<input type="hidden"
name="attireName"
value="<%=a[1]%>">

<input type="hidden"
name="price"
value="<%=a[4]%>">

<input type="hidden"
name="imagePath"
value="<%=a[6]%>">

<button type="submit"
class="btn btn-book"
style="width:100%;">

Select Attire

</button>

</form>

<% } else { %>

<button class="btn btn-disabled">
Unavailable
</button>

<% } %>

</div>

</div>

</div>

<%
}

}else{
%>

<p>No attire available</p>

<%
}
%>

</div>

</div>

</div>

<!-- MODAL -->

<div id="sizeModal" class="modal">

<div class="modal-content">

<span class="close"
onclick="closeModal()">

&times;

</span>

<div id="modalTitle"
class="modal-title"></div>

<div id="modalDesc"
class="modal-desc"></div>

</div>

</div>

<!-- JS -->

<script>

function openModalFromBtn(btn){

var title = btn.getAttribute("data-title");
var desc = btn.getAttribute("data-desc");

document.getElementById("modalTitle").innerText =
title + " Size Chart";

document.getElementById("modalDesc").innerText =
desc;

document.getElementById("sizeModal").style.display =
"flex";
}

function closeModal(){
document.getElementById("sizeModal").style.display =
"none";
}

window.onclick = function(event){

let modal =
document.getElementById("sizeModal");

if(event.target == modal){
modal.style.display = "none";
}

}

</script>

</body>
</html>