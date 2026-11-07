<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String userName = (String) session.getAttribute("userName");

    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Add Donor - Blood Donor Finder</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;

    min-height: 100vh;

    background: linear-gradient(
        135deg,
        #fff5f5,
        #ffe0e0
    );

    display: flex;
    justify-content: center;
    align-items: center;
}

.container {

    width: 500px;

    background: white;

    padding: 35px;

    border-radius: 20px;

    box-shadow:
        0 10px 30px rgba(0,0,0,0.15);
}

h1 {

    text-align: center;

    color: #c31432;

    margin-bottom: 10px;
}

.subtitle {

    text-align: center;

    color: #777;

    margin-bottom: 25px;
}

label {

    display: block;

    margin-top: 15px;

    margin-bottom: 6px;

    font-weight: bold;

    color: #444;
}

input,
select {

    width: 100%;

    padding: 12px;

    border: 1px solid #ddd;

    border-radius: 8px;

    font-size: 15px;

    outline: none;
}

input:focus,
select:focus {

    border-color: #c31432;
}

button {

    width: 100%;

    padding: 13px;

    margin-top: 25px;

    background: #c31432;

    color: white;

    border: none;

    border-radius: 8px;

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

    margin-top: 18px;

    color: #c31432;

    text-decoration: none;
}

</style>

</head>

<body>

<div class="container">

    <h1>🩸 Add Donor</h1>

    <p class="subtitle">
        Register a blood donor
    </p>

    <form action="addDonor" method="post">

        <label>Blood Group</label>

        <select name="bloodGroup" required>

            <option value="">Select Blood Group</option>

            <option value="A+">A+</option>
            <option value="A-">A-</option>
            <option value="B+">B+</option>
            <option value="B-">B-</option>
            <option value="AB+">AB+</option>
            <option value="AB-">AB-</option>
            <option value="O+">O+</option>
            <option value="O-">O-</option>

        </select>


        <label>Age</label>

        <input
            type="number"
            name="age"
            min="18"
            max="65"
            placeholder="Enter age"
            required>


        <label>Gender</label>

        <select name="gender" required>

            <option value="">Select Gender</option>

            <option value="Male">Male</option>

            <option value="Female">Female</option>

            <option value="Other">Other</option>

        </select>


        <label>City</label>

        <input
            type="text"
            name="city"
            placeholder="Enter city"
            required>


        <button type="submit">
            🩸 Register Donor
        </button>

    </form>


    <a href="dashboard.jsp" class="back">
        ← Back to Dashboard
    </a>

</div>

</body>

</html>