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
import java.util.logging.Level;
import java.util.logging.Logger;

public class StudentRegistration extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3307/cscds";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        String fullName = request.getParameter("fullname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String department = request.getParameter("department");
        String gender = request.getParameter("gender");
        int classYear = Integer.parseInt(request.getParameter("classyear"));

        // Get the department from session
        HttpSession session = request.getSession();
        String department1 = (String) session.getAttribute("dpt");
        if (department1 == null || department1.isEmpty()) {
            // Handle case where department is not set in the session
            String errorMessage = "Department is not set in the session.";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Determine the table name based on the department
        String tableName;
        switch (department1) {
            case "SE":
                tableName = "swestudent";
                break;
            case "CSE":
                tableName = "csestudent";
                break;
            case "CS":
                tableName = "csstudent";
                break;
            case "IT":
                tableName = "itstudent";
                break;
            case "IS":
                tableName = "isstudent";
                break;
            case "ISY":
                tableName = "isystudent";
                break;
            default:
                tableName = null;
                break;
        }

        if (tableName == null) {
            // Handle case where department does not match any table
            String errorMessage = "Invalid department. Cannot determine the student table.";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Store student information in the database
        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD)) {
                // Prepare SQL statement
                String sql = "INSERT INTO " + tableName + " (fullName, username, password,department, gender, classyear) VALUES (?, ?, ?, ?, ?,?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, fullName);
                    stmt.setString(2, username);
                    stmt.setString(3, password);
                    stmt.setString(4, department);
                    stmt.setString(5, gender);
                    stmt.setInt(6, classYear);

                    // Execute the SQL statement
                    stmt.executeUpdate();
                }
            }
            response.sendRedirect("http://localhost:8080/FinalYearProject/finalyear/registerStudent.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            // Handle any database errors
            String errorMessage = "An error occurred during the student registration process. Please try again later.";
            request.setAttribute("errorMessage", errorMessage);
            // Forward to the error page
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
