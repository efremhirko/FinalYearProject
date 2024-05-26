package lastproject;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.util.*;
import java.sql.*;

public class CourseAssignment extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3307/cscds";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null || !session.getAttribute("role").equals("head")) {
            response.sendRedirect("error.jsp");
            return;
        }

        String department = (String) session.getAttribute("dpt");

        List<Teacher> teachers = getTeachersForDepartment(department);
        List<Course> courses = getCoursesForDepartment(department);

        // Sort teachers by Experience and Education Level in descending order
        teachers.sort(Comparator.comparingInt(Teacher::getExperience).reversed()
                .thenComparing(Comparator.comparing(Teacher::getEducationLevel).reversed()));

        boolean coursesAssignedSuccessfully = assignCoursesToTeachers(teachers, courses);

        if (coursesAssignedSuccessfully) {
            request.getRequestDispatcher("/assignmentConfirmation.jsp").forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    private List<Teacher> getTeachersForDepartment(String department) {
        List<Teacher> teachers = new ArrayList<>();
        Set<String> relevantDepartments = getRelevantDepartments(department);

        for (String dept : relevantDepartments) {
            String query = "SELECT * FROM " + getTeacherTableName(dept);

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(query);
                 ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Teacher teacher = new Teacher(
                        rs.getString("fullName"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("Gender"),
                        rs.getInt("Experience"),
                        rs.getString("EducationLevel"),
                        rs.getString("FieldOfStudy"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getString("Department"),
                        rs.getString("role")
                    );
                    teachers.add(teacher);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return teachers;
    }

    private Set<String> getRelevantDepartments(String department) {
        Set<String> relevantDepartments = new HashSet<>();
        // Implement logic to determine relevant departments based on courses offered
        // For simplicity, let's include all departments for now
        relevantDepartments.add("CS");
        relevantDepartments.add("CSE");
        relevantDepartments.add("IS");
        relevantDepartments.add("ISY");
        relevantDepartments.add("IT");
        relevantDepartments.add("SE");
        // Add additional relevant departments based on the department provided
        return relevantDepartments;
    }

    private List<Course> getCoursesForDepartment(String department) {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT * FROM " + getCourseTableName(department);

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Course course = new Course(
                    rs.getString("CourseCode"),
                    rs.getString("CourseTitle"),
                    rs.getInt("ECTS"),
                    rs.getInt("Lech"),
                    rs.getInt("Tuth"),
                    rs.getInt("Labh"),
                    rs.getInt("Batch"),
                    rs.getString("Semester"),
                    rs.getString("Department")
                );
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    private boolean assignCoursesToTeachers(List<Teacher> teachers, List<Course> courses) {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            for (Teacher teacher : teachers) {
                String tableName = getAssignedCourseTableName(teacher.getDepartment());
                if (tableName == null) {
                    continue; // Skip if the table name is not valid
                }

                int coursesAssigned = getCoursesAssignedCount(teacher.getUsername(), tableName, conn);
                int totalECTSTaken = getTotalECTSAssigned(teacher.getUsername(), tableName, conn);

                for (Course course : courses) {
                    if (course.getDepartment().equals(teacher.getDepartment())) {
                        if (!isCourseAssignedToAnotherTeacher(course.getCourseCode(), tableName, conn) && totalECTSTaken + course.getEcts() <= 12 && coursesAssigned < 3) {
                            if (!isCourseAssignedToTeacherInBatch(teacher.getUsername(), course.getBatch(), course.getSemester(), tableName, conn)) {
                                assignCourseToTeacher(conn, teacher, course, tableName);
                                totalECTSTaken += course.getEcts();
                                coursesAssigned++;
                                if (totalECTSTaken >= 12 || coursesAssigned >= 3) {
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    private String getTeacherTableName(String department) {
        switch (department) {
            case "CS":
                return "csinstructor";
            case "CSE":
                return "cseinstructor";
            case "IS":
                return "isinstructor";
            case "ISY":
                return "isyinstructor";
            case "IT":
                return "itinstructor";
            case "SE":
                return "sweinstructor";
            default:
                return null;
        }
    }

    private String getCourseTableName(String department) {
        switch (department) {
            case "CS":
                return "cscourse";
            case "CSE":
                return "csecourse";
            case "IS":
                return "isccourse";
            case "ISY":
                return "isycourse";
            case "IT":
                return "itcourse";
            case "SE":
                return "swecourse";
            default:
                return null;
        }
    }

    private String getAssignedCourseTableName(String department) {
        switch (department) {
            case "CS":
                return "csassignedcourse";
            case "CSE":
                return "cseassignedcourse";
            case "IS":
                return "isassignedcourse";
            case "ISY":
                return "isyassignedcourse";
            case "IT":
                return "itassignedcourse";
            case "SE":
                return "sweassignedcourse";
            default:
                return null;
        }
    }

    private void assignCourseToTeacher(Connection conn, Teacher teacher, Course course, String tableName) throws SQLException {
        String insertQuery = "INSERT INTO " + tableName + " (courseCode, courseName, tid, tName, dept, classYear, semester) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
            insertStmt.setString(1, course.getCourseCode());
            insertStmt.setString(2, course.getCourseTitle());
            insertStmt.setString(3, teacher.getUsername());
            insertStmt.setString(4, teacher.getFullName());
            insertStmt.setString(5, teacher.getDepartment());
            insertStmt.setInt(6, course.getBatch());
            insertStmt.setString(7, course.getSemester());
            insertStmt.executeUpdate();
        }
    }

    private boolean isCourseAssignedToAnotherTeacher(String courseCode, String tableName, Connection conn) throws SQLException {
        String query = "SELECT COUNT(*) FROM " + tableName + " WHERE courseCode = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, courseCode);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0;
                }
            }
        }
        return false;
    }

    private boolean isCourseAssignedToTeacherInBatch(String teacherUsername, int batch, String semester, String tableName, Connection conn) throws SQLException {
        String query = "SELECT COUNT(*) FROM " + tableName + " WHERE tid = ? AND classYear = ? AND semester = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, teacherUsername);
            stmt.setInt(2, batch);
            stmt.setString(3, semester);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0;
                }
            }
        }
        return false;
    }

    private int getCoursesAssignedCount(String teacherUsername, String tableName, Connection conn) throws SQLException {
        String query = "SELECT COUNT(*) FROM " + tableName + " WHERE tid = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, teacherUsername);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    private int getTotalECTSAssigned(String teacherUsername, String tableName, Connection conn) throws SQLException {
        String query = "SELECT SUM(courses.ECTS) FROM " + tableName + " ac INNER JOIN (SELECT courseCode, ECTS FROM cscourse UNION ALL SELECT courseCode, ECTS FROM csecourse UNION ALL SELECT courseCode, ECTS FROM isccourse UNION ALL SELECT courseCode, ECTS FROM isycourse UNION ALL SELECT courseCode, ECTS FROM itcourse UNION ALL SELECT courseCode, ECTS FROM swecourse) courses ON ac.courseCode = courses.courseCode WHERE ac.tid = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, teacherUsername);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    private void updateDatabaseWithAssignedCourses(List<Teacher> teachers) {
        // This method can be used for additional database updates if needed
    }
}

