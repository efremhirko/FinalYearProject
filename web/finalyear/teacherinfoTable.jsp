<%@ page import="java.sql.*, javax.naming.*, java.util.*, java.io.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
// Check if the user is logged in and has the role of "head"
HttpSession sessionObj = request.getSession(false);
if (sessionObj != null && sessionObj.getAttribute("role") != null && sessionObj.getAttribute("role").equals("head")) {
    // Get the department of the logged-in user
    String department = (String) sessionObj.getAttribute("dpt");

    int recordsPerPage = 10;
    int currentPage = 1;

    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }

    int startRecord = (currentPage - 1) * recordsPerPage;

%>
<!DOCTYPE html>
<html>
<head>
    <!-- Basic Page Info -->
    <meta charset="utf-8">
    <title>CSCDS</title>

    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="vendors/styles/core.css">
    <link rel="stylesheet" type="text/css" href="vendors/styles/icon-font.min.css">
    <link rel="stylesheet" type="text/css" href="src/plugins/datatables/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" type="text/css" href="src/plugins/datatables/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" type="text/css" href="vendors/styles/style.css">

    <style type="text/css">
        .dataTables_wrapper .dataTables_paginate {
    display: none;
}
    </style>
</head>
<body>
<%@include file="header.jsp" %>

<div class="main-container">
    <div class="pd-ltr-20 xs-pd-20-10">
        <div class="min-height-200px">

            <!-- Export Datatable start -->
            <div class="card-box mb-30">
                <div class="pd-20">
                    <h4 class="text-blue h4">Teacher Information Table</h4>
                </div>
                <div class="pb-20">
                    <table class="table hover multiple-select-row data-table-export nowrap">
                        <thead>
                        <tr>
                            <th>Id</th>
                            <th class="table-plus datatable-nosort">Full Name</th>
                            <th>Gender</th>
                            <th>Experience</th>
                            <th>Education level</th>
                            <th>Field of Study</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Department</th>
                            <th>Role</th>
                            <th class="datatable-nosort">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            boolean hasNextPage = false; // Initialize hasNextPage variable

                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");
                                PreparedStatement pstmt = null;

                                // Constructing the query based on the department
                                switch (department) {
                                    case "SE":
                                        pstmt = con.prepareStatement("SELECT * FROM sweinstructor LIMIT ?, ?");
                                        break;
                                    case "CSE":
                                        pstmt = con.prepareStatement("SELECT * FROM cseinstructor LIMIT ?, ?");
                                        break;
                                    case "CS":
                                        pstmt = con.prepareStatement("SELECT * FROM csinstructor LIMIT ?, ?");
                                        break;
                                    case "IT":
                                        pstmt = con.prepareStatement("SELECT * FROM itinstructor LIMIT ?, ?");
                                        break;
                                    case "IS":
                                        pstmt = con.prepareStatement("SELECT * FROM isinstructor LIMIT ?, ?");
                                        break;
                                    case "ISY":
                                        pstmt = con.prepareStatement("SELECT * FROM isyinstructor LIMIT ?, ?");
                                        break;
                                    default:
                                        // Handle invalid department
                                        break;
                                }

                                if (pstmt != null) {
                                    pstmt.setInt(1, startRecord);
                                    pstmt.setInt(2, recordsPerPage);
                                    ResultSet rs = pstmt.executeQuery();

                                    while (rs.next()) {
                        %>

                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("fullName") %></td>
                            <td><%= rs.getString("gender") %></td>
                            <td><%= rs.getString("experience") %></td>
                            <td><%= rs.getString("educationLevel") %></td>
                            <td><%= rs.getString("fieldOfStudy") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("phone") %></td>
                            <td><%= rs.getString("department") %></td>
                            <td><%= rs.getString("role") %></td>

                            <td>
                                <div class="dropdown">
                                    <a class="btn btn-link font-24 p-0 line-height-1 no-arrow dropdown-toggle" href="#" role="button" data-toggle="dropdown">
                                        <i class="dw dw dw-more"></i>
                                    </a>

                                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-icon-list">
                                        <a class="dropdown-item" href="#"><i class="dw dw-eye"></i> View</a>
                                        <a class="dropdown-item" href="editTeacher.jsp?id=<%= rs.getInt("id") %>"><i class="dw dw-edit2" onclick="return confirm('Are you sure you want to update this teacher?')"></i> Edit</a>
                                        <a class="dropdown-item" href="<%= request.getContextPath()%>/deleteTeacher?id=<%= rs.getInt("id") %>" onclick="return confirm('Are you sure you want to delete this teacher?')"><i class="dw dw-delete-3"></i> Delete</a>
                                    </div>

                                </div>
                            </td>

                        </tr>
                        <%
                                    }
                                    rs.close();
                                    pstmt.close();

                                    // Check if there are more records in the next page
                                    pstmt = con.prepareStatement("SELECT 1 FROM sweinstructor LIMIT ?, 1");
                                    pstmt.setInt(1, startRecord + recordsPerPage);
                                    rs = pstmt.executeQuery();
                                    hasNextPage = rs.next();

                                }

                                con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>

                        </tbody>
                    </table>
                        
                 <!-- Pagination -->
      <ul class="pagination justify-content-center">
        <% 
          try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");
            Statement stmt = con.createStatement();
            int totalRecords = 0;

            // Count total records from different tables based on department
            switch ((String) sessionObj.getAttribute("dpt")) {
              case "SE":
                ResultSet rsSE = stmt.executeQuery("SELECT COUNT(*) AS total FROM sweinstructor");
                rsSE.next();
                totalRecords = rsSE.getInt("total");
                break;
              case "CSE":
                ResultSet rsCSE = stmt.executeQuery("SELECT COUNT(*) AS total FROM cseinstructor");
                rsCSE.next();
                totalRecords = rsCSE.getInt("total");
                break;
              case "CS":
                ResultSet rsCS = stmt.executeQuery("SELECT COUNT(*) AS total FROM csinstructor");
                rsCS.next();
                totalRecords = rsCS.getInt("total");
                break;
              case "IT":
                ResultSet rsIT = stmt.executeQuery("SELECT COUNT(*) AS total FROM itinstructor");
                rsIT.next();
                totalRecords = rsIT.getInt("total");
                break;
              case "IS":
                ResultSet rsIS = stmt.executeQuery("SELECT COUNT(*) AS total FROM isinstructor");
                rsIS.next();
                totalRecords = rsIS.getInt("total");
                break;
              case "ISY":
                ResultSet rsISY = stmt.executeQuery("SELECT COUNT(*) AS total FROM isyinstructor");
                rsISY.next();
                totalRecords = rsISY.getInt("total");
                break;
              default:
                // Handle invalid department
                break;
            }

            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
            con.close();

            // Previous page
            if (currentPage > 1) {
        %>
              <li class="page-item">
                <a class="page-link" href="?currentPage=<%= currentPage - 1 %>">Previous</a>
              </li>
        <% } 

        // Page numbers
        for (int i = 1; i <= totalPages; i++) { %>
          <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
            <a class="page-link" href="?currentPage=<%= i %>"><%= i %></a>
          </li>
        <% } 

        // Next page
        if (currentPage < totalPages) { %>
          <li class="page-item">
            <a class="page-link" href="?currentPage=<%= currentPage + 1 %>">Next</a>
          </li>
        <% } } catch (ClassNotFoundException | SQLException e) {
          out.println("<html><body>");
          out.println("<h2>Error: " + e.getMessage() + "</h2>");
          out.println("</body></html>");
        } %>
      </ul>
</div>
</div>
</div>
<%@ include file="footer.jsp" %>
</div>
</div>
<!-- js -->
<script src="vendors/scripts/core.js"></script>
<script src="vendors/scripts/script.min.js"></script>
<script src="vendors/scripts/process.js"></script>
<script src="vendors/scripts/layout-settings.js"></script>
<script src="src/plugins/datatables/js/jquery.dataTables.min.js"></script>
<script src="src/plugins/datatables/js/dataTables.bootstrap4.min.js"></script>
<script src="src/plugins/datatables/js/dataTables.responsive.min.js"></script>
<script src="src/plugins/datatables/js/responsive.bootstrap4.min.js"></script>
<!-- buttons for Export datatable -->
<script src="src/plugins/datatables/js/dataTables.buttons.min.js"></script>
<script src="src/plugins/datatables/js/buttons.bootstrap4.min.js"></script>
<script src="src/plugins/datatables/js/buttons.print.min.js"></script>
<script src="src/plugins/datatables/js/buttons.html5.min.js"></script>
<script src="src/plugins/datatables/js/buttons.flash.min.js"></script>
<script src="src/plugins/datatables/js/pdfmake.min.js"></script>
<script src="src/plugins/datatables/js/vfs_fonts.js"></script>
<!-- Datatable Setting js -->
<script src="vendors/scripts/datatable-setting.js"></script>
</body>
</html>

<%
} else {
    // Redirect to a login page or show an error message
    response.sendRedirect("http://localhost:8080/FinalYearProject/index.jsp");
}
%>

