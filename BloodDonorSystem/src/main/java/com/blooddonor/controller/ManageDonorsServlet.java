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

import com.blooddonor.model.Donor;
import com.blooddonor.util.DBConnection;

@WebServlet("/manageDonors")
public class ManageDonorsServlet extends HttpServlet {

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


        List<Donor> donors =
                new ArrayList<>();


        // ===============================
        // SQL
        // ===============================

        String sql =
            "SELECT donor_id, user_id, blood_group, " +
            "age, gender, city, availability, " +
            "last_donation_date " +
            "FROM donors " +
            "ORDER BY donor_id DESC";


        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();


            while (rs.next()) {

                Donor donor =
                        new Donor();


                donor.setDonorId(
                    rs.getInt("donor_id")
                );


                donor.setUserId(
                    rs.getInt("user_id")
                );


                donor.setBloodGroup(
                    rs.getString("blood_group")
                );


                donor.setAge(
                    rs.getInt("age")
                );


                donor.setGender(
                    rs.getString("gender")
                );


                donor.setCity(
                    rs.getString("city")
                );


                donor.setAvailability(
                    rs.getBoolean("availability")
                );


                donor.setLastDonationDate(
                    rs.getDate("last_donation_date")
                );


                donors.add(donor);
            }


            rs.close();

            ps.close();

            con.close();


            // ===============================
            // SEND TO JSP
            // ===============================

            request.setAttribute(
                "donors",
                donors
            );


            request.getRequestDispatcher(
                "manage-donors.jsp"
            ).forward(
                request,
                response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "admin-dashboard.jsp?error=donors"
            );
        }
    }
}
