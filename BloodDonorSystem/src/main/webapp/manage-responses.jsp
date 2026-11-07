<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.blooddonor.model.DonorResponse" %>


<%
    if (session.getAttribute("adminId") == null) {

        response.sendRedirect("admin-login.jsp");
        return;
    }

    List<DonorResponse> responses =
        (List<DonorResponse>)
        request.getAttribute("responses");
%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Donor Responses - Admin</title>


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

    transition: 0.3s;
}


.back:hover {

    transform: translateY(-2px);

    background: #ffe5e5;
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

    padding: 14px;

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


/* ================= BLOOD ================= */

.blood {

    display: inline-block;

    background: #ffe1e1;

    color: #8e0e00;

    padding: 6px 12px;

    border-radius: 20px;

    font-weight: bold;
}


/* ================= STATUS ================= */

.status {

    display: inline-block;

    padding: 7px 13px;

    border-radius: 20px;

    font-weight: bold;
}


.accepted {

    background: #e7f8ed;

    color: #16803c;
}


.declined {

    background: #ffe5e5;

    color: #c31432;
}


/* ================= EMPTY ================= */

.empty {

    text-align: center;

    padding: 35px;

    color: #777;

    font-size: 16px;
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

        ❤️ Donor Responses

    </h1>


    <div class="table-box">


        <table>


            <tr>

                <th>
                    Response ID
                </th>

                <th>
                    Request ID
                </th>

                <th>
                    Donor ID
                </th>

                <th>
                    Blood Group
                </th>

                <th>
                    City
                </th>

                <th>
                    Response Status
                </th>

                <th>
                    Response Date
                </th>

            </tr>


            <%
                if (responses != null &&
                    !responses.isEmpty()) {


                    for (
                        DonorResponse dr :
                        responses
                    ) {
            %>


            <tr>


                <!-- RESPONSE ID -->

                <td>

                    <%= dr.getResponseId() %>

                </td>


                <!-- REQUEST ID -->

                <td>

                    <%= dr.getRequestId() %>

                </td>


                <!-- DONOR ID -->

                <td>

                    <%= dr.getDonorId() %>

                </td>


                <!-- BLOOD GROUP -->

                <td>

                    <span class="blood">

                        <%= dr.getBloodGroup() %>

                    </span>

                </td>


                <!-- CITY -->

                <td>

                    <%= dr.getCity() %>

                </td>


                <!-- STATUS -->

                <td>

                    <%
                        String status =
                            dr.getResponseStatus();

                        String statusClass =
                            "accepted";

                        if ("DECLINED"
                                .equalsIgnoreCase(status)) {

                            statusClass =
                                "declined";
                        }
                    %>


                    <span
                        class="status <%= statusClass %>">

                        <%= status %>

                    </span>

                </td>


                <!-- DATE -->

                <td>

                    <%= dr.getResponseDate() %>

                </td>


            </tr>


            <%
                    }

                } else {
            %>


            <tr>

                <td
                    colspan="7"
                    class="empty">

                    ❤️ No donor responses found.

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
