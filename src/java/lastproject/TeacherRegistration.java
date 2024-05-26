package lastproject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

public class TeacherRegistration extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3307/cscds";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        int experience = 0;
        String educationLevel = request.getParameter("educationLevel");
        String fieldOfStudy = request.getParameter("FieldOfStudy");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");

        try {
            // Parse experience value
            experience = Integer.parseInt(request.getParameter("experience"));
        } catch (NumberFormatException e) {
            // Handle invalid experience value
            Logger.getLogger(TeacherRegistration.class.getName()).log(Level.WARNING, "Invalid experience value", e);
            request.setAttribute("experienceErrorMessage", "Please enter a valid experience value.");
            request.getRequestDispatcher("registerTeacher.jsp").forward(request, response);
            return;
        }

        // Get the department from session
        HttpSession session = request.getSession();
        String department = (String) session.getAttribute("dpt");
        if (department == null || department.isEmpty()) {
            // Handle case where department is not set in the session
            String errorMessage = "Department is not set in the session.";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Determine the table name based on the department
        String tableName;
        switch (department) {
            case "SE":
                tableName = "sweinstructor";
                break;
            case "CSE":
                tableName = "cseinstructor";
                break;
            case "IS":
                tableName = "isinstructor";
                break;
            case "ISY":
                tableName = "isyinstructor";
                break;
            case "IT":
                tableName = "itinstructor";
                break;
            case "CS":
                tableName = "csinstructor";
                break;
            default:
                tableName = null;
                break;
        }

        if (tableName == null) {
            // Handle case where department does not match any table
            String errorMessage = "Invalid department. Cannot determine the instructor table.";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Create teacher object using the factory
        TeacherFactory teacherFactory = new TeacherFactory();
        Teacher teacher = teacherFactory.createTeacher(fullName, username, password, gender,
                experience, educationLevel, fieldOfStudy, email, phone, department, role);

        // Store teacher object in the database
        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {
                // Check for duplicate username, email, and phone
                String checkDuplicateQuery = "SELECT COUNT(*) FROM " + tableName + " WHERE username = ? OR email = ? OR phone = ?";
                try (PreparedStatement stmt = conn.prepareStatement(checkDuplicateQuery)) {
                    stmt.setString(1, teacher.getUsername());
                    stmt.setString(2, teacher.getEmail());
                    stmt.setString(3, teacher.getPhone());
                    ResultSet resultSet = stmt.executeQuery();
                    if (resultSet.next()) {
                        int count = resultSet.getInt(1);
                        if (count > 0) {
                            // Duplicate found
                            String errorMessage = "Username, email, or phone number already exists. Please choose different values.";
                            request.setAttribute("errorMessage", errorMessage);
                            request.getRequestDispatcher("error.jsp").forward(request, response);
                            return;
                        }
                    }
                }

                // Prepare SQL statement
                String sql = "INSERT INTO " + tableName + " (fullName, username, password, gender, experience, educationLevel, FieldOfStudy, email, phone, department, role)" +
                        " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, teacher.getFullName());
                    stmt.setString(2, teacher.getUsername());
                    stmt.setString(3, teacher.getPassword());
                    stmt.setString(4, teacher.getGender());
                    stmt.setInt(5, teacher.getExperience());
                    stmt.setString(6, teacher.getEducationLevel());
                    stmt.setString(7, teacher.getFieldOfStudy());
                    stmt.setString(8, teacher.getEmail());
                    stmt.setString(9, teacher.getPhone());
                    stmt.setString(10, teacher.getDepartment());
                    stmt.setString(11, teacher.getRole());

                    // Execute the SQL statement
                    stmt.executeUpdate();
                }
            }
            response.sendRedirect("http://localhost:8080/FinalYearProject/finalyear/registerTeacher.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            // Handle any database errors
            String errorMessage = "An error occurred during the teacher registration process. Please try again later.";
            request.setAttribute("errorMessage", errorMessage);
            // Forward to the error page
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
