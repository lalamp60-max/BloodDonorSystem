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
    // GET REQUEST LIST
    // ==========================================

    List<String[]> requests =
        (List<String[]>)
        request.getAttribute("requests");

%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Pending Blood Requests</title>


<style>

/* ==========================================
   GLOBAL
========================================== */

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


.back-btn {

    background: white;

    color: #c31432;

    padding: 10px 20px;

    border-radius: 25px;

    text-decoration: none;

    font-weight: bold;

    transition: 0.3s;
}


.back-btn:hover {

    transform: translateY(-2px);

    background: #ffe5e5;
}


/* ==========================================
   MAIN
========================================== */

.container {

    width: 92%;

    max-width: 1250px;

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

    font-size: 16px;

    margin-bottom: 25px;
}


/* ==========================================
   MESSAGES
========================================== */

.message {

    max-width: 750px;

    margin:
        0 auto 25px;

    padding: 14px 20px;

    border-radius: 12px;

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
   GRID
========================================== */

.requests-grid {

    display: grid;

    grid-template-columns:
        repeat(
            auto-fit,
            minmax(320px, 1fr)
        );

    gap: 25px;
}


/* ==========================================
   REQUEST CARD
========================================== */

.request-card {

    background: white;

    padding: 25px;

    border-radius: 20px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.1);

    border-left:
        5px solid #c31432;

    transition: 0.3s;

    position: relative;
}


.request-card:hover {

    transform:
        translateY(-6px);

    box-shadow:
        0 15px 35px
        rgba(0,0,0,0.16);
}


/* ==========================================
   EMERGENCY CARD
========================================== */

.emergency-card {

    border-left:
        6px solid #8e0e00;

    background:
        linear-gradient(
            135deg,
            #fffafa,
            #fff0f0
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

    box-shadow:
        0 4px 10px
        rgba(142,14,0,0.2);
}


/* ==========================================
   REQUEST ID
========================================== */

.request-id {

    font-size: 21px;

    font-weight: bold;

    color: #8e0e00;

    margin-bottom: 18px;
}


/* ==========================================
   INFORMATION
========================================== */

.info {

    margin: 12px 0;

    color: #555;

    font-size: 15px;

    line-height: 1.5;
}


.info strong {

    color: #333;
}


/* ==========================================
   BLOOD GROUP
========================================== */

.blood-group {

    display: inline-block;

    padding: 7px 14px;

    margin-left: 5px;

    background: #ffe1e1;

    color: #c31432;

    border-radius: 20px;

    font-weight: bold;
}


/* ==========================================
   STATUS
========================================== */

.status {

    display: inline-block;

    padding: 6px 14px;

    background: #fff3cd;

    color: #856404;

    border-radius: 20px;

    font-weight: bold;
}


/* ==========================================
   RESPONSE BUTTONS
========================================== */

.response-buttons {

    display: flex;

    gap: 12px;

    margin-top: 24px;
}


.response-buttons form {

    flex: 1;

    margin: 0;
}


.accept-btn,
.decline-btn {

    width: 100%;

    padding: 13px;

    border: none;

    border-radius: 25px;

    font-size: 15px;

    font-weight: bold;

    cursor: pointer;

    transition: 0.3s;
}


.accept-btn {

    background:
        linear-gradient(
            135deg,
            #198754,
            #28a745
        );

    color: white;
}


.decline-btn {

    background:
        linear-gradient(
            135deg,
            #c31432,
            #dc3545
        );

    color: white;
}


.accept-btn:hover,
.decline-btn:hover {

    transform:
        translateY(-3px);

    box-shadow:
        0 8px 18px
        rgba(0,0,0,0.2);
}


/* ==========================================
   EMPTY
========================================== */

.empty-box {

    grid-column: 1 / -1;

    background: white;

    padding: 60px 30px;

    border-radius: 20px;

    text-align: center;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.1);
}


.empty-box h2 {

    color: #8e0e00;

    margin-bottom: 10px;
}


.empty-box p {

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

        font-size: 18px;
    }


    .container {

        width: 90%;
    }


    .title {

        font-size: 26px;
    }


    .response-buttons {

        flex-direction: column;
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
        class="back-btn">

        ← Dashboard

    </a>


</div>



<!-- ==========================================
     MAIN
========================================== -->

<div class="container">


    <h1 class="title">

        Pending Blood Requests

    </h1>


    <p class="subtitle">

        View blood requests created by other users
        and choose whether you can help.

    </p>



    <!-- ======================================
         SUCCESS / ERROR MESSAGES
    ======================================= -->


<%

    String success =
        request.getParameter("success");

    String error =
        request.getParameter("error");


    if ("accepted".equals(success)) {

%>

        <div class="message success">

            Request accepted successfully.

        </div>

<%

    } else if ("declined".equals(success)) {

%>

        <div class="message success">

            Request declined successfully.

        </div>

<%
    }


    if ("notDonor".equals(error)) {

%>

        <div class="message error">

            You must have a donor profile
            to respond to blood requests.

        </div>

<%

    } else if ("invalidRequest".equals(error)) {

%>

        <div class="message error">

            This request is invalid or
            no longer available.

        </div>

<%

    } else if ("alreadyProcessed".equals(error)) {

%>

        <div class="message error">

            This request has already been processed.

        </div>

<%

    } else if ("ownRequest".equals(error)) {

%>

        <div class="message error">

            You cannot respond to your own request.

        </div>

<%

    } else if ("alreadyResponded".equals(error)) {

%>

        <div class="message error">

            You have already responded to this request.

        </div>

<%

    } else if ("invalidAction".equals(error)) {

%>

        <div class="message error">

            Invalid response action.

        </div>

<%

    } else if ("response".equals(error)) {

%>

        <div class="message error">

            Something went wrong while submitting
            your response.

        </div>

<%

    }

%>



    <!-- ======================================
         REQUEST GRID
    ======================================= -->

    <div class="requests-grid">


<%

    if (requests != null &&
        !requests.isEmpty()) {


        for (String[] r : requests) {


            /*
             * ==========================================
             * ARRAY STRUCTURE
             * ==========================================
             *
             * r[0] = request_id
             * r[1] = requester_id
             * r[2] = blood_group
             * r[3] = units_required
             * r[4] = city
             * r[5] = status
             * r[6] = request_date
             * r[7] = emergency
             */


            boolean emergency = false;


            if (r.length > 7) {

                emergency =
                    "true".equalsIgnoreCase(
                        r[7]
                    );
            }

%>


        <!-- ======================================
             REQUEST CARD
        ======================================= -->


        <div class="
            request-card
            <%= emergency ? "emergency-card" : "" %>
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


            <!-- REQUESTER -->

            <div class="info">

                <strong>
                    Requester ID:
                </strong>

                <%= r[1] %>

            </div>


            <!-- BLOOD GROUP -->

            <div class="info">

                <strong>
                    Blood Group:
                </strong>

                <span class="blood-group">

                    <%= r[2] %>

                </span>

            </div>


            <!-- UNITS -->

            <div class="info">

                <strong>
                    Units Required:
                </strong>

                <%= r[3] %>

            </div>


            <!-- CITY -->

            <div class="info">

                <strong>
                    City:
                </strong>

                <%= r[4] %>

            </div>


            <!-- STATUS -->

            <div class="info">

                <strong>
                    Status:
                </strong>

                <span class="status">

                    <%= r[5] %>

                </span>

            </div>


            <!-- REQUEST DATE -->

            <div class="info">

                <strong>
                    Request Date:
                </strong>

                <%= r[6] %>

            </div>


            <!-- ==================================
                 ACCEPT / DECLINE
            =================================== -->

            <div class="response-buttons">


                <!-- ACCEPT -->

                <form
                    action="donorResponse"
                    method="post">


                    <input
                        type="hidden"
                        name="requestId"
                        value="<%= r[0] %>"
                    >


                    <input
                        type="hidden"
                        name="action"
                        value="ACCEPTED"
                    >


                    <button
                        type="submit"
                        class="accept-btn">

                        Accept

                    </button>


                </form>



                <!-- DECLINE -->

                <form
                    action="donorResponse"
                    method="post">


                    <input
                        type="hidden"
                        name="requestId"
                        value="<%= r[0] %>"
                    >


                    <input
                        type="hidden"
                        name="action"
                        value="DECLINED"
                    >


                    <button
                        type="submit"
                        class="decline-btn">

                        Decline

                    </button>


                </form>


            </div>


        </div>


<%

        }

    } else {

%>


        <!-- ======================================
             NO REQUESTS
        ======================================= -->


        <div class="empty-box">


            <h2>

                No Pending Requests

            </h2>


            <p>

                There are currently no pending
                requests from other users.

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