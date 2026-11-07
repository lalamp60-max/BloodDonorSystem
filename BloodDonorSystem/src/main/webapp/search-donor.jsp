<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%

    // ==========================================
    // LOGIN CHECK
    // ==========================================

    String userName =
            (String)
            session.getAttribute(
                    "userName"
            );


    if (userName == null) {

        response.sendRedirect(
                "login.jsp"
        );

        return;
    }

%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Search Blood Donor</title>


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
            #ffe0e0
        );

}


/* ==========================================
   NAVBAR
========================================== */

.navbar {

    background:
        linear-gradient(
            135deg,
            #8e0e00,
            #c31432
        );

    color: white;

    padding: 18px 40px;

    display: flex;

    justify-content: space-between;

    align-items: center;

    box-shadow:
        0 5px 15px
        rgba(0,0,0,0.20);

}


.logo {

    font-size: 23px;

    font-weight: bold;

}


.back {

    color: white;

    text-decoration: none;

    background:
        rgba(255,255,255,0.18);

    padding: 9px 18px;

    border-radius: 20px;

    transition: 0.3s;

}


.back:hover {

    background:
        rgba(255,255,255,0.30);

    transform:
        translateY(-2px);

}


/* ==========================================
   MAIN
========================================== */

.container {

    width: 90%;

    max-width: 1050px;

    margin: 40px auto;

}


/* ==========================================
   SEARCH BOX
========================================== */

.search-box {

    background: white;

    padding: 32px;

    border-radius: 20px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.10);

    margin-bottom: 30px;

}


h1 {

    text-align: center;

    color: #c31432;

    margin-top: 0;

    margin-bottom: 10px;

}


.subtitle {

    text-align: center;

    color: #777;

    margin-bottom: 30px;

}


/* ==========================================
   FORM ROW
========================================== */

.form-row {

    display: flex;

    gap: 20px;

    flex-wrap: wrap;

}


.form-group {

    flex: 1;

    min-width: 220px;

}


label {

    display: block;

    font-weight: bold;

    margin-bottom: 8px;

    color: #444;

}


select,
input {

    width: 100%;

    padding: 12px 14px;

    border:
        1px solid #ddd;

    border-radius: 9px;

    font-size: 15px;

    outline: none;

    transition: 0.3s;

}


select:focus,
input:focus {

    border-color: #c31432;

    box-shadow:
        0 0 0 3px
        rgba(195,20,50,0.10);

}


/* ==========================================
   BUTTONS
========================================== */

.button-row {

    display: flex;

    gap: 15px;

    margin-top: 25px;

}


.search-btn,
.reset-btn {

    flex: 1;

    padding: 13px;

    border: none;

    border-radius: 25px;

    font-size: 16px;

    font-weight: bold;

    cursor: pointer;

    text-decoration: none;

    text-align: center;

    transition: 0.3s;

}


.search-btn {

    background:
        linear-gradient(
            135deg,
            #8e0e00,
            #c31432
        );

    color: white;

}


.reset-btn {

    background: #f2f2f2;

    color: #555;

}


.search-btn:hover,
.reset-btn:hover {

    transform:
        translateY(-2px);

    box-shadow:
        0 7px 18px
        rgba(0,0,0,0.15);

}


/* ==========================================
   INFO
========================================== */

.info {

    text-align: center;

    color: #777;

    margin-top: 20px;

    font-size: 14px;

}


/* ==========================================
   ERROR
========================================== */

.error-message {

    background: #f8d7da;

    color: #721c24;

    border:
        1px solid #f5c6cb;

    padding: 12px;

    border-radius: 10px;

    text-align: center;

    margin-bottom: 20px;

}


/* ==========================================
   MOBILE
========================================== */

@media (max-width: 650px) {

    .navbar {

        padding: 18px 20px;

    }


    .logo {

        font-size: 18px;

    }


    .container {

        width: 92%;

    }


    .button-row {

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
        class="back">

        ← Dashboard

    </a>


</div>



<!-- ==========================================
     MAIN
========================================== -->

<div class="container">


    <div class="search-box">


        <h1>

            Search Blood Donor

        </h1>


        <p class="subtitle">

            Find available donors using blood group,
            city and availability.

        </p>


<%

    String error =
        request.getParameter("error");


    if ("1".equals(error)) {

%>

        <div class="error-message">

            Something went wrong while searching
            for donors. Please try again.

        </div>

<%

    }

%>



        <!-- ======================================
             SEARCH FORM
        ======================================= -->

        <form
            action="searchDonor"
            method="get">


            <div class="form-row">


                <!-- BLOOD GROUP -->

                <div class="form-group">

                    <label>

                        Blood Group

                    </label>


                    <select
                        name="bloodGroup">


                        <option value="">

                            All Blood Groups

                        </option>


                        <option value="A+">
                            A+
                        </option>


                        <option value="A-">
                            A-
                        </option>


                        <option value="B+">
                            B+
                        </option>


                        <option value="B-">
                            B-
                        </option>


                        <option value="AB+">
                            AB+
                        </option>


                        <option value="AB-">
                            AB-
                        </option>


                        <option value="O+">
                            O+
                        </option>


                        <option value="O-">
                            O-
                        </option>


                    </select>

                </div>



                <!-- CITY -->

                <div class="form-group">

                    <label>

                        City

                    </label>


                    <input
                        type="text"
                        name="city"
                        placeholder="Enter city">


                </div>



                <!-- AVAILABILITY -->

                <div class="form-group">

                    <label>

                        Availability

                    </label>


                    <select
                        name="availability">


                        <option
                            value="AVAILABLE">

                            Available Donors

                        </option>


                        <option
                            value="ALL">

                            All Donors

                        </option>


                    </select>

                </div>


            </div>



            <!-- ==================================
                 BUTTONS
            =================================== -->

            <div class="button-row">


                <button
                    type="submit"
                    class="search-btn">

                    Search Donors

                </button>


                <a
                    href="search-donor.jsp"
                    class="reset-btn">

                    Reset

                </a>


            </div>


        </form>



        <div class="info">

            You can search by blood group,
            city or both.

        </div>


    </div>


</div>


</body>

</html>