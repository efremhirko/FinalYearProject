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



public class CourseRegistration extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3307/cscds";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        String courseCode = request.getParameter("courseCode");
        String courseTitle = request.getParameter("courseTitle");
        int ects = Integer.parseInt(request.getParameter("ects"));
        int lectureHours = Integer.parseInt(request.getParameter("lectureHours"));
        int tutorialHours = Integer.parseInt(request.getParameter("tutorialHours"));
        int labHours = Integer.parseInt(request.getParameter("labHours"));
        int batch = Integer.parseInt( request.getParameter("batch"));
        String semester = request.getParameter("semester");

        // Get department from session
        HttpSession session = request.getSession(false);
        String department = (String) session.getAttribute("dpt");

        // Create course object using the factory
        CourseFactory courseFactory = new CourseFactory();
        Course course = courseFactory.createCourse(courseCode, courseTitle, ects, lectureHours, tutorialHours,
                labHours, batch, semester, department);

        // Store course object in the database
        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

            // Prepare SQL statement
            String sql = "";
            switch (department) {
                case "SE":
                    sql = "INSERT INTO swecourse (CourseCode, CourseTitle, ECTS, Lech, Tuth, Labh , Batch, Semester, Department) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    break;
                case "CS":
                    sql = "INSERT INTO cscourse (CourseCode, CourseTitle, ECTS, Lech, Tuth, Labh , Batch, Semester, Department) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    break;
                case "IS":
                    sql = "INSERT INTO iscourse (CourseCode, CourseTitle, ECTS, Lech, Tuth, Labh , Batch, Semester, Department) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    break;
                case "ISY":
                    sql = "INSERT INTO isycourse (CourseCode, CourseTitle, ECTS, Lech, Tuth, Labh , Batch, Semester, Department) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    break;
                case "IT":
                    sql = "INSERT INTO itcourse (CourseCode, CourseTitle, ECTS, Lech, Tuth, Labh , Batch, Semester, Department) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    break;
                default:
                    sql = "INSERT INTO csecourse (CourseCode, CourseTitle, ECTS, Lech, Tuth, Labh , Batch, Semester, Department) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    break;
            }

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, course.getCourseCode());
            stmt.setString(2, course.getCourseTitle());
            stmt.setInt(3, course.getEcts());
            stmt.setInt(4, course.getLectureHours());
            stmt.setInt(5, course.getTutorialHours());
            stmt.setInt(6, course.getLabHours());
            stmt.setInt(7, course.getBatch());
            stmt.setString(8, course.getSemester());
            stmt.setString(9, course.getDepartment());

            // Execute the SQL statement
            stmt.executeUpdate();

            // Close database connection
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            // Handle any database errors
            String errorMessage = "An error occurred during the course registration process. Please try again later.";
            request.setAttribute("errorMessage", errorMessage);
            // Forward to the error page
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Redirect to a success page
        response.sendRedirect("http://localhost:8080/FinalYearProject/finalyear/registerCourse.jsp");
    }
}
