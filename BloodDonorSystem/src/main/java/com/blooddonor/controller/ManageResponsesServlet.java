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

import com.blooddonor.model.DonorResponse;
import com.blooddonor.util.DBConnection;

@WebServlet("/manageResponses")
public class ManageResponsesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // ===============================
        // ADMIN LOGIN CHECK
        // ===============================

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("adminId") == null) {

            response.sendRedirect("admin-login.jsp");
            return;
        }


        List<DonorResponse> responses =
                new ArrayList<>();


        /*
         * JOIN donor_responses with donors
         *
         * This gives us blood group and city
         * of the donor.
         */

        String sql =
            "SELECT dr.response_id, " +
            "dr.request_id, " +
            "dr.donor_id, " +
            "d.blood_group, " +
            "d.city, " +
            "dr.response_status, " +
            "dr.response_date " +

            "FROM donor_responses dr " +

            "JOIN donors d " +
            "ON dr.donor_id = d.donor_id " +

            "ORDER BY dr.response_id DESC";


        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();


            while (rs.next()) {

                DonorResponse dr =
                        new DonorResponse();


                dr.setResponseId(
                    rs.getInt("response_id")
                );


                dr.setRequestId(
                    rs.getInt("request_id")
                );


                dr.setDonorId(
                    rs.getInt("donor_id")
                );


                dr.setBloodGroup(
                    rs.getString("blood_group")
                );


                dr.setCity(
                    rs.getString("city")
                );


                dr.setResponseStatus(
                    rs.getString("response_status")
                );


                dr.setResponseDate(
                    rs.getTimestamp("response_date")
                );


                responses.add(dr);
            }


            rs.close();

            ps.close();

            con.close();


            request.setAttribute(
                "responses",
                responses
            );


            request.getRequestDispatcher(
                "manage-responses.jsp"
            ).forward(
                request,
                response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "admin-dashboard.jsp?error=responses"
            );
        }
    }
}