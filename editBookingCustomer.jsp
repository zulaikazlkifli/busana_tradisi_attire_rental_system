<%-- 
    Document   : editBookingCustomer
    Created on : Apr 17, 2026, 8:59:16 PM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>

<%
String bookingID = (String) request.getAttribute("bookingID");
String eventStartDate = (String) request.getAttribute("eventStartDate");
String eventEndDate = (String) request.getAttribute("eventEndDate");

String attireName = (String) request.getAttribute("attireName");
String attireImage = (String) request.getAttribute("attireImage");

ArrayList<String[]> accList =
(ArrayList<String[]>) request.getAttribute("accessoryList");
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Booking</title>

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

.wrapper{
display:flex;
height:100vh;
}

.main{
flex:1;
padding:28px;
overflow-y:auto;
}

.container{
    width:100%;
    max-width:550px;
    margin:auto;
    background:white;
    padding:35px;
    border-radius:28px;
    box-shadow:0 18px 35px rgba(15,23,42,0.06);
}

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
}

.menu a:hover{
    background:rgba(255,255,255,0.12);
    color:white;
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
}

/* TITLE */
.title{
    font-size:24px;
    font-weight:600;
    color:#4338ca;
    text-align:center;
}

.subtitle{
    text-align:center;
    font-size:13px;
    color:#6b7280;
    margin-bottom:25px;
}

/* ================= ITEMS ================= */
.items-container{
    background:linear-gradient(135deg,#f8fafc,#eef2ff);
    padding:20px;
    border-radius:16px;
    margin-bottom:25px;
}

.items-title{
    font-size:15px;
    font-weight:600;
    margin-bottom:15px;
    color:#4338ca;
}

/* GRID */
.items-grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:12px;
}

/* CARD */
.item-card{
    background:white;
    border-radius:14px;
    padding:12px;
    text-align:center;
    box-shadow:0 6px 15px rgba(0,0,0,0.05);
    transition:0.25s;
}

.item-card:hover{
    transform:translateY(-4px);
    box-shadow:0 12px 25px rgba(0,0,0,0.12);
}

/* IMAGE SAME SIZE */
.item-card img{
    width:100%;
    height:120px;
    object-fit:cover;
    border-radius:10px;
    margin-bottom:10px;
}

/* TEXT */
.item-name{
    font-size:13px;
    font-weight:500;
    color:#1f2937;
}

/* TAG */
.tag{
    margin-top:5px;
    display:inline-block;
    font-size:10px;
    background:#4f46e5;
    color:white;
    padding:4px 10px;
    border-radius:20px;
}

/* NOTE */
.note-box{
    margin-top:12px;
    font-size:12px;
    color:#6b7280;
    text-align:center;
}

/* ================= FORM ================= */

label{
    font-size:13px;
    font-weight:500;
}

input{
    width:100%;
    padding:12px;
    margin-top:5px;
    margin-bottom:15px;
    border-radius:10px;
    border:1px solid #ddd;
}

input:focus{
    border:1px solid #6366f1;
    outline:none;
    box-shadow:0 0 0 2px rgba(99,102,241,0.2);
}

.date-box{
    background:#f9fafb;
    padding:15px;
    border-radius:12px;
    margin-bottom:15px;
}

/* BUTTON */
.btn{
    width:100%;
    padding:13px;
    background:linear-gradient(135deg,#4f46e5,#6366f1);
    color:white;
    border:none;
    border-radius:12px;
    cursor:pointer;
    font-weight:600;
}

.btn:hover{
    transform:translateY(-2px);
}

/* BACK */
.back{
    display:block;
    margin-top:18px;
    text-align:center;
    padding:10px;
    border-radius:10px;
    background:#eef2ff;
    color:#4f46e5;
    text-decoration:none;
    font-size:13px;
}

</style>

<script>
function calculateDates(){
    let start = document.getElementById("startDate").value;
    let end = document.getElementById("endDate").value;

    if(start && end){
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
    }
}

window.onload = function(){

    calculateDates();

    let today = new Date();

    let minDate =
        today.toISOString().split('T')[0];

    document.getElementById("startDate").min =
        minDate;

    document.getElementById("endDate").min =
        minDate;
}
</script>

</head>

<body>

<div class="wrapper">

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

<a href="ViewBookingCustomerServlet" class="active">
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

<div class="main">

<div class="container">
<div class="title">✏️ Edit Booking</div>
<div class="subtitle">Update your event dates below</div>

<!-- ===== ITEMS DISPLAY ===== -->
<div class="items-container">

<div class="items-title">📦 Selected Items</div>

<div class="items-grid">

<!-- ATTIRE -->
<div class="item-card">
    <% if(attireImage != null){ %>
    <img src="<%=request.getContextPath()+"/uploads/"+attireImage%>">
    <% } %>

    <div class="item-name"><%=attireName%></div>
    <div class="tag">Main Outfit</div>
</div>

<!-- ACCESSORIES -->
<%
if(accList != null && !accList.isEmpty()){
    for(String[] a : accList){
%>

<div class="item-card">
    <img src="<%=request.getContextPath()+"/uploads/"+a[1]%>">
    <div class="item-name"><%=a[0]%></div>
</div>

<%
    }
}else{
%>

<div class="item-card">
    <div class="item-name">No accessories</div>
</div>

<%
}
%>

</div>

<div class="note-box">
⚠️ Items cannot be edited. Cancel & create new booking if needed.
</div>

</div>

<!-- ===== FORM ===== -->
<form action="<%=request.getContextPath()%>/UpdateBookingCustomerServlet" method="post">

<input type="hidden" name="bookingID" value="<%=bookingID%>">

<div class="date-box">
<label>Event Start Date</label>
<input type="date" id="startDate" name="eventStartDate"
value="<%=eventStartDate%>" onchange="calculateDates()" required>
</div>

<div class="date-box">
<label>Event End Date</label>
<input type="date" id="endDate" name="eventEndDate"
value="<%=eventEndDate%>" onchange="calculateDates()" required>
</div>

<div class="date-box">
<label>Pickup Date</label>
<input type="date" id="pickupDate" readonly>
</div>

<div class="date-box">
<label>Return Date</label>
<input type="date" id="returnDate" readonly>
</div>

<input type="submit" value="Update Booking" class="btn">

</form>

<a href="ViewBookingCustomerServlet" class="back">← Back to My Bookings</a>

</div> <!-- container -->
</div> <!-- main -->
</div> <!-- wrapper -->

</body>
</html>