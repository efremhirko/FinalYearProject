
<%@ page import="java.sql.*, javax.naming.*, java.util.*, java.io.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
  // Check if the user is logged in and has the role of "head"
  HttpSession sessionObj = request.getSession(false);
  if (sessionObj != null && sessionObj.getAttribute("role") != null && sessionObj.getAttribute("role").equals("teach")) {
%>
<!DOCTYPE html>
<html>
<head>
	<!-- Basic Page Info -->
	<meta charset="utf-8">
	<title>CSCDS</title>

	<!-- Site favicon
	<link rel="apple-touch-icon" sizes="180x180" href="vendors/images/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="vendors/images/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="vendors/images/favicon-16x16.png">-->

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
<%
      // Check if the user is logged in
       sessionObj = request.getSession(false);
      if (sessionObj != null && sessionObj.getAttribute("role") != null) {
        String role = (String) sessionObj.getAttribute("role");
        String department = (String) sessionObj.getAttribute("dpt");
        String username = (String) sessionObj.getAttribute("un");

        try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");
          Statement stmt = con.createStatement();
          ResultSet rs = null;

          List<String> courseCodes = new ArrayList<>();
          List<String> classYears = new ArrayList<>();

          String queryCourse = "SELECT * FROM assignedcourse WHERE tid='" + username + "'";
          rs = stmt.executeQuery(queryCourse);

          while (rs.next()) {
            courseCodes.add(rs.getString("courseCode"));
            classYears.add(rs.getString("classYear"));
          }

          for (String year : classYears) {
            int classYear = Integer.parseInt(year);
            switch (classYear) {
              case 2:
                queryCourse = "SELECT * FROM software2ndyear";
                break;
              case 3:
                queryCourse = "SELECT * FROM software3rdyear";
                break;
              case 4:
                queryCourse = "SELECT * FROM software4thyear";
                break;
              case 5:
                queryCourse = "SELECT * FROM software5thyear";
                break;
              default:
                queryCourse = "";
            }

            if (!queryCourse.isEmpty()) {
              rs = stmt.executeQuery(queryCourse);
    %>
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
                        <th>Time</th>
                        <th class="table-plus datatable-nosort">Monday</th>
                        <th>Tuesday</th>
                        <th>Wednesday</th>
                        <th>Thursday</th>
                        <th>Friday</th>
                      </tr>
          
          </thead>
          <tbody><% while (rs.next()) { %>
                        <tr>
                          <td><%= rs.getString("time") %></td>
                          <% for (String course : courseCodes) { %>
                            <td><%= course.equals(rs.getString("Monday")) ? course : "" %></td>
                            <td><%= course.equals(rs.getString("Tuesday")) ? course : "" %></td>
                            <td><%= course.equals(rs.getString("Wednesday")) ? course : "" %></td>
                            <td><%= course.equals(rs.getString("Thursday")) ? course : "" %></td>
                            <td><%= course.equals(rs.getString("Friday")) ? course : "" %></td>
                          <% } %>
                        </tr>
                      <% } %>
          </tbody>
                
                
                 </table>
      </div>

      <!-- Pagination -->
       <%
            }
          }
          con.close();
        } catch (ClassNotFoundException | SQLException e) {
          out.println("<html><body>");
          out.println("<h2>Error: " + e.getMessage() + "</h2>");
          out.println("</body></html>");
        }
      } else {
        // Redirect to a login page or show an error message
        response.sendRedirect("index.jsp");
      }
    %>
    </div>
				</div>
				<!-- Export Datatable End -->
			</div>
        <%@include file="footer.jsp" %>
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
        for (var j = 0; j < tr[i].cells.length; j++) {
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
