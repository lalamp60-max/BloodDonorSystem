<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.blooddonor.model.Notification" %>

<%
    if (session.getAttribute("userId") == null) {

        response.sendRedirect("login.jsp");
        return;
    }

    List<Notification> notifications =
        (List<Notification>)
        request.getAttribute("notifications");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Notifications - Blood Donor Finder</title>

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


/* =========================================
   NAVBAR
========================================= */

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
}


/* =========================================
   MAIN
========================================= */

.container {

    width: 92%;

    max-width: 850px;

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

    margin-bottom: 30px;
}


/* =========================================
   NOTIFICATION CARD
========================================= */

.notification {

    background: white;

    padding: 20px;

    border-radius: 18px;

    margin-bottom: 15px;

    display: flex;

    justify-content: space-between;

    align-items: center;

    gap: 20px;

    border-left: 5px solid #c31432;

    box-shadow:
        0 8px 20px
        rgba(0,0,0,0.08);

    transition: 0.3s;
}

.notification:hover {

    transform: translateY(-3px);

    box-shadow:
        0 12px 28px
        rgba(0,0,0,0.12);
}


.notification.unread {

    background: #fff7f7;

    border-left: 6px solid #8e0e00;
}


.notification.read {

    opacity: 0.75;

    border-left-color: #bbb;
}


/* =========================================
   CONTENT
========================================= */

.message {

    color: #333;

    font-size: 16px;

    line-height: 1.5;
}

.date {

    color: #888;

    font-size: 13px;

    margin-top: 7px;
}


/* =========================================
   STATUS
========================================= */

.badge {

    display: inline-block;

    padding: 6px 10px;

    border-radius: 15px;

    font-size: 11px;

    font-weight: bold;

    margin-bottom: 8px;
}

.unread-badge {

    background: #ffe1e1;

    color: #8e0e00;
}


/* =========================================
   BUTTON
========================================= */

.read-btn {

    padding: 9px 15px;

    border: none;

    border-radius: 20px;

    background: #c31432;

    color: white;

    font-weight: bold;

    cursor: pointer;
}


/* =========================================
   EMPTY
========================================= */

.empty {

    background: white;

    padding: 50px 30px;

    border-radius: 20px;

    text-align: center;

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


/* =========================================
   FOOTER
========================================= */

.footer {

    text-align: center;

    padding: 30px;

    color: #888;

    font-size: 14px;
}


/* =========================================
   MOBILE
========================================= */

@media (max-width: 600px) {

    .navbar {

        padding: 0 20px;
    }

    .logo {

        font-size: 18px;
    }

    .notification {

        flex-direction: column;

        align-items: flex-start;
    }

    .read-btn {

        width: 100%;
    }
}

</style>

</head>


<body>


<!-- NAVBAR -->

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



<!-- MAIN -->

<div class="container">

    <h1 class="title">

        Notifications

    </h1>


    <p class="subtitle">

        Stay updated about your blood requests
        and donor responses.

    </p>


<%

    if (notifications != null &&
        !notifications.isEmpty()) {


        for (
            Notification notification :
            notifications
        ) {

%>


        <div class="
            notification
            <%= notification.isRead()
                ? "read"
                : "unread" %>
        ">


            <div>


                <%
                    if (!notification.isRead()) {
                %>

                    <div class="badge unread-badge">

                        UNREAD

                    </div>

                <%
                    }
                %>


                <div class="message">

                    <%= notification.getMessage() %>

                </div>


                <div class="date">

                    <%= notification.getCreatedAt() %>

                </div>


                <div class="date">

                    Request ID:
                    <%= notification.getRequestId() %>

                </div>


            </div>


            <%
                if (!notification.isRead()) {
            %>


                <form
                    action="markNotificationRead"
                    method="post">


                    <input
                        type="hidden"
                        name="notificationId"
                        value="<%= notification.getNotificationId() %>"
                    >


                    <button
                        type="submit"
                        class="read-btn">

                        Mark as Read

                    </button>


                </form>


            <%
                }
            %>


        </div>


<%

        }

    } else {

%>


        <div class="empty">

            <h2>
                No Notifications
            </h2>

            <p>
                You don't have any notifications yet.
            </p>

        </div>


<%

    }

%>


</div>



<div class="footer">

    © 2026 Blood Donor Finder System

</div>


</body>

</html>