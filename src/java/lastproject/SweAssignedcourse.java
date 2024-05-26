package lastproject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Set;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SweAssignedcourse extends HttpServlet {

    // Constants for database connection
    private static final String DB_URL = "jdbc:mysql://localhost:3307/cscds";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        assignCoursesToAllTeachers();
       response.sendRedirect("http://localhost:8080/FinalYearProject/finalyear/assignedCourseall.jsp");
    }

    // Method to assign courses to all registered teachers
    private void assignCoursesToAllTeachers() {
        List<Teacher> teachers = getAllTeachers();
        List<Course> courses = getAllCourses();

        // Sort teachers by Experience and Education Level in descending order
        teachers.sort(Comparator.comparingInt(Teacher::getExperience).reversed()
                .thenComparing(Comparator.comparing(Teacher::getEducationLevel).reversed()));

        assignCoursesToTeachers(teachers, courses);
    }

    // Method to get all teachers from sweinstructor table
    private List<Teacher> getAllTeachers() {
        List<Teacher> teachers = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "SELECT * FROM sweinstructor";
            try (PreparedStatement stmt = conn.prepareStatement(query);
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return teachers;
    }

    // Method to get all courses from swecourse table
    private List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "SELECT * FROM swecourse";
            try (PreparedStatement stmt = conn.prepareStatement(query);
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courses;
    }

    // Method to assign courses to teachers based on given conditions
    private void assignCoursesToTeachers(List<Teacher> teachers, List<Course> courses) {
        // Iterate over each department and assign courses to teachers within that department
        for (String department : getDistinctDepartments(teachers)) {
            // Get teachers and courses for the current department
            List<Teacher> departmentTeachers = getTeachersByDepartment(teachers, department);
            List<Course> departmentCourses = getCoursesByDepartment(courses, department);

            // Set to keep track of assigned courses
            Set<String> assignedCourses = new HashSet<>();
            int teacherIndex = 0;

            // Iterate over available courses and assign them to the teachers
            for (Course course : departmentCourses) {
                // Check if the course has not been assigned yet
                if (!assignedCourses.contains(course.getCourseCode())) {
                    // Get the current teacher
                    Teacher teacher = departmentTeachers.get(teacherIndex);

                    // Assign the course to the teacher
                    assignCourseToTeacher(teacher, course);
                    assignedCourses.add(course.getCourseCode());

                    // Move to the next teacher
                    teacherIndex = (teacherIndex + 1) % departmentTeachers.size();
                }
            }
        }
    }

    // Method to get distinct departments from the list of teachers
    private List<String> getDistinctDepartments(List<Teacher> teachers) {
        Set<String> departments = new HashSet<>();
        for (Teacher teacher : teachers) {
            departments.add(teacher.getDepartment());
        }
        return new ArrayList<>(departments);
    }

    // Method to get teachers by department
    private List<Teacher> getTeachersByDepartment(List<Teacher> teachers, String department) {
        List<Teacher> departmentTeachers = new ArrayList<>();
        for (Teacher teacher : teachers) {
            if (teacher.getDepartment().equals(department)) {
                departmentTeachers.add(teacher);
            }
        }
        return departmentTeachers;
    }

    // Method to get courses by department
    private List<Course> getCoursesByDepartment(List<Course> courses, String department) {
        List<Course> departmentCourses = new ArrayList<>();
        for (Course course : courses) {
            if (course.getDepartment().equals(department)) {
                departmentCourses.add(course);
            }
        }
        return departmentCourses;
    }

    // Method to assign a course to a teacher
    private void assignCourseToTeacher(Teacher teacher, Course course) {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // SQL query to insert data into sweassignedcourse table
            String query = "INSERT INTO sweassignedcourse (courseCode, courseName, tid, tName, dept, classYear, semester) VALUES (?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                // Set parameters for the PreparedStatement
                stmt.setString(1, course.getCourseCode());
                stmt.setString(2, course.getCourseTitle());
                stmt.setString(3, teacher.getUsername());
                stmt.setString(4, teacher.getFullName());
                stmt.setString(5, teacher.getDepartment());
                stmt.setInt(6, course.getBatch());
                stmt.setString(7, course.getSemester());

                // Execute the INSERT statement
                stmt.executeUpdate();

                System.out.println("Course assigned successfully: " + course.getCourseTitle() + " to teacher: " + teacher.getFullName());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
