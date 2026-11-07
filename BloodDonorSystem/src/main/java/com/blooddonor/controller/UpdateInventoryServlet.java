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

@WebServlet("/updateInventory")
public class UpdateInventoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
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


        String bloodGroup =
                request.getParameter("bloodGroup");

        String unitsString =
                request.getParameter("units");


        try {

            int units =
                    Integer.parseInt(unitsString);


            // Negative units not allowed

            if (units < 0) {

                response.sendRedirect(
                    "bloodInventory?error=negative"
                );

                return;
            }


            Connection con =
                    DBConnection.getConnection();


            // ==========================================
            // CHECK WHETHER BLOOD GROUP ALREADY EXISTS
            // ==========================================

            String checkSql =
                "SELECT inventory_id " +
                "FROM blood_inventory " +
                "WHERE blood_group=?";


            PreparedStatement checkPs =
                    con.prepareStatement(checkSql);

            checkPs.setString(1, bloodGroup);

            ResultSet rs =
                    checkPs.executeQuery();


            if (rs.next()) {

                // ==========================================
                // UPDATE EXISTING BLOOD GROUP
                // ==========================================

                int inventoryId =
                        rs.getInt("inventory_id");


                String updateSql =
                    "UPDATE blood_inventory " +
                    "SET units_available=? " +
                    "WHERE inventory_id=?";


                PreparedStatement updatePs =
                        con.prepareStatement(updateSql);


                updatePs.setInt(1, units);

                updatePs.setInt(
                    2,
                    inventoryId
                );


                updatePs.executeUpdate();

                updatePs.close();


            } else {

                // ==========================================
                // ADD NEW BLOOD GROUP
                // ==========================================

                String insertSql =
                    "INSERT INTO blood_inventory " +
                    "(blood_group, units_available) " +
                    "VALUES (?, ?)";


                PreparedStatement insertPs =
                        con.prepareStatement(insertSql);


                insertPs.setString(
                    1,
                    bloodGroup
                );

                insertPs.setInt(
                    2,
                    units
                );


                insertPs.executeUpdate();

                insertPs.close();
            }


            rs.close();
            checkPs.close();
            con.close();


            // ==========================================
            // BACK TO INVENTORY
            // ==========================================

            response.sendRedirect(
                "bloodInventory?success=updated"
            );


        } catch (NumberFormatException e) {

            response.sendRedirect(
                "bloodInventory?error=invalid"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "bloodInventory?error=database"
            );
        }
    }
}
