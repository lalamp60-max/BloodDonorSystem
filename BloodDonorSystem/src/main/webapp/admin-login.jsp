<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Admin Login - Blood Donor Finder</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;

    min-height: 100vh;

    font-family: Arial, sans-serif;

    display: flex;

    justify-content: center;

    align-items: center;

    background:
        linear-gradient(
            135deg,
            #3b0000,
            #8e0e00,
            #c31432
        );
}

.login-box {

    width: 420px;

    background: white;

    padding: 40px;

    border-radius: 22px;

    box-shadow:
        0 15px 40px rgba(0,0,0,0.3);
}

.icon {

    width: 90px;

    height: 90px;

    margin: 0 auto 20px;

    border-radius: 50%;

    background:
        linear-gradient(
            135deg,
            #8e0e00,
            #c31432
        );

    display: flex;

    justify-content: center;

    align-items: center;

    font-size: 45px;
}

h1 {

    text-align: center;

    color: #8e0e00;

    margin-bottom: 8px;
}

.subtitle {

    text-align: center;

    color: #777;

    margin-bottom: 30px;
}

label {

    display: block;

    margin-bottom: 7px;

    font-weight: bold;

    color: #444;
}

input {

    width: 100%;

    padding: 13px;

    border: 1px solid #ddd;

    border-radius: 9px;

    margin-bottom: 20px;

    font-size: 15px;
}

input:focus {

    outline: none;

    border-color: #c31432;
}

button {

    width: 100%;

    padding: 13px;

    border: none;

    border-radius: 9px;

    background: #c31432;

    color: white;

    font-size: 16px;

    font-weight: bold;

    cursor: pointer;
}

button:hover {

    background: #8e0e00;
}

.back {

    display: block;

    text-align: center;

    margin-top: 20px;

    color: #c31432;

    text-decoration: none;
}

</style>

</head>

<body>

<div class="login-box">

    <div class="icon">
        🔐
    </div>

    <h1>
        Admin Login
    </h1>

    <p class="subtitle">
        Blood Donor Finder Administration
    </p>


    <form action="adminLogin" method="post">

        <label>
            Email
        </label>

        <input
            type="email"
            name="email"
            placeholder="Enter admin email"
            required>


        <label>
            Password
        </label>

        <input
            type="password"
            name="password"
            placeholder="Enter admin password"
            required>


        <button type="submit">

            🔑 Admin Login

        </button>

    </form>


    <a
        href="index.jsp"
        class="back">

        ← Back to Home

    </a>

</div>

</body>

</html>