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

<title>Create Blood Request</title>

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

    margin-bottom: 7px;

    font-weight: bold;

    color: #444;
}

select,
input {

    width: 100%;

    padding: 12px;

    border: 1px solid #ddd;

    border-radius: 8px;

    font-size: 15px;
}

select:focus,
input:focus {

    outline: none;

    border-color: #c31432;
}

button {

    width: 100%;

    padding: 13px;

    margin-top: 25px;

    border: none;

    border-radius: 8px;

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

    margin-top: 18px;

    color: #c31432;

    text-decoration: none;
}
/* ==========================================
   EMERGENCY FIELD
========================================== */

.form-group select[name="emergency"] {

    border-color: #c31432;

    font-weight: bold;
}


/* ==========================================
   EMERGENCY NOTE
========================================== */

.emergency-note {

    margin-top: 10px;

    padding: 12px 15px;

    background: #fff1f1;

    color: #8e0e00;

    border-left: 4px solid #c31432;

    border-radius: 8px;

    font-size: 14px;
}
</style>

</head>

<body>

<div class="container">

    <h1>🆘 Blood Request</h1>

    <p class="subtitle">
        Create a new blood requirement
    </p>

    <form action="createRequest" method="post">

        <label>Blood Group</label>

        <select name="bloodGroup" required>

            <option value="">
                Select Blood Group
            </option>

            <option value="A+">A+</option>
            <option value="A-">A-</option>

            <option value="B+">B+</option>
            <option value="B-">B-</option>

            <option value="AB+">AB+</option>
            <option value="AB-">AB-</option>

            <option value="O+">O+</option>
            <option value="O-">O-</option>

        </select>


        <label>Units Required</label>

        <input
            type="number"
            name="units"
            min="1"
            max="10"
            placeholder="Enter required units"
            required>


        <label>City</label>

        <input
            type="text"
            name="city"
            placeholder="Enter city"
            required>
<!-- ==========================================
     EMERGENCY REQUEST
========================================== -->

<div class="form-group">

    <label>
        Emergency Request
    </label>

    <select
        name="emergency"
        required>

        <option value="NO">
            No
        </option>

        <option value="YES">
            Yes - Emergency
        </option>

    </select>

</div>

        <button type="submit">
            🩸 Create Blood Request
        </button>

    </form>


    <a href="dashboard.jsp" class="back">
        ← Back to Dashboard
    </a>

</div>

</body>

</html>