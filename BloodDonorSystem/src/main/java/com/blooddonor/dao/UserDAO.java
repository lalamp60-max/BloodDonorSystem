package com.blooddonor.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.blooddonor.util.DBConnection;

public class UserDAO {

    public boolean registerUser(
            String name,
            String email,
            String password) {

        boolean status = false;

        String sql =
                "INSERT INTO users(name, email, password) VALUES (?, ?, ?)";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}