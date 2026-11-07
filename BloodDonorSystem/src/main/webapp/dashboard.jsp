<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.blooddonor.util.DBConnection" %>
<%
    // =====================================================
    // LOGIN CHECK
    // =====================================================

    String userName =
            (String) session.getAttribute("userName");

    if (userName == null) {

        response.sendRedirect("login.jsp");

        return;
    }


    // =====================================================
    // GET LOGGED-IN USER ID
    // =====================================================

    Integer userIdObj =
            (Integer) session.getAttribute("userId");

    if (userIdObj == null) {

        response.sendRedirect("login.jsp");

        return;
    }


    int userId =
            userIdObj;


    // =====================================================
    // UNREAD NOTIFICATION COUNT
    // =====================================================

    int unreadCount = 0;

    Connection notificationCon = null;

    PreparedStatement countPs = null;

    ResultSet countRs = null;


    try {

        notificationCon =
                DBConnection.getConnection();


        String countSql =
                "SELECT COUNT(*) AS total " +
                "FROM notifications " +
                "WHERE user_id = ? " +
                "AND is_read = FALSE";


        countPs =
                notificationCon.prepareStatement(
                        countSql
                );


        countPs.setInt(
                1,
                userId
        );


        countRs =
                countPs.executeQuery();


        if (countRs.next()) {

            unreadCount =
                    countRs.getInt("total");
        }


    } catch (Exception e) {

        e.printStackTrace();

        unreadCount = 0;

    } finally {

        try {

            if (countRs != null) {
                countRs.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }


        try {

            if (countPs != null) {
                countPs.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }


        try {

            if (notificationCon != null) {
                notificationCon.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>
    Blood Donor Finder - Dashboard
</title>


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

    min-height: 70px;

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
        rgba(0,0,0,0.20);

}


.logo {

    font-size: 24px;

    font-weight: bold;

}


.user-area {

    display: flex;

    align-items: center;

    gap: 20px;

}


.user-name {

    font-size: 16px;

    font-weight: 500;

}


.logout {

    padding: 9px 18px;

    background: white;

    color: #c31432;

    text-decoration: none;

    border-radius: 20px;

    font-weight: bold;

    transition: 0.3s;

}


.logout:hover {

    background: #ffe5e5;

    transform:
        translateY(-2px);

}


/* =====================================================
   MAIN
===================================================== */

.main {

    padding: 40px;

}


/* =====================================================
   WELCOME
===================================================== */

.welcome {

    background: white;

    padding: 30px;

    border-radius: 20px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.10);

    margin-bottom: 30px;

}


.welcome h1 {

    margin:
        0 0 10px;

    color: #8e0e00;

    font-size: 36px;

}


.welcome p {

    margin: 0;

    color: #666;

    font-size: 17px;

    line-height: 1.6;

}


/* =====================================================
   DASHBOARD GRID
===================================================== */

.dashboard-grid {

    display: grid;

    grid-template-columns:
        repeat(
            auto-fit,
            minmax(230px, 1fr)
        );

    gap: 25px;

}


/* =====================================================
   CARD
===================================================== */

.card {

    background: white;

    padding: 30px;

    border-radius: 20px;

    text-decoration: none;

    color: #333;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.10);

    transition: 0.3s;

    border-top:
        5px solid #c31432;

    min-height: 300px;

    display: block;

    position: relative;

}


.card:hover {

    transform:
        translateY(-8px);

    box-shadow:
        0 15px 35px
        rgba(0,0,0,0.18);

}


/* =====================================================
   CARD ICON
===================================================== */

.card-icon {

    font-size: 48px;

    margin-bottom: 18px;

    height: 60px;

    display: flex;

    align-items: center;

}


/* =====================================================
   CARD TITLE
===================================================== */

.card h2 {

    margin:
        0 0 12px;

    color: #8e0e00;

    font-size: 22px;

}


/* =====================================================
   CARD DESCRIPTION
===================================================== */

.card p {

    margin: 0;

    color: #777;

    line-height: 1.6;

    font-size: 15px;

}


/* =====================================================
   NOTIFICATION CARD
===================================================== */

.notification-card {

    border-top:
        5px solid #c31432;

}


/* =====================================================
   NOTIFICATION COUNT
===================================================== */

.notification-badge {

    position: absolute;

    top: 20px;

    right: 20px;

    min-width: 30px;

    height: 30px;

    padding:
        0 8px;

    background:
        #c31432;

    color: white;

    border-radius: 50px;

    display: flex;

    align-items: center;

    justify-content: center;

    font-size: 13px;

    font-weight: bold;

    box-shadow:
        0 4px 10px
        rgba(195,20,50,0.30);

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

        padding:
            15px 20px;

    }


    .logo {

        font-size: 19px;

    }


    .user-area {

        gap: 10px;

    }


    .user-name {

        font-size: 14px;

    }


    .logout {

        padding:
            8px 14px;

    }


    .main {

        padding:
            25px 18px;

    }


    .welcome h1 {

        font-size: 28px;

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

        🩸 Blood Donor Finder

    </div>


    <div class="user-area">


        <div class="user-name">

            👤 Welcome,
            <%= userName %>

        </div>


        <a
            href="logout"
            class="logout">

            Logout

        </a>


    </div>


</div>



<!-- =====================================================
     MAIN
===================================================== -->

<div class="main">


    <!-- =================================================
         WELCOME SECTION
    ================================================== -->

    <div class="welcome">


        <h1>

            Welcome to Dashboard,
            <%= userName %> ❤️

        </h1>


        <p>

            Manage blood donors, search for donors,
            create blood requests, view pending
            requests and manage donor responses.

        </p>


    </div>



    <!-- =================================================
         DASHBOARD CARDS
    ================================================== -->

    <div class="dashboard-grid">


        <!-- ==============================================
             ADD DONOR
        =============================================== -->

        <a
            href="add-donor.jsp"
            class="card">


            <div class="card-icon">

                🩸

            </div>


            <h2>

                Add Donor

            </h2>


            <p>

                Register a donor and add blood group,
                age, gender and city details.

            </p>


        </a>



        <!-- ==============================================
             SEARCH DONOR
        =============================================== -->

        <a
            href="search-donor.jsp"
            class="card">


            <div class="card-icon">

                🔍

            </div>


            <h2>

                Search Donor

            </h2>


            <p>

                Find available blood donors based
                on blood group and location.

            </p>


        </a>



        <!-- ==============================================
             CREATE BLOOD REQUEST
        =============================================== -->

        <a
            href="create-request.jsp"
            class="card">


            <div class="card-icon">

                🆘

            </div>


            <h2>

                Create Blood Request

            </h2>


            <p>

                Create a new blood request when
                blood is urgently required.

            </p>


        </a>



        <!-- ==============================================
             MY REQUESTS
        =============================================== -->

        <a
            href="myRequests"
            class="card">


            <div class="card-icon">

                📋

            </div>


            <h2>

                My Requests

            </h2>


            <p>

                View and track your submitted
                blood requests and their status.

            </p>


        </a>



        <!-- ==============================================
             VIEW PENDING REQUESTS
        =============================================== -->

        <a
            href="viewPendingRequests"
            class="card">


            <div class="card-icon">

                🔎

            </div>


            <h2>

                View Pending Requests

            </h2>


            <p>

                View blood requests from other users
                and respond to them.

            </p>


        </a>



        <!-- ==============================================
             DONOR RESPONSES
        =============================================== -->

        <a
            href="myDonorResponses"
            class="card">


            <div class="card-icon">

                ❤️

            </div>


            <h2>

                Donor Responses

            </h2>


            <p>

                View donors who responded to
                your blood requests.

            </p>


        </a>



        <!-- ==============================================
             NOTIFICATIONS
        =============================================== -->

        <a
            href="notifications"
            class="card notification-card">


            <div class="card-icon">

                🔔

            </div>


            <h2>

                Notifications

            </h2>


            <p>

                View updates about donor responses
                and your blood requests.

            </p>


<%
    // =====================================================
    // UNREAD NOTIFICATION BADGE
    // =====================================================

    if (unreadCount > 0) {
%>


            <div class="notification-badge">

                <%= unreadCount %>

            </div>


<%
    }
%>


        </a>



        <!-- ==============================================
             MY PROFILE
        =============================================== -->

        <a
            href="profile"
            class="card">


            <div class="card-icon">

                👤

            </div>


            <h2>

                My Profile

            </h2>


            <p>

                View and manage your account
                and donor information.

            </p>


        </a>


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