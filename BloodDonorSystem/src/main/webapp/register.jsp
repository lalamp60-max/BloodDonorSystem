<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Register - Blood Donor Finder</title>


<style>

* {
    box-sizing: border-box;
}


body {

    margin: 0;

    font-family: Arial, sans-serif;

    min-height: 100vh;

    background:
        linear-gradient(
            135deg,
            #8e0e00,
            #c31432,
            #240b36
        );

    display: flex;

    justify-content: center;

    align-items: center;
}


.register-card {

    width: 90%;

    max-width: 480px;

    background: white;

    padding: 38px;

    border-radius: 25px;

    box-shadow:
        0 15px 40px
        rgba(0,0,0,0.3);
}


h1 {

    text-align: center;

    color: #8e0e00;

    margin-bottom: 10px;
}


.subtitle {

    text-align: center;

    color: #777;

    margin-bottom: 25px;
}


.form-group {

    margin-bottom: 18px;
}


label {

    display: block;

    margin-bottom: 7px;

    color: #555;

    font-weight: bold;

    font-size: 14px;
}


input {

    width: 100%;

    padding: 12px 14px;

    border:
        1px solid #ddd;

    border-radius: 10px;

    font-size: 15px;

    outline: none;
}


input:focus {

    border-color: #c31432;

    box-shadow:
        0 0 0 3px
        rgba(195,20,50,0.1);
}


.register-btn {

    width: 100%;

    padding: 13px;

    border: none;

    border-radius: 25px;

    background:
        linear-gradient(
            135deg,
            #8e0e00,
            #c31432
        );

    color: white;

    font-size: 16px;

    font-weight: bold;

    cursor: pointer;
}


.login-link {

    text-align: center;

    margin-top: 20px;

    color: #777;
}


.login-link a {

    color: #c31432;

    text-decoration: none;

    font-weight: bold;
}


.message {

    padding: 12px;

    margin-bottom: 18px;

    border-radius: 10px;

    text-align: center;

    font-weight: bold;
}


.error {

    background: #f8d7da;

    color: #721c24;

    border:
        1px solid #f5c6cb;
}

</style>

</head>


<body>


<div class="register-card">


    <h1>
        Create Account
    </h1>


    <p class="subtitle">

        Register with your contact details

    </p>


<%

    String error =
        request.getParameter("error");


    if ("empty".equals(error)) {

%>

        <div class="message error">

            Please fill all fields.

        </div>

<%
    }

    if ("phone".equals(error)) {
%>

        <div class="message error">

            Enter a valid 10-digit phone number.

        </div>

<%
    }

    if ("email".equals(error)) {
%>

        <div class="message error">

            Email is already registered.

        </div>

<%
    }

    if ("failed".equals(error)) {
%>

        <div class="message error">

            Registration failed.

        </div>

<%
    }

    if ("database".equals(error)) {
%>

        <div class="message error">

            Database error occurred.

        </div>

<%
    }
%>


    <form
        action="register"
        method="post">


        <!-- NAME -->

        <div class="form-group">

            <label>
                Full Name
            </label>

            <input
                type="text"
                name="name"
                placeholder="Enter your name"
                required>

        </div>



        <!-- EMAIL -->

        <div class="form-group">

            <label>
                Email
            </label>

            <input
                type="email"
                name="email"
                placeholder="Enter your email"
                required>

        </div>



        <!-- PHONE -->

        <div class="form-group">

            <label>
                Phone Number
            </label>

            <input
                type="tel"
                name="phone"
                placeholder="Enter 10-digit phone number"
                maxlength="10"
                pattern="[0-9]{10}"
                required>

        </div>



        <!-- PASSWORD -->

        <div class="form-group">

            <label>
                Password
            </label>

            <input
                type="password"
                name="password"
                placeholder="Enter password"
                required>

        </div>



        <!-- SUBMIT -->

        <button
            type="submit"
            class="register-btn">

            Create Account

        </button>


    </form>



    <div class="login-link">

        Already have an account?

        <a href="login.jsp">
            Login
        </a>

    </div>


</div>


</body>

</html>