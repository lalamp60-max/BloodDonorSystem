<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.blooddonor.model.Donor" %>

<%
    if (session.getAttribute("adminId") == null) {

        response.sendRedirect("admin-login.jsp");
        return;
    }

    List<Donor> donors =
        (List<Donor>) request.getAttribute("donors");
%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Manage Donors - Admin</title>


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


/* ================= NAVBAR ================= */

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


/* ================= MAIN ================= */

.container {

    width: 95%;

    max-width: 1400px;

    margin: 40px auto;
}


h1 {

    color: #8e0e00;

    margin-bottom: 25px;
}


/* ================= TABLE BOX ================= */

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

    min-width: 900px;
}


th {

    background: #8e0e00;

    color: white;

    padding: 15px;

    text-align: left;
}


td {

    padding: 14px;

    border-bottom:
        1px solid #eee;

    color: #444;
}


tr:hover {

    background: #fff5f5;
}


/* ================= BLOOD GROUP ================= */

.blood {

    display: inline-block;

    background: #ffe1e1;

    color: #8e0e00;

    padding: 7px 13px;

    border-radius: 20px;

    font-weight: bold;
}


/* ================= AVAILABLE ================= */

.available {

    display: inline-block;

    background: #e7f8ed;

    color: #16803c;

    padding: 6px 12px;

    border-radius: 15px;

    font-weight: bold;
}


.unavailable {

    display: inline-block;

    background: #ffe5e5;

    color: #c31432;

    padding: 6px 12px;

    border-radius: 15px;

    font-weight: bold;
}


/* ================= EMPTY ================= */

.empty {

    text-align: center;

    padding: 35px;

    color: #777;

}

</style>

</head>


<body>


<!-- ================= NAVBAR ================= -->

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



<!-- ================= MAIN ================= -->

<div class="container">


    <h1>

        🩸 Manage Blood Donors

    </h1>



    <div class="table-box">


        <table>


            <tr>

                <th>
                    Donor ID
                </th>

                <th>
                    User ID
                </th>

                <th>
                    Blood Group
                </th>

                <th>
                    Age
                </th>

                <th>
                    Gender
                </th>

                <th>
                    City
                </th>

                <th>
                    Availability
                </th>

                <th>
                    Last Donation
                </th>

            </tr>


            <%
                if (donors != null &&
                    !donors.isEmpty()) {


                    for (Donor donor : donors) {
            %>


            <tr>


                <!-- DONOR ID -->

                <td>

                    <%= donor.getDonorId() %>

                </td>


                <!-- USER ID -->

                <td>

                    <%= donor.getUserId() %>

                </td>


                <!-- BLOOD GROUP -->

                <td>

                    <span class="blood">

                        <%= donor.getBloodGroup() %>

                    </span>

                </td>


                <!-- AGE -->

                <td>

                    <%= donor.getAge() %>

                </td>


                <!-- GENDER -->

                <td>

                    <%= donor.getGender() %>

                </td>


                <!-- CITY -->

                <td>

                    <%= donor.getCity() %>

                </td>


                <!-- AVAILABILITY -->

                <td>

                    <%
                        if (donor.isAvailability()) {
                    %>

                        <span class="available">

                            Available

                        </span>

                    <%
                        } else {
                    %>

                        <span class="unavailable">

                            Not Available

                        </span>

                    <%
                        }
                    %>

                </td>


                <!-- LAST DONATION -->

                <td>

                    <%
                        if (donor.getLastDonationDate()
                                != null) {
                    %>

                        <%= donor.getLastDonationDate() %>

                    <%
                        } else {
                    %>

                        Not Available

                    <%
                        }
                    %>

                </td>


            </tr>


            <%
                    }

                } else {
            %>


            <tr>

                <td
                    colspan="8"
                    class="empty">

                    🩸 No donors found.

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
