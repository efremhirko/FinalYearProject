package lastproject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


public class RoomRegistration extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3307/cscds";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "*1181Ehg#";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        int buildingNo = Integer.parseInt(request.getParameter("buildingNo"));
        int floor = Integer.parseInt(request.getParameter("floor"));
        int roomNo = Integer.parseInt(request.getParameter("roomNo"));
        String classType = request.getParameter("classType");

        // Store room data in the database
        try {
               Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);


            // Prepare SQL statement
            String sql = "INSERT INTO room (buildingNo, floor, roomNo, classType) VALUES (?, ?, ?, ?)";
           PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, buildingNo);
            stmt.setInt(2, floor);
            stmt.setInt(3, roomNo);
            stmt.setString(4, classType);

            // Execute the SQL statement
            stmt.executeUpdate();

            // Close database connection
            stmt.close();
            conn.close();

            // Redirect to a success page
            response.sendRedirect("registerRoom.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Handle any database errors
            String errorMessage = "An error occurred during the course registration process. Please try again later.";
            request.setAttribute("errorMessage", errorMessage);
            // Forward to the error page
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
    }
}
