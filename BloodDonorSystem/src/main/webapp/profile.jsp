<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

    // ==========================================
    // LOGIN CHECK
    // ==========================================

    if (session.getAttribute("userId") == null) {

        response.sendRedirect("login.jsp");

        return;
    }


    String name =
        (String) request.getAttribute("name");

    String email =
        (String) request.getAttribute("email");

    String phone =
        (String) request.getAttribute("phone");

    Object userIdObj =
        request.getAttribute("userId");

    Object roleObj =
        request.getAttribute("role");


    String userId =
        userIdObj != null
            ? String.valueOf(userIdObj)
            : "";

    String role =
        roleObj != null
            ? String.valueOf(roleObj)
            : "";


    if (name == null)
        name = "";

    if (email == null)
        email = "";

    if (phone == null)
        phone = "";

%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>My Profile</title>


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
            #fff5f5,
            #ffe1e1
        );
}


/* ==========================================
   NAVBAR
========================================== */

.navbar {

    height: 70px;

    background:
        linear-gradient(
            135deg,
            #8e0e00,
            #c31432
        );

    color: white;

    display: flex;

    align-items: center;

    justify-content: space-between;

    padding: 0 40px;

    box-shadow:
        0 5px 15px rgba(0,0,0,0.2);
}


.logo {

    font-size: 24px;

    font-weight: bold;
}


.dashboard-btn {

    background: white;

    color: #c31432;

    text-decoration: none;

    padding: 10px 20px;

    border-radius: 25px;

    font-weight: bold;

    transition: 0.3s;
}


.dashboard-btn:hover {

    background: #ffe5e5;

    transform: translateY(-2px);
}


/* ==========================================
   MAIN
========================================== */

.container {

    width: 92%;

    max-width: 800px;

    margin: 45px auto;
}


/* ==========================================
   HEADER
========================================== */

.profile-header {

    text-align: center;

    margin-bottom: 30px;
}


.profile-header h1 {

    margin: 0 0 10px;

    color: #8e0e00;

    font-size: 36px;
}


.profile-header p {

    margin: 0;

    color: #666;

    font-size: 17px;
}


/* ==========================================
   PROFILE CARD
========================================== */

.profile-card {

    background: white;

    padding: 35px;

    border-radius: 22px;

    box-shadow:
        0 10px 30px
        rgba(0,0,0,0.10);

    border-top:
        5px solid #c31432;
}


/* ==========================================
   FORM GROUP
========================================== */

.form-group {

    margin-bottom: 20px;
}


.form-group label {

    display: block;

    margin-bottom: 8px;

    color: #666;

    font-size: 14px;

    font-weight: bold;
}


.form-group input {

    width: 100%;

    padding: 13px 15px;

    border:
        1px solid #ddd;

    border-radius: 10px;

    font-size: 16px;

    outline: none;

    transition: 0.3s;
}


.form-group input:focus {

    border-color: #c31432;

    box-shadow:
        0 0 0 3px
        rgba(195,20,50,0.10);
}


/* ==========================================
   READ ONLY EMAIL
========================================== */

.form-group input[readonly] {

    background: #f7f7f7;

    color: #666;

    cursor: not-allowed;
}


/* ==========================================
   BUTTON
========================================== */

.update-btn {

    width: 100%;

    padding: 14px;

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

    transition: 0.3s;

    margin-top: 5px;
}


.update-btn:hover {

    transform: translateY(-2px);

    box-shadow:
        0 8px 18px
        rgba(0,0,0,0.20);
}


/* ==========================================
   SUCCESS / ERROR
========================================== */

.message {

    padding: 13px 17px;

    border-radius: 10px;

    margin-bottom: 20px;

    text-align: center;

    font-weight: bold;
}


.success {

    background: #d4edda;

    color: #155724;

    border:
        1px solid #c3e6cb;
}


.error {

    background: #f8d7da;

    color: #721c24;

    border:
        1px solid #f5c6cb;
}


/* ==========================================
   USER INFORMATION
========================================== */

.info-box {

    margin-top: 25px;

    background: #fff7f7;

    padding: 18px;

    border-radius: 15px;

    border-left:
        5px solid #c31432;

    color: #555;

    line-height: 1.6;
}


.info-box strong {

    color: #8e0e00;
}


/* ==========================================
   FOOTER
========================================== */

.footer {

    text-align: center;

    padding: 30px;

    color: #888;

    font-size: 14px;
}


/* ==========================================
   MOBILE
========================================== */

@media (max-width: 600px) {

    .navbar {

        padding: 0 20px;
    }


    .logo {

        font-size: 18px;
    }


    .container {

        width: 90%;
    }


    .profile-card {

        padding: 25px;
    }


    .profile-header h1 {

        font-size: 30px;
    }

}

</style>

</head>


<body>


<!-- ==========================================
     NAVBAR
========================================== -->

<div class="navbar">


    <div class="logo">

        Blood Donor Finder

    </div>


    <a
        href="dashboard.jsp"
        class="dashboard-btn">

        ← Dashboard

    </a>


</div>



<!-- ==========================================
     MAIN
========================================== -->

<div class="container">


    <div class="profile-header">

        <h1>
            My Profile
        </h1>


        <p>
            View and manage your account information
        </p>

    </div>



<%
    String success =
        request.getParameter("success");

    String error =
        request.getParameter("error");


    if ("updated".equals(success)) {
%>

        <div class="message success">

            Profile updated successfully.

        </div>

<%
    }


    if ("phone".equals(error)) {
%>

        <div class="message error">

            Please enter your phone number.

        </div>

<%
    }


    if ("invalidPhone".equals(error)) {
%>

        <div class="message error">

            Please enter a valid 10-digit phone number.

        </div>

<%
    }


    if ("name".equals(error)) {
%>

        <div class="message error">

            Name cannot be empty.

        </div>

<%
    }


    if ("update".equals(error)) {
%>

        <div class="message error">

            Profile could not be updated.

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



    <!-- =======================================
         PROFILE CARD
    ======================================== -->

    <div class="profile-card">


        <form
            action="profile"
            method="post">


            <!-- USER ID -->

            <div class="form-group">

                <label>
                    User ID
                </label>

                <input
                    type="text"
                    value="<%= userId %>"
                    readonly>

            </div>



            <!-- NAME -->

            <div class="form-group">

                <label>
                    Name
                </label>

                <input
                    type="text"
                    name="name"
                    value="<%= name %>"
                    required>

            </div>



            <!-- EMAIL -->

            <div class="form-group">

                <label>
                    Email
                </label>

                <input
                    type="email"
                    value="<%= email %>"
                    readonly>

            </div>



            <!-- PHONE -->

            <div class="form-group">

                <label>
                    Phone Number
                </label>

                <input
                    type="tel"
                    name="phone"
                    value="<%= phone %>"
                    placeholder="Enter 10-digit phone number"
                    maxlength="10"
                    pattern="[0-9]{10}"
                    required>

            </div>



            <!-- ROLE -->

            <div class="form-group">

                <label>
                    Role
                </label>

                <input
                    type="text"
                    value="<%= role %>"
                    readonly>

            </div>



            <!-- UPDATE -->

            <button
                type="submit"
                class="update-btn">

                Update Profile

            </button>


        </form>



        <!-- INFORMATION -->

        <div class="info-box">

            <strong>
                Contact Information
            </strong>

            <br>

            Your phone number is used so that
            people who receive your donor response
            can contact you when required.

        </div>


    </div>


</div>



<div class="footer">

    © 2026 Blood Donor Finder System

</div>


</body>

</html>