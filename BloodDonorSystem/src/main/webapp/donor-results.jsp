<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>


<%

    // =====================================================
    // LOGIN CHECK
    // =====================================================

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


    // =====================================================
    // SEARCH DATA
    // =====================================================

    List<String[]> donors =
        (List<String[]>)
        request.getAttribute(
            "donors"
        );


    List<String[]> inventory =
        (List<String[]>)
        request.getAttribute(
            "inventory"
        );


    String bloodGroup =
        (String)
        request.getAttribute(
            "bloodGroup"
        );


    String city =
        (String)
        request.getAttribute(
            "city"
        );


    String availability =
        (String)
        request.getAttribute(
            "availability"
        );


    Integer totalInventoryObj =
        (Integer)
        request.getAttribute(
            "totalInventoryUnits"
        );


    Integer availableDonorsObj =
        (Integer)
        request.getAttribute(
            "availableDonors"
        );


    int totalInventoryUnits =
        totalInventoryObj != null
            ? totalInventoryObj
            : 0;


    int availableDonors =
        availableDonorsObj != null
            ? availableDonorsObj
            : 0;


    if (bloodGroup == null) {

        bloodGroup = "";
    }


    if (city == null) {

        city = "";
    }


    if (availability == null) {

        availability =
            "AVAILABLE";
    }

%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Donor Search Results</title>


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

    background:
        linear-gradient(
            135deg,
            #fff5f5,
            #ffe0e0
        );

    min-height: 100vh;
}


/* =====================================================
   NAVBAR
===================================================== */

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
}


/* =====================================================
   MAIN
===================================================== */

.container {

    width: 92%;

    max-width: 1250px;

    margin: 40px auto;
}


/* =====================================================
   HEADING
===================================================== */

.heading {

    background: white;

    padding: 25px;

    border-radius: 18px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.10);

    margin-bottom: 22px;
}


.heading h1 {

    margin: 0;

    color: #8e0e00;

    font-size: 29px;
}


.heading p {

    color: #666;

    margin:
        10px 0 0;
}


/* =====================================================
   FILTERS
===================================================== */

.filters {

    display: flex;

    gap: 10px;

    flex-wrap: wrap;

    margin-top: 18px;
}


.filter {

    background: #ffe1e1;

    color: #8e0e00;

    padding: 7px 13px;

    border-radius: 20px;

    font-weight: bold;

    font-size: 13px;
}


/* =====================================================
   SUMMARY GRID
===================================================== */

.summary-grid {

    display: grid;

    grid-template-columns:
        repeat(
            auto-fit,
            minmax(230px, 1fr)
        );

    gap: 20px;

    margin-bottom: 25px;
}


/* =====================================================
   SUMMARY CARD
===================================================== */

.summary-card {

    background: white;

    padding: 23px;

    border-radius: 18px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.08);

    border-top:
        5px solid #c31432;
}


.summary-title {

    color: #777;

    font-size: 14px;

    margin-bottom: 10px;
}


.summary-value {

    color: #8e0e00;

    font-size: 32px;

    font-weight: bold;
}


.summary-subtitle {

    color: #999;

    font-size: 13px;

    margin-top: 5px;
}


.inventory-summary {

    border-top-color:
        #198754;
}


.inventory-summary
.summary-value {

    color: #155724;
}


.donor-summary {

    border-top-color:
        #c31432;
}


/* =====================================================
   INVENTORY SECTION
===================================================== */

.inventory-section {

    background: white;

    padding: 25px;

    border-radius: 18px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.09);

    margin-bottom: 25px;
}


.inventory-section h2 {

    margin:
        0 0 20px;

    color: #8e0e00;

    font-size: 23px;
}


.inventory-grid {

    display: grid;

    grid-template-columns:
        repeat(
            auto-fit,
            minmax(180px, 1fr)
        );

    gap: 15px;
}


/* =====================================================
   INVENTORY CARD
===================================================== */

.inventory-card {

    background:
        linear-gradient(
            135deg,
            #fff7f7,
            #fff0f0
        );

    padding: 20px;

    border-radius: 15px;

    border:
        1px solid #ffd6d6;
}


.inventory-group {

    color: #c31432;

    font-size: 24px;

    font-weight: bold;

    margin-bottom: 8px;
}


.inventory-units {

    font-size: 28px;

    color: #155724;

    font-weight: bold;
}


.inventory-label {

    color: #777;

    font-size: 13px;
}


.inventory-date {

    color: #999;

    font-size: 11px;

    margin-top: 10px;
}


/* =====================================================
   OUT OF STOCK
===================================================== */

.out-of-stock {

    color: #dc3545;

    font-weight: bold;

    margin-top: 8px;

    font-size: 13px;
}


/* =====================================================
   DONOR TABLE
===================================================== */

.table-box {

    background: white;

    padding: 25px;

    border-radius: 18px;

    box-shadow:
        0 8px 25px
        rgba(0,0,0,0.10);

    overflow-x: auto;
}


table {

    width: 100%;

    border-collapse: collapse;

    min-width: 1000px;
}


th {

    background:
        linear-gradient(
            135deg,
            #8e0e00,
            #c31432
        );

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


/* =====================================================
   BLOOD
===================================================== */

.blood {

    font-weight: bold;

    color: #c31432;

    background: #ffe1e1;

    padding: 6px 12px;

    border-radius: 18px;

    display: inline-block;
}


/* =====================================================
   PHONE
===================================================== */

.phone {

    color: #8e0e00;

    font-weight: bold;

    white-space: nowrap;
}


/* =====================================================
   AVAILABLE
===================================================== */

.available {

    color: #198754;

    font-weight: bold;
}


.unavailable {

    color: #dc3545;

    font-weight: bold;
}


/* =====================================================
   CONTACT
===================================================== */

.contact-btn {

    display: inline-block;

    padding: 8px 14px;

    background:
        linear-gradient(
            135deg,
            #8e0e00,
            #c31432
        );

    color: white;

    text-decoration: none;

    border-radius: 20px;

    font-size: 13px;

    font-weight: bold;

    white-space: nowrap;
}


.contact-btn:hover {

    transform:
        translateY(-2px);
}


/* =====================================================
   NO RESULTS
===================================================== */

.no-result {

    text-align: center;

    padding: 50px 30px;

    color: #777;

    font-size: 18px;
}


.search-again {

    display: inline-block;

    margin-top: 20px;

    padding: 11px 22px;

    background:
        linear-gradient(
            135deg,
            #8e0e00,
            #c31432
        );

    color: white;

    text-decoration: none;

    border-radius: 25px;

    font-weight: bold;
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

@media (max-width: 650px) {

    .navbar {

        padding:
            18px 20px;
    }


    .logo {

        font-size: 18px;
    }


    .container {

        width: 90%;
    }


    .summary-grid {

        grid-template-columns: 1fr;
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


    <!-- =================================================
         SEARCH SUMMARY
    ================================================== -->

    <div class="heading">


        <h1>

            Donor Search Results

        </h1>


        <p>

            View available blood donors and
            blood inventory information.

        </p>


        <div class="filters">


            <!-- BLOOD GROUP -->

            <%
                if (!bloodGroup.isEmpty()) {
            %>

                <span class="filter">

                    Blood Group:
                    <%= bloodGroup %>

                </span>

            <%
                } else {
            %>

                <span class="filter">

                    All Blood Groups

                </span>

            <%
                }
            %>


            <!-- CITY -->

            <%
                if (!city.isEmpty()) {
            %>

                <span class="filter">

                    City:
                    <%= city %>

                </span>

            <%
                } else {
            %>

                <span class="filter">

                    All Cities

                </span>

            <%
                }
            %>


            <!-- AVAILABILITY -->

            <%
                if ("AVAILABLE"
                    .equalsIgnoreCase(
                        availability
                    )) {
            %>

                <span class="filter">

                    Available Donors

                </span>

            <%
                } else {
            %>

                <span class="filter">

                    All Donors

                </span>

            <%
                }
            %>


        </div>


    </div>



    <!-- =================================================
         SUMMARY
    ================================================== -->

    <div class="summary-grid">


        <!-- AVAILABLE DONORS -->

        <div class="summary-card donor-summary">


            <div class="summary-title">

                Available Donors

            </div>


            <div class="summary-value">

                <%= availableDonors %>

            </div>


            <div class="summary-subtitle">

                Matching your search

            </div>


        </div>



        <!-- BLOOD INVENTORY -->

        <div class="
            summary-card
            inventory-summary
        ">


            <div class="summary-title">

                Blood Inventory

            </div>


            <div class="summary-value">

                <%= totalInventoryUnits %>

            </div>


            <div class="summary-subtitle">

                Available blood units

            </div>


        </div>


    </div>



    <!-- =================================================
         INVENTORY
    ================================================== -->

    <div class="inventory-section">


        <h2>

            Blood Inventory Availability

        </h2>


<%

    if (inventory != null &&
        !inventory.isEmpty()) {

%>


        <div class="inventory-grid">


<%

        for (String[] item : inventory) {

            int units = 0;


            try {

                units =
                    Integer.parseInt(
                        item[2]
                    );

            } catch (Exception e) {

                units = 0;
            }

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


<%

                if (units <= 0) {

%>


                <div class="out-of-stock">

                    Currently unavailable

                </div>


<%

                }

%>


                <div class="inventory-date">

                    Updated:
                    <%= item[3] %>

                </div>


            </div>


<%

        }

%>


        </div>


<%

    } else {

%>


        <div class="no-result">

            No inventory record found for
            the selected blood group.

        </div>


<%

    }

%>


    </div>



    <!-- =================================================
         DONOR RESULTS
    ================================================== -->

    <div class="table-box">


<%

    if (donors != null &&
        !donors.isEmpty()) {

%>


        <table>


            <tr>


                <th>
                    Donor ID
                </th>


                <th>
                    Name
                </th>


                <th>
                    Email
                </th>


                <th>
                    Phone
                </th>


                <th>
                    Blood Group
                </th>


                <th>
                    Age
                </th>


                <th>
                    Gender
                </th>


                <th>
                    City
                </th>


                <th>
                    Availability
                </th>


                <th>
                    Contact
                </th>


            </tr>


<%

        for (String[] donor :
             donors) {


            boolean isAvailable =

                "true".equalsIgnoreCase(
                    donor[8]
                );


%>


            <tr>


                <!-- DONOR ID -->

                <td>

                    <%= donor[0] %>

                </td>


                <!-- NAME -->

                <td>

                    <strong>

                        <%= donor[1] %>

                    </strong>

                </td>


                <!-- EMAIL -->

                <td>

                    <%= donor[2] %>

                </td>


                <!-- PHONE -->

                <td class="phone">

                    <%
                        if (donor[3] != null &&
                            !donor[3]
                                .trim()
                                .isEmpty()) {
                    %>

                        <%= donor[3] %>

                    <%
                        } else {
                    %>

                        Not Provided

                    <%
                        }
                    %>

                </td>


                <!-- BLOOD -->

                <td>

                    <span class="blood">

                        <%= donor[4] %>

                    </span>

                </td>


                <!-- AGE -->

                <td>

                    <%= donor[5] %>

                </td>


                <!-- GENDER -->

                <td>

                    <%= donor[6] %>

                </td>


                <!-- CITY -->

                <td>

                    <%= donor[7] %>

                </td>


                <!-- AVAILABILITY -->

                <td>


<%

                if (isAvailable) {

%>


                    <span class="available">

                        Available

                    </span>


<%

                } else {

%>


                    <span class="unavailable">

                        Unavailable

                    </span>


<%

                }

%>


                </td>


                <!-- CONTACT -->

                <td>


<%

                if (isAvailable &&
                    donor[3] != null &&
                    !donor[3]
                        .trim()
                        .isEmpty()) {

%>


                    <a
                        href="tel:<%= donor[3] %>"
                        class="contact-btn">

                        Call Donor

                    </a>


<%

                } else {

%>


                    <span class="unavailable">

                        Not Available

                    </span>


<%

                }

%>


                </td>


            </tr>


<%

        }

%>


        </table>


<%

    } else {

%>


        <div class="no-result">

            No donors found matching
            the selected criteria.


            <br>


            <a
                href="search-donor.jsp"
                class="search-again">

                Search Again

            </a>

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