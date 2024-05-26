<%@ page import="java.sql.*" %>
<%
    String tableName = request.getParameter("tableName");
%>
<div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
        <div class="modal-header">
            <h4 class="modal-title">Class Schedule for <%= tableName %></h4>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        </div>
        <div class="modal-body">
            <div class="pb-20">
                <table class="table hover multiple-select-row data-table-export nowrap">
                    <thead>
                        <tr>
                            <th class="table-plus datatable-nosort">id</th>
                            <th class="nosort">time</th>
                            <th>Monday</th>
                            <th>Tuesday</th>
                            <th>Wednesday</th>
                            <th>Thursday</th>
                            <th>Friday</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");
                                Statement stmt = con.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT * FROM " + tableName);

                                while (rs.next()) { 
                        %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("time") %></td>
                            <td><%= rs.getString("Monday") %></td>
                            <td><%= rs.getString("Tuesday") %></td>
                            <td><%= rs.getString("Wednesday") %></td>
                            <td><%= rs.getString("Thursday") %></td>
                            <td><%= rs.getString("Friday") %></td>
                        </tr>
                        <% 
                                }
                                con.close();
                            } catch (ClassNotFoundException | SQLException e) {
                                out.println("<html><body>");
                                out.println("<h2>Error: " + e.getMessage() + "</h2>");
                                out.println("</body></html>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
    </div>
</div>
