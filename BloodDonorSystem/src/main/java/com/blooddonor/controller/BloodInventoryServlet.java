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

import com.blooddonor.model.BloodInventory;
import com.blooddonor.util.DBConnection;

@WebServlet("/bloodInventory")
public class BloodInventoryServlet extends HttpServlet {

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


        List<BloodInventory> inventoryList =
                new ArrayList<>();


        // ===============================
        // SQL QUERY
        // ===============================

        String sql =
            "SELECT inventory_id, blood_group, " +
            "units_available, last_updated " +
            "FROM blood_inventory " +
            "ORDER BY blood_group";


        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();


            while (rs.next()) {

                BloodInventory inventory =
                        new BloodInventory();


                inventory.setInventoryId(
                    rs.getInt("inventory_id")
                );


                inventory.setBloodGroup(
                    rs.getString("blood_group")
                );


                inventory.setUnitsAvailable(
                    rs.getInt("units_available")
                );


                inventory.setLastUpdated(
                    rs.getTimestamp("last_updated")
                );


                inventoryList.add(inventory);
            }


            rs.close();
            ps.close();
            con.close();


            // ===============================
            // SEND DATA TO JSP
            // ===============================

            request.setAttribute(
                "inventoryList",
                inventoryList
            );


            request.getRequestDispatcher(
                "blood-inventory.jsp"
            ).forward(
                request,
                response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "admin-dashboard.jsp?error=inventory"
            );
        }
    }
}