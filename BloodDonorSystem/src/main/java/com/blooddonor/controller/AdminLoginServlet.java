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

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");


        String sql =
            "SELECT admin_id, name, email " +
            "FROM admin " +
            "WHERE email = ? AND password = ?";


        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, email);

            ps.setString(2, password);


            ResultSet rs =
                    ps.executeQuery();


            if (rs.next()) {

                // Create admin session
                HttpSession session =
                        request.getSession();

                session.setAttribute(
                    "adminId",
                    rs.getInt("admin_id")
                );

                session.setAttribute(
                    "adminName",
                    rs.getString("name")
                );

                session.setAttribute(
                    "adminEmail",
                    rs.getString("email")
                );


                response.sendRedirect(
                    "adminDashboard"
                );

            } else {

                response.sendRedirect(
                    "admin-login.jsp?error=invalid"
                );
            }


            rs.close();

            ps.close();

            con.close();


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "admin-login.jsp?error=database"
            );
        }
    }
}