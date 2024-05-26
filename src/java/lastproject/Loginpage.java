package lastproject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.*;
import java.sql.*;


public class Loginpage extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3307/cscds";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    // SQL queries for each table
    private static final String QUERY_SWE = "SELECT role, Department, username FROM sweinstructor WHERE username = ? AND password = ?";
    private static final String QUERY_IT = "SELECT role, Department FROM itinstructor WHERE username = ? AND password = ?";
    private static final String QUERY_CS = "SELECT role, Department FROM csinstructor WHERE username = ? AND password = ?";
    private static final String QUERY_IS = "SELECT role, Department FROM isinstructor WHERE username = ? AND password = ?";
    private static final String QUERY_CSE = "SELECT role, Department FROM cseinstructor WHERE username = ? AND password = ?";
    private static final String QUERY_ISY = "SELECT role, Department FROM isyinstructor WHERE username = ? AND password = ?";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String role = null;
                String department = null;
                String un = null;
                // Check user credentials in each table
                if ((role = checkUser(conn, QUERY_SWE, username, password)) != null) {
                    department = getDepartment(conn, QUERY_SWE, username, password);
                    un = getUsername(conn, QUERY_SWE, username, password);
                } else if ((role = checkUser(conn, QUERY_IT, username, password)) != null) {
                    department = getDepartment(conn, QUERY_IT, username, password);
                     un = getUsername(conn, QUERY_IT, username, password);
                } else if ((role = checkUser(conn, QUERY_CS, username, password)) != null) {
                    department = getDepartment(conn, QUERY_CS, username, password);
                     un = getUsername(conn, QUERY_CS, username, password);
                } else if ((role = checkUser(conn, QUERY_IS, username, password)) != null) {
                    department = getDepartment(conn, QUERY_IS, username, password);
                     un = getUsername(conn, QUERY_IS, username, password);
                } else if ((role = checkUser(conn, QUERY_CSE, username, password)) != null) {
                    department = getDepartment(conn, QUERY_CSE, username, password);
                     un = getUsername(conn, QUERY_CSE, username, password);
                } else if ((role = checkUser(conn, QUERY_ISY, username, password)) != null) {
                    department = getDepartment(conn, QUERY_ISY, username, password);
                     un = getUsername(conn, QUERY_ISY, username, password);
                } 

                // If role is found, set session attributes and redirect accordingly
                if (role != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("role", role);
                    session.setAttribute("dpt", department);
                    session.setAttribute("un", un);

                    switch (role) {
                        case "head":
                            response.sendRedirect("http://localhost:8080/FinalYearProject/finalyear/head.jsp");
                            break;
                        case "teach":
                            response.sendRedirect("http://localhost:8080/FinalYearProject/finalyear/teachpage.jsp");
                            break;
                        case "stud":
                            response.sendRedirect("student_home.jsp");
                            break;
                        case "admin":
                            response.sendRedirect("admin_home.jsp");
                            break;
                        default:
                            response.sendRedirect("login.jsp?error=invalid_role");
                            break;
                    }
                } else {
                    response.sendRedirect("error.jsp?error=invalid_credentials");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    private String checkUser(Connection conn, String query, String username, String password) throws Exception {
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("role");
                }
            }
        }
        return null;
    }
      private String getUsername(Connection conn, String query, String username, String password) throws Exception {
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("username");
                }
            }
        }
        return null;
    }

    private String getDepartment(Connection conn, String query, String username, String password) throws Exception {
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("Department");
                    
                }
            }
        }
        return null;
    }
}
