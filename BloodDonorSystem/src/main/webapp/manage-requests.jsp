<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>

<%
    // =========================================================
    // ADMIN LOGIN CHECK
    // =========================================================

    if (session.getAttribute("adminId") == null) {

        response.sendRedirect("admin-login.jsp");

        return;
    }


    // =========================================================
    // GET REQUEST LIST
    // =========================================================

    List<String[]> requests =
        (List<String[]>)
        request.getAttribute("requests");

%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Manage Blood Requests - Admin</title>


<style>

/* =========================================================
   GLOBAL
========================================================= */

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


/* =========================================================
   NAVBAR
========================================================= */

.navbar {

    height: 72px;

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
        0 5px 18px
        rgba(0,0,0,0.20);
}


.logo {

    font-size: 24px;

    font-weight: bold;
}


.nav-right {

    display: flex;

    align-items: center;

    gap: 15px;
}


.dashboard-btn {

    background: white;

    color: #c31432;

    text-decoration: none;

    padding: 10px 18px;

    border-radius: 22px;

    font-weight: bold;

    transition: 0.3s;
}


.dashboard-btn:hover {

    transform: translateY(-2px);

    background: #ffe5e5;
}


.logout-btn {

    background:
        rgba(255,255,255,0.18);

    color: white;

    text-decoration: none;

    padding: 10px 18px;

    border-radius: 22px;

    font-weight: bold;

    transition: 0.3s;
}


.logout-btn:hover {

    background:
        rgba(255,255,255,0.30);

    transform: translateY(-2px);
}


/* =========================================================
   MAIN
========================================================= */

.container {

    width: 94%;

    max-width: 1400px;

    margin: 40px auto;
}


/* =========================================================
   HEADER
========================================================= */

.page-header {

    background: white;

    padding: 28px;

    border-radius: 20px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.10);

    margin-bottom: 25px;

    border-top:
        5px solid #c31432;
}


.page-header h1 {

    margin: 0 0 10px;

    color: #8e0e00;

    font-size: 32px;
}


.page-header p {

    margin: 0;

    color: #666;

    font-size: 16px;

    line-height: 1.6;
}


/* =========================================================
   MESSAGE
========================================================= */

.message {

    max-width: 850px;

    margin:
        0 auto 25px;

    padding: 15px 20px;

    border-radius: 12px;

    text-align: center;

    font-weight: bold;

    font-size: 15px;
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


/* =========================================================
   REQUEST GRID
========================================================= */

.requests-grid {

    display: grid;

    grid-template-columns:
        repeat(
            auto-fit,
            minmax(340px, 1fr)
        );

    gap: 25px;
}


/* =========================================================
   REQUEST CARD
========================================================= */

.request-card {

    background: white;

    padding: 25px;

    border-radius: 20px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.10);

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


/* =========================================================
   EMERGENCY CARD
========================================================= */

.emergency-card {

    border-left:
        6px solid #8e0e00;

    background:
        linear-gradient(
            135deg,
            #ffffff,
            #fff2f2
        );
}


/* =========================================================
   EMERGENCY BADGE
========================================================= */

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


/* =========================================================
   REQUEST HEADER
========================================================= */

.request-header {

    display: flex;

    justify-content: space-between;

    align-items: center;

    gap: 15px;

    margin-bottom: 20px;
}


.request-id {

    font-size: 21px;

    font-weight: bold;

    color: #8e0e00;
}


/* =========================================================
   STATUS
========================================================= */

.status {

    display: inline-block;

    padding: 7px 13px;

    border-radius: 20px;

    font-size: 12px;

    font-weight: bold;

    white-space: nowrap;
}


.status-pending {

    background: #fff3cd;

    color: #856404;
}


.status-approved {

    background: #d4edda;

    color: #155724;
}


.status-rejected {

    background: #f8d7da;

    color: #721c24;
}


.status-completed {

    background: #cce5ff;

    color: #004085;
}


/* =========================================================
   INFORMATION
========================================================= */

.info {

    margin: 12px 0;

    color: #555;

    font-size: 15px;

    line-height: 1.5;
}


.info strong {

    color: #333;
}


/* =========================================================
   BLOOD GROUP
========================================================= */

.blood {

    display: inline-block;

    padding: 6px 13px;

    background: #ffe1e1;

    color: #c31432;

    border-radius: 20px;

    font-weight: bold;

    margin-left: 4px;
}


/* =========================================================
   ACTION SECTION
========================================================= */

.action-section {

    margin-top: 23px;

    padding-top: 20px;

    border-top:
        1px solid #eee;
}


.action-title {

    color: #555;

    font-size: 14px;

    font-weight: bold;

    margin-bottom: 13px;
}


.action-buttons {

    display: flex;

    gap: 10px;
}


.action-buttons form {

    flex: 1;

    margin: 0;
}


.action-btn {

    width: 100%;

    padding: 11px;

    border: none;

    border-radius: 22px;

    font-size: 14px;

    font-weight: bold;

    cursor: pointer;

    transition: 0.3s;
}


.approve-btn {

    background:
        linear-gradient(
            135deg,
            #198754,
            #28a745
        );

    color: white;
}


.reject-btn {

    background:
        linear-gradient(
            135deg,
            #b02a37,
            #dc3545
        );

    color: white;
}


.complete-btn {

    background:
        linear-gradient(
            135deg,
            #0d6efd,
            #3d8bfd
        );

    color: white;
}


.action-btn:hover {

    transform:
        translateY(-3px);

    box-shadow:
        0 7px 16px
        rgba(0,0,0,0.18);
}


/* =========================================================
   NO ACTION
========================================================= */

.no-action {

    margin-top: 23px;

    padding-top: 18px;

    border-top:
        1px solid #eee;

    color: #777;

    font-size: 14px;

    text-align: center;
}


/* =========================================================
   EMPTY
========================================================= */

.empty-box {

    grid-column: 1 / -1;

    background: white;

    padding: 60px 30px;

    border-radius: 20px;

    text-align: center;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.10);
}


.empty-box h2 {

    color: #8e0e00;

    margin-bottom: 10px;
}


.empty-box p {

    color: #777;

    margin: 0;
}


/* =========================================================
   FOOTER
========================================================= */

.footer {

    text-align: center;

    padding: 30px;

    color: #888;

    font-size: 14px;
}


/* =========================================================
   MOBILE
========================================================= */

@media (max-width: 700px) {

    .navbar {

        padding: 0 18px;

    }


    .logo {

        font-size: 18px;

    }


    .dashboard-btn,
    .logout-btn {

        padding:
            8px 12px;

        font-size: 12px;

    }


    .container {

        width: 90%;

    }


    .page-header h1 {

        font-size: 27px;

    }


    .request-header {

        flex-direction: column;

        align-items: flex-start;

    }


    .action-buttons {

        flex-direction: column;

    }

}

</style>

</head>


<body>


<!-- =========================================================
     NAVBAR
========================================================= -->

<div class="navbar">


    <div class="logo">

        Blood Donor Finder - Admin

    </div>


    <div class="nav-right">


        <a
            href="adminDashboard"
            class="dashboard-btn">

            Dashboard

        </a>


        <a
            href="adminLogout"
            class="logout-btn">

            Logout

        </a>


    </div>


</div>



<!-- =========================================================
     MAIN
========================================================= -->

<div class="container">


    <!-- PAGE HEADER -->

    <div class="page-header">


        <h1>

            Manage Blood Requests

        </h1>


        <p>

            Review blood requests and manage
            their approval, rejection and completion.

        </p>


    </div>



    <!-- =====================================================
         SUCCESS / ERROR MESSAGES
    ====================================================== -->


<%

    String success =
        request.getParameter("success");


    String error =
        request.getParameter("error");


    if ("approved".equalsIgnoreCase(success)) {

%>


        <div class="message success">

            Blood request approved successfully.

        </div>


<%

    } else if ("rejected".equalsIgnoreCase(success)) {

%>


        <div class="message success">

            Blood request rejected successfully.

        </div>


<%

    } else if ("completed".equalsIgnoreCase(success)) {

%>


        <div class="message success">

            Blood request completed successfully
            and blood inventory has been updated.

        </div>


<%

    } else if ("updated".equalsIgnoreCase(success)) {

%>


        <div class="message success">

            Request status updated successfully.

        </div>


<%

    }


    // ==========================================
    // ERRORS
    // ==========================================


    if ("insufficientStock".equalsIgnoreCase(error)) {

%>


        <div class="message error">

            Cannot complete the request because
            there are not enough blood units in inventory.

        </div>


<%

    } else if ("noInventory"
            .equalsIgnoreCase(error)) {

%>


        <div class="message error">

            No inventory record exists for the
            requested blood group.

        </div>


<%

    } else if ("mustApprove"
            .equalsIgnoreCase(error)) {

%>


        <div class="message error">

            A request must be approved before
            it can be completed.

        </div>


<%

    } else if ("alreadyCompleted"
            .equalsIgnoreCase(error)) {

%>


        <div class="message error">

            This request has already been completed.

        </div>


<%

    } else if ("notFound"
            .equalsIgnoreCase(error)) {

%>


        <div class="message error">

            Request not found.

        </div>


<%

    } else if ("invalid"
            .equalsIgnoreCase(error)) {

%>


        <div class="message error">

            Invalid request information.

        </div>


<%

    } else if ("database"
            .equalsIgnoreCase(error)) {

%>


        <div class="message error">

            A database error occurred.
            Please try again.

        </div>


<%

    } else if ("update"
            .equalsIgnoreCase(error)) {

%>


        <div class="message error">

            Request status could not be updated.

        </div>


<%

    }

%>



    <!-- =====================================================
         REQUEST GRID
    ====================================================== -->

    <div class="requests-grid">


<%

    if (requests != null &&
        !requests.isEmpty()) {


        for (String[] r : requests) {


            /*
             * =================================================
             * EXPECTED ARRAY STRUCTURE
             * =================================================
             *
             * r[0] = request_id
             * r[1] = requester_id
             * r[2] = requester_name
             * r[3] = blood_group
             * r[4] = units_required
             * r[5] = city
             * r[6] = status
             * r[7] = request_date
             * r[8] = emergency
             */


            String requestId =
                r[0];


            String requesterId =
                r[1];


            String requesterName =
                r[2];


            String bloodGroup =
                r[3];


            String units =
                r[4];


            String city =
                r[5];


            String status =
                r[6];


            String requestDate =
                r[7];


            boolean emergency =
                false;


            if (r.length > 8) {

                emergency =
                    "true".equalsIgnoreCase(
                        r[8]
                    );
            }


            // ==========================================
            // STATUS CLASS
            // ==========================================

            String statusClass =
                "status-pending";


            if ("APPROVED"
                    .equalsIgnoreCase(status)) {

                statusClass =
                    "status-approved";

            } else if (
                "REJECTED"
                    .equalsIgnoreCase(status)
            ) {

                statusClass =
                    "status-rejected";

            } else if (
                "COMPLETED"
                    .equalsIgnoreCase(status)
            ) {

                statusClass =
                    "status-completed";
            }

%>


        <!-- =================================================
             REQUEST CARD
        ================================================== -->

        <div class="
            request-card
            <%= emergency
                ? "emergency-card"
                : "" %>
        ">


<%
            // ==========================================
            // EMERGENCY BADGE
            // ==========================================

            if (emergency) {
%>


            <div class="emergency-badge">

                EMERGENCY REQUEST

            </div>


<%
            }
%>


            <!-- ==========================================
                 REQUEST HEADER
            =========================================== -->

            <div class="request-header">


                <div class="request-id">

                    Request #<%= requestId %>

                </div>


                <span
                    class="
                        status
                        <%= statusClass %>
                    ">

                    <%= status %>

                </span>


            </div>



            <!-- ==========================================
                 REQUESTER
            =========================================== -->

            <div class="info">

                <strong>
                    Requester ID:
                </strong>

                <%= requesterId %>

            </div>


            <div class="info">

                <strong>
                    Requester Name:
                </strong>

                <%= requesterName %>

            </div>



            <!-- ==========================================
                 BLOOD GROUP
            =========================================== -->

            <div class="info">

                <strong>
                    Blood Group:
                </strong>

                <span class="blood">

                    <%= bloodGroup %>

                </span>

            </div>



            <!-- ==========================================
                 UNITS
            =========================================== -->

            <div class="info">

                <strong>
                    Units Required:
                </strong>

                <%= units %>

            </div>



            <!-- ==========================================
                 CITY
            =========================================== -->

            <div class="info">

                <strong>
                    City:
                </strong>

                <%= city %>

            </div>



            <!-- ==========================================
                 REQUEST DATE
            =========================================== -->

            <div class="info">

                <strong>
                    Request Date:
                </strong>

                <%= requestDate %>

            </div>



            <!-- ==========================================
                 ADMIN ACTIONS
            =========================================== -->


<%
    if ("PENDING"
        .equalsIgnoreCase(status)) {
%>


            <div class="action-section">


                <div class="action-title">

                    Admin Actions

                </div>


                <div class="action-buttons">


                    <!-- APPROVE -->

                    <form
                        action="updateRequestStatus"
                        method="post">


                        <input
                            type="hidden"
                            name="requestId"
                            value="<%= requestId %>"
                        >


                        <input
                            type="hidden"
                            name="status"
                            value="APPROVED"
                        >


                        <button
                            type="submit"
                            class="action-btn approve-btn">

                            Approve

                        </button>


                    </form>



                    <!-- REJECT -->

                    <form
                        action="updateRequestStatus"
                        method="post">


                        <input
                            type="hidden"
                            name="requestId"
                            value="<%= requestId %>"
                        >


                        <input
                            type="hidden"
                            name="status"
                            value="REJECTED"
                        >


                        <button
                            type="submit"
                            class="action-btn reject-btn">

                            Reject

                        </button>


                    </form>


                </div>


            </div>


<%
    } else if (
        "APPROVED"
        .equalsIgnoreCase(status)
    ) {
%>


            <div class="action-section">


                <div class="action-title">

                    Admin Actions

                </div>


                <div class="action-buttons">


                    <!-- COMPLETE -->

                    <form
                        action="updateRequestStatus"
                        method="post">


                        <input
                            type="hidden"
                            name="requestId"
                            value="<%= requestId %>"
                        >


                        <input
                            type="hidden"
                            name="status"
                            value="COMPLETED"
                        >


                        <button
                            type="submit"
                            class="action-btn complete-btn">

                            Complete

                        </button>


                    </form>


                </div>


            </div>


<%
    } else {
%>


            <div class="no-action">

                No further admin action required.

            </div>


<%
    }
%>


        </div>


<%

        }

    } else {

%>


        <!-- =================================================
             EMPTY
        ================================================== -->

        <div class="empty-box">


            <h2>

                No Blood Requests Found

            </h2>


            <p>

                There are currently no blood requests
                available for administration.

            </p>


        </div>


<%

    }

%>


    </div>


</div>



<!-- =========================================================
     FOOTER
========================================================= -->

<div class="footer">

    © 2026 Blood Donor Finder System

</div>


</body>

</html>