import java.sql.*;
import java.util.Scanner;

public class Main {
    private static final String URL = "jdbc:mysql://localhost:3306/XXXXXXXXXXX";
    private static final String USERNAME = "XXXXXXXXX";
    private static final String PASSWORD = "XXXXXXXXXX";
    private static final Scanner scanner = new Scanner(System.in);

    public static void main(String[] args){
        try(Connection myCon = DriverManager.getConnection(URL, USERNAME, PASSWORD)) {
            String menu = "\n\n================ Welcome to Application Tracker ================\n" +
                    "** Pick the following options (integer) to proceed **\n" +
                    "1. View Applicants\n" +
                    "2. Add Applicant\n" +
                    "3. Update Applicant Email\n" +
                    "4. View Positions\n" +
                    "5. Add Position\n" +
                    "6. Delete Position\n" +
                    "7. View Applications\n" +
                    "8. Add Application\n" +
                    "9. Transaction Workflow (Application + Interview)\n" +
                    "0. Exit";
            boolean running = true;
            while (running) {
                System.out.println(menu);
                int choice = readInt("Enter choice: ");
                switch(choice) {
                    case 1: {
                        viewApplicants(myCon);
                        break;
                    }
                    case 2: {
                        addApplicant(myCon);
                        break;
                    }
                    case 3: {
                        updateApplicantEmail(myCon);
                        break;
                    }
                    case 4: {
                        viewPositions(myCon);
                        break;
                    }
                    case 5: {
                        addPosition(myCon);
                        break;
                    }
                    case 6: {
                        deletePosition(myCon);
                        break;
                    }
                    case 7: {
                        viewApplications(myCon);
                        break;
                    }
                    case 8: {
                        addApplication(myCon);
                        break;
                    }
                    case 9: {
                        runTransaction(myCon);
                        break;
                    }
                    case 0: {
                        running = false;
                        System.out.println("Exiting... Goodbye!");
                        break;
                    }
                    default: System.out.println("Invalid choice, please try again.");
                }
            }
        } catch (SQLException e) {
            System.out.println("Sorry, could not connect to the DB: " + e.getMessage());
        }
    }

    private static int readInt(String prompt){
        while(true){
            System.out.print(prompt);
            String line = scanner.nextLine().trim();
            try {
                return Integer.parseInt(line);
            } catch (NumberFormatException e){
                System.out.println("Please enter a valid integer.");
            }
        }
    }

    private static String readNonEmpty(String prompt) {
        while(true) {
            System.out.print(prompt);
            String line = scanner.nextLine().trim();
            if(!line.isEmpty()){
                return line;
            }
            System.out.println("Sorry! Input cannot be empty.");
        }
    }

    // =================== Applicant =======================
    private static void viewApplicants(Connection myCon) {
        String sql = "SELECT ApplicantID, FullName, Email, PhoneNumber FROM Applicant";
        try(PreparedStatement ps = myCon.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){
            System.out.println("\n****** Applicants ******");
            while(rs.next()){
                int id = rs.getInt("ApplicantID");
                String name = rs.getString("FullName");
                String email = rs.getString("Email");
                String phone = rs.getString("PhoneNumber");
                System.out.printf("ID=%d | %s | %s |%s%n", id, name, email, phone);
            }
            ps.close();
            rs.close();
        } catch (SQLException e) {
            System.out.println("Error viewing applicants: " + e.getMessage());
        }
    }

    private static void addApplicant(Connection myCon) {
        int id = readInt("Enter new ApplicantID (int): ");
        String name = readNonEmpty("Full name: ");
        String email = readNonEmpty("Email: ");
        String phone = readNonEmpty("Phone number: ");
        String address = readNonEmpty("Address: ");
        String sql = "INSERT INTO Applicant (ApplicantID, PhoneNumber, Address," +
                "FullName, Email) VALUES (?,?,?,?,?)";
        try(PreparedStatement ps = myCon.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setString(4, name);
            ps.setString(5, email);
            int rows = ps.executeUpdate();
            System.out.println("Inserted " + rows + " applicant(s).");
        } catch (SQLException e) {
            System.out.println("Error inserting applicant: " + e.getMessage());
        }
    }

    private static void updateApplicantEmail(Connection myCon) {
        int id = readInt("Enter ApplicantID to update: ");
        String newEmail = readNonEmpty("Enter new email: ");

        String sql = "UPDATE Applicant SET Email = ? WHERE ApplicantID = ?";
        try (PreparedStatement ps = myCon.prepareStatement(sql)) {
            ps.setString(1, newEmail);
            ps.setInt(2, id);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("Applicant email updated.");
            } else {
                System.out.println("No applicant found with that ID.");
            }
        } catch (SQLException e) {
            System.out.println("Error updating applicant: " + e.getMessage());
        }
    }


    // ================== Position =======================
    private static void viewPositions(Connection myCon) {
        String sql = "SELECT PositionID, CompanyID, Title, Location, Salary FROM Position";
        try(PreparedStatement ps = myCon.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()) {
            System.out.println("\n****** Positions ******");
            while(rs.next()){
                int posId = rs.getInt("PositionID");
                int comId = rs.getInt("CompanyID");
                String title = rs.getString("Title");
                String location = rs.getString("Location");
                double salary = rs.getDouble("Salary");
                System.out.printf("PositionID=%d | CompanyID=%d | %s | %s | %.2f%n",
                        posId, comId, title, location, salary);
            }
            ps.close();
            rs.close();
        } catch (SQLException e){
            System.out.println("Error viewing positions: " + e.getMessage());
        }
    }

    private static void addPosition(Connection myCon){
        int posId = readInt("Enter new PositionID (int): ");
        int comId = readInt("Enter CompanyID (int): ");
        String title = readNonEmpty("Title: ");
        String location = readNonEmpty("Location: ");
        String description = readNonEmpty("Description: ");
        String salaryStr = readNonEmpty("Salary (e.g. 1000.24): ");
        double salary;
        try {
            salary = Double.parseDouble(salaryStr);
        } catch (NumberFormatException e){
            System.out.println("Invalid salary, defaulting to 0.");
            salary = 0.0;
        }
        String sql = "INSERT INTO Position (PositionID, CompanyID, Description," +
                "Location, Salary, Title) VALUES (?,?,?,?,?,?)";
        try(PreparedStatement ps = myCon.prepareStatement(sql)) {
            ps.setInt(1, posId);
            ps.setInt(2, comId);
            ps.setString(3, description);
            ps.setString(4, location);
            ps.setDouble(5, salary);
            ps.setString(6, title);
            int rows = ps.executeUpdate();
            System.out.println("Inserted " + rows + " position(s).");
        } catch (SQLException e) {
            System.out.println("Error inserting position: " + e.getMessage());
        }
    }

    private static void deletePosition(Connection myCon) {
        int posId = readInt("Enter PositionID to delete: ");

        String sql = "DELETE FROM Position WHERE PositionID = ?";
        try (PreparedStatement ps = myCon.prepareStatement(sql)) {
            ps.setInt(1, posId);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("Position deleted.");
            } else {
                System.out.println("No such PositionID found.");
            }
        } catch (SQLException e) {
            System.out.println("Error deleting position: " + e.getMessage());
        }
    }


    // =================== Application =====================
    private static void viewApplications(Connection myCon){
        String sql = "SELECT ApplicationID, PositionID, ApplicantID, AppliedDate,"+
                "Status FROM Application";
        try (PreparedStatement ps = myCon.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()) {
            System.out.println("\n****** Applications ******");
            while(rs.next()){
                int appId = rs.getInt("ApplicationID");
                int posId = rs.getInt("PositionID");
                int applicantId = rs.getInt("ApplicantID");
                Timestamp applied = rs.getTimestamp("AppliedDate");
                String status = rs.getString("Status");
                System.out.printf("ApplicationID=%d | PositionID=%d | ApplicantID=%d | %s | %s%n",
                        appId, posId, applicantId, applied == null? "null" : applied.toString(), status);
            }
        } catch (SQLException e) {
            System.out.println("Error viewing applications: " + e.getMessage());
        }
    }

    private static void addApplication(Connection myCon){
        int appId = readInt("Enter new ApplicationID (int): ");
        int posId = readInt("PositionID (int): ");
        int applicantId = readInt("ApplicantID (int): ");

        String status = "";

        // keep asking until user enters a valid status
        while (true) {
            status = readNonEmpty("Status [Rejected, Pending, Accepted]: ").trim();

            if (status.equalsIgnoreCase("Rejected") ||
                    status.equalsIgnoreCase("Pending")  ||
                    status.equalsIgnoreCase("Accepted")) {

                // normalize to match ENUM exactly
                if (status.equalsIgnoreCase("Rejected")) status = "Rejected";
                if (status.equalsIgnoreCase("Pending"))  status = "Pending";
                if (status.equalsIgnoreCase("Accepted")) status = "Accepted";
                break; // exit the while loop
            }

            System.out.println("Invalid status, must be Rejected, Pending, or Accepted.");
        }

        String sql = "INSERT INTO Application " +
                "(ApplicationID, PositionID, ApplicantID, AppliedDate, LastUpdated, Status) " +
                "VALUES (?, ?, ?, NOW(), NOW(), ?)";

        try (PreparedStatement ps = myCon.prepareStatement(sql)) {
            ps.setInt(1, appId);
            ps.setInt(2, posId);
            ps.setInt(3, applicantId);
            ps.setString(4, status); // guaranteed valid now

            int rows = ps.executeUpdate();
            System.out.println("Inserted " + rows + " application(s).");
        } catch (SQLException e) {
            System.out.println("Error inserting application: " + e.getMessage());
        }
    }


    // ================== Transaction Workflow ===================
    private static void runTransaction(Connection myCon) {
        System.out.println("\n ****** Transaction: create Application + Interview ******");

        int appId = readInt("New ApplicationID (int): ");
        int posId = readInt("PositionID (int): ");
        int applicantId = readInt("ApplicantID (int): ");
        int interviewId = readInt("New InterviewID (int): ");

        // step 1: Validate interview type
        String interviewType;
        while (true) {
            interviewType = readNonEmpty("Interview type [Phone, Onsite, Video]: ").trim();

            if (interviewType.equalsIgnoreCase("Phone") ||
                    interviewType.equalsIgnoreCase("Onsite") ||
                    interviewType.equalsIgnoreCase("Video")) {

                // normalize to exact enum spelling in DB
                if (interviewType.equalsIgnoreCase("Phone"))  interviewType = "Phone";
                if (interviewType.equalsIgnoreCase("Onsite")) interviewType = "Onsite";
                if (interviewType.equalsIgnoreCase("Video"))  interviewType = "Video";
                break;  // valid then exit loop
            }

            System.out.println("Invalid type, must be Phone, Onsite, or Video.");
        }

        try {
            myCon.setAutoCommit(false); // start transaction

            // step 2: Insert Application
            String appSql = "INSERT INTO Application " +
                    "(ApplicationID, PositionID, ApplicantID, AppliedDate, LastUpdated, Status) " +
                    "VALUES (?, ?, ?, NOW(), NOW(), 'Pending')";
            try (PreparedStatement psApp = myCon.prepareStatement(appSql)) {
                psApp.setInt(1, appId);
                psApp.setInt(2, posId);
                psApp.setInt(3, applicantId);
                psApp.executeUpdate();
            }

            // step 3: Insert Interview
            String intSql = "INSERT INTO Interview " +
                    "(InterviewID, ApplicationID, InterviewDate, Status, Type) " +
                    "VALUES (?, ?, NOW(), 'Scheduled', ?)";
            try (PreparedStatement psInt = myCon.prepareStatement(intSql)) {
                psInt.setInt(1, interviewId);
                psInt.setInt(2, appId);
                psInt.setString(3, interviewType);
                psInt.executeUpdate();
            }

            myCon.commit();
            System.out.println("TRANSACTION SUCCESS: Application + Interview created.");

        } catch (SQLException e) {
            System.out.println("TRANSACTION FAILED, rolling back: " + e.getMessage());
            try {
                myCon.rollback();
            } catch (SQLException ex) {
                System.out.println("Error during rollback: " + ex.getMessage());
            }
        } finally {
            try {
                myCon.setAutoCommit(true);
            } catch (SQLException e) {
                System.out.println("Error resetting autocommit: " + e.getMessage());
            }
        }
    }
}
