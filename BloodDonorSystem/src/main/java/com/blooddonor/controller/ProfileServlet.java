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

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    // =========================================================
    // GET PROFILE
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);


        // ==========================================
        // LOGIN CHECK
        // ==========================================

        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");

            return;
        }


        int userId =
                (Integer) session.getAttribute("userId");


        Connection con = null;


        try {

            con =
                    DBConnection.getConnection();


            // ==========================================
            // GET USER DETAILS
            // ==========================================

            String sql =
                    "SELECT user_id, name, email, phone, role " +
                    "FROM users " +
                    "WHERE user_id = ?";


            PreparedStatement ps =
                    con.prepareStatement(sql);


            ps.setInt(
                    1,
                    userId
            );


            ResultSet rs =
                    ps.executeQuery();


            if (rs.next()) {

                request.setAttribute(
                        "userId",
                        rs.getInt("user_id")
                );


                request.setAttribute(
                        "name",
                        rs.getString("name")
                );


                request.setAttribute(
                        "email",
                        rs.getString("email")
                );


                request.setAttribute(
                        "phone",
                        rs.getString("phone")
                );


                request.setAttribute(
                        "role",
                        rs.getString("role")
                );


            } else {

                rs.close();
                ps.close();
                con.close();

                response.sendRedirect(
                        "dashboard.jsp"
                );

                return;
            }


            rs.close();
            ps.close();
            con.close();


            // ==========================================
            // OPEN PROFILE PAGE
            // ==========================================

            request.getRequestDispatcher(
                    "profile.jsp"
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
                    "dashboard.jsp?error=profile"
            );
        }
    }


    // =========================================================
    // UPDATE PROFILE
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);


        // ==========================================
        // LOGIN CHECK
        // ==========================================

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

        String name =
                request.getParameter("name");

        String phone =
                request.getParameter("phone");


        // ==========================================
        // VALIDATION
        // ==========================================

        if (name == null ||
            name.trim().isEmpty()) {

            response.sendRedirect(
                    "profile?error=name"
            );

            return;
        }


        if (phone == null ||
            phone.trim().isEmpty()) {

            response.sendRedirect(
                    "profile?error=phone"
            );

            return;
        }


        phone =
                phone.trim();


        // ==========================================
        // PHONE VALIDATION
        // ==========================================

        if (!phone.matches("\\d{10}")) {

            response.sendRedirect(
                    "profile?error=invalidPhone"
            );

            return;
        }


        Connection con = null;


        try {

            con =
                    DBConnection.getConnection();


            // ==========================================
            // UPDATE USER
            // ==========================================

            String sql =
                    "UPDATE users " +
                    "SET name = ?, phone = ? " +
                    "WHERE user_id = ?";


            PreparedStatement ps =
                    con.prepareStatement(sql);


            ps.setString(
                    1,
                    name.trim()
            );


            ps.setString(
                    2,
                    phone
            );


            ps.setInt(
                    3,
                    userId
            );


            int rows =
                    ps.executeUpdate();


            ps.close();
            con.close();


            if (rows == 1) {

                // Update session name too
                session.setAttribute(
                        "userName",
                        name.trim()
                );


                response.sendRedirect(
                        "profile?success=updated"
                );

            } else {

                response.sendRedirect(
                        "profile?error=update"
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
                    "profile?error=database"
            );
        }
    }
}