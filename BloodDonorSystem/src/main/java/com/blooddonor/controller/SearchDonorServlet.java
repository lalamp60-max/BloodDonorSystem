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

import com.blooddonor.util.DBConnection;

@WebServlet("/searchDonor")
public class SearchDonorServlet extends HttpServlet {

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


        // =====================================================
        // GET SEARCH VALUES
        // =====================================================

        String bloodGroup =
                request.getParameter("bloodGroup");

        String city =
                request.getParameter("city");

        String availability =
                request.getParameter("availability");


        // =====================================================
        // DEFAULT VALUES
        // =====================================================

        if (bloodGroup == null) {

            bloodGroup = "";
        }


        if (city == null) {

            city = "";
        }


        if (availability == null ||
            availability.trim().isEmpty()) {

            availability = "AVAILABLE";
        }


        bloodGroup =
                bloodGroup.trim();

        city =
                city.trim();

        availability =
                availability.trim().toUpperCase();


        // =====================================================
        // DONOR RESULT LIST
        // =====================================================

        List<String[]> donors =
                new ArrayList<>();


        // =====================================================
        // INVENTORY LIST
        // =====================================================

        List<String[]> inventory =
                new ArrayList<>();


        Connection con = null;


        try {

            con =
                    DBConnection.getConnection();


            // =================================================
            // BUILD DONOR SEARCH QUERY
            // =================================================

            StringBuilder sql =
                    new StringBuilder();


            sql.append(

                "SELECT " +

                "d.donor_id, " +

                "u.name, " +

                "u.email, " +

                "u.phone, " +

                "d.blood_group, " +

                "d.age, " +

                "d.gender, " +

                "d.city, " +

                "d.availability " +

                "FROM donors d " +

                "JOIN users u " +

                "ON d.user_id = u.user_id " +

                "WHERE 1=1 "
            );


            List<Object> parameters =
                    new ArrayList<>();


            // =================================================
            // BLOOD GROUP FILTER
            // =================================================

            if (!bloodGroup.isEmpty()) {

                sql.append(
                    "AND d.blood_group = ? "
                );

                parameters.add(
                    bloodGroup
                );
            }


            // =================================================
            // CITY FILTER
            // =================================================

            if (!city.isEmpty()) {

                sql.append(
                    "AND LOWER(d.city) = LOWER(?) "
                );

                parameters.add(
                    city
                );
            }


            // =================================================
            // AVAILABILITY FILTER
            // =================================================

            if ("AVAILABLE".equals(
                    availability)) {

                sql.append(
                    "AND d.availability = TRUE "
                );
            }


            // =================================================
            // ORDER
            // =================================================

            sql.append(
                "ORDER BY d.blood_group, u.name"
            );


            PreparedStatement ps =
                    con.prepareStatement(
                        sql.toString()
                    );


            // =================================================
            // SET PARAMETERS
            // =================================================

            for (int i = 0;
                 i < parameters.size();
                 i++) {

                ps.setObject(
                    i + 1,
                    parameters.get(i)
                );
            }


            // =================================================
            // EXECUTE DONOR SEARCH
            // =================================================

            ResultSet rs =
                    ps.executeQuery();


            while (rs.next()) {

                String phone =
                        rs.getString("phone");


                if (phone == null) {

                    phone = "";
                }


                String[] donor = {

                    // 0 - Donor ID
                    String.valueOf(
                        rs.getInt("donor_id")
                    ),

                    // 1 - Name
                    rs.getString("name"),

                    // 2 - Email
                    rs.getString("email"),

                    // 3 - Phone
                    phone,

                    // 4 - Blood Group
                    rs.getString(
                        "blood_group"
                    ),

                    // 5 - Age
                    String.valueOf(
                        rs.getInt("age")
                    ),

                    // 6 - Gender
                    rs.getString("gender"),

                    // 7 - City
                    rs.getString("city"),

                    // 8 - Availability
                    String.valueOf(
                        rs.getBoolean(
                            "availability"
                        )
                    )
                };


                donors.add(donor);
            }


            rs.close();

            ps.close();


            // =================================================
            // GET BLOOD INVENTORY
            // =================================================

            String inventorySql;


            if (!bloodGroup.isEmpty()) {

                // Selected blood group only

                inventorySql =

                    "SELECT inventory_id, " +

                    "blood_group, " +

                    "units_available, " +

                    "last_updated " +

                    "FROM blood_inventory " +

                    "WHERE blood_group = ? " +

                    "ORDER BY blood_group";


            } else {

                // All blood groups

                inventorySql =

                    "SELECT inventory_id, " +

                    "blood_group, " +

                    "units_available, " +

                    "last_updated " +

                    "FROM blood_inventory " +

                    "ORDER BY blood_group";
            }


            PreparedStatement inventoryPs =
                    con.prepareStatement(
                        inventorySql
                    );


            if (!bloodGroup.isEmpty()) {

                inventoryPs.setString(
                    1,
                    bloodGroup
                );
            }


            ResultSet inventoryRs =
                    inventoryPs.executeQuery();


            while (inventoryRs.next()) {

                String[] item = {

                    // 0 - Inventory ID
                    String.valueOf(
                        inventoryRs.getInt(
                            "inventory_id"
                        )
                    ),

                    // 1 - Blood Group
                    inventoryRs.getString(
                        "blood_group"
                    ),

                    // 2 - Units Available
                    String.valueOf(
                        inventoryRs.getInt(
                            "units_available"
                        )
                    ),

                    // 3 - Last Updated
                    String.valueOf(
                        inventoryRs.getTimestamp(
                            "last_updated"
                        )
                    )
                };


                inventory.add(item);
            }


            inventoryRs.close();

            inventoryPs.close();


            // =================================================
            // CALCULATE TOTAL INVENTORY UNITS
            // =================================================

            int totalInventoryUnits = 0;


            String totalInventorySql;


            if (!bloodGroup.isEmpty()) {

                totalInventorySql =
                    "SELECT COALESCE(" +
                    "SUM(units_available), 0" +
                    ") AS total " +
                    "FROM blood_inventory " +
                    "WHERE blood_group = ?";

            } else {

                totalInventorySql =
                    "SELECT COALESCE(" +
                    "SUM(units_available), 0" +
                    ") AS total " +
                    "FROM blood_inventory";
            }


            PreparedStatement totalPs =
                    con.prepareStatement(
                        totalInventorySql
                    );


            if (!bloodGroup.isEmpty()) {

                totalPs.setString(
                    1,
                    bloodGroup
                );
            }


            ResultSet totalRs =
                    totalPs.executeQuery();


            if (totalRs.next()) {

                totalInventoryUnits =
                    totalRs.getInt("total");
            }


            totalRs.close();

            totalPs.close();


            // =================================================
            // AVAILABLE DONOR COUNT
            // =================================================

            int availableDonors = 0;


            String donorCountSql =

                "SELECT COUNT(*) AS total " +

                "FROM donors d " +

                "WHERE d.availability = TRUE ";


            List<Object> donorCountParameters =
                    new ArrayList<>();


            if (!bloodGroup.isEmpty()) {

                donorCountSql +=
                    "AND d.blood_group = ? ";

                donorCountParameters.add(
                    bloodGroup
                );
            }


            if (!city.isEmpty()) {

                donorCountSql +=
                    "AND LOWER(d.city) = LOWER(?) ";

                donorCountParameters.add(
                    city
                );
            }


            PreparedStatement donorCountPs =
                    con.prepareStatement(
                        donorCountSql
                    );


            for (int i = 0;
                 i < donorCountParameters.size();
                 i++) {

                donorCountPs.setObject(
                    i + 1,
                    donorCountParameters.get(i)
                );
            }


            ResultSet donorCountRs =
                    donorCountPs.executeQuery();


            if (donorCountRs.next()) {

                availableDonors =
                    donorCountRs.getInt("total");
            }


            donorCountRs.close();

            donorCountPs.close();


            // =================================================
            // CLOSE CONNECTION
            // =================================================

            con.close();


            // =================================================
            // SEND DATA TO JSP
            // =================================================

            request.setAttribute(
                "donors",
                donors
            );


            request.setAttribute(
                "bloodGroup",
                bloodGroup
            );


            request.setAttribute(
                "city",
                city
            );


            request.setAttribute(
                "availability",
                availability
            );


            request.setAttribute(
                "inventory",
                inventory
            );


            request.setAttribute(
                "totalInventoryUnits",
                totalInventoryUnits
            );


            request.setAttribute(
                "availableDonors",
                availableDonors
            );


            // =================================================
            // OPEN RESULTS PAGE
            // =================================================

            request.getRequestDispatcher(
                "donor-results.jsp"
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
                "search-donor.jsp?error=1"
            );
        }
    }
}