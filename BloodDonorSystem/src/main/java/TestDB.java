import java.sql.*;

public class TestDB {
    public static void main(String[] args) {
        try {
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/blood_donor_system",
                "root",
                "p@1236"
            );

            Statement stmt = con.createStatement();

            // 👉 INSERT CODE (ikkada pettaali)
            int rows = stmt.executeUpdate(
            	    "INSERT INTO users(name, email, password, phone, role) " +
            	    	    "VALUES('Suresh', 'suresh@gmail.com', '1234', '9999999999', 'USER')"
            	    	);

            System.out.println("Inserted rows: " + rows);

            // 👉 SELECT CODE (already undhi)
            ResultSet rs = stmt.executeQuery("SELECT * FROM users");

            while (rs.next()) {
                System.out.println(
                    rs.getInt("user_id") + " " +
                    rs.getString("name") + " " +
                    rs.getString("email")
                );
            }

            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}