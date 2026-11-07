<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.blooddonor.model.User" %>

<%
    if (session.getAttribute("adminId") == null) {

        response.sendRedirect("admin-login.jsp");
        return;
    }

    List<User> users =
        (List<User>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Manage Users - Admin</title>

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


/* NAVBAR */

.navbar {

    height: 70px;

    background:
        linear-gradient(
            135deg,
            #3b0000,
            #8e0e00,
            #c31432
        );

    color: white;

    display: flex;

    align-items: center;

    justify-content: space-between;

    padding: 0 40px;
}

.logo {

    font-size: 23px;

    font-weight: bold;
}

.back {

    color: #c31432;

    background: white;

    text-decoration: none;

    padding: 9px 18px;

    border-radius: 20px;

    font-weight: bold;
}


/* MAIN */

.container {

    width: 92%;

    max-width: 1200px;

    margin: 40px auto;
}

h1 {

    color: #8e0e00;

    margin-bottom: 25px;
}


/* TABLE */

.table-box {

    background: white;

    padding: 25px;

    border-radius: 20px;

    box-shadow:
        0 10px 30px rgba(0,0,0,0.1);

    overflow-x: auto;
}

table {

    width: 100%;

    border-collapse: collapse;
}

th {

    background: #8e0e00;

    color: white;

    padding: 15px;

    text-align: left;
}

td {

    padding: 14px;

    border-bottom: 1px solid #eee;

    color: #444;
}

tr:hover {

    background: #fff5f5;
}


.badge {

    background: #ffe1e1;

    color: #8e0e00;

    padding: 6px 12px;

    border-radius: 15px;

    font-weight: bold;
}


.empty {

    text-align: center;

    padding: 30px;

    color: #777;
}

</style>

</head>


<body>


<div class="navbar">

    <div class="logo">

        🩸 Blood Donor Finder - Admin

    </div>


    <a
        href="adminDashboard"
        class="back">

        ← Dashboard

    </a>

</div>



<div class="container">

    <h1>

        👥 Manage Users

    </h1>


    <div class="table-box">


        <table>

            <tr>

                <th>
                    ID
                </th>

                <th>
                    Name
                </th>

                <th>
                    Email
                </th>

                <th>
                    Phone
                </th>

                <th>
                    Role
                </th>

            </tr>


            <%
                if (users != null &&
                    !users.isEmpty()) {

                    for (User user : users) {
            %>

            <tr>

                <td>
                    <%= user.getUserId() %>
                </td>

                <td>
                    <%= user.getName() %>
                </td>

                <td>
                    <%= user.getEmail() %>
                </td>

                <td>
                    <%= user.getPhone() %>
                </td>

                <td>

                    <span class="badge">

                        <%= user.getRole() %>

                    </span>

                </td>

            </tr>

            <%
                    }

                } else {
            %>

            <tr>

                <td
                    colspan="5"
                    class="empty">

                    No users found.

                </td>

            </tr>

            <%
                }
            %>

        </table>

    </div>

</div>


</body>

</html>