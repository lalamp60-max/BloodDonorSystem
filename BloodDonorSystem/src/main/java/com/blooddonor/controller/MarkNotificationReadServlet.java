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

@WebServlet("/markNotificationRead")
public class MarkNotificationReadServlet extends HttpServlet {

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


        String notificationIdValue =
                request.getParameter("notificationId");


        try {

            int notificationId =
                    Integer.parseInt(
                            notificationIdValue
                    );


            Connection con =
                    DBConnection.getConnection();


            String sql =
                    "UPDATE notifications " +
                    "SET is_read = TRUE " +
                    "WHERE notification_id = ? " +
                    "AND user_id = ?";


            PreparedStatement ps =
                    con.prepareStatement(sql);


            ps.setInt(1, notificationId);
            ps.setInt(2, userId);


            ps.executeUpdate();


            ps.close();
            con.close();


            response.sendRedirect(
                    "notifications"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "notifications?error=read"
            );
        }
    }
}