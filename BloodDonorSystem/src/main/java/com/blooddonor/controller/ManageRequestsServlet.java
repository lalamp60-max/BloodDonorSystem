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

@WebServlet("/manageRequests")
public class ManageRequestsServlet extends HttpServlet {

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


        // =====================================================
        // REQUEST LIST
        // =====================================================

        List<String[]> requests =
                new ArrayList<>();


        Connection con = null;


        try {

            // =================================================
            // DATABASE CONNECTION
            // =================================================

            con =
                    DBConnection.getConnection();


            // =================================================
            // FETCH REQUESTS
            // =================================================

            /*
             * We are joining users table because
             * manage-requests.jsp also displays
             * requester name.
             *
             * We are also fetching emergency because
             * emergency requests are highlighted.
             */

            String sql =

                "SELECT " +

                "r.request_id, " +
                "r.requester_id, " +
                "u.name AS requester_name, " +
                "r.blood_group, " +
                "r.units_required, " +
                "r.city, " +
                "r.status, " +
                "r.request_date, " +
                "r.emergency " +

                "FROM requests r " +

                "LEFT JOIN users u " +

                "ON r.requester_id = u.user_id " +

                "ORDER BY " +

                "r.emergency DESC, " +

                "r.request_date DESC";


            PreparedStatement ps =
                    con.prepareStatement(
                            sql
                    );


            ResultSet rs =
                    ps.executeQuery();


            // =================================================
            // READ REQUESTS
            // =================================================

            while (rs.next()) {


                String requesterName =
                        rs.getString(
                                "requester_name"
                        );


                /*
                 * If requester name is NULL
                 * show Unknown User instead.
                 */

                if (requesterName == null ||
                    requesterName.trim().isEmpty()) {

                    requesterName =
                            "Unknown User";
                }


                String[] r = {

                    // =========================================
                    // 0 - REQUEST ID
                    // =========================================

                    String.valueOf(
                        rs.getInt(
                            "request_id"
                        )
                    ),


                    // =========================================
                    // 1 - REQUESTER ID
                    // =========================================

                    String.valueOf(
                        rs.getInt(
                            "requester_id"
                        )
                    ),


                    // =========================================
                    // 2 - REQUESTER NAME
                    // =========================================

                    requesterName,


                    // =========================================
                    // 3 - BLOOD GROUP
                    // =========================================

                    rs.getString(
                        "blood_group"
                    ),


                    // =========================================
                    // 4 - UNITS REQUIRED
                    // =========================================

                    String.valueOf(
                        rs.getInt(
                            "units_required"
                        )
                    ),


                    // =========================================
                    // 5 - CITY
                    // =========================================

                    rs.getString(
                        "city"
                    ),


                    // =========================================
                    // 6 - STATUS
                    // =========================================

                    rs.getString(
                        "status"
                    ),


                    // =========================================
                    // 7 - REQUEST DATE
                    // =========================================

                    String.valueOf(
                        rs.getTimestamp(
                            "request_date"
                        )
                    ),


                    // =========================================
                    // 8 - EMERGENCY
                    // =========================================

                    String.valueOf(
                        rs.getBoolean(
                            "emergency"
                        )
                    )
                };


                requests.add(r);
            }


            // =================================================
            // CLOSE RESOURCES
            // =================================================

            rs.close();

            ps.close();

            con.close();


            // =================================================
            // SEND DATA TO JSP
            // =================================================

            request.setAttribute(
                    "requests",
                    requests
            );


            // =================================================
            // OPEN MANAGE REQUESTS PAGE
            // =================================================

            request.getRequestDispatcher(
                    "manage-requests.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (Exception e) {

            // =================================================
            // PRINT ACTUAL ERROR IN ECLIPSE CONSOLE
            // =================================================

            e.printStackTrace();


            // =================================================
            // CLOSE CONNECTION
            // =================================================

            try {

                if (con != null &&
                    !con.isClosed()) {

                    con.close();
                }

            } catch (Exception ex) {

                ex.printStackTrace();
            }


            // =================================================
            // REDIRECT TO ADMIN DASHBOARD
            // =================================================

            response.sendRedirect(
                    "admin-dashboard.jsp?error=requests"
            );
        }
    }
}