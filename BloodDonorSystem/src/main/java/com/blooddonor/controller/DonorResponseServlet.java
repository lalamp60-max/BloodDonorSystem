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

@WebServlet("/donorResponse")
public class DonorResponseServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    // =========================================================
    // GET
    // =========================================================
    // Used when a user opens donor-response.jsp directly.
    // It automatically finds the donor ID from the logged-in user.
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);


        // ==========================================
        // LOGIN CHECK
        // ==========================================

        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }


        int userId =
                (Integer) session.getAttribute("userId");


        // ==========================================
        // GET REQUEST ID
        // ==========================================

        String requestIdValue =
                request.getParameter("requestId");


        if (requestIdValue == null ||
            requestIdValue.trim().isEmpty()) {

            response.sendRedirect(
                    "viewPendingRequests"
            );

            return;
        }


        int requestId;

        try {

            requestId =
                    Integer.parseInt(requestIdValue);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "viewPendingRequests?error=invalidRequest"
            );

            return;
        }


        Connection con = null;


        try {

            con =
                    DBConnection.getConnection();


            // ==========================================
            // FIND DONOR ID
            // ==========================================

            String donorSql =
                    "SELECT donor_id " +
                    "FROM donors " +
                    "WHERE user_id = ?";


            PreparedStatement donorPs =
                    con.prepareStatement(donorSql);


            donorPs.setInt(1, userId);


            ResultSet donorRs =
                    donorPs.executeQuery();


            if (!donorRs.next()) {

                donorRs.close();
                donorPs.close();
                con.close();

                response.sendRedirect(
                        "viewPendingRequests?error=notDonor"
                );

                return;
            }


            int donorId =
                    donorRs.getInt("donor_id");


            donorRs.close();
            donorPs.close();


            // ==========================================
            // CHECK REQUEST
            // ==========================================

            String requestSql =
                    "SELECT requester_id, status " +
                    "FROM requests " +
                    "WHERE request_id = ?";


            PreparedStatement requestPs =
                    con.prepareStatement(requestSql);


            requestPs.setInt(
                    1,
                    requestId
            );


            ResultSet requestRs =
                    requestPs.executeQuery();


            if (!requestRs.next()) {

                requestRs.close();
                requestPs.close();
                con.close();

                response.sendRedirect(
                        "viewPendingRequests?error=invalidRequest"
                );

                return;
            }


            int requesterId =
                    requestRs.getInt(
                            "requester_id"
                    );


            String currentStatus =
                    requestRs.getString(
                            "status"
                    );


            requestRs.close();
            requestPs.close();


            // ==========================================
            // OWN REQUEST CHECK
            // ==========================================

            if (requesterId == userId) {

                con.close();

                response.sendRedirect(
                        "viewPendingRequests?error=ownRequest"
                );

                return;
            }


            // ==========================================
            // REQUEST MUST BE PENDING
            // ==========================================

            if (!"PENDING"
                    .equalsIgnoreCase(currentStatus)) {

                con.close();

                response.sendRedirect(
                        "viewPendingRequests?error=alreadyProcessed"
                );

                return;
            }


            // ==========================================
            // SEND DATA TO RESPONSE JSP
            // ==========================================

            request.setAttribute(
                    "requestId",
                    requestId
            );


            request.setAttribute(
                    "donorId",
                    donorId
            );


            con.close();


            request.getRequestDispatcher(
                    "donor-response.jsp"
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
                    "viewPendingRequests?error=response"
            );
        }
    }


    // =========================================================
    // POST
    // =========================================================
    // Accept / Decline donor response
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        HttpSession session =
                request.getSession(false);


        // ==========================================
        // LOGIN CHECK
        // ==========================================

        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }


        int loggedUserId =
                (Integer) session.getAttribute("userId");


        // ==========================================
        // GET REQUEST ID
        // ==========================================

        String requestIdValue =
                request.getParameter("requestId");


        if (requestIdValue == null ||
            requestIdValue.trim().isEmpty()) {

            response.sendRedirect(
                    "viewPendingRequests?error=invalidRequest"
            );

            return;
        }


        int requestId;

        try {

            requestId =
                    Integer.parseInt(requestIdValue);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "viewPendingRequests?error=invalidRequest"
            );

            return;
        }


        // ==========================================
        // GET ACTION
        // ==========================================

        String action =
                request.getParameter("action");


        if (action == null ||
            action.trim().isEmpty()) {

            response.sendRedirect(
                    "viewPendingRequests?error=invalidAction"
            );

            return;
        }


        /*
         * Support both:
         *
         * ACCEPT / ACCEPTED
         * DECLINE / DECLINED
         */

        if (action.equalsIgnoreCase("ACCEPT") ||
            action.equalsIgnoreCase("ACCEPTED")) {

            action = "ACCEPTED";

        } else if (
                action.equalsIgnoreCase("DECLINE") ||
                action.equalsIgnoreCase("DECLINED")) {

            action = "DECLINED";

        } else {

            response.sendRedirect(
                    "viewPendingRequests?error=invalidAction"
            );

            return;
        }


        Connection con = null;


        try {

            con =
                    DBConnection.getConnection();


            // =====================================================
            // START TRANSACTION
            // =====================================================

            con.setAutoCommit(false);


            // =====================================================
            // 1. FIND DONOR ID
            // =====================================================

            String donorSql =
                    "SELECT donor_id " +
                    "FROM donors " +
                    "WHERE user_id = ?";


            PreparedStatement donorPs =
                    con.prepareStatement(donorSql);


            donorPs.setInt(
                    1,
                    loggedUserId
            );


            ResultSet donorRs =
                    donorPs.executeQuery();


            if (!donorRs.next()) {

                donorRs.close();
                donorPs.close();

                con.rollback();
                con.close();

                response.sendRedirect(
                        "viewPendingRequests?error=notDonor"
                );

                return;
            }


            int donorId =
                    donorRs.getInt("donor_id");


            donorRs.close();
            donorPs.close();


            // =====================================================
            // 2. GET REQUEST INFORMATION
            // =====================================================

            String requestSql =
                    "SELECT requester_id, status " +
                    "FROM requests " +
                    "WHERE request_id = ?";


            PreparedStatement requestPs =
                    con.prepareStatement(requestSql);


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
                        "viewPendingRequests?error=invalidRequest"
                );

                return;
            }


            int requesterId =
                    requestRs.getInt(
                            "requester_id"
                    );


            String currentStatus =
                    requestRs.getString(
                            "status"
                    );


            requestRs.close();
            requestPs.close();


            // =====================================================
            // 3. DON'T ALLOW OWN REQUEST
            // =====================================================

            if (requesterId == loggedUserId) {

                con.rollback();
                con.close();

                response.sendRedirect(
                        "viewPendingRequests?error=ownRequest"
                );

                return;
            }


            // =====================================================
            // 4. REQUEST MUST STILL BE PENDING
            // =====================================================

            if (!"PENDING"
                    .equalsIgnoreCase(currentStatus)) {

                con.rollback();
                con.close();

                response.sendRedirect(
                        "viewPendingRequests?error=alreadyProcessed"
                );

                return;
            }


            // =====================================================
            // 5. CHECK DUPLICATE RESPONSE
            // =====================================================

            String duplicateSql =
                    "SELECT response_id " +
                    "FROM donor_responses " +
                    "WHERE request_id = ? " +
                    "AND donor_id = ?";


            PreparedStatement duplicatePs =
                    con.prepareStatement(
                            duplicateSql
                    );


            duplicatePs.setInt(
                    1,
                    requestId
            );


            duplicatePs.setInt(
                    2,
                    donorId
            );


            ResultSet duplicateRs =
                    duplicatePs.executeQuery();


            if (duplicateRs.next()) {

                duplicateRs.close();
                duplicatePs.close();

                con.rollback();
                con.close();

                response.sendRedirect(
                        "viewPendingRequests?error=alreadyResponded"
                );

                return;
            }


            duplicateRs.close();
            duplicatePs.close();


            // =====================================================
            // 6. INSERT DONOR RESPONSE
            // =====================================================

            String insertSql =
                    "INSERT INTO donor_responses " +
                    "(request_id, donor_id, response_status) " +
                    "VALUES (?, ?, ?)";


            PreparedStatement insertPs =
                    con.prepareStatement(
                            insertSql
                    );


            insertPs.setInt(
                    1,
                    requestId
            );


            insertPs.setInt(
                    2,
                    donorId
            );


            insertPs.setString(
                    3,
                    action
            );


            int insertedRows =
                    insertPs.executeUpdate();


            insertPs.close();


            if (insertedRows != 1) {

                con.rollback();
                con.close();

                response.sendRedirect(
                        "viewPendingRequests?error=response"
                );

                return;
            }


            // =====================================================
            // 7. ACCEPTED
            // =====================================================

            if ("ACCEPTED".equals(action)) {


                // -----------------------------------------------
                // Update request status
                // -----------------------------------------------

                String updateRequestSql =
                        "UPDATE requests " +
                        "SET status = 'APPROVED' " +
                        "WHERE request_id = ?";


                PreparedStatement updateRequestPs =
                        con.prepareStatement(
                                updateRequestSql
                        );


                updateRequestPs.setInt(
                        1,
                        requestId
                );


                updateRequestPs.executeUpdate();


                updateRequestPs.close();


                // -----------------------------------------------
                // Donor becomes unavailable
                // -----------------------------------------------

                String updateDonorSql =
                        "UPDATE donors " +
                        "SET availability = FALSE " +
                        "WHERE donor_id = ?";


                PreparedStatement updateDonorPs =
                        con.prepareStatement(
                                updateDonorSql
                        );


                updateDonorPs.setInt(
                        1,
                        donorId
                );


                updateDonorPs.executeUpdate();


                updateDonorPs.close();
            }


            // =====================================================
            // 8. CREATE NOTIFICATION FOR REQUESTER
            // =====================================================

            String notificationMessage;


            if ("ACCEPTED".equals(action)) {

                notificationMessage =
                        "A donor has accepted your blood request #"
                        + requestId
                        + ".";

            } else {

                notificationMessage =
                        "A donor has declined your blood request #"
                        + requestId
                        + ".";
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
                    notificationMessage
            );


            notificationPs.setString(
                    4,
                    "DONOR_RESPONSE"
            );


            notificationPs.executeUpdate();


            notificationPs.close();


            // =====================================================
            // 9. COMMIT EVERYTHING
            // =====================================================

            con.commit();


            con.close();


            // =====================================================
            // 10. SUCCESS
            // =====================================================

            if ("ACCEPTED".equals(action)) {

                response.sendRedirect(
                        "viewPendingRequests?success=accepted"
                );

            } else {

                response.sendRedirect(
                        "viewPendingRequests?success=declined"
                );
            }


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
                    "viewPendingRequests?error=response"
            );
        }
    }
}