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

@WebServlet("/respondToRequest")
public class RespondToRequestServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        int userId =
                (Integer) session.getAttribute("userId");

        int requestId =
                Integer.parseInt(
                    request.getParameter("requestId")
                );

        String responseStatus =
                request.getParameter("responseStatus");

        Connection con = null;

        try {

            con = DBConnection.getConnection();

            /*
             * Get donor_id belonging to
             * logged-in user
             */
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
                    "viewPendingRequests"
                );

                return;
            }

            int donorId =
                donorRs.getInt("donor_id");

            donorRs.close();
            donorPs.close();


            /*
             * Insert response
             */
            String insertSql =
                "INSERT INTO donor_responses " +
                "(request_id, donor_id, response_status) " +
                "VALUES (?, ?, ?)";

            PreparedStatement ps =
                con.prepareStatement(insertSql);

            ps.setInt(1, requestId);
            ps.setInt(2, donorId);
            ps.setString(3, responseStatus);

            ps.executeUpdate();

            ps.close();
            con.close();


            response.sendRedirect(
                "viewPendingRequests?success=1"
            );

        } catch (Exception e) {

            e.printStackTrace();

            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ignored) {
            }

            response.sendRedirect(
                "viewPendingRequests?error=1"
            );
        }
    }
}