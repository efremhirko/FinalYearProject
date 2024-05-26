<%@ page import="java.sql.*, javax.naming.*, java.util.*, java.io.*, javax.servlet.http.*" %>
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
                    <h4 class="text-blue h4">Student Information Table</h4>
                </div>
                <div class="pb-20">
                    <table class="table hover multiple-select-row data-table-export nowrap">
                        <thead>
                        <tr>
                            <th>Id</th>
                            <th class="table-plus datatable-nosort">Full Name</th>
                            <th>Class Year</th>
                            <th>Department</th>
                            <th>Gender</th>
                            <th class="datatable-nosort">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            boolean hasNextPage = false; // Initialize hasNextPage variable

                            Connection con = null;
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                con = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");

                                // Constructing the query based on the department
                                String query = null;
                                switch (department) {
                                    case "SE":
                                        query = "SELECT * FROM swestudent LIMIT ?, ?";
                                        break;
                                    case "CSE":
                                        query = "SELECT * FROM csestudent LIMIT ?, ?";
                                        break;
                                    case "CS":
                                        query = "SELECT * FROM csstudent LIMIT ?, ?";
                                        break;
                                    case "IT":
                                        query = "SELECT * FROM itstudent LIMIT ?, ?";
                                        break;
                                    case "IS":
                                        query = "SELECT * FROM isstudent LIMIT ?, ?";
                                        break;
                                    case "ISY":
                                        query = "SELECT * FROM isystudent LIMIT ?, ?";
                                        break;
                                    default:
                                        throw new IllegalArgumentException("Invalid department: " + department);
                                }

                                pstmt = con.prepareStatement(query);
                                pstmt.setInt(1, startRecord);
                                pstmt.setInt(2, recordsPerPage);
                                rs = pstmt.executeQuery();

                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("fullname") %></td>
                            <td><%= rs.getInt("classyear") %></td>
                            <td><%= rs.getString("department") %></td>
                            <td><%= rs.getString("gender") %></td>
                            <td>
                                <div class="dropdown">
                                    <a class="btn btn-link font-24 p-0 line-height-1 no-arrow dropdown-toggle" href="#" role="button" data-toggle="dropdown">
                                        <i class="dw dw-more"></i>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-icon-list">
                                        <a class="dropdown-item" href="#"><i class="dw dw-eye"></i> View</a>
                                        <a class="dropdown-item" href="editStudent.jsp?id=<%= rs.getInt("id") %>"><i class="dw dw-edit2" onclick="return confirm('Are you sure you want to update this student?')"></i> Edit</a>
                                        <a class="dropdown-item" href="<%= request.getContextPath() %>/deleteStudent?id=<%= rs.getInt("id") %>" onclick="return confirm('Are you sure you want to delete this student?')"><i class="dw dw-delete-3"></i> Delete</a>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                            } catch (ClassNotFoundException | SQLException e) {
                                out.println("<html><body>");
                                out.println("<h2>Error: " + e.getMessage() + "</h2>");
                                out.println("</body></html>");
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                                if (con != null) try { con.close(); } catch (SQLException ignore) {}
                            }
                        %>
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    <ul class="pagination justify-content-center">
                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                con = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");
                                Statement stmt = con.createStatement();
                                int totalRecords = 0;

                                // Count total records from different tables based on department
                                String countQuery = null;
                                switch (department) {
                                    case "SE":
                                        countQuery = "SELECT COUNT(*) AS total FROM swestudent";
                                        break;
                                    case "CSE":
                                        countQuery = "SELECT COUNT(*) AS total FROM csestudent";
                                        break;
                                    case "CS":
                                        countQuery = "SELECT COUNT(*) AS total FROM csstudent";
                                        break;
                                    case "IT":
                                        countQuery = "SELECT COUNT(*) AS total FROM itstudent";
                                        break;
                                    case "IS":
                                        countQuery = "SELECT COUNT(*) AS total FROM isstudent";
                                        break;
                                    case "ISY":
                                        countQuery = "SELECT COUNT(*) AS total FROM isystudent";
                                        break;
                                    default:
                                        throw new IllegalArgumentException("Invalid department: " + department);
                                }

                                rs = stmt.executeQuery(countQuery);
                                if (rs.next()) {
                                    totalRecords = rs.getInt("total");
                                }
                                int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
                                rs.close();
                                stmt.close();
                                con.close();
                                
                                // Previous page
                                if (currentPage > 1) {
                        %>
                        <li class="page-item">
                            <a class="page-link" href="?currentPage=<%= currentPage - 1 %>">Previous</a>
                        </li>
                        <% 
                                } 
                                // Page numbers
                                for (int i = 1; i <= totalPages; i++) { 
                        %>
                        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                            <a class="page-link" href="?currentPage=<%= i %>"><%= i %></a>
                        </li>
                        <% 
                                } 
                                // Next page
                                if (currentPage < totalPages) { 
                        %>
                        <li class="page-item">
                            <a class="page-link" href="?currentPage=<%= currentPage + 1 %>">Next</a>
                        </li>
                        <% 
                                } 
                            } catch (ClassNotFoundException | SQLException e) {
                                out.println("<html><body>");
                                out.println("<h2>Error: " + e.getMessage() + "</h2>");
                                out.println("</body></html>");
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                                if (con != null) try { con.close(); } catch (SQLException ignore) {}
                            }
                        %>
                    </ul>
                </div>
            </div>
            <!-- Export Datatable end -->
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
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
