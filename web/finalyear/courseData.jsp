
<%@ page import="java.sql.*, javax.naming.*, java.util.*, java.io.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
  // Check if the user is logged in and has the role of "head"
  HttpSession sessionObj = request.getSession(false);
  if (sessionObj != null && sessionObj.getAttribute("role") != null && sessionObj.getAttribute("role").equals("head")) {
%>
<!DOCTYPE html>
<html>
<head>
	<!-- Basic Page Info -->
	<meta charset="utf-8">
	<title>CSCDS</title>
	<!-- Mobile Specific Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
	<!-- CSS -->
	<link rel="stylesheet" type="text/css" href="vendors/styles/core.css">
	<link rel="stylesheet" type="text/css" href="vendors/styles/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="src/plugins/datatables/css/dataTables.bootstrap4.min.css">
	<link rel="stylesheet" type="text/css" href="src/plugins/datatables/css/responsive.bootstrap4.min.css">
	<link rel="stylesheet" type="text/css" href="vendors/styles/style.css">

	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-119386393-1"></script>
	
</head>
<body>
      <%@include file="header.jsp" %>

	<div class="main-container">
		<div class="pd-ltr-20 xs-pd-20-10">
			<div class="min-height-200px">
				
				
				<!-- Export Datatable start -->
				<div class="card-box mb-30">
					<div class="pd-20">
						<h4 class="text-blue h4">Data Table with Export Buttons</h4>
					</div>
					<div class="pb-20">
						<table class="table hover multiple-select-row data-table-export nowrap">
		
   
     <thead>
            <tr>
              <th>Id</th>
          <th class="table-plus datatable-nosort">Course Code</th>
              <th>Course Title</th>
              <th>ECTS</th>
              <th>Lec</th>
              <th>Tut</th>
              <th>Lab</th>
              <th>Batch</th>
              <th>Semester</th>
              <th>Department</th>
               <th  class="datatable-nosort">Action</th>
            </tr>
          </thead>
          <tbody>
              
            <% 
              int recordsPerPage = 10;
              int currentPage = 1;

              // Get the current page number from the query parameter
              if (request.getParameter("currentPage") != null) {
                currentPage = Integer.parseInt(request.getParameter("currentPage"));
              }

              int startRecord = (currentPage - 1) * recordsPerPage;

              try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");
                Statement stmt = con.createStatement();
                ResultSet rs = null; // Declare ResultSet here
            %>
            <% if (sessionObj != null && sessionObj.getAttribute("dpt") != null) { 
                  String dpt = (String) sessionObj.getAttribute("dpt");
                  String query = "";
                  switch (dpt) {
                    case "SE":
                      query = "SELECT * FROM swecourse";
                      break;
                    case "CS":
                      query = "SELECT * FROM cscourse";
                      break;
                    case "IS":
                      query = "SELECT * FROM iscourse";
                      break;
                    case "ISY":
                      query = "SELECT * FROM isycourse";
                      break;
                    case "IT":
                      query = "SELECT * FROM itcourse";
                      break;
                    default:
                      query = "SELECT * FROM csecourse";
                      break;
                  }
                  query += " LIMIT " + startRecord + ", " + recordsPerPage;
                  rs = stmt.executeQuery(query);
              } 
            %>
            <% while (rs.next()) { %>
              <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("CourseCode") %></td>
                <td><%= rs.getString("CourseTitle") %></td>
                <td><%= rs.getString("ECTS") %></td>
                <td><%= rs.getString("Lech") %></td>
                <td><%= rs.getString("Tuth") %></td>
                <td><%= rs.getString("Labh") %></td>
                <td><%= rs.getString("Batch") %></td>
                <td><%= rs.getString("Semester") %></td>
                <td><%= rs.getString("Department") %></td>
              <td>
     <div class="dropdown"> 
    <a class="btn btn-link font-24 p-0 line-height-1 no-arrow dropdown-toggle" href="#" role="button" data-toggle="dropdown">
                        <i class="dw dw-more"></i>
                </a>
         
             <div class="dropdown-menu dropdown-menu-right dropdown-menu-icon-list">
                        <a class="dropdown-item" href="#"><i class="dw dw-eye"></i> View</a>
                        <a class="dropdown-item" href="editCourse.jsp?id=<%= rs.getInt("id") %>"><i class="dw dw-edit2" onclick="return confirm('Are you sure you want to update this course?')"></i> Edit</a>
                        <a class="dropdown-item" href="<%= request.getContextPath()%>/deleteCourse?id=<%= rs.getInt("id") %>" onclick="return confirm('Are you sure you want to delete this course?')"><i class="dw dw-delete-3"></i> Delete</a>
                </div>
         
      </div>
</td>
              </tr>
            <% } 
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
                ResultSet rsSE = stmt.executeQuery("SELECT COUNT(*) AS total FROM swecourse");
                rsSE.next();
                totalRecords = rsSE.getInt("total");
                break;
              case "CS":
                ResultSet rsCS = stmt.executeQuery("SELECT COUNT(*) AS total FROM cscourse");
                rsCS.next();
                totalRecords = rsCS.getInt("total");
                break;
              case "IS":
                ResultSet rsIS = stmt.executeQuery("SELECT COUNT(*) AS total FROM iscourse");
                rsIS.next();
                totalRecords = rsIS.getInt("total");
                break;
              case "ISY":
                ResultSet rsISY = stmt.executeQuery("SELECT COUNT(*) AS total FROM isycourse");
                rsISY.next();
                totalRecords = rsISY.getInt("total");
                break;
              case "IT":
                ResultSet rsIT = stmt.executeQuery("SELECT COUNT(*) AS total FROM itcourse");
                rsIT.next();
                totalRecords = rsIT.getInt("total");
                break;
              default:
                ResultSet rsDefault = stmt.executeQuery("SELECT COUNT(*) AS total FROM csecourse");
                rsDefault.next();
                totalRecords = rsDefault.getInt("total");
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
				<!-- Export Datatable End -->
			</div>
			<%@ include file="footer.jsp" %>
		</div>
	
                                         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    function searchTable() {
      var input, filter, table, tr, td, i, txtValue;
      input = document.getElementById("searchInput");
      filter = input.value.toUpperCase();
      table = document.getElementById("courseTable");
      tr = table.getElementsByTagName("tr");

      for (i = 0; i < tr.length; i++) {
        var found = false;
        for (var j = 0; j < tr[i].cells.length - 1; j++) { // Exclude last column (Action)
          td = tr[i].getElementsByTagName("td")[j];
          if (td) {
            txtValue = td.textContent || td.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
              found = true;
              break;
            }
          }
        }
        tr[i].style.display = found ? "" : "none";
      }
    }
  </script>
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
