<%-- 
    Document   : chooseAccessory
    Created on : Apr 13, 2026, 12:16:37 AM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>

<%
ArrayList<ArrayList<String>> list =
(ArrayList<ArrayList<String>>) request.getAttribute("accessoryList");

ArrayList cart = (ArrayList) session.getAttribute("cart");
%>

<!DOCTYPE html>
<html>
<head>
<title>Select Accessories | Busana Tradisi</title>

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
ACTION BAR
========================= */

.action-bar{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:24px;
}

.cart-info{
background:white;
padding:16px 22px;
border-radius:20px;
box-shadow:0 10px 25px rgba(15,23,42,0.05);
display:flex;
align-items:center;
gap:14px;
}

.cart-info i{
font-size:20px;
color:#2563eb;
}

.cart-info h3{
font-size:24px;
color:#0f172a;
margin-bottom:2px;
}

.cart-info p{
font-size:13px;
color:#64748b;
}

.cart-btn{
background:linear-gradient(135deg,#2563eb,#3b82f6);
color:white;
text-decoration:none;
padding:14px 24px;
border-radius:16px;
font-size:14px;
font-weight:700;
transition:0.3s;
box-shadow:0 12px 25px rgba(37,99,235,0.2);
}

.cart-btn:hover{
transform:translateY(-3px);
}

/* =========================
GRID
========================= */

.grid{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(280px,320px));
gap:24px;
}

/* =========================
CARD
========================= */

.card{
background:white;
border-radius:24px;
overflow:hidden;
box-shadow:0 15px 30px rgba(15,23,42,0.06);
transition:0.35s;
mad-width: 320px;
}

.card:hover{
transform:translateY(-6px);
box-shadow:0 20px 40px rgba(37,99,235,0.12);
}

.img-box{
height:180px;
overflow:hidden;
background:#f8fbff;
}

.card img{
width:100%;
height:100%;
object-fit:cover;
transition:0.4s;
}

.card:hover img{
transform:scale(1.04);
}

/* =========================
CONTENT
========================= */

.card-content{
padding:20px;
}

.name{
font-size:20px;
font-weight:800;
color:#0f172a;
margin-bottom:8px;
}

.price{
font-size:22px;
font-weight:800;
color:#2563eb;
margin-bottom:10px;
}

.stock{
font-size:13px;
color:#64748b;
margin-bottom:18px;
}

/* =========================
BUTTON
========================= */

.btn{
width:100%;
padding:12px;
border:none;
border-radius:14px;
font-size:13px;
font-weight:700;
cursor:pointer;
transition:0.3s;
}

.btn-add{
background:linear-gradient(135deg,#2563eb,#3b82f6);
color:white;
box-shadow:0 10px 20px rgba(37,99,235,0.18);
}

.btn-add:hover{
transform:translateY(-2px);
}

.btn.added{
background:linear-gradient(135deg,#22c55e,#16a34a);
}

.disabled{
background:#cbd5e1;
color:white;
cursor:not-allowed;
box-shadow:none;
}

/* =========================
EMPTY
========================= */

.empty{
background:white;
padding:50px;
border-radius:24px;
text-align:center;
color:#64748b;
font-size:16px;
box-shadow:0 15px 30px rgba(15,23,42,0.05);
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

.action-bar{
flex-direction:column;
align-items:flex-start;
gap:16px;
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

<a href="ViewAccessoryCustomerServlet?mode=all" class="active">
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
Accessories
</div>

<div class="customer-box">
<i class="fa-solid fa-user"></i>
Customer
</div>

</div>

<!-- HERO -->

<div class="hero-card">

<div class="hero-tag">
ACCESSORY COLLECTION
</div>

<div class="hero-title">
Customize Your Outfit
</div>

<div class="hero-subtitle">
Choose elegant accessories to complete your traditional attire and create a perfect boutique look.
</div>

</div>

<%
String selectedAttireID =
(String) session.getAttribute("selectedAttireID");

if(selectedAttireID != null){
%>

<div style="
background:#eff6ff;
border-left:5px solid #2563eb;
padding:16px 20px;
border-radius:14px;
margin-bottom:20px;
display:flex;
justify-content:space-between;
align-items:center;
">

<div>

<b style="color:#1e40af;">
Showing accessories related to your selected attire
</b>

<br>

<span style="font-size:13px;color:#64748b;">
Want to browse all accessories instead?
</span>

</div>

<a href="ViewAccessoryCustomerServlet?mode=all"
style="
background:#2563eb;
color:white;
padding:10px 18px;
border-radius:12px;
text-decoration:none;
font-size:13px;
font-weight:600;
">

View All Accessories

</a>

</div>

<%
}
%>

<!-- ACTION BAR -->

<div class="action-bar">

<div class="cart-info">

<i class="fa-solid fa-cart-shopping"></i>

<div>
<h3>
<%= (cart != null) ? cart.size() : 0 %>
</h3>
<p>Items in Cart</p>
</div>

</div>

<a href="cart.jsp" class="cart-btn">
View Cart
</a>

</div>

<!-- GRID -->

<div class="grid">

<%
if(list != null && !list.isEmpty()){

for(ArrayList<String> row : list){

int qty = Integer.parseInt(row.get(5));
%>

<div class="card">

<div class="img-box">

<img src="<%=request.getContextPath()%>/uploads/<%=row.get(3)%>">

</div>

<div class="card-content">

<div class="name">
<%=row.get(1)%>
</div>

<div class="price">
RM <%=row.get(4)%>
</div>

<div class="stock">
Available Stock : <%=qty%>
</div>

<%
if(qty > 0){
%>

<form action="AddToCartServlet"
method="post"
onsubmit="return animateBtn(this)">

<input type="hidden"
name="accessoryID"
value="<%=row.get(0)%>">
<input type="hidden"
name="name"
value="<%=row.get(1)%>">

<input type="hidden"
name="price"
value="<%=row.get(4)%>">

<input type="hidden"
name="image"
value="<%=row.get(3)%>">

<button type="submit"
class="btn btn-add">

Add to Cart

</button>

</form>

<%
}else{
%>

<button class="btn disabled" disabled>
Out of Stock
</button>

<%
}
%>

</div>

</div>

<%
}

}else{
%>

<div class="empty">
No accessories available
</div>

<%
}
%>

</div>

</div>

</div>

<script>

function animateBtn(form){

let btn = form.querySelector("button");

btn.innerText = "✓ Added";
btn.classList.add("added");

return true;
}

</script>

</body>
</html>