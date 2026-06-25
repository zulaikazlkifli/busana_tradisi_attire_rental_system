<%-- 
    Document   : addAccessory
    Created on : Mar 31, 2026, 10:55:32 PM
    Author     : Che Zulaika
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>

<%
if(session.getAttribute("role")==null || !"OWNER".equals(session.getAttribute("role"))){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Add New Accessory | Busana Tradisi</title>

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
    overflow-y:auto;
    padding:35px 60px;
}

/* =========================
   FORM CARD
========================= */

.container{
    width:100%;
    max-width:760px;
    margin:auto;
    background:rgba(255,255,255,0.88);
    backdrop-filter:blur(14px);
    border-radius:32px;
    padding:32px;
    box-shadow:0 25px 50px rgba(15,23,42,0.08);
    border:1px solid rgba(255,255,255,0.7);
    position:relative;
    overflow:hidden;
}

.container::before{
    content:'';
    position:absolute;
    width:220px;
    height:220px;
    border-radius:50%;
    background:rgba(59,130,246,0.06);
    top:-120px;
    right:-70px;
}

/* =========================
   HEADER
========================= */

.header{
    margin-bottom:28px;
    position:relative;
    z-index:2;
}

.header-tag{
    color:#2563eb;
    font-size:11px;
    font-weight:700;
    letter-spacing:2px;
    margin-bottom:10px;
}

.header-title{
    font-size:30px;
    font-weight:800;
    color:#0f172a;
    letter-spacing:-1px;
    margin-bottom:10px;
}

.header-subtitle{
    color:#64748b;
    font-size:14px;
    line-height:1.7;
}

/* =========================
   FORM
========================= */

.form-group{
    margin-bottom:20px;
}

label{
    display:block;
    margin-bottom:8px;
    font-size:13px;
    font-weight:700;
    color:#334155;
}

input,
select,
textarea{
    width:100%;
    border:none;
    outline:none;
    background:#f8fbff;
    padding:15px 16px;
    border-radius:16px;
    font-size:14px;
    font-family:'Inter',sans-serif;
    color:#0f172a;
    border:1px solid #e2e8f0;
    transition:0.3s;
}

textarea{
    resize:none;
}

input:focus,
select:focus,
textarea:focus{
    border-color:#3b82f6;
    background:white;
    box-shadow:0 0 0 4px rgba(59,130,246,0.08);
}

/* FILE BOX */

.file-upload{
    background:#f8fbff;
    border:2px dashed #bfdbfe;
    padding:20px;
    border-radius:18px;
    text-align:center;
    transition:0.3s;
}

.file-upload:hover{
    background:#f1f7ff;
}

.file-upload i{
    font-size:28px;
    color:#2563eb;
    margin-bottom:10px;
}

.file-upload p{
    font-size:13px;
    color:#64748b;
    margin-bottom:12px;
}

.file-upload input{
    background:none;
    border:none;
    padding:0;
    box-shadow:none;
}

/* =========================
   BUTTONS
========================= */

.button-group{
    display:flex;
    gap:14px;
    margin-top:28px;
}

.btn{
    flex:1;
    padding:15px;
    border-radius:18px;
    text-decoration:none;
    text-align:center;
    font-size:14px;
    font-weight:700;
    transition:0.3s;
    border:none;
    cursor:pointer;
}

.btn-submit{
    background:linear-gradient(135deg,#2563eb,#3b82f6);
    color:white;
    box-shadow:0 14px 28px rgba(37,99,235,0.22);
}

.btn-submit:hover{
    transform:translateY(-3px);
}

.btn-back{
    background:#eff6ff;
    color:#2563eb;
}

.btn-back:hover{
    background:#dbeafe;
}

/* =========================
   RESPONSIVE
========================= */

@media(max-width:1100px){

.sidebar{
    width:220px;
}

}

@media(max-width:768px){

.wrapper{
    flex-direction:column;
}

.sidebar{
    width:100%;
    height:auto;
}

.main{
    padding:20px;
}

.container{
    padding:24px;
}

.header-title{
    font-size:24px;
}

.button-group{
    flex-direction:column;
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

                <a href="ViewAttireServlet">
                    <i class="fa-solid fa-shirt"></i>
                    Attires
                </a>

                <a href="ViewAccessoryOwnerServlet" class="active">
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

        <div class="container">

            <!-- HEADER -->

            <div class="header">

                <div class="header-tag">
                    ACCESSORY MANAGEMENT
                </div>

                <div class="header-title">
                    Add New Accessory
                </div>

                <div class="header-subtitle">
                    Add boutique accessories, pricing, quantity and outfit matching details professionally.
                </div>

            </div>

            <!-- FORM -->

            <form action="AddAccessoryServlet"
                  method="post"
                  enctype="multipart/form-data">

                <!-- ACCESSORY NAME -->

                <div class="form-group">

                    <label>
                        Accessory Name
                    </label>

                    <input type="text"
                           name="name"
                           placeholder="Example: Pearl Necklace"
                           required>

                </div>

                <!-- DESCRIPTION -->

                <div class="form-group">

                    <label>
                        Description
                        </label>

                    <textarea name="description"
                              rows="4"
                              placeholder="Example: Elegant pearl accessory suitable for traditional attire"
                              required></textarea>

                </div>

                <!-- PRICE -->

                <div class="form-group">

                    <label>
                        Price (RM)
                    </label>

                    <input type="number"
                           name="price"
                           step="0.01"
                           placeholder="0.00"
                           required>

                </div>

                <!-- QUANTITY -->

                <div class="form-group">

                    <label>
                        Quantity
                    </label>

                    <input type="number"
                           name="quantity"
                           placeholder="Enter quantity"
                           required>

                </div>

                <!-- ATTIRE -->

                <div class="form-group">

                    <label>
                        Attire
                    </label>

                    <select name="attireID" required>

                        <option value="">
                            -- Select Attire --
                        </option>

                        <%
                        ArrayList<String[]> attireList =
                            (ArrayList<String[]>) request.getAttribute("attireList");

                        if(attireList != null){

                            for(String[] a : attireList){
                        %>

                        <option value="<%= a[0] %>">
                            <%= a[1] %> - <%= a[0] %>
                        </option>

                        <%
                            }
                        }
                        %>

                    </select>

                </div>

                <!-- IMAGE -->

                <div class="form-group">

                    <label>
                        Upload Accessory Image
                    </label>

                    <div class="file-upload">

                        <i class="fa-solid fa-image"></i>

                        <p>
                            Upload accessory image here
                        </p>

                        <input type="file"
                               name="image"
                               accept="image/*"
                               required>

                    </div>

                </div>

                <!-- BUTTONS -->

                <div class="button-group">

                    <button type="submit"
                            class="btn btn-submit">

                        <i class="fa-solid fa-plus"></i>
                        Add Accessory

                    </button>

                    <a href="ViewAccessoryOwnerServlet"
                       class="btn btn-back">

                       ← Back

                    </a>

                </div>

            </form>

        </div>

    </div>

</div>

</body>
</html>
