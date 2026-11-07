package com.blooddonor.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.blooddonor.util.DBConnection;

@WebServlet("/createRequest")
public class CreateRequestServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
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


        int userId =
                (Integer) session.getAttribute("userId");


        // ==========================================
        // GET FORM DATA
        // ==========================================

        String bloodGroup =
                request.getParameter("bloodGroup");

        String unitsValue =
                request.getParameter("units");

        String city =
                request.getParameter("city");

        String emergencyValue =
                request.getParameter("emergency");


        // ==========================================
        // VALIDATION
        // ==========================================

        if (bloodGroup == null ||
            bloodGroup.trim().isEmpty() ||
            unitsValue == null ||
            unitsValue.trim().isEmpty() ||
            city == null ||
            city.trim().isEmpty()) {

            response.sendRedirect(
                "create-request.jsp?error=empty"
            );

            return;
        }


        int units;

        try {

            units =
                Integer.parseInt(unitsValue);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                "create-request.jsp?error=invalidUnits"
            );

            return;
        }


        if (units <= 0) {

            response.sendRedirect(
                "create-request.jsp?error=invalidUnits"
            );

            return;
        }


        // ==========================================
        // EMERGENCY VALUE
        // ==========================================

        boolean emergency =
                "YES".equalsIgnoreCase(emergencyValue);


        Connection con = null;


        try {

            con =
                DBConnection.getConnection();


            // ==========================================
            // INSERT REQUEST
            // ==========================================

            String sql =
                "INSERT INTO requests " +
                "(requester_id, blood_group, " +
                "units_required, city, status, emergency) " +
                "VALUES (?, ?, ?, ?, 'PENDING', ?)";


            PreparedStatement ps =
                con.prepareStatement(sql);


            ps.setInt(1, userId);

            ps.setString(
                2,
                bloodGroup.trim()
            );

            ps.setInt(
                3,
                units
            );

            ps.setString(
                4,
                city.trim()
            );

            ps.setBoolean(
                5,
                emergency
            );


            int rows =
                ps.executeUpdate();


            ps.close();

            con.close();


            if (rows == 1) {

                response.sendRedirect(
                    "create-request.jsp?success=created"
                );

            } else {

                response.sendRedirect(
                    "create-request.jsp?error=failed"
                );
            }


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
                "create-request.jsp?error=database"
            );
        }
    }
}