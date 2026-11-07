package com.blooddonor.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.blooddonor.util.DBConnection;

@WebServlet("/updateRequestStatus")
public class UpdateRequestStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    @Override
    protected void doPost(
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


        // =====================================================
        // ADMIN ID
        // =====================================================

        int adminId =
                (Integer) session.getAttribute(
                        "adminId"
                );


        // =====================================================
        // REQUEST ID
        // =====================================================

        String requestIdValue =
                request.getParameter(
                        "requestId"
                );


        // =====================================================
        // STATUS
        // =====================================================

        String status =
                request.getParameter(
                        "status"
                );


        if (requestIdValue == null ||
            status == null ||
            status.trim().isEmpty()) {

            response.sendRedirect(
                    "manageRequests?error=invalid"
            );

            return;
        }


        int requestId;


        try {

            requestId =
                    Integer.parseInt(
                            requestIdValue
                    );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "manageRequests?error=invalid"
            );

            return;
        }


        // =====================================================
        // VALID STATUS
        // =====================================================

        status =
                status.toUpperCase();


        if (!status.equals("APPROVED") &&
            !status.equals("REJECTED") &&
            !status.equals("COMPLETED")) {

            response.sendRedirect(
                    "manageRequests?error=invalid"
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
            // START TRANSACTION
            // =================================================

            con.setAutoCommit(false);


            // =================================================
            // GET REQUEST DETAILS
            // =================================================

            String requestSql =
                    "SELECT requester_id, " +
                    "blood_group, " +
                    "units_required, " +
                    "status " +
                    "FROM requests " +
                    "WHERE request_id = ? " +
                    "FOR UPDATE";


            PreparedStatement requestPs =
                    con.prepareStatement(
                            requestSql
                    );


            requestPs.setInt(
                    1,
                    requestId
            );


            ResultSet requestRs =
                    requestPs.executeQuery();


            if (!requestRs.next()) {

                requestRs.close();
                requestPs.close();

                con.rollback();
                con.close();

                response.sendRedirect(
                        "manageRequests?error=notFound"
                );

                return;
            }


            int requesterId =
                    requestRs.getInt(
                            "requester_id"
                    );


            String bloodGroup =
                    requestRs.getString(
                            "blood_group"
                    );


            int unitsRequired =
                    requestRs.getInt(
                            "units_required"
                    );


            String currentStatus =
                    requestRs.getString(
                            "status"
                    );


            requestRs.close();
            requestPs.close();


            // =================================================
            // ALREADY COMPLETED
            // =================================================

            if ("COMPLETED".equalsIgnoreCase(
                    currentStatus)) {

                con.rollback();
                con.close();

                response.sendRedirect(
                        "manageRequests?error=alreadyCompleted"
                );

                return;
            }


            // =================================================
            // COMPLETED REQUEST MUST BE APPROVED FIRST
            // =================================================

            if ("COMPLETED".equals(status)) {

                if (!"APPROVED".equalsIgnoreCase(
                        currentStatus)) {

                    con.rollback();
                    con.close();

                    response.sendRedirect(
                            "manageRequests?error=mustApprove"
                    );

                    return;
                }
            }


            // =================================================
            // CHECK BLOOD INVENTORY FOR COMPLETION
            // =================================================

            if ("COMPLETED".equals(status)) {


                String inventorySql =
                        "SELECT inventory_id, " +
                        "units_available " +
                        "FROM blood_inventory " +
                        "WHERE blood_group = ? " +
                        "FOR UPDATE";


                PreparedStatement inventoryPs =
                        con.prepareStatement(
                                inventorySql
                        );


                inventoryPs.setString(
                        1,
                        bloodGroup
                );


                ResultSet inventoryRs =
                        inventoryPs.executeQuery();


                if (!inventoryRs.next()) {

                    inventoryRs.close();
                    inventoryPs.close();

                    con.rollback();
                    con.close();

                    response.sendRedirect(
                            "manageRequests?error=noInventory&bloodGroup="
                            + java.net.URLEncoder.encode(
                                    bloodGroup,
                                    "UTF-8"
                            )
                    );

                    return;
                }


                int inventoryId =
                        inventoryRs.getInt(
                                "inventory_id"
                        );


                int availableUnits =
                        inventoryRs.getInt(
                                "units_available"
                        );


                inventoryRs.close();
                inventoryPs.close();


                // =============================================
                // INSUFFICIENT STOCK
                // =============================================

                if (availableUnits <
                        unitsRequired) {

                    con.rollback();
                    con.close();

                    response.sendRedirect(
                            "manageRequests?error=insufficientStock"
                            + "&available="
                            + availableUnits
                            + "&required="
                            + unitsRequired
                    );

                    return;
                }


                // =============================================
                // DEDUCT BLOOD UNITS
                // =============================================

                int remainingUnits =
                        availableUnits -
                        unitsRequired;


                String updateInventorySql =
                        "UPDATE blood_inventory " +
                        "SET units_available = ? " +
                        "WHERE inventory_id = ?";


                PreparedStatement updateInventoryPs =
                        con.prepareStatement(
                                updateInventorySql
                        );


                updateInventoryPs.setInt(
                        1,
                        remainingUnits
                );


                updateInventoryPs.setInt(
                        2,
                        inventoryId
                );


                updateInventoryPs.executeUpdate();


                updateInventoryPs.close();
            }


            // =================================================
            // UPDATE REQUEST STATUS
            // =================================================

            String updateSql =
                    "UPDATE requests " +
                    "SET status = ?, " +
                    "admin_id = ?, " +
                    "admin_action_date = CURRENT_TIMESTAMP " +
                    "WHERE request_id = ?";


            PreparedStatement updatePs =
                    con.prepareStatement(
                            updateSql
                    );


            updatePs.setString(
                    1,
                    status
            );


            updatePs.setInt(
                    2,
                    adminId
            );


            updatePs.setInt(
                    3,
                    requestId
            );


            int updatedRows =
                    updatePs.executeUpdate();


            updatePs.close();


            if (updatedRows != 1) {

                con.rollback();
                con.close();

                response.sendRedirect(
                        "manageRequests?error=update"
                );

                return;
            }


            // =================================================
            // CREATE NOTIFICATION
            // =================================================

            String message;


            if ("APPROVED".equals(status)) {

                message =
                        "Admin has approved your blood request #"
                        + requestId
                        + ".";

            } else if ("REJECTED".equals(status)) {

                message =
                        "Admin has rejected your blood request #"
                        + requestId
                        + ".";

            } else {

                message =
                        "Admin has completed your blood request #"
                        + requestId
                        + ". "
                        + unitsRequired
                        + " unit(s) of "
                        + bloodGroup
                        + " blood were processed.";
            }


            String notificationSql =
                    "INSERT INTO notifications " +
                    "(user_id, request_id, message, notification_type) " +
                    "VALUES (?, ?, ?, ?)";


            PreparedStatement notificationPs =
                    con.prepareStatement(
                            notificationSql
                    );


            notificationPs.setInt(
                    1,
                    requesterId
            );


            notificationPs.setInt(
                    2,
                    requestId
            );


            notificationPs.setString(
                    3,
                    message
            );


            notificationPs.setString(
                    4,
                    "ADMIN_ACTION"
            );


            notificationPs.executeUpdate();


            notificationPs.close();


            // =================================================
            // COMMIT ALL CHANGES
            // =================================================

            con.commit();


            con.close();


            // =================================================
            // SUCCESS
            // =================================================

            response.sendRedirect(
                    "manageRequests?success="
                    + status.toLowerCase()
            );


        } catch (Exception e) {

            e.printStackTrace();


            try {

                if (con != null) {

                    con.rollback();

                    con.close();
                }

            } catch (Exception ex) {

                ex.printStackTrace();
            }


            response.sendRedirect(
                    "manageRequests?error=database"
            );
        }
    }
}