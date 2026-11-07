<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>

<%

    // =====================================================
    // LOGIN CHECK
    // =====================================================

    if (session.getAttribute("userId") == null) {

        response.sendRedirect("login.jsp");

        return;
    }


    // =====================================================
    // GET RESPONSES
    // =====================================================

    List<String[]> responses =
        (List<String[]>)
        request.getAttribute("responses");

%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Donor Responses</title>


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


/* =====================================================
   NAVBAR
===================================================== */

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

    text-decoration: none;

    padding: 10px 20px;

    border-radius: 25px;

    font-weight: bold;

    transition: 0.3s;
}


.back:hover {

    transform: translateY(-2px);

    background: #ffe5e5;
}


/* =====================================================
   MAIN
===================================================== */

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

    font-size: 16px;
}


/* =====================================================
   GRID
===================================================== */

.responses-grid {

    display: grid;

    grid-template-columns:
        repeat(
            auto-fit,
            minmax(380px, 1fr)
        );

    gap: 25px;
}


/* =====================================================
   CARD
===================================================== */

.response-card {

    background: white;

    padding: 25px;

    border-radius: 20px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.1);

    border-top: 5px solid #c31432;

    transition: 0.3s;
}


.response-card:hover {

    transform: translateY(-5px);

    box-shadow:
        0 15px 35px
        rgba(0,0,0,0.15);
}


/* =====================================================
   HEADER
===================================================== */

.response-header {

    display: flex;

    justify-content: space-between;

    align-items: center;

    gap: 15px;

    margin-bottom: 20px;
}


.response-title {

    font-size: 21px;

    font-weight: bold;

    color: #8e0e00;
}


.status {

    display: inline-block;

    padding: 8px 15px;

    border-radius: 20px;

    font-size: 13px;

    font-weight: bold;

    white-space: nowrap;
}


/* =====================================================
   DONOR STATUS
===================================================== */

.accepted {

    background: #d4edda;

    color: #155724;
}


.declined {

    background: #f8d7da;

    color: #721c24;
}


/* =====================================================
   ADMIN STATUS
===================================================== */

.admin-approved {

    background: #d4edda;

    color: #155724;
}


.admin-rejected {

    background: #f8d7da;

    color: #721c24;
}


.admin-completed {

    background: #cce5ff;

    color: #004085;
}


/* =====================================================
   SECTIONS
===================================================== */

.section {

    padding: 20px;

    border-radius: 15px;

    margin-top: 15px;
}


.donor-section {

    background: #f4fff7;

    border-left:
        5px solid #28a745;
}


.admin-section {

    background: #fff5f5;

    border-left:
        5px solid #c31432;
}


/* =====================================================
   SECTION TITLE
===================================================== */

.section-title {

    font-size: 19px;

    font-weight: bold;

    margin-bottom: 15px;
}


.donor-title {

    color: #155724;
}


.admin-title {

    color: #8e0e00;
}


/* =====================================================
   INFORMATION
===================================================== */

.info {

    margin: 11px 0;

    color: #555;

    font-size: 15px;

    line-height: 1.5;
}


.info strong {

    color: #333;
}


/* =====================================================
   BLOOD GROUP
===================================================== */

.blood {

    display: inline-block;

    padding: 6px 13px;

    background: #ffe1e1;

    color: #c31432;

    border-radius: 20px;

    font-weight: bold;
}


/* =====================================================
   REQUEST DETAILS
===================================================== */

.request-details {

    background: #f8f8f8;

    padding: 18px;

    border-radius: 15px;

    margin-top: 15px;
}


.request-title {

    color: #555;

    font-size: 18px;

    font-weight: bold;

    margin-bottom: 12px;
}


/* =====================================================
   EMPTY
===================================================== */

.empty {

    grid-column: 1 / -1;

    background: white;

    padding: 60px 30px;

    border-radius: 20px;

    text-align: center;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.1);
}


.empty h2 {

    color: #8e0e00;

    margin-bottom: 10px;
}


.empty p {

    color: #777;

    font-size: 16px;
}


/* =====================================================
   FOOTER
===================================================== */

.footer {

    text-align: center;

    padding: 30px;

    color: #888;

    font-size: 14px;
}


/* =====================================================
   MOBILE
===================================================== */

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


    .response-header {

        flex-direction: column;

        align-items: flex-start;
    }

}

</style>

</head>


<body>


<!-- =====================================================
     NAVBAR
===================================================== -->

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



<!-- =====================================================
     MAIN
===================================================== -->

<div class="container">


    <h1 class="title">

        Donor Responses

    </h1>


    <p class="subtitle">

        View donor responses and administrator
        actions related to your blood requests.

    </p>



    <div class="responses-grid">


<%

    if (responses != null &&
        !responses.isEmpty()) {


        for (String[] r : responses) {


            /*
             * =================================================
             * DONOR ARRAY STRUCTURE
             * =================================================
             *
             * r[0]  = TYPE
             * r[1]  = Response ID
             * r[2]  = Request ID
             * r[3]  = Donor ID
             * r[4]  = Donor Name
             * r[5]  = Donor Email
             * r[6]  = Donor Phone
             * r[7]  = Blood Group
             * r[8]  = Age
             * r[9]  = Gender
             * r[10] = City
             * r[11] = Response Status
             * r[12] = Response Date
             * r[13] = Requested Blood Group
             * r[14] = Units Required
             * r[15] = Requested City
             *
             *
             * =================================================
             * ADMIN ARRAY STRUCTURE
             * =================================================
             *
             * r[0]  = TYPE
             * r[1]  = -
             * r[2]  = Request ID
             * r[3]  = Admin ID
             * r[4]  = Admin Name
             * r[5]  = Admin Email
             * r[6]  = System
             * r[7]  = Blood Group
             * r[8]  = -
             * r[9]  = -
             * r[10] = System
             * r[11] = Admin Action
             * r[12] = Action Date
             * r[13] = Blood Group
             * r[14] = Units Required
             * r[15] = Request City
             */


            String type =
                r[0];


            /* =================================================
               DONOR RESPONSE
            ================================================= */

            if ("DONOR".equalsIgnoreCase(type)) {


                String responseStatus =
                    r[11];


                String statusClass =
                    "declined";


                if ("ACCEPTED"
                    .equalsIgnoreCase(responseStatus)) {

                    statusClass =
                        "accepted";
                }

%>


        <!-- =================================================
             DONOR RESPONSE CARD
        ================================================= -->


        <div class="response-card">


            <!-- HEADER -->

            <div class="response-header">


                <div class="response-title">

                    Donor Response

                </div>


                <span
                    class="status <%= statusClass %>">

                    <%= responseStatus %>

                </span>


            </div>



            <!-- =================================================
                 DONOR DETAILS
            ================================================= -->

            <div class="section donor-section">


                <div class="section-title donor-title">

                    Donor Details

                </div>


                <div class="info">

                    <strong>
                        Response ID:
                    </strong>

                    <%= r[1] %>

                </div>


                <div class="info">

                    <strong>
                        Request ID:
                    </strong>

                    <%= r[2] %>

                </div>


                <div class="info">

                    <strong>
                        Donor ID:
                    </strong>

                    <%= r[3] %>

                </div>


                <div class="info">

                    <strong>
                        Donor Name:
                    </strong>

                    <%= r[4] %>

                </div>


                <div class="info">

                    <strong>
                        Donor Email:
                    </strong>

                    <%= r[5] %>

                </div>


                <div class="info">

                    <strong>
                        Donor Phone:
                    </strong>

                    <%= r[6] %>

                </div>


                <div class="info">

                    <strong>
                        Blood Group:
                    </strong>

                    <span class="blood">

                        <%= r[7] %>

                    </span>

                </div>


                <div class="info">

                    <strong>
                        Age:
                    </strong>

                    <%= r[8] %>

                </div>


                <div class="info">

                    <strong>
                        Gender:
                    </strong>

                    <%= r[9] %>

                </div>


                <div class="info">

                    <strong>
                        City:
                    </strong>

                    <%= r[10] %>

                </div>


                <div class="info">

                    <strong>
                        Response Date:
                    </strong>

                    <%= r[12] %>

                </div>


            </div>



            <!-- =================================================
                 REQUEST DETAILS
            ================================================= -->

            <div class="request-details">


                <div class="request-title">

                    Your Request

                </div>


                <div class="info">

                    <strong>
                        Required Blood:
                    </strong>

                    <span class="blood">

                        <%= r[13] %>

                    </span>

                </div>


                <div class="info">

                    <strong>
                        Units Required:
                    </strong>

                    <%= r[14] %>

                </div>


                <div class="info">

                    <strong>
                        Request City:
                    </strong>

                    <%= r[15] %>

                </div>


            </div>


        </div>


<%

            }


            /* =================================================
               ADMIN ACTION
            ================================================= */

            else if ("ADMIN".equalsIgnoreCase(type)) {


                String adminAction =
                    r[11];


                String adminStatusClass =
                    "admin-completed";


                if ("APPROVED"
                    .equalsIgnoreCase(adminAction)) {

                    adminStatusClass =
                        "admin-approved";

                } else if (
                    "REJECTED"
                    .equalsIgnoreCase(adminAction)
                ) {

                    adminStatusClass =
                        "admin-rejected";

                } else if (
                    "COMPLETED"
                    .equalsIgnoreCase(adminAction)
                ) {

                    adminStatusClass =
                        "admin-completed";
                }

%>


        <!-- =================================================
             ADMIN ACTION CARD
        ================================================= -->


        <div class="response-card">


            <!-- HEADER -->

            <div class="response-header">


                <div class="response-title">

                    Admin Action

                </div>


                <span
                    class="status <%= adminStatusClass %>">

                    <%= adminAction %>

                </span>


            </div>



            <!-- =================================================
                 ADMIN DETAILS
            ================================================= -->

            <div class="section admin-section">


                <div class="section-title admin-title">

                    Administrator Details

                </div>


                <div class="info">

                    <strong>
                        Request ID:
                    </strong>

                    <%= r[2] %>

                </div>


                <div class="info">

                    <strong>
                        Admin ID:
                    </strong>

                    <%= r[3] %>

                </div>


                <div class="info">

                    <strong>
                        Admin Name:
                    </strong>

                    <%= r[4] %>

                </div>


                <div class="info">

                    <strong>
                        Admin Email:
                    </strong>

                    <%= r[5] %>

                </div>


                <div class="info">

                    <strong>
                        Action:
                    </strong>

                    <%= adminAction %>

                </div>


                <div class="info">

                    <strong>
                        Action Date:
                    </strong>

                    <%= r[12] %>

                </div>


            </div>



            <!-- =================================================
                 REQUEST DETAILS
            ================================================= -->

            <div class="request-details">


                <div class="request-title">

                    Request Information

                </div>


                <div class="info">

                    <strong>
                        Required Blood:
                    </strong>

                    <span class="blood">

                        <%= r[13] %>

                    </span>

                </div>


                <div class="info">

                    <strong>
                        Units Required:
                    </strong>

                    <%= r[14] %>

                </div>


                <div class="info">

                    <strong>
                        Request City:
                    </strong>

                    <%= r[15] %>

                </div>


            </div>


        </div>


<%

            }

        }


    } else {

%>


        <!-- =================================================
             NO RESPONSE
        ================================================= -->


        <div class="empty">


            <h2>

                No Responses Yet

            </h2>


            <p>

                No donor or administrator response
                is available for your requests yet.

            </p>


        </div>


<%

    }

%>


    </div>


</div>



<!-- =====================================================
     FOOTER
===================================================== -->

<div class="footer">

    © 2026 Blood Donor Finder System

</div>


</body>

</html>