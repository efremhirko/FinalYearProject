package lastproject;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import java.util.*;

public class CourseSchedule extends HttpServlet {
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

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            generateAndInsertSchedule(conn, "software2ndyear", 2, department);
            generateAndInsertSchedule(conn, "software3rdyear", 3, department);
            generateAndInsertSchedule(conn, "software4thyear", 4, department);
            generateAndInsertSchedule(conn, "software5thyear", 5, department);

            request.getRequestDispatcher("/scheduleConfirmation.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void generateAndInsertSchedule(Connection conn, String tableName, int year, String department) throws SQLException {
        // Time slots
        String[] timeSlots = {"2-3:50", "4-5:50", "7-8:50", "9-11"};
        // Days of the week
        String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};

        // Get assigned courses for the specified year and department
        String query = "SELECT courseCode, tid FROM sweassignedcourse WHERE classYear = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, year);
            try (ResultSet rs = stmt.executeQuery()) {
                Map<String, String> courseTeacherMap = new HashMap<>();
                List<String> courseCodes = new ArrayList<>();
                while (rs.next()) {
                    String courseCode = rs.getString("courseCode");
                    String teacherId = rs.getString("tid");
                    courseCodes.add(courseCode);
                    courseTeacherMap.put(courseCode, teacherId);
                }

                // Shuffle courses for random distribution
                Collections.shuffle(courseCodes);

                // Create an empty schedule
                String[][] schedule = new String[4][6]; // 4 time slots and 6 columns (index 0 is unused for day names)

                int courseIndex = 0;
                while (courseIndex < courseCodes.size()) {
                    String courseCode = courseCodes.get(courseIndex);
                    String teacherId = courseTeacherMap.get(courseCode);
                    int assignedCount = 0;
                    for (int i = 0; i < timeSlots.length; i++) {
                        for (int j = 1; j <= 5; j++) { // Loop to iterate from 1 to 5 for days
                            if (schedule[i][j] == null && assignedCount < 3 && !isTeacherScheduled(schedule, teacherId, i, j, courseTeacherMap)) {
                                schedule[i][j] = courseCode;
                                assignedCount++;
                                if (assignedCount == 3) break;
                            }
                        }
                        if (assignedCount == 3) break;
                    }
                    courseIndex++;
                }

                // Insert the schedule into the appropriate table
                String insertQuery = "INSERT INTO " + tableName + " (time, Monday, Tuesday, Wednesday, Thursday, Friday) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                    for (int i = 0; i < schedule.length; i++) {
                        insertStmt.setString(1, timeSlots[i]);
                        for (int j = 1; j <= 5; j++) { // Loop to iterate from 1 to 5 for days
                            insertStmt.setString(j + 1, schedule[i][j] != null ? schedule[i][j] : "");
                        }
                        insertStmt.executeUpdate();
                    }
                }
            }
        }
    }

    private boolean isTeacherScheduled(String[][] schedule, String teacherId, int timeSlot, int day, Map<String, String> courseTeacherMap) {
        for (int i = 0; i < schedule.length; i++) {
            if (courseTeacherMap.get(schedule[i][day]) != null && courseTeacherMap.get(schedule[i][day]).equals(teacherId)) {
                return true;
            }
        }
        return false;
    }
}
