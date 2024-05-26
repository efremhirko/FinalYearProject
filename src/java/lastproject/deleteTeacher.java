
package lastproject;

import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class deleteTeacher extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));

        // Check if the user is logged in and has the role of "head"
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null || !session.getAttribute("role").equals("head")) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Retrieve the department of the logged-in department head
        String headDepartment = (String) session.getAttribute("dpt");
        System.out.println("Head Department: " + headDepartment); // Logging the department

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");

            // Determine the correct instructor table based on the head's department
            String tableName = null;
            switch (headDepartment) {
                case "SE":
                    tableName = "sweinstructor";
                    break;
                case "CS":
                    tableName = "csinstructor";
                    break;
                case "IS":
                    tableName = "isnstructor";
                    break;
                case "ISY":
                    tableName = "isyinstructor";
                    break;
                case "IT":
                    tableName = "itnstructor";
                    break;
                case "CSE":
                    tableName = "csenstructor";
                    break;
                default:
                    request.setAttribute("errorMessage", "Teacher not found.");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                    return;
            }

            System.out.println("Table Name: " + tableName); // Logging the table name

            // Proceed with deleting the teacher
            String sql = "DELETE FROM " + tableName + " WHERE id = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);

            int rowsDeleted = statement.executeUpdate();
            if (rowsDeleted > 0) {
                response.sendRedirect("http://localhost:8080/FinalYearProject/finalyear/teacherinfoTable.jsp");
            } else {
                request.setAttribute("errorMessage", "Teacher not found.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
