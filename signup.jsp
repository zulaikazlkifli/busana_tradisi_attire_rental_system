<%-- 
    Document   : signup
    Created on : Dec 25, 2025, 10:26:01 PM
    Author     : Che Zulaika
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up | Busana Tradisi Boutique</title>

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-image:
                linear-gradient(
                    rgba(255,255,255,0.25),
                    rgba(255,255,255,0.25)
                ),
                url('asset/BG.png');

            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }


        /* ===== TOP BAR ===== */
        .top-bar {
            background: #6b73b5;
            padding: 20px 40px;
            color: white;
            font-family: 'Playfair Display', serif;
            font-size: 22px;
            letter-spacing: 1px;
            background: rgba(107,115,181,0.95);
        }

        /* ===== MAIN LAYOUT ===== */
        .container {
        display: flex;
        height: calc(100vh - 80px);
    }

        /* ===== LEFT BRAND ===== */
        .left-panel {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding-left: 350px;
        }

        .left-panel img {
            width: 530px;
            filter: drop-shadow(0px 10px 20px rgba(0,0,0,0.15));
        }

        /* ===== RIGHT FORM ===== */
        .right-panel {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            padding-right: 150px;
        }

        .signup-box {
            width: 380px;
            background: rgba(255,255,255,0.92);
            padding: 40px;
            border-radius: 30px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        h2 {
            font-family: 'Playfair Display', serif;
            color: #1d2c8b;
            margin-bottom: 22px;
            font-size: 34px;
            text-align: center;
        }

        label {
            font-size: 14px;
            color: #333;
        }

        .input-group {
            display: flex;
            margin-bottom: 16px;
        }

        .icon {
            background: #6b73b5;
            color: white;
            padding: 12px;
            border-radius: 6px 0 0 6px;
            width: 42px;
            text-align: center;
        }

        input, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-left: none;
            border-radius: 0 6px 6px 0;
            font-size: 14px;
        }

        button {
            width: 100%;
            padding: 14px;
            background: #6b73b5;
            border: none;
            border-radius: 30px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
            box-shadow: 0 6px 15px rgba(107,115,181,0.4);
        }


        button:hover {
            background: #5660a8;
        }

        .login-link {
            margin-top: 16px;
            font-size: 14px;
            text-align: center;
        }

        .login-link a {
            color: #1d2c8b;
            font-weight: bold;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="top-bar">
    BUSANA TRADISI BOUTIQUE
</div>

<div class="container">

    <!-- LEFT BRAND (LOGO IMAGE) -->
    <div class="left-panel">
        <img src="asset/logobtar.png" alt="Busana Tradisi Logo">
    </div>

    <!-- RIGHT FORM -->
    <div class="right-panel">
        <div class="signup-box">
            <h2>Sign Up</h2>

            <form action="SignupServlet" method="post">

                <label>Name</label>
                <div class="input-group">
                    <div class="icon"><i class="fa fa-user"></i></div>
                    <input type="text" name="name" required>
                </div>

                <label>Email</label>
                <div class="input-group">
                    <div class="icon"><i class="fa fa-envelope"></i></div>
                    <input type="email" name="email" required>
                </div>
                <label>Password</label>
                <div class="input-group">
                    <div class="icon"><i class="fa fa-lock"></i></div>
                    <input type="password" name="password" required>
                </div>

                <label>Phone</label>
                <div class="input-group">
                    <div class="icon"><i class="fa fa-phone"></i></div>
                    <input type="text" name="phone">
                </div>

                <button type="submit">Sign Up</button>
            </form>

            <div class="login-link">
                Already have an account?
                <a href="login.jsp">Login</a>
            </div>
        </div>
    </div>

</div>

</body>
</html>