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

import com.blooddonor.model.Notification;
import com.blooddonor.util.DBConnection;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // =====================================================
        // LOGIN CHECK
        // =====================================================

        HttpSession session =
                request.getSession(false);


        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");

            return;
        }


        int userId =
                (Integer) session.getAttribute(
                        "userId"
                );


        List<Notification> notifications =
                new ArrayList<>();


        Connection con = null;


        try {

            // =================================================
            // DATABASE CONNECTION
            // =================================================

            con =
                    DBConnection.getConnection();


            // =================================================
            // GET ALL NOTIFICATIONS
            // =================================================

            String sql =
                    "SELECT notification_id, " +
                    "user_id, " +
                    "request_id, " +
                    "message, " +
                    "notification_type, " +
                    "is_read, " +
                    "created_at " +

                    "FROM notifications " +

                    "WHERE user_id = ? " +

                    "ORDER BY created_at DESC";


            PreparedStatement ps =
                    con.prepareStatement(sql);


            ps.setInt(
                    1,
                    userId
            );


            ResultSet rs =
                    ps.executeQuery();


            // =================================================
            // READ NOTIFICATIONS
            // =================================================

            while (rs.next()) {

                Notification notification =
                        new Notification();


                notification.setNotificationId(
                        rs.getInt(
                                "notification_id"
                        )
                );


                notification.setUserId(
                        rs.getInt(
                                "user_id"
                        )
                );


                notification.setRequestId(
                        rs.getInt(
                                "request_id"
                        )
                );


                notification.setMessage(
                        rs.getString(
                                "message"
                        )
                );


                notification.setNotificationType(
                        rs.getString(
                                "notification_type"
                        )
                );


                notification.setRead(
                        rs.getBoolean(
                                "is_read"
                        )
                );


                notification.setCreatedAt(
                        rs.getTimestamp(
                                "created_at"
                        )
                );


                notifications.add(
                        notification
                );
            }


            rs.close();

            ps.close();


            // =================================================
            // COUNT UNREAD NOTIFICATIONS
            // =================================================

            int unreadCount = 0;


            String countSql =
                    "SELECT COUNT(*) AS total " +
                    "FROM notifications " +
                    "WHERE user_id = ? " +
                    "AND is_read = FALSE";


            PreparedStatement countPs =
                    con.prepareStatement(
                            countSql
                    );


            countPs.setInt(
                    1,
                    userId
            );


            ResultSet countRs =
                    countPs.executeQuery();


            if (countRs.next()) {

                unreadCount =
                        countRs.getInt(
                                "total"
                        );
            }


            countRs.close();

            countPs.close();


            // =================================================
            // SEND DATA TO JSP
            // =================================================

            request.setAttribute(
                    "notifications",
                    notifications
            );


            request.setAttribute(
                    "unreadCount",
                    unreadCount
            );


            // =================================================
            // CLOSE CONNECTION
            // =================================================

            con.close();


            // =================================================
            // OPEN NOTIFICATIONS PAGE
            // =================================================

            request.getRequestDispatcher(
                    "notifications.jsp"
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
                    "dashboard.jsp?error=notifications"
            );
        }
    }
}