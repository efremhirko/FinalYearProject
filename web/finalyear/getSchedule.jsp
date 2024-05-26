<%@ page import="java.sql.*" %>
<%@ page import="java.io.IOException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String tableName = request.getParameter("table");
    if (tableName != null && !tableName.isEmpty()) {
        displaySchedule(out, tableName);
    }

    public void displaySchedule(JspWriter out, String tableName) throws SQLException, IOException {
        String dbURL = "jdbc:mysql://localhost:3307/cscds";
        String dbUser = "root";
        String dbPassword = "";

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
            stmt = conn.createStatement();
            String query = "SELECT * FROM " + tableName;
            rs = stmt.executeQuery(query);

            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("id") + "</td>");
                out.println("<td>" + rs.getString("time") + "</td>");
                out.println("<td>" + rs.getString("Monday") + "</td>");
                out.println("<td>" + rs.getString("Tuesday") + "</td>");
                out.println("<td>" + rs.getString("Wednesday") + "</td>");
                out.println("<td>" + rs.getString("Thursday") + "</td>");
                out.println("<td>" + rs.getString("Friday") + "</td>");
                out.println("</tr>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
%>
