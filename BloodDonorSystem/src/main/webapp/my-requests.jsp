<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>


<%

    // ==========================================
    // LOGIN CHECK
    // ==========================================

    if (session.getAttribute("userId") == null) {

        response.sendRedirect("login.jsp");

        return;
    }


    // ==========================================
    // GET REQUESTS
    // ==========================================

    List<String[]> requests =
        (List<String[]>)
        request.getAttribute("requests");

%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>My Blood Requests</title>


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
        0 5px 15px
        rgba(0,0,0,0.2);
}


.logo {

    font-size: 24px;

    font-weight: bold;
}


.back {

    background: white;

    color: #c31432;

    padding: 10px 20px;

    border-radius: 25px;

    text-decoration: none;

    font-weight: bold;

    transition: 0.3s;
}


.back:hover {

    background: #ffe5e5;

    transform: translateY(-2px);
}


/* ==========================================
   MAIN
========================================== */

.container {

    width: 92%;

    max-width: 1200px;

    margin: 40px auto;
}


.title {

    text-align: center;

    color: #8e0e00;

    font-size: 32px;

    margin-bottom: 10px;
}


.subtitle {

    text-align: center;

    color: #666;

    margin-bottom: 35px;
}


/* ==========================================
   GRID
========================================== */

.requests-grid {

    display: grid;

    grid-template-columns:
        repeat(
            auto-fit,
            minmax(340px, 1fr)
        );

    gap: 25px;
}


/* ==========================================
   CARD
========================================== */

.card {

    background: white;

    padding: 28px;

    border-radius: 20px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.1);

    border-top:
        5px solid #c31432;

    transition: 0.3s;
}


.card:hover {

    transform:
        translateY(-6px);

    box-shadow:
        0 15px 35px
        rgba(0,0,0,0.15);
}


/* ==========================================
   EMERGENCY CARD
========================================== */

.emergency-card {

    border-top:
        5px solid #8e0e00;

    background:
        linear-gradient(
            135deg,
            #ffffff,
            #fff5f5
        );
}


/* ==========================================
   EMERGENCY BADGE
========================================== */

.emergency-badge {

    display: inline-block;

    margin-bottom: 15px;

    padding: 7px 14px;

    background:
        linear-gradient(
            135deg,
            #8e0e00,
            #c31432
        );

    color: white;

    border-radius: 20px;

    font-size: 12px;

    font-weight: bold;

    letter-spacing: 0.5px;
}


/* ==========================================
   REQUEST ID
========================================== */

.request-id {

    font-size: 21px;

    font-weight: bold;

    color: #8e0e00;

    margin-bottom: 20px;
}


/* ==========================================
   INFO
========================================== */

.info {

    margin: 12px 0;

    color: #555;

    line-height: 1.5;
}


.info strong {

    color: #333;
}


/* ==========================================
   BLOOD
========================================== */

.blood {

    display: inline-block;

    padding: 6px 13px;

    border-radius: 20px;

    background: #ffe1e1;

    color: #c31432;

    font-weight: bold;
}


/* ==========================================
   STATUS
========================================== */

.status {

    display: inline-block;

    padding: 7px 15px;

    border-radius: 20px;

    font-weight: bold;
}


.pending {

    background: #fff3cd;

    color: #856404;
}


.approved {

    background: #d4edda;

    color: #155724;
}


.rejected {

    background: #f8d7da;

    color: #721c24;
}


.completed {

    background: #cce5ff;

    color: #004085;
}


/* ==========================================
   DONOR BOX
========================================== */

.donor-box {

    margin-top: 22px;

    padding: 18px;

    background: #f4fff7;

    border-radius: 15px;

    border-left:
        5px solid #28a745;
}


.donor-title {

    color: #155724;

    font-size: 18px;

    font-weight: bold;

    margin-bottom: 10px;
}


/* ==========================================
   ADMIN BOX
========================================== */

.admin-box {

    margin-top: 22px;

    padding: 18px;

    background: #fff5f5;

    border-radius: 15px;

    border-left:
        5px solid #c31432;
}


.admin-title {

    color: #8e0e00;

    font-size: 18px;

    font-weight: bold;

    margin-bottom: 10px;
}


.admin-action {

    display: inline-block;

    padding: 7px 14px;

    background: #ffe1e1;

    color: #8e0e00;

    border-radius: 20px;

    font-weight: bold;
}


/* ==========================================
   WAITING BOX
========================================== */

.waiting-box {

    margin-top: 22px;

    padding: 18px;

    background: #fffaf0;

    border-radius: 15px;

    border-left:
        5px solid #ffc107;
}


.waiting-title {

    color: #856404;

    font-size: 18px;

    font-weight: bold;

    margin-bottom: 10px;
}


/* ==========================================
   EMPTY
========================================== */

.empty {

    grid-column: 1 / -1;

    background: white;

    padding: 55px;

    text-align: center;

    border-radius: 20px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.1);
}


.empty h2 {

    color: #8e0e00;
}


.empty p {

    color: #777;
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

        font-size: 19px;
    }


    .container {

        width: 90%;
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
        class="back">

        ← Dashboard

    </a>

</div>



<!-- ==========================================
     MAIN
========================================== -->

<div class="container">


    <h1 class="title">

        My Blood Requests

    </h1>


    <p class="subtitle">

        Track the status of your blood requests
        and view donor or administrator responses.

    </p>



    <div class="requests-grid">


<%

    if (requests != null &&
        !requests.isEmpty()) {


        for (String[] r : requests) {


            /*
             * ==========================================
             * NORMAL ARRAY
             * ==========================================
             *
             * r[0]  = Request ID
             * r[1]  = Blood Group
             * r[2]  = Units
             * r[3]  = City
             * r[4]  = Status
             * r[5]  = Request Date
             * r[6]  = Donor/Admin ID
             * r[7]  = Donor/Admin Name
             * r[8]  = Donor/Admin Email
             * r[9]  = Response/Action
             * r[10] = Actor Type
             * r[11] = Emergency
             */


            String status =
                r[4];


            String statusClass =
                "pending";


            if ("APPROVED"
                .equalsIgnoreCase(status)) {

                statusClass =
                    "approved";

            } else if (
                "REJECTED"
                .equalsIgnoreCase(status)
            ) {

                statusClass =
                    "rejected";

            } else if (
                "COMPLETED"
                .equalsIgnoreCase(status)
            ) {

                statusClass =
                    "completed";
            }


            // ==========================================
            // EMERGENCY
            // ==========================================

            boolean emergency = false;


            if (r.length > 11) {

                emergency =
                    "true".equalsIgnoreCase(
                        r[11]
                    );
            }


            String actorType =
                r[10];

%>


        <!-- ==========================================
             REQUEST CARD
        =========================================== -->

        <div class="
            card
            <%= emergency
                ? "emergency-card"
                : "" %>
        ">


<%
            if (emergency) {
%>


            <div class="emergency-badge">

                EMERGENCY REQUEST

            </div>


<%
            }
%>


            <!-- REQUEST ID -->

            <div class="request-id">

                Request #<%= r[0] %>

            </div>


            <!-- BLOOD GROUP -->

            <div class="info">

                <strong>
                    Blood Group:
                </strong>

                <span class="blood">

                    <%= r[1] %>

                </span>

            </div>


            <!-- UNITS -->

            <div class="info">

                <strong>
                    Units Required:
                </strong>

                <%= r[2] %>

            </div>


            <!-- CITY -->

            <div class="info">

                <strong>
                    City:
                </strong>

                <%= r[3] %>

            </div>


            <!-- STATUS -->

            <div class="info">

                <strong>
                    Status:
                </strong>

                <span
                    class="
                        status
                        <%= statusClass %>
                    ">

                    <%= status %>

                </span>

            </div>


            <!-- REQUEST DATE -->

            <div class="info">

                <strong>
                    Request Date:
                </strong>

                <%= r[5] %>

            </div>



<%
    // =================================================
    // DONOR RESPONSE
    // =================================================

    if ("DONOR".equalsIgnoreCase(actorType)) {

%>


            <div class="donor-box">


                <div class="donor-title">

                    Donor Details

                </div>


                <div class="info">

                    <strong>
                        Donor ID:
                    </strong>

                    <%= r[6] %>

                </div>


                <div class="info">

                    <strong>
                        Donor Name:
                    </strong>

                    <%= r[7] %>

                </div>


                <div class="info">

                    <strong>
                        Donor Email:
                    </strong>

                    <%= r[8] %>

                </div>


                <div class="info">

                    <strong>
                        Response:
                    </strong>

                    <%= r[9] %>

                </div>


            </div>


<%
    // =================================================
    // ADMIN ACTION
    // =================================================

    } else if (
        "ADMIN".equalsIgnoreCase(actorType)
    ) {

%>


            <div class="admin-box">


                <div class="admin-title">

                    Admin Action

                </div>


                <div class="info">

                    <strong>
                        Handled By:
                    </strong>

                    Administrator

                </div>


                <div class="info">

                    <strong>
                        Admin ID:
                    </strong>

                    <%= r[6] %>

                </div>


                <div class="info">

                    <strong>
                        Admin Name:
                    </strong>

                    <%= r[7] %>

                </div>


                <div class="info">

                    <strong>
                        Admin Email:
                    </strong>

                    <%= r[8] %>

                </div>


                <div class="info">

                    <strong>
                        Action:
                    </strong>

                    <span class="admin-action">

                        <%= r[9] %>

                    </span>

                </div>


            </div>


<%
    // =================================================
    // WAITING
    // =================================================

    } else {

%>


            <div class="waiting-box">


                <div class="waiting-title">

                    Waiting for Donor

                </div>


                <div class="info">

                    Your request is still pending.
                    A donor can respond from the
                    Pending Requests page.

                </div>


            </div>


<%
    }

%>


        </div>


<%

        }

    } else {

%>


        <!-- ==========================================
             EMPTY
        =========================================== -->

        <div class="empty">


            <h2>

                No Blood Requests

            </h2>


            <p>

                You have not created any blood
                requests yet.

            </p>


        </div>


<%

    }

%>


    </div>


</div>



<!-- ==========================================
     FOOTER
========================================== -->

<div class="footer">

    © 2026 Blood Donor Finder System

</div>


</body>

</html>