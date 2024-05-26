//package lastproject;
//
//import java.io.*;
//import jakarta.servlet.*;
//import jakarta.servlet.http.*;
//import java.util.*;
//import java.sql.*;
//
//public class CourseAssignment extends HttpServlet {
//   
//    // Database connection details
//    private static final String DB_URL = "jdbc:mysql://localhost:3307/cscds";
//    private static final String DB_USER = "root";
//    private static final String DB_PASSWORD = "";
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        // Retrieve department head's session information
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("role") == null || !session.getAttribute("role").equals("head")) {
//            // Redirect to an error page or show an error message
//            response.sendRedirect("error.jsp");
//            return;
//        }
//        
//        // Retrieve department head's department and role from session
//        String department = (String) session.getAttribute("dpt");
//        String role = (String) session.getAttribute("role");
//
//        // Retrieve the list of teachers for the department head's department from the database
//        List<Teacher> teachers = getTeachersForDepartment(department);
//
//        // Retrieve the list of courses for the department head's department from the database
//        List<Course> courses = getCoursesForDepartment(department);
//
//        // Assign courses to teachers based on criteria
//        boolean coursesAssignedSuccessfully = assignCoursesToTeachers(teachers, courses);
//
//        if (coursesAssignedSuccessfully) {
//            // Update the database with assigned courses for each teacher
//            updateDatabaseWithAssignedCourses(teachers);
//            // Forward to a confirmation page
//            request.getRequestDispatcher("/assignmentConfirmation.jsp").forward(request, response);
//        } else {
//            // Display an error message or redirect to an error page
//            response.sendRedirect("error.jsp");
//        }
//    }
//
//    // Method to retrieve teachers for a specific department from the database
//    private List<Teacher> getTeachersForDepartment(String department) {
//        List<Teacher> teachers = new ArrayList<>();
//        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
//            String query = "SELECT * FROM instructor WHERE Department = ?";
//            try (PreparedStatement stmt = conn.prepareStatement(query)) {
//                stmt.setString(1, department);
//                try (ResultSet rs = stmt.executeQuery()) {
//                    while (rs.next()) {
//                        Teacher teacher = new Teacher(
//                            rs.getString("FullName"),
//                            rs.getString("Username"),
//                            rs.getString("Password"),
//                            rs.getString("Gender"),
//                            rs.getInt("Experience"),
//                            rs.getString("EducationLevel"),
//                            rs.getString("FieldOfStudy"),
//                            rs.getString("Email"),
//                            rs.getString("Phone"),
//                            rs.getString("Department"),
//                            rs.getString("Role")
//                        );
//                        teachers.add(teacher);
//                    }
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            // Handle database connection or query errors
//        }
//        return teachers;
//    }
//
//    // Method to retrieve courses for a specific department from the database
//    private List<Course> getCoursesForDepartment(String department) {
//        List<Course> courses = new ArrayList<>();
//        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
//            String query = "";
//            switch (department) {
//                case "CS":
//                    query = "SELECT * FROM cscourse";
//                    break;
//                case "CSE":
//                    query = "SELECT * FROM csecourse";
//                    break;
//                case "IS":
//                    query = "SELECT * FROM isccourse";
//                    break;
//                case "ISY":
//                    query = "SELECT * FROM isycourse";
//                    break;
//                case "IT":
//                    query = "SELECT * FROM itcourse";
//                    break;
//                case "SE":
//                    query = "SELECT * FROM swecourse";
//                    break;
//                default:
//                    // Handle unrecognized department
//                   
//                    break;
//            }
//            try (PreparedStatement stmt = conn.prepareStatement(query);
//                 ResultSet rs = stmt.executeQuery()) {
//                while (rs.next()) {
//                    Course course = new Course(
//                        rs.getString("CourseCode"),
//                        rs.getString("CourseTitle"),
//                        rs.getInt("ECTS"),
//                        rs.getInt("Lech"),
//                        rs.getInt("Tuth"),
//                        rs.getInt("Labh"),
//                        rs.getString("Batch"),
//                        rs.getString("Semester"),
//                        rs.getString("Department")
//                    );
//                    courses.add(course);
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            // Handle database connection or query errors
//        }
//        return courses;
//    }
//
//
//    // Method to assign courses to teachers based on criteria
//private boolean assignCoursesToTeachers(List<Teacher> teachers, List<Course> courses) {
//    try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
//        for (Teacher teacher : teachers) {
//            int totalECTSTaken = 0; // Track total ECTS taken by the teacher
//            int coursesAssigned = 0; // Track number of courses assigned to the teacher
//
//            for (Course course : courses) {
//                // Check if the course belongs to the teacher's department
//                if (course.getDepartment().equals(teacher.getDepartment())) {
//                    // Check if the teacher has not reached the maximum ECTS limit and maximum courses per semester
//                    if (totalECTSTaken < 12 && coursesAssigned < 3) {
//                        // Logic to determine if the teacher meets criteria for the course
//                        // For example, based on experience, education level, and field of study
//                        if (!isCourseAssignedToAnotherTeacher(course.getCourseCode())) {
//                            // Assign the course to the teacher
//                            try {
//                                String insertQuery = "INSERT INTO assignedcourse (courseCode, courseName, tid, tName, dept, classYear, semester) VALUES (?, ?, ?, ?, ?, ?, ?)";
//                                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
//                                insertStmt.setString(1, course.getCourseCode());
//                                insertStmt.setString(2, course.getCourseTitle());
//                                insertStmt.setString(3, teacher.getUsername());
//                                insertStmt.setString(4, teacher.getFullName());
//                                insertStmt.setString(5, teacher.getDepartment());
//                                insertStmt.setString(6, course.getBatch());
//                                insertStmt.setString(7, course.getSemester());
//                                insertStmt.executeUpdate();
//                                
//                                // Update totalECTSTaken and coursesAssigned
//                                totalECTSTaken += course.getEcts();
//                                coursesAssigned++;
//                            } catch (SQLException e) {
//                                e.printStackTrace();
//                                // Handle SQL exception
//                                return false; // Return false indicating failure
//                            }
//                        }
//                    } else {
//                        // Break the loop if the teacher has reached the maximum ECTS limit or courses per semester
//                        break;
//                    }
//                }
//            }
//        }
//        return true; // Return true indicating success
//    } catch (SQLException e) {
//        e.printStackTrace();
//        // Handle SQL exception
//        return false; // Return false indicating failure
//    }
//}
//
//// Method to assign a course to a teacher
//private void assignCourseToTeacher(Connection conn, Teacher teacher, Course course) throws SQLException {
//    String insertQuery = "INSERT INTO assignedcourse (courseCode, courseName, tid, tName, dept, classYear, semester) VALUES (?, ?, ?, ?, ?, ?, ?)";
//    try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
//        insertStmt.setString(1, course.getCourseCode());
//        insertStmt.setString(2, course.getCourseTitle());
//        insertStmt.setString(3, teacher.getUsername());
//        insertStmt.setString(4, teacher.getFullName());
//        insertStmt.setString(5, teacher.getDepartment());
//        insertStmt.setString(6, course.getBatch());
//        insertStmt.setString(7, course.getSemester());
//        insertStmt.executeUpdate();
//    }
//}
//
//
//  
//   
//    // Method to check if a course is already assigned to a teacher
//private boolean isCourseAssigned(String teacherUsername, String courseCode) {
//    boolean isAssigned = false;
//    try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
//        String query = "SELECT * FROM assignedcourse WHERE tid = ? AND courseCode = ?";
//        try (PreparedStatement stmt = conn.prepareStatement(query)) {
//            stmt.setString(1, teacherUsername);
//            stmt.setString(2, courseCode);
//            try (ResultSet rs = stmt.executeQuery()) {
//                if (rs.next()) {
//                    isAssigned = true;
//                }
//            }
//        }
//    } catch (SQLException e) {
//        e.printStackTrace();
//        // Handle database connection or query errors
//    }
//    return isAssigned;
//}
//// Method to check if a course is already assigned to another teacher
//private boolean isCourseAssignedToAnotherTeacher(String courseCode) {
//    try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
//        // Query to check if the course is already assigned to another teacher
//        String query = "SELECT COUNT(*) FROM assignedcourse WHERE courseCode = ?";
//        try (PreparedStatement stmt = conn.prepareStatement(query)) {
//            stmt.setString(1, courseCode);
//            try (ResultSet rs = stmt.executeQuery()) {
//                if (rs.next()) {
//                    int count = rs.getInt(1);
//                    return count > 0; // Return true if the course is assigned to another teacher
//                }
//            }
//        }
//    } catch (SQLException e) {
//        e.printStackTrace();
//        // Handle SQL exception
//    }
//    return false; // Return false if an error occurs or if the course is not assigned to another teacher
//}
//
//
//    // Method to update the database with assigned courses for each teacher
//    private void updateDatabaseWithAssignedCourses(List<Teacher> teachers) {
//        // Database update statements to assign courses to teachers
//        // You need to implement this part based on your database schema
//    }
//}