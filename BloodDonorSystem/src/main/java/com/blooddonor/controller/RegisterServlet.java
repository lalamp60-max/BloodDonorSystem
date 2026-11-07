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

import com.blooddonor.util.DBConnection;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // ==========================================
        // GET FORM DATA
        // ==========================================

        String name =
                request.getParameter("name");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        String phone =
                request.getParameter("phone");


        // ==========================================
        // VALIDATION
        // ==========================================

        if (name == null ||
            email == null ||
            password == null ||
            phone == null ||
            name.trim().isEmpty() ||
            email.trim().isEmpty() ||
            password.trim().isEmpty() ||
            phone.trim().isEmpty()) {

            response.sendRedirect(
                    "register.jsp?error=empty"
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
                    "register.jsp?error=phone"
            );

            return;
        }


        Connection con = null;


        try {

            con =
                    DBConnection.getConnection();


            // ==========================================
            // CHECK EMAIL
            // ==========================================

            String checkSql =
                    "SELECT user_id " +
                    "FROM users " +
                    "WHERE email = ?";


            PreparedStatement checkPs =
                    con.prepareStatement(
                            checkSql
                    );


            checkPs.setString(
                    1,
                    email.trim()
            );


            ResultSet checkRs =
                    checkPs.executeQuery();


            if (checkRs.next()) {

                checkRs.close();
                checkPs.close();
                con.close();

                response.sendRedirect(
                        "register.jsp?error=email"
                );

                return;
            }


            checkRs.close();
            checkPs.close();


            // ==========================================
            // INSERT USER
            // ==========================================

            String sql =
                    "INSERT INTO users " +
                    "(name, email, password, phone, role) " +
                    "VALUES (?, ?, ?, ?, 'USER')";


            PreparedStatement ps =
                    con.prepareStatement(sql);


            ps.setString(
                    1,
                    name.trim()
            );


            ps.setString(
                    2,
                    email.trim()
            );


            ps.setString(
                    3,
                    password
            );


            ps.setString(
                    4,
                    phone
            );


            int rows =
                    ps.executeUpdate();


            ps.close();
            con.close();


            if (rows == 1) {

                response.sendRedirect(
                        "login.jsp?success=registered"
                );

            } else {

                response.sendRedirect(
                        "register.jsp?error=failed"
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
                    "register.jsp?error=database"
            );
        }
    }
}