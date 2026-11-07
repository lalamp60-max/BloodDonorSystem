package com.blooddonor.controller;
import com.blooddonor.model.User;
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

@WebServlet("/manageUsers")
public class ManageUsersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Admin login check
        if (session == null ||
            session.getAttribute("adminId") == null) {

            response.sendRedirect("admin-login.jsp");
            return;
        }

        List<User> users =
                new ArrayList<>();

        String sql =
            "SELECT user_id, name, email, phone, role " +
            "FROM users ORDER BY user_id DESC";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                User user = new User();

                user.setUserId(
                    rs.getInt("user_id")
                );

                user.setName(
                    rs.getString("name")
                );

                user.setEmail(
                    rs.getString("email")
                );

                user.setPhone(
                    rs.getString("phone")
                );

                user.setRole(
                    rs.getString("role")
                );

                users.add(user);
            }

            rs.close();
            ps.close();
            con.close();

            request.setAttribute(
                "users",
                users
            );

            request.getRequestDispatcher(
                "manage-users.jsp"
            ).forward(
                request,
                response
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "admin-dashboard.jsp?error=users"
            );
        }
    }
}