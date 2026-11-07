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

@WebServlet("/viewPendingRequests")
public class ViewPendingRequestsServlet extends HttpServlet {

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
         * =========================================================
         * SHOW ONLY OTHER USERS' PENDING REQUESTS
         *
         * Own request:
         *     requester_id <> logged-in user
         *
         * Already responded:
         *     excluded using NOT EXISTS
         *
         * Emergency requests:
         *     displayed first
         *
         * Normal requests:
         *     displayed after emergency requests
         * =========================================================
         */

        String sql =

            "SELECT " +
            "r.request_id, " +
            "r.requester_id, " +
            "r.blood_group, " +
            "r.units_required, " +
            "r.city, " +
            "r.status, " +
            "r.request_date, " +
            "r.emergency " +

            "FROM requests r " +

            "WHERE r.status = 'PENDING' " +

            "AND r.requester_id <> ? " +

            "AND NOT EXISTS (" +

                "SELECT 1 " +

                "FROM donor_responses dr " +

                "JOIN donors d " +
                "ON dr.donor_id = d.donor_id " +

                "WHERE dr.request_id = r.request_id " +

                "AND d.user_id = ? " +

            ") " +

            /*
             * Emergency requests first
             */
            "ORDER BY r.emergency DESC, " +

            /*
             * Newest request next
             */
            "r.request_date DESC";


        try {

            // ==========================================
            // DATABASE CONNECTION
            // ==========================================

            Connection con =
                    DBConnection.getConnection();


            PreparedStatement ps =
                    con.prepareStatement(sql);


            /*
             * First ?:
             *     requester_id
             *
             * Second ?:
             *     logged-in user's ID
             */

            ps.setInt(1, userId);
            ps.setInt(2, userId);


            // ==========================================
            // EXECUTE QUERY
            // ==========================================

            ResultSet rs =
                    ps.executeQuery();


            // ==========================================
            // READ REQUESTS
            // ==========================================

            while (rs.next()) {

                String[] r = {

                    // =================================
                    // 0 - REQUEST ID
                    // =================================

                    String.valueOf(
                        rs.getInt("request_id")
                    ),


                    // =================================
                    // 1 - REQUESTER ID
                    // =================================

                    String.valueOf(
                        rs.getInt("requester_id")
                    ),


                    // =================================
                    // 2 - BLOOD GROUP
                    // =================================

                    rs.getString(
                        "blood_group"
                    ),


                    // =================================
                    // 3 - UNITS REQUIRED
                    // =================================

                    String.valueOf(
                        rs.getInt("units_required")
                    ),


                    // =================================
                    // 4 - CITY
                    // =================================

                    rs.getString(
                        "city"
                    ),


                    // =================================
                    // 5 - STATUS
                    // =================================

                    rs.getString(
                        "status"
                    ),


                    // =================================
                    // 6 - REQUEST DATE
                    // =================================

                    String.valueOf(
                        rs.getTimestamp(
                            "request_date"
                        )
                    ),


                    // =================================
                    // 7 - EMERGENCY
                    // =================================

                    String.valueOf(
                        rs.getBoolean("emergency")
                    )
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
                "pending-requests.jsp"
            ).forward(
                request,
                response
            );


        } catch (Exception e) {

            e.printStackTrace();


            response.sendRedirect(
                "dashboard.jsp?error=pendingRequests"
            );
        }
    }
}