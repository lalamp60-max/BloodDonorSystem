package com.blooddonor.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.blooddonor.util.DBConnection;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // =====================================================
        // ADMIN LOGIN CHECK
        // =====================================================

        HttpSession session =
                request.getSession(false);


        if (session == null ||
            session.getAttribute("adminId") == null) {

            response.sendRedirect(
                    "admin-login.jsp"
            );

            return;
        }


        Connection con = null;


        try {

            // =================================================
            // DATABASE CONNECTION
            // =================================================

            con =
                    DBConnection.getConnection();


            // =================================================
            // TOTAL USERS
            // =================================================

            int totalUsers = 0;


            String usersSql =
                    "SELECT COUNT(*) AS total " +
                    "FROM users";


            PreparedStatement usersPs =
                    con.prepareStatement(
                            usersSql
                    );


            ResultSet usersRs =
                    usersPs.executeQuery();


            if (usersRs.next()) {

                totalUsers =
                        usersRs.getInt("total");
            }


            usersRs.close();

            usersPs.close();


            // =================================================
            // TOTAL DONORS
            // =================================================

            int totalDonors = 0;


            String donorsSql =
                    "SELECT COUNT(*) AS total " +
                    "FROM donors";


            PreparedStatement donorsPs =
                    con.prepareStatement(
                            donorsSql
                    );


            ResultSet donorsRs =
                    donorsPs.executeQuery();


            if (donorsRs.next()) {

                totalDonors =
                        donorsRs.getInt("total");
            }


            donorsRs.close();

            donorsPs.close();


            // =================================================
            // TOTAL PENDING REQUESTS
            // =================================================

            int pendingRequests = 0;


            String pendingSql =
                    "SELECT COUNT(*) AS total " +
                    "FROM requests " +
                    "WHERE status = 'PENDING'";


            PreparedStatement pendingPs =
                    con.prepareStatement(
                            pendingSql
                    );


            ResultSet pendingRs =
                    pendingPs.executeQuery();


            if (pendingRs.next()) {

                pendingRequests =
                        pendingRs.getInt("total");
            }


            pendingRs.close();

            pendingPs.close();


            // =================================================
            // TOTAL APPROVED REQUESTS
            // =================================================

            int approvedRequests = 0;


            String approvedSql =
                    "SELECT COUNT(*) AS total " +
                    "FROM requests " +
                    "WHERE status = 'APPROVED'";


            PreparedStatement approvedPs =
                    con.prepareStatement(
                            approvedSql
                    );


            ResultSet approvedRs =
                    approvedPs.executeQuery();


            if (approvedRs.next()) {

                approvedRequests =
                        approvedRs.getInt("total");
            }


            approvedRs.close();

            approvedPs.close();


            // =================================================
            // TOTAL COMPLETED REQUESTS
            // =================================================

            int completedRequests = 0;


            String completedSql =
                    "SELECT COUNT(*) AS total " +
                    "FROM requests " +
                    "WHERE status = 'COMPLETED'";


            PreparedStatement completedPs =
                    con.prepareStatement(
                            completedSql
                    );


            ResultSet completedRs =
                    completedPs.executeQuery();


            if (completedRs.next()) {

                completedRequests =
                        completedRs.getInt("total");
            }


            completedRs.close();

            completedPs.close();


            // =================================================
            // TOTAL REJECTED REQUESTS
            // =================================================

            int rejectedRequests = 0;


            String rejectedSql =
                    "SELECT COUNT(*) AS total " +
                    "FROM requests " +
                    "WHERE status = 'REJECTED'";


            PreparedStatement rejectedPs =
                    con.prepareStatement(
                            rejectedSql
                    );


            ResultSet rejectedRs =
                    rejectedPs.executeQuery();


            if (rejectedRs.next()) {

                rejectedRequests =
                        rejectedRs.getInt("total");
            }


            rejectedRs.close();

            rejectedPs.close();


            // =================================================
            // AVAILABLE DONORS
            // =================================================

            int availableDonors = 0;


            String availableDonorsSql =
                    "SELECT COUNT(*) AS total " +
                    "FROM donors " +
                    "WHERE availability = TRUE";


            PreparedStatement availableDonorsPs =
                    con.prepareStatement(
                            availableDonorsSql
                    );


            ResultSet availableDonorsRs =
                    availableDonorsPs.executeQuery();


            if (availableDonorsRs.next()) {

                availableDonors =
                        availableDonorsRs.getInt(
                                "total"
                        );
            }


            availableDonorsRs.close();

            availableDonorsPs.close();


            // =================================================
            // TOTAL AVAILABLE BLOOD UNITS
            // =================================================

            int totalBloodUnits = 0;


            String inventoryTotalSql =
                    "SELECT COALESCE(" +
                    "SUM(units_available), 0" +
                    ") AS total " +
                    "FROM blood_inventory";


            PreparedStatement inventoryTotalPs =
                    con.prepareStatement(
                            inventoryTotalSql
                    );


            ResultSet inventoryTotalRs =
                    inventoryTotalPs.executeQuery();


            if (inventoryTotalRs.next()) {

                totalBloodUnits =
                        inventoryTotalRs.getInt(
                                "total"
                        );
            }


            inventoryTotalRs.close();

            inventoryTotalPs.close();


            // =================================================
            // BLOOD INVENTORY LIST
            // =================================================

            List<String[]> inventory =
                    new ArrayList<>();


            String inventorySql =
                    "SELECT inventory_id, " +
                    "blood_group, " +
                    "units_available, " +
                    "last_updated " +
                    "FROM blood_inventory " +
                    "ORDER BY blood_group";


            PreparedStatement inventoryPs =
                    con.prepareStatement(
                            inventorySql
                    );


            ResultSet inventoryRs =
                    inventoryPs.executeQuery();


            while (inventoryRs.next()) {

                String[] item = {

                    // 0 - Inventory ID
                    String.valueOf(
                            inventoryRs.getInt(
                                    "inventory_id"
                            )
                    ),

                    // 1 - Blood Group
                    inventoryRs.getString(
                            "blood_group"
                    ),

                    // 2 - Units
                    String.valueOf(
                            inventoryRs.getInt(
                                    "units_available"
                            )
                    ),

                    // 3 - Last Updated
                    String.valueOf(
                            inventoryRs.getTimestamp(
                                    "last_updated"
                            )
                    )
                };


                inventory.add(item);
            }


            inventoryRs.close();

            inventoryPs.close();


            // =================================================
            // SEND DATA TO JSP
            // =================================================

            request.setAttribute(
                    "totalUsers",
                    totalUsers
            );


            request.setAttribute(
                    "totalDonors",
                    totalDonors
            );


            request.setAttribute(
                    "pendingRequests",
                    pendingRequests
            );


            request.setAttribute(
                    "approvedRequests",
                    approvedRequests
            );


            request.setAttribute(
                    "completedRequests",
                    completedRequests
            );


            request.setAttribute(
                    "rejectedRequests",
                    rejectedRequests
            );


            request.setAttribute(
                    "availableDonors",
                    availableDonors
            );


            request.setAttribute(
                    "totalBloodUnits",
                    totalBloodUnits
            );


            request.setAttribute(
                    "inventory",
                    inventory
            );


            // =================================================
            // CLOSE CONNECTION
            // =================================================

            con.close();


            // =================================================
            // FORWARD TO ADMIN DASHBOARD
            // =================================================

            request.getRequestDispatcher(
                    "admin-dashboard.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            e.printStackTrace();


            try {

                if (con != null &&
                    !con.isClosed()) {

                    con.close();
                }

            } catch (Exception ex) {

                ex.printStackTrace();
            }


            response.sendRedirect(
                    "admin-dashboard.jsp?error=statistics"
            );
        }
    }
}