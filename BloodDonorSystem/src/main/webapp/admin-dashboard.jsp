<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>


<%

    // =====================================================
    // ADMIN LOGIN CHECK
    // =====================================================

    if (session.getAttribute("adminId") == null) {

        response.sendRedirect(
                "admin-login.jsp"
        );

        return;
    }


    // =====================================================
    // GET STATISTICS
    // =====================================================

    Integer totalUsersObj =
        (Integer)
        request.getAttribute(
                "totalUsers"
        );


    Integer totalDonorsObj =
        (Integer)
        request.getAttribute(
                "totalDonors"
        );


    Integer pendingRequestsObj =
        (Integer)
        request.getAttribute(
                "pendingRequests"
        );


    Integer approvedRequestsObj =
        (Integer)
        request.getAttribute(
                "approvedRequests"
        );


    Integer completedRequestsObj =
        (Integer)
        request.getAttribute(
                "completedRequests"
        );


    Integer rejectedRequestsObj =
        (Integer)
        request.getAttribute(
                "rejectedRequests"
        );


    Integer availableDonorsObj =
        (Integer)
        request.getAttribute(
                "availableDonors"
        );


    Integer totalBloodUnitsObj =
        (Integer)
        request.getAttribute(
                "totalBloodUnits"
        );


    int totalUsers =
        totalUsersObj != null
            ? totalUsersObj
            : 0;


    int totalDonors =
        totalDonorsObj != null
            ? totalDonorsObj
            : 0;


    int pendingRequests =
        pendingRequestsObj != null
            ? pendingRequestsObj
            : 0;


    int approvedRequests =
        approvedRequestsObj != null
            ? approvedRequestsObj
            : 0;


    int completedRequests =
        completedRequestsObj != null
            ? completedRequestsObj
            : 0;


    int rejectedRequests =
        rejectedRequestsObj != null
            ? rejectedRequestsObj
            : 0;


    int availableDonors =
        availableDonorsObj != null
            ? availableDonorsObj
            : 0;


    int totalBloodUnits =
        totalBloodUnitsObj != null
            ? totalBloodUnitsObj
            : 0;


    // =====================================================
    // INVENTORY
    // =====================================================

    List<String[]> inventory =
        (List<String[]>)
        request.getAttribute(
                "inventory"
        );

%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Admin Dashboard - Blood Donor Finder</title>


<style>

/* =====================================================
   GLOBAL
===================================================== */

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

    font-size: 25px;

    font-weight: bold;
}


.admin-area {

    display: flex;

    align-items: center;

    gap: 18px;
}


.admin-text {

    font-size: 15px;
}


.logout {

    background: white;

    color: #c31432;

    text-decoration: none;

    padding: 9px 18px;

    border-radius: 22px;

    font-weight: bold;

    transition: 0.3s;
}


.logout:hover {

    transform: translateY(-2px);

    background: #ffe5e5;
}


/* =====================================================
   MAIN
===================================================== */

.container {

    width: 94%;

    max-width: 1400px;

    margin: 40px auto;
}


/* =====================================================
   PAGE HEADER
===================================================== */

.page-header {

    margin-bottom: 30px;
}


.page-header h1 {

    margin: 0 0 8px;

    color: #8e0e00;

    font-size: 36px;
}


.page-header p {

    margin: 0;

    color: #666;

    font-size: 16px;
}


/* =====================================================
   STATISTICS GRID
===================================================== */

.stats-grid {

    display: grid;

    grid-template-columns:
        repeat(
            auto-fit,
            minmax(220px, 1fr)
        );

    gap: 22px;

    margin-bottom: 35px;
}


/* =====================================================
   STAT CARD
===================================================== */

.stat-card {

    background: white;

    padding: 25px;

    border-radius: 18px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.09);

    border-top:
        5px solid #c31432;

    transition: 0.3s;
}


.stat-card:hover {

    transform: translateY(-6px);

    box-shadow:
        0 14px 32px
        rgba(0,0,0,0.15);
}


.stat-title {

    color: #777;

    font-size: 15px;

    margin-bottom: 12px;
}


.stat-value {

    color: #8e0e00;

    font-size: 36px;

    font-weight: bold;
}


/* =====================================================
   SPECIAL STAT CARDS
===================================================== */

.pending-card {

    border-top-color: #ffc107;
}


.pending-card .stat-value {

    color: #856404;
}


.approved-card {

    border-top-color: #28a745;
}


.approved-card .stat-value {

    color: #155724;
}


.completed-card {

    border-top-color: #0d6efd;
}


.completed-card .stat-value {

    color: #004085;
}


.rejected-card {

    border-top-color: #dc3545;
}


.rejected-card .stat-value {

    color: #721c24;
}


/* =====================================================
   SECTION
===================================================== */

.section {

    background: white;

    padding: 28px;

    border-radius: 20px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.09);

    margin-bottom: 30px;
}


.section h2 {

    margin: 0 0 22px;

    color: #8e0e00;

    font-size: 25px;
}


/* =====================================================
   INVENTORY GRID
===================================================== */

.inventory-grid {

    display: grid;

    grid-template-columns:
        repeat(
            auto-fit,
            minmax(180px, 1fr)
        );

    gap: 18px;
}


.inventory-card {

    background:
        linear-gradient(
            135deg,
            #fff7f7,
            #fff0f0
        );

    padding: 20px;

    border-radius: 16px;

    border:
        1px solid #ffd6d6;

    transition: 0.3s;
}


.inventory-card:hover {

    transform: translateY(-4px);

    box-shadow:
        0 8px 20px
        rgba(0,0,0,0.10);
}


.inventory-group {

    font-size: 25px;

    font-weight: bold;

    color: #c31432;

    margin-bottom: 10px;
}


.inventory-units {

    font-size: 28px;

    font-weight: bold;

    color: #333;
}


.inventory-label {

    color: #777;

    font-size: 13px;

    margin-top: 4px;
}


.inventory-date {

    margin-top: 12px;

    color: #888;

    font-size: 12px;
}


/* =====================================================
   EMPTY INVENTORY
===================================================== */

.empty-inventory {

    text-align: center;

    padding: 35px;

    color: #777;
}


/* =====================================================
   ACTIONS
===================================================== */

.actions-grid {

    display: grid;

    grid-template-columns:
        repeat(
            auto-fit,
            minmax(220px, 1fr)
        );

    gap: 18px;
}


.action-card {

    display: block;

    padding: 20px;

    background: #fff7f7;

    border-radius: 15px;

    text-decoration: none;

    border-left:
        5px solid #c31432;

    color: #333;

    transition: 0.3s;
}


.action-card:hover {

    transform: translateY(-4px);

    background: #fff0f0;

    box-shadow:
        0 8px 20px
        rgba(0,0,0,0.10);
}


.action-card h3 {

    margin: 0 0 8px;

    color: #8e0e00;
}


.action-card p {

    margin: 0;

    color: #777;

    font-size: 14px;

    line-height: 1.5;
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

@media (max-width: 700px) {

    .navbar {

        padding: 0 18px;
    }


    .logo {

        font-size: 19px;
    }


    .admin-text {

        display: none;
    }


    .container {

        width: 90%;
    }


    .page-header h1 {

        font-size: 28px;
    }


    .section {

        padding: 20px;
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

        Blood Donor Finder - Admin

    </div>


    <div class="admin-area">


        <div class="admin-text">

            Admin Dashboard

        </div>


        <a
            href="adminLogout"
            class="logout">

            Logout

        </a>


    </div>

</div>



<!-- =====================================================
     MAIN
===================================================== -->

<div class="container">


    <!-- PAGE HEADER -->

    <div class="page-header">

        <h1>

            Admin Dashboard

        </h1>


        <p>

            Monitor users, donors, blood requests
            and blood inventory from one place.

        </p>

    </div>



    <!-- =================================================
         STATISTICS
    ================================================== -->

    <div class="stats-grid">


        <!-- TOTAL USERS -->

        <div class="stat-card">

            <div class="stat-title">

                Total Users

            </div>


            <div class="stat-value">

                <%= totalUsers %>

            </div>

        </div>


        <!-- TOTAL DONORS -->

        <div class="stat-card">

            <div class="stat-title">

                Total Donors

            </div>


            <div class="stat-value">

                <%= totalDonors %>

            </div>

        </div>


        <!-- AVAILABLE DONORS -->

        <div class="stat-card">

            <div class="stat-title">

                Available Donors

            </div>


            <div class="stat-value">

                <%= availableDonors %>

            </div>

        </div>


        <!-- BLOOD UNITS -->

        <div class="stat-card">

            <div class="stat-title">

                Available Blood Units

            </div>


            <div class="stat-value">

                <%= totalBloodUnits %>

            </div>

        </div>


        <!-- PENDING -->

        <div class="stat-card pending-card">

            <div class="stat-title">

                Pending Requests

            </div>


            <div class="stat-value">

                <%= pendingRequests %>

            </div>

        </div>


        <!-- APPROVED -->

        <div class="stat-card approved-card">

            <div class="stat-title">

                Approved Requests

            </div>


            <div class="stat-value">

                <%= approvedRequests %>

            </div>

        </div>


        <!-- COMPLETED -->

        <div class="stat-card completed-card">

            <div class="stat-title">

                Completed Requests

            </div>


            <div class="stat-value">

                <%= completedRequests %>

            </div>

        </div>


        <!-- REJECTED -->

        <div class="stat-card rejected-card">

            <div class="stat-title">

                Rejected Requests

            </div>


            <div class="stat-value">

                <%= rejectedRequests %>

            </div>

        </div>


    </div>



    <!-- =================================================
         BLOOD INVENTORY
    ================================================== -->

    <div class="section">


        <h2>

            Blood Inventory Overview

        </h2>


        <div class="inventory-grid">


<%

    if (inventory != null &&
        !inventory.isEmpty()) {


        for (String[] item : inventory) {

%>


            <div class="inventory-card">


                <div class="inventory-group">

                    <%= item[1] %>

                </div>


                <div class="inventory-units">

                    <%= item[2] %>

                </div>


                <div class="inventory-label">

                    Units Available

                </div>


                <div class="inventory-date">

                    Last Updated:
                    <%= item[3] %>

                </div>


            </div>


<%

        }

    } else {

%>


            <div class="empty-inventory">

                No blood inventory records found.

            </div>


<%

    }

%>


        </div>


    </div>



    <!-- =================================================
         QUICK ACTIONS
    ================================================== -->

    <div class="section">


        <h2>

            Quick Actions

        </h2>


        <div class="actions-grid">


            <!-- USERS -->

            <a
                href="manageUsers"
                class="action-card">


                <h3>

                    Manage Users

                </h3>


                <p>

                    View and manage registered users.

                </p>


            </a>



            <!-- DONORS -->

            <a
                href="manageDonors"
                class="action-card">


                <h3>

                    Manage Donors

                </h3>


                <p>

                    View and manage registered donors.

                </p>


            </a>



            <!-- REQUESTS -->

            <a
                href="manageRequests"
                class="action-card">


                <h3>

                    Manage Requests

                </h3>


                <p>

                    Approve, reject or complete
                    blood requests.

                </p>


            </a>



            <!-- RESPONSES -->

            <a
                href="manageResponses"
                class="action-card">


                <h3>

                    Manage Responses

                </h3>


                <p>

                    View donor responses to
                    blood requests.

                </p>


            </a>



            <!-- INVENTORY -->

            <a
                href="bloodInventory"
                class="action-card">


                <h3>

                    Blood Inventory

                </h3>


                <p>

                    Add or update available
                    blood units.

                </p>


            </a>


        </div>


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