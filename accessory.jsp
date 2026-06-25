<%-- 
    Document   : accessory
    Created on : Mar 31, 2026, 10:40:03 PM
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>

<%
ArrayList accessoryList = (ArrayList) request.getAttribute("accessoryList");
%>

<!DOCTYPE html>
<html>
<head>
<title>Select Accessories</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">

<style>

body{
font-family:'Poppins',sans-serif;
background:#f5f7fc;
margin:0;
padding:40px;
}

.container{
max-width:1100px;
margin:auto;
}

.title{
font-size:28px;
font-weight:600;
margin-bottom:25px;
}

.grid{
display:grid;
grid-template-columns:repeat(auto-fill,minmax(250px,1fr));
gap:25px;
}

.card{
background:white;
border-radius:15px;
padding:15px;
box-shadow:0 10px 25px rgba(0,0,0,0.08);
transition:0.3s;
}

.card:hover{
transform:translateY(-5px);
}

.card img{
width:100%;
height:200px;
object-fit:cover;
border-radius:10px;
}

.name{
font-size:16px;
font-weight:500;
margin-top:10px;
}

.price{
color:#2f3a8f;
margin-top:5px;
font-weight:600;
}

.btn{
margin-top:12px;
width:100%;
padding:10px;
border:none;
border-radius:25px;
background:#2f3a8f;
color:white;
cursor:pointer;
}

</style>
</head>

<body>

<div class="container">
<%
String added = request.getParameter("added");
if("true".equals(added)){
%>
<p style="
background:#e8f8f0;
color:#2ecc71;
padding:10px;
border-radius:10px;
margin-bottom:15px;
font-size:14px;
">
✔ Accessory added successfully!
</p>
<%
}
%>
<div class="title">Add Accessories</div>

<div class="grid">

<%
if(accessoryList != null){
for(int i=0; i<accessoryList.size(); i++){

ArrayList row = (ArrayList) accessoryList.get(i);
%>

<div class="card">

<img src="uploads/<%=row.get(3)%>">

<div class="name"><%=row.get(1)%></div>
<div class="price">RM <%=row.get(4)%></div>

<form action="AddAccessoryCartServlet" method="post">

<input type="hidden" name="accessoryID" value="<%=row.get(0)%>">
<input type="hidden" name="price" value="<%=row.get(4) != null ? row.get(4) : "0"%>">
<input type="hidden" name="name" value="<%=row.get(1)%>">

<button class="btn">Add</button>

</form>

</div>

<%
}
}
%>

</div>
<hr style="margin:40px 0;">

<h3>Selected Accessories</h3>

<%
ArrayList cart = (ArrayList) session.getAttribute("accessoryCart");

double total = 0;

if(cart != null && cart.size() > 0){

for(int i=0; i<cart.size(); i++){

ArrayList item = (ArrayList) cart.get(i);
%>

<p>
- <%=item.get(1)%> (RM <%=item.get(2)%>)
</p>

<%
total += (double) item.get(2);
}
%>

<p style="font-weight:bold; margin-top:10px;">
Total Accessories: RM <%=total%>
</p>

<%
}else{
%>

<p>No accessories selected yet.</p>

<%
}
%>

</div>

</body>
</html>