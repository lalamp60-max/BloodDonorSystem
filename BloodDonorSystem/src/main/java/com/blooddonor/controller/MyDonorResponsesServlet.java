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

@WebServlet("/myDonorResponses")
public class MyDonorResponsesServlet extends HttpServlet {

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
        // LOGGED-IN USER
        // ==========================================

        int userId =
                (Integer) session.getAttribute("userId");


        List<String[]> responses =
                new ArrayList<>();


        Connection con = null;

        try {

            con =
                    DBConnection.getConnection();


            // =====================================================
            // 1. DONOR RESPONSES TO USER'S REQUESTS
            // =====================================================

            String donorSql =

                "SELECT " +

                "dr.response_id, " +
                "dr.request_id, " +
                "dr.donor_id, " +

                "u.name AS donor_name, " +
                "u.email AS donor_email, " +
                "u.phone AS donor_phone, " +

                "d.blood_group, " +
                "d.age, " +
                "d.gender, " +
                "d.city, " +

                "dr.response_status, " +
                "dr.response_date, " +

                "r.blood_group AS requested_blood_group, " +
                "r.units_required, " +
                "r.city AS requested_city " +

                "FROM donor_responses dr " +

                "JOIN requests r " +
                "ON dr.request_id = r.request_id " +

                "JOIN donors d " +
                "ON dr.donor_id = d.donor_id " +

                "JOIN users u " +
                "ON d.user_id = u.user_id " +

                "WHERE r.requester_id = ? " +

                "ORDER BY dr.response_date DESC";


            PreparedStatement donorPs =
                    con.prepareStatement(donorSql);


            donorPs.setInt(1, userId);


            ResultSet donorRs =
                    donorPs.executeQuery();


            while (donorRs.next()) {


                String[] r = {

                    // 0 - TYPE
                    "DONOR",

                    // 1 - Response ID
                    String.valueOf(
                        donorRs.getInt("response_id")
                    ),

                    // 2 - Request ID
                    String.valueOf(
                        donorRs.getInt("request_id")
                    ),

                    // 3 - Donor/Admin ID
                    String.valueOf(
                        donorRs.getInt("donor_id")
                    ),

                    // 4 - Name
                    donorRs.getString(
                        "donor_name"
                    ),

                    // 5 - Email
                    donorRs.getString(
                        "donor_email"
                    ),

                    // 6 - Phone
                    donorRs.getString(
                        "donor_phone"
                    ),

                    // 7 - Blood Group
                    donorRs.getString(
                        "blood_group"
                    ),

                    // 8 - Age
                    String.valueOf(
                        donorRs.getInt("age")
                    ),

                    // 9 - Gender
                    donorRs.getString(
                        "gender"
                    ),

                    // 10 - City
                    donorRs.getString(
                        "city"
                    ),

                    // 11 - Status
                    donorRs.getString(
                        "response_status"
                    ),

                    // 12 - Date
                    String.valueOf(
                        donorRs.getTimestamp(
                            "response_date"
                        )
                    ),

                    // 13 - Requested Blood
                    donorRs.getString(
                        "requested_blood_group"
                    ),

                    // 14 - Units
                    String.valueOf(
                        donorRs.getInt(
                            "units_required"
                        )
                    ),

                    // 15 - Requested City
                    donorRs.getString(
                        "requested_city"
                    )
                };


                responses.add(r);
            }


            donorRs.close();

            donorPs.close();


            // =====================================================
            // 2. ADMIN ACTIONS ON USER'S REQUESTS
            // =====================================================

            String adminSql =

                "SELECT " +

                "r.request_id, " +
                "r.blood_group, " +
                "r.units_required, " +
                "r.city, " +
                "r.status, " +
                "r.admin_id, " +
                "r.admin_action_date, " +

                "a.name AS admin_name, " +
                "a.email AS admin_email " +

                "FROM requests r " +

                "JOIN admin a " +
                "ON r.admin_id = a.admin_id " +

                "WHERE r.requester_id = ? " +

                "AND r.admin_id IS NOT NULL " +

                "ORDER BY r.admin_action_date DESC";


            PreparedStatement adminPs =
                    con.prepareStatement(adminSql);


            adminPs.setInt(1, userId);


            ResultSet adminRs =
                    adminPs.executeQuery();


            while (adminRs.next()) {


                String[] r = {

                    // 0 - TYPE
                    "ADMIN",

                    // 1 - Response ID
                    "-"
                    ,

                    // 2 - Request ID
                    String.valueOf(
                        adminRs.getInt(
                            "request_id"
                        )
                    ),

                    // 3 - Admin ID
                    String.valueOf(
                        adminRs.getInt(
                            "admin_id"
                        )
                    ),

                    // 4 - Admin Name
                    adminRs.getString(
                        "admin_name"
                    ),

                    // 5 - Admin Email
                    adminRs.getString(
                        "admin_email"
                    ),

                    // 6 - Admin Phone
                    "System",

                    // 7 - Blood Group
                    adminRs.getString(
                        "blood_group"
                    ),

                    // 8 - Age
                    "-",

                    // 9 - Gender
                    "-",

                    // 10 - City
                    "System",

                    // 11 - Status / Action
                    adminRs.getString(
                        "status"
                    ),

                    // 12 - Action Date
                    String.valueOf(
                        adminRs.getTimestamp(
                            "admin_action_date"
                        )
                    ),

                    // 13 - Requested Blood
                    adminRs.getString(
                        "blood_group"
                    ),

                    // 14 - Units
                    String.valueOf(
                        adminRs.getInt(
                            "units_required"
                        )
                    ),

                    // 15 - Requested City
                    adminRs.getString(
                        "city"
                    )
                };


                responses.add(r);
            }


            adminRs.close();

            adminPs.close();


            con.close();


            // =====================================================
            // SEND BOTH DONOR + ADMIN RESPONSES TO JSP
            // =====================================================

            request.setAttribute(
                "responses",
                responses
            );


            request.getRequestDispatcher(
                "my-donor-responses.jsp"
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
                "dashboard.jsp?error=responses"
            );
        }
    }
}