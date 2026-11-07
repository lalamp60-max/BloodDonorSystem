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

@WebServlet("/addDonor")
public class AddDonorServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        int userId =
                (Integer) session.getAttribute("userId");

        String bloodGroup =
                request.getParameter("bloodGroup");

        int age =
                Integer.parseInt(
                    request.getParameter("age")
                );

        String gender =
                request.getParameter("gender");

        String city =
                request.getParameter("city");

        String sql =
            "INSERT INTO donors " +
            "(user_id, blood_group, age, gender, city, availability) " +
            "VALUES (?, ?, ?, ?, ?, ?)";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setString(2, bloodGroup);
            ps.setInt(3, age);
            ps.setString(4, gender);
            ps.setString(5, city);
            ps.setBoolean(6, true);

            int rows =
                    ps.executeUpdate();

            ps.close();
            con.close();

            if (rows > 0) {

                response.sendRedirect(
                    "dashboard.jsp?success=donor"
                );

            } else {

                response.sendRedirect(
                    "add-donor.jsp?error=1"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "add-donor.jsp?error=1"
            );
        }
    }
}
