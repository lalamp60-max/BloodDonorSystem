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

@WebServlet("/myRequests")
public class MyRequestsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // ==========================================
        // LOGIN CHECK
        // ==========================================

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }


        // ==========================================
        // LOGGED-IN USER ID
        // ==========================================

        int userId =
                (Integer) session.getAttribute("userId");


        // ==========================================
        // REQUEST LIST
        // ==========================================

        List<String[]> requests =
                new ArrayList<>();


        /*
         * =====================================================
         * GET USER'S REQUESTS
         *
         * If an accepted donor exists:
         *     show donor details.
         *
         * If no donor exists and request was processed
         * by admin:
         *     show Admin as the handler.
         *
         * Pending request:
         *     show Waiting for response.
         * =====================================================
         */

        String sql =

            "SELECT " +

            "r.request_id, " +
            "r.blood_group, " +
            "r.units_required, " +
            "r.city, " +
            "r.status, " +
            "r.request_date, " +

            "dr.response_status, " +

            "d.donor_id, " +

            "u.name AS donor_name, " +

            "u.email AS donor_email, " +

            /*
             * Actor type
             *
             * DONOR = accepted donor exists
             * ADMIN = request processed but no donor response
             * WAITING = still pending
             */

            "CASE " +

                "WHEN dr.donor_id IS NOT NULL " +
                "THEN 'DONOR' " +

                "WHEN r.status IN " +
                "('APPROVED', 'REJECTED', 'COMPLETED') " +
                "THEN 'ADMIN' " +

                "ELSE 'WAITING' " +

            "END AS actor_type " +

            "FROM requests r " +


            /*
             * Find accepted donor response
             */

            "LEFT JOIN donor_responses dr " +

            "ON r.request_id = dr.request_id " +

            "AND dr.response_status = 'ACCEPTED' " +


            /*
             * Donor information
             */

            "LEFT JOIN donors d " +

            "ON dr.donor_id = d.donor_id " +


            /*
             * Donor's user information
             */

            "LEFT JOIN users u " +

            "ON d.user_id = u.user_id " +


            /*
             * Only current user's requests
             */

            "WHERE r.requester_id = ? " +


            "ORDER BY r.request_date DESC";


        try {

            Connection con =
                    DBConnection.getConnection();


            PreparedStatement ps =
                    con.prepareStatement(sql);


            ps.setInt(1, userId);


            ResultSet rs =
                    ps.executeQuery();


            while (rs.next()) {


                String donorId =
                        rs.getString("donor_id");


                String donorName =
                        rs.getString("donor_name");


                String donorEmail =
                        rs.getString("donor_email");


                String donorResponse =
                        rs.getString("response_status");


                String actorType =
                        rs.getString("actor_type");


                /*
                 * ==========================================
                 * DONOR ACTION
                 * ==========================================
                 */

                if ("DONOR".equalsIgnoreCase(actorType)) {

                    if (donorId == null) {
                        donorId = "-";
                    }

                    if (donorName == null) {
                        donorName = "-";
                    }

                    if (donorEmail == null) {
                        donorEmail = "-";
                    }

                    if (donorResponse == null) {
                        donorResponse = "ACCEPTED";
                    }
                }


                /*
                 * ==========================================
                 * ADMIN ACTION
                 * ==========================================
                 */

                else if ("ADMIN".equalsIgnoreCase(actorType)) {

                    donorId =
                            "ADMIN";

                    donorName =
                            "Administrator";

                    donorEmail =
                            "System Administrator";

                    donorResponse =
                            rs.getString("status");
                }


                /*
                 * ==========================================
                 * WAITING
                 * ==========================================
                 */

                else {

                    donorId =
                            "-";

                    donorName =
                            "-";

                    donorEmail =
                            "-";

                    donorResponse =
                            "-";
                }


                /*
                 * ==========================================
                 * CREATE ARRAY
                 * ==========================================
                 *
                 * r[0]  = Request ID
                 * r[1]  = Blood Group
                 * r[2]  = Units
                 * r[3]  = City
                 * r[4]  = Status
                 * r[5]  = Request Date
                 * r[6]  = Donor/Admin ID
                 * r[7]  = Donor/Admin Name
                 * r[8]  = Donor/Admin Email
                 * r[9]  = Response/Action
                 * r[10] = Actor Type
                 */

                String[] r = {

                    // Request ID
                    String.valueOf(
                        rs.getInt("request_id")
                    ),

                    // Blood Group
                    rs.getString(
                        "blood_group"
                    ),

                    // Units
                    String.valueOf(
                        rs.getInt("units_required")
                    ),

                    // City
                    rs.getString(
                        "city"
                    ),

                    // Status
                    rs.getString(
                        "status"
                    ),

                    // Request Date
                    String.valueOf(
                        rs.getTimestamp(
                            "request_date"
                        )
                    ),

                    // Donor/Admin ID
                    donorId,

                    // Donor/Admin Name
                    donorName,

                    // Donor/Admin Email
                    donorEmail,

                    // Response/Action
                    donorResponse,

                    // Actor Type
                    actorType
                };


                requests.add(r);
            }


            // ==========================================
            // CLOSE RESOURCES
            // ==========================================

            rs.close();

            ps.close();

            con.close();


            // ==========================================
            // SEND DATA TO JSP
            // ==========================================

            request.setAttribute(
                "requests",
                requests
            );


            request.getRequestDispatcher(
                "my-requests.jsp"
            ).forward(
                request,
                response
            );


        } catch (Exception e) {

            e.printStackTrace();


            response.sendRedirect(
                "dashboard.jsp?error=myRequests"
            );
        }
    }
}