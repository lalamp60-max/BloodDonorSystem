<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.blooddonor.model.BloodInventory" %>


<%
    if (session.getAttribute("adminId") == null) {

        response.sendRedirect("admin-login.jsp");
        return;
    }

    List<BloodInventory> inventoryList =
        (List<BloodInventory>)
        request.getAttribute("inventoryList");
%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Blood Inventory - Admin</title>


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


/* ================= NAVBAR ================= */

.navbar {

    height: 70px;

    background:
        linear-gradient(
            135deg,
            #3b0000,
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

    font-size: 23px;

    font-weight: bold;
}


.back {

    color: #c31432;

    background: white;

    text-decoration: none;

    padding: 9px 18px;

    border-radius: 20px;

    font-weight: bold;

    transition: 0.3s;
}


.back:hover {

    transform: translateY(-2px);

    background: #ffe5e5;
}


/* ================= MAIN ================= */

.container {

    width: 95%;

    max-width: 1200px;

    margin: 40px auto;
}


h1 {

    color: #8e0e00;

    margin-bottom: 25px;
}


/* ================= TABLE ================= */

.table-box {

    background: white;

    padding: 25px;

    border-radius: 20px;

    box-shadow:
        0 10px 30px rgba(0,0,0,0.1);

    overflow-x: auto;
}


table {

    width: 100%;

    border-collapse: collapse;
}


th {

    background: #8e0e00;

    color: white;

    padding: 15px;

    text-align: left;
}


td {

    padding: 15px;

    border-bottom:
        1px solid #eee;

    color: #444;
}


tr:hover {

    background: #fff5f5;
}


/* ================= BLOOD GROUP ================= */

.blood {

    display: inline-block;

    background: #ffe1e1;

    color: #8e0e00;

    padding: 8px 15px;

    border-radius: 20px;

    font-weight: bold;

    font-size: 16px;
}


/* ================= UNITS ================= */

.units {

    font-size: 18px;

    font-weight: bold;

    color: #8e0e00;
}


/* ================= STATUS ================= */

.good {

    display: inline-block;

    background: #e7f8ed;

    color: #16803c;

    padding: 7px 13px;

    border-radius: 20px;

    font-weight: bold;
}


.low {

    display: inline-block;

    background: #fff3cd;

    color: #856404;

    padding: 7px 13px;

    border-radius: 20px;

    font-weight: bold;
}


.empty {

    text-align: center;

    padding: 35px;

    color: #777;
}
/* ================= UPDATE BOX ================= */

.update-box {

    background: white;

    padding: 25px;

    border-radius: 20px;

    margin-bottom: 30px;

    box-shadow:
        0 10px 30px rgba(0,0,0,0.1);
}


.update-box h2 {

    margin-top: 0;

    color: #8e0e00;
}


.update-box p {

    color: #777;

    margin-bottom: 20px;
}


/* ================= FORM ================= */

.inventory-form {

    display: flex;

    align-items: end;

    gap: 20px;

    flex-wrap: wrap;
}


.form-group {

    display: flex;

    flex-direction: column;

    gap: 8px;
}


.form-group label {

    font-weight: bold;

    color: #555;
}


.form-group select,
.form-group input {

    width: 220px;

    padding: 12px 15px;

    border: 1px solid #ddd;

    border-radius: 10px;

    font-size: 15px;

    outline: none;
}


.form-group select:focus,
.form-group input:focus {

    border-color: #c31432;

    box-shadow:
        0 0 0 3px rgba(195,20,50,0.1);
}


/* ================= BUTTON ================= */

.update-btn {

    padding: 12px 25px;

    border: none;

    border-radius: 25px;

    background:
        linear-gradient(
            135deg,
            #8e0e00,
            #c31432
        );

    color: white;

    font-size: 15px;

    font-weight: bold;

    cursor: pointer;

    transition: 0.3s;
}


.update-btn:hover {

    transform: translateY(-3px);

    box-shadow:
        0 8px 20px rgba(0,0,0,0.2);
}


/* ================= MESSAGE ================= */

.message {

    padding: 12px 18px;

    border-radius: 10px;

    margin-bottom: 20px;

    font-weight: bold;
}


.success-message {

    background: #e7f8ed;

    color: #16803c;
}


.error-message {

    background: #ffe5e5;

    color: #c31432;
}
</style>

</head>


<body>


<!-- ================= NAVBAR ================= -->

<div class="navbar">

    <div class="logo">

        🩸 Blood Donor Finder - Admin

    </div>


    <a
        href="adminDashboard"
        class="back">

        ← Dashboard

    </a>

</div>



<!-- ================= MAIN ================= -->

<div class="container">


    <h1>

        🩸 Blood Inventory

    </h1>
    <!-- ================= ADD / UPDATE FORM ================= -->

<div class="update-box">

    <h2>
        ➕ Add / Update Blood Units
    </h2>

    <p>
        Select a blood group and enter the
        total available units.
    </p>
<%
    String success =
        request.getParameter("success");

    String error =
        request.getParameter("error");
%>


<%
    if ("updated".equals(success)) {
%>

    <div class="message success-message">

        ✅ Blood inventory updated successfully!

    </div>

<%
    }
%>


<%
    if ("negative".equals(error)) {
%>

    <div class="message error-message">

        ❌ Units cannot be negative.

    </div>

<%
    }
%>


<%
    if ("invalid".equals(error)) {
%>

    <div class="message error-message">

        ❌ Please enter a valid number.

    </div>

<%
    }
%>


<%
    if ("database".equals(error)) {
%>

    <div class="message error-message">

        ❌ Database error occurred.

    </div>

<%
    }
%>

    <form
        action="updateInventory"
        method="post"
        class="inventory-form">


        <div class="form-group">

            <label>
                Blood Group
            </label>

            <select
                name="bloodGroup"
                required>

                <option value="">
                    Select Blood Group
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


        <div class="form-group">

            <label>
                Available Units
            </label>

            <input
                type="number"
                name="units"
                min="0"
                placeholder="Enter units"
                required>

        </div>


        <button
            type="submit"
            class="update-btn">

            💾 Save Inventory

        </button>


    </form>

</div>


    <div class="table-box">


        <table>


            <tr>

                <th>
                    Inventory ID
                </th>

                <th>
                    Blood Group
                </th>

                <th>
                    Units Available
                </th>

                <th>
                    Inventory Status
                </th>

                <th>
                    Last Updated
                </th>

            </tr>


            <%
                if (inventoryList != null &&
                    !inventoryList.isEmpty()) {


                    for (
                        BloodInventory item :
                        inventoryList
                    ) {
            %>


            <tr>


                <!-- INVENTORY ID -->

                <td>

                    <%= item.getInventoryId() %>

                </td>


                <!-- BLOOD GROUP -->

                <td>

                    <span class="blood">

                        <%= item.getBloodGroup() %>

                    </span>

                </td>


                <!-- UNITS -->

                <td>

                    <span class="units">

                        <%= item.getUnitsAvailable() %>
                        units

                    </span>

                </td>


                <!-- STATUS -->

                <td>

                    <%
                        if (item.getUnitsAvailable() > 5) {
                    %>

                        <span class="good">

                            Available

                        </span>

                    <%
                        } else {
                    %>

                        <span class="low">

                            Low Stock

                        </span>

                    <%
                        }
                    %>

                </td>


                <!-- LAST UPDATED -->

                <td>

                    <%= item.getLastUpdated() %>

                </td>


            </tr>


            <%
                    }

                } else {
            %>


            <tr>

                <td
                    colspan="5"
                    class="empty">

                    🩸 No blood inventory records found.

                </td>

            </tr>


            <%
                }
            %>


        </table>


    </div>


</div>


</body>

</html>