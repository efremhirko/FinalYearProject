package lastproject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



public class deleteCourse extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));

        // Get department from session
        HttpSession session = request.getSession(false);
        String department = (String) session.getAttribute("dpt");

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");

            String sql = "";
            switch (department) {
                case "SE":
                    sql = "DELETE FROM swecourse WHERE id = ?";
                    break;
                case "CS":
                    sql = "DELETE FROM cscourse WHERE id = ?";
                    break;
                case "IS":
                    sql = "DELETE FROM iscourse WHERE id = ?";
                    break;
                case "ISY":
                    sql = "DELETE FROM isycourse WHERE id = ?";
                    break;
                case "IT":
                    sql = "DELETE FROM itcourse WHERE id = ?";
                    break;
                default:
                    sql = "DELETE FROM csecourse WHERE id = ?";
                    break;
            }

            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);

            int rowsDeleted = statement.executeUpdate();
            if (rowsDeleted > 0) {
                response.sendRedirect("http://localhost:8080/FinalYearProject/finalyear/courseData.jsp");
            } else {
                request.setAttribute("errorMessage", "Resource not found");
                request.getRequestDispatcher("courseData.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
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
