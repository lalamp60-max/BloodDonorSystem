import java.sql.*;
import java.util.Scanner;

public class LoginTest {

    public static void main(String[] args) {
        try {
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/blood_donor_system",
                "root",
                "p@1236"
            );

            Scanner sc = new Scanner(System.in);

            System.out.print("Enter Email: ");
            String email = sc.nextLine();

            System.out.print("Enter Password: ");
            String password = sc.nextLine();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE email=? AND password=?"
            );

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                System.out.println("✅ Login Successful");
                String name = rs.getString("name");
                System.out.println("Welcome " + name);

                showDashboard(con, sc);

            } else {
                System.out.println("❌ Invalid Credentials");
            }

            con.close();

        } catch (Exception e) {
            System.out.println(e);
        }
    }
    // ✅ Dashboard
    public static void showDashboard(Connection con, Scanner sc) {
        while (true) {
            System.out.println("\n===== DASHBOARD =====");
            System.out.println("1. View All Users");
            System.out.println("2. Add User");
            System.out.println("3. Delete User");
            System.out.println("4. Logout");
            System.out.println("5. Add Donor");
            System.out.println("6. Search Donor");
            System.out.println("7. Create Request");
            System.out.println("8. Respond to Request");
            System.out.println("9. View Requests");
            System.out.println("10. Update Request Status");
            System.out.println("11. View Responses");

            System.out.print("Enter choice: ");
            int choice = sc.nextInt();
            sc.nextLine();

            try {
                switch (choice) {

                    case 1:
                        ResultSet rs = con.createStatement().executeQuery("SELECT * FROM users");
                        while (rs.next()) {
                            System.out.println(
                                rs.getInt("user_id") + " " +
                                rs.getString("name") + " " +
                                rs.getString("email")
                            );
                        }
                        break;

                    case 2:
                        System.out.print("Enter Name: ");
                        String name = sc.nextLine();

                        System.out.print("Enter Email: ");
                        String email = sc.nextLine();

                        System.out.print("Enter Password: ");
                        String pass = sc.nextLine();

                        PreparedStatement ps1 = con.prepareStatement(
                            "INSERT INTO users(name,email,password) VALUES(?,?,?)"
                        );

                        ps1.setString(1, name);
                        ps1.setString(2, email);
                        ps1.setString(3, pass);

                        System.out.println("Inserted rows: " + ps1.executeUpdate());
                        break;

                    case 3:
                        System.out.print("Enter User ID: ");
                        int id = sc.nextInt();

                        PreparedStatement ps2 = con.prepareStatement(
                            "DELETE FROM users WHERE user_id=?"
                        );

                        ps2.setInt(1, id);
                        System.out.println("Deleted rows: " + ps2.executeUpdate());
                        break;

                    case 4:
                        System.out.println("👋 Logged out");
                        return;

                    case 5:
                        System.out.print("Enter User ID: ");
                        int uid = sc.nextInt();
                        sc.nextLine();

                        System.out.print("Blood Group: ");
                        String bg = sc.nextLine();

                        System.out.print("Age: ");
                        int age = sc.nextInt();
                        sc.nextLine();

                        System.out.print("Gender: ");
                        String gender = sc.nextLine();

                        System.out.print("City: ");
                        String city = sc.nextLine();

                        PreparedStatement ps3 = con.prepareStatement(
                            "INSERT INTO donors(user_id,blood_group,age,gender,city,availability) VALUES(?,?,?,?,?,true)"
                        );

                        ps3.setInt(1, uid);
                        ps3.setString(2, bg);
                        ps3.setInt(3, age);
                        ps3.setString(4, gender);
                        ps3.setString(5, city);

                        ps3.executeUpdate();
                        System.out.println("✅ Donor Added");
                        break;

                    case 6:
                        System.out.print("Enter Blood Group: ");
                        String bgSearch = sc.nextLine();

                        PreparedStatement ps4 = con.prepareStatement(
                            "SELECT * FROM donors WHERE blood_group=? AND availability=true"
                        );

                        ps4.setString(1, bgSearch);

                        ResultSet rs2 = ps4.executeQuery();
                        while (rs2.next()) {
                            System.out.println(
                                rs2.getInt("donor_id") + " " +
                                rs2.getString("blood_group") + " " +
                                rs2.getString("city")
                            );
                        }
                        break;

                    case 7:
                        System.out.print("Enter User ID: ");
                        int rid = sc.nextInt();
                        sc.nextLine();

                        System.out.print("Blood Group: ");
                        String rbg = sc.nextLine();

                        System.out.print("Units: ");
                        int units = sc.nextInt();
                        sc.nextLine();

                        System.out.print("City: ");
                        String rcity = sc.nextLine();

                        PreparedStatement ps5 = con.prepareStatement(
                            "INSERT INTO requests(requester_id,blood_group,units_required,city,status) VALUES(?,?,?,?, 'Pending')"
                        );

                        ps5.setInt(1, rid);
                        ps5.setString(2, rbg);
                        ps5.setInt(3, units);
                        ps5.setString(4, rcity);

                        ps5.executeUpdate();
                        System.out.println("✅ Request Created");
                        break;

                    case 8:
                        System.out.print("Enter Request ID: ");
                        int requestId = sc.nextInt();

                        System.out.print("Enter Donor ID: ");
                        int donorId = sc.nextInt();

                        PreparedStatement ps6 = con.prepareStatement(
                            "INSERT INTO donor_responses(request_id, donor_id, response_status) VALUES(?,?, 'Accepted')"
                        );

                        ps6.setInt(1, requestId);
                        ps6.setInt(2, donorId);

                        ps6.executeUpdate();
                        System.out.println("✅ Response Submitted");
                        break;

                    case 9:
                        ResultSet rs3 = con.createStatement().executeQuery("SELECT * FROM requests");
                        while (rs3.next()) {
                            System.out.println(
                                rs3.getInt("request_id") + " " +
                                rs3.getString("blood_group") + " " +
                                rs3.getString("status")
                            );
                        }
                        break;

                    case 10:
                        System.out.print("Enter Request ID: ");
                        int reqId = sc.nextInt();
                        sc.nextLine();

                        System.out.print("Enter Status (Approved/Completed): ");
                        String status = sc.nextLine();

                        PreparedStatement ps7 = con.prepareStatement(
                            "UPDATE requests SET status=? WHERE request_id=?"
                        );

                        ps7.setString(1, status);
                        ps7.setInt(2, reqId);

                        ps7.executeUpdate();
                        System.out.println("✅ Status Updated");
                        break;

                    case 11:
                        ResultSet rs4 = con.createStatement().executeQuery("SELECT * FROM donor_responses");
                        while (rs4.next()) {
                            System.out.println(
                                rs4.getInt("response_id") + " " +
                                rs4.getString("response_status")
                            );
                        }
                        break;

                    default:
                        System.out.println("Invalid choice");
                }

            } catch (Exception e) {
                System.out.println(e);
            }
        }
    }
}