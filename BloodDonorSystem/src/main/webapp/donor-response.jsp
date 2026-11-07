<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Integer requestId =
        (Integer) request.getAttribute("requestId");

    Integer donorId =
        (Integer) request.getAttribute("donorId");

    if (requestId == null || donorId == null) {
        response.sendRedirect("viewPendingRequests");
        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Respond to Blood Request</title>

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

    display: flex;

    justify-content: center;

    align-items: center;
}


/* ================= CARD ================= */

.response-card {

    width: 90%;

    max-width: 500px;

    background: white;

    padding: 40px;

    border-radius: 25px;

    box-shadow:
        0 15px 40px
        rgba(0,0,0,0.15);

    text-align: center;

}


/* ================= ICON ================= */

.icon {

    font-size: 65px;

    margin-bottom: 15px;

}


/* ================= TITLE ================= */

h1 {

    color: #8e0e00;

    margin-bottom: 10px;

}


.subtitle {

    color: #666;

    margin-bottom: 30px;

    line-height: 1.5;

}


/* ================= INFO ================= */

.info-box {

    background: #fff5f5;

    padding: 18px;

    border-radius: 15px;

    margin-bottom: 30px;

    text-align: left;

}


.info {

    margin: 10px 0;

    color: #555;

}


.info strong {

    color: #333;

}


/* ================= BUTTONS ================= */

.buttons {

    display: flex;

    gap: 15px;

}


.btn {

    flex: 1;

    padding: 14px;

    border: none;

    border-radius: 25px;

    font-size: 16px;

    font-weight: bold;

    cursor: pointer;

    transition: 0.3s;

}


.accept {

    background:
        linear-gradient(
            135deg,
            #11998e,
            #38ef7d
        );

    color: white;

}


.decline {

    background:
        linear-gradient(
            135deg,
            #8e0e00,
            #c31432
        );

    color: white;

}


.btn:hover {

    transform: translateY(-3px);

    box-shadow:
        0 8px 20px
        rgba(0,0,0,0.2);

}


/* ================= BACK ================= */

.back {

    display: inline-block;

    margin-top: 25px;

    color: #c31432;

    text-decoration: none;

    font-weight: bold;

}

</style>

</head>


<body>


<div class="response-card">


    <div class="icon">
        ❤️
    </div>


    <h1>
        Respond to Blood Request
    </h1>


    <p class="subtitle">

        Please choose whether you can help
        with this blood request.

    </p>


    <!-- ================= INFO ================= -->

    <div class="info-box">

        <div class="info">

            🆘

            <strong>
                Request ID:
            </strong>

            <%= requestId %>

        </div>


        <div class="info">

            🩸

            <strong>
                Your Donor ID:
            </strong>

            <%= donorId %>

        </div>

    </div>


    <!-- ================= FORM ================= -->

    <form action="donorResponse"
          method="post">

        <input
            type="hidden"
            name="requestId"
            value="<%= requestId %>"
        >


        <div class="buttons">


            <!-- ACCEPT -->

            <button
                type="submit"
                name="action"
                value="ACCEPT"
                class="btn accept">

                ❤️ Accept

            </button>


            <!-- DECLINE -->

            <button
                type="submit"
                name="action"
                value="DECLINE"
                class="btn decline">

                ❌ Decline

            </button>


        </div>

    </form>


    <a
        href="viewPendingRequests"
        class="back">

        ← Back to Pending Requests

    </a>


</div>


</body>

</html>