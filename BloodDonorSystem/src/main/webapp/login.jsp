<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Blood Donor Finder - Login</title>

<style>

body {
    margin: 0;
    font-family: Arial, sans-serif;

    background: linear-gradient(135deg, #8e0e00, #1f1c18);

    height: 100vh;

    display: flex;
    justify-content: center;
    align-items: center;
}

.login-box {

    width: 400px;

    padding: 35px;

    background: white;

    border-radius: 15px;

    box-shadow:
        0 10px 30px rgba(0,0,0,0.4);
}

h1 {
    text-align: center;
    color: #d90429;
}

input {

    width: 100%;

    padding: 12px;

    margin: 10px 0;

    border: 1px solid #ddd;

    border-radius: 8px;

    box-sizing: border-box;
}

button {

    width: 100%;

    padding: 12px;

    background: #d90429;

    color: white;

    border: none;

    border-radius: 8px;

    cursor: pointer;

    font-size: 16px;
}

button:hover {
    background: #a90321;
}

.register-link {

    text-align: center;

    margin-top: 15px;
}

.register-link a {

    color: #d90429;

    text-decoration: none;
}

.error {

    text-align: center;

    color: red;

    margin-bottom: 10px;
}

</style>

</head>

<body>

<div class="login-box">

    <h1>🩸 Blood Donor Finder</h1>

    <h3 style="text-align:center;">
        Login
    </h3>

    <%
        String error = request.getParameter("error");

        if ("1".equals(error)) {
    %>

        <div class="error">
            Invalid email or password!
        </div>

    <%
        }
    %>

    <form action="login" method="post">

        <input
            type="email"
            name="email"
            placeholder="Enter Email"
            required>

        <input
            type="password"
            name="password"
            placeholder="Enter Password"
            required>

        <button type="submit">
            Login
        </button>

    </form>

    <div class="register-link">

        Don't have an account?

        <a href="register.jsp">
            Register
        </a>

    </div>

</div>

</body>

</html>