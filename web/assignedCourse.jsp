<%@ page import="java.sql.*, javax.naming.*, java.util.*, java.io.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
  // Check if the user is logged in and has the role of "teach"
  HttpSession sessionObj = request.getSession(false);
  if (sessionObj != null && sessionObj.getAttribute("role") != null && sessionObj.getAttribute("role").equals("teach")) {
%>
<!DOCTYPE html>

<html>

    <head>
  <meta charset="UTF-8">
  <title>Course Data</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    th, td {
      text-align: center;
    }
  </style>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css">
 

	<!-- Custom CSS -->
	<style>
             th, td {
      text-align: left;
    }
		body {
			background-color: #f8f9fa;
			display: flex;
			flex-direction: column;
			min-height: 100vh;
		}
		header {
			background-color: #343a40;
			color: #fff;
			padding: 10px;
		}
		h1 {
			margin: 0;
		}
		nav ul {
			list-style: none;
			margin: 0;
			padding: 0;
			display: flex;
			align-items: center;
		}
		nav li {
			margin-right: 20px;
		}
		nav a {
			color: #fff;
			text-decoration: none;
		}
		nav button {
			margin-left: auto;
		}
		main {
			flex: 1;
			display: flex;
			flex-wrap: wrap;
			justify-content: left;
			align-items: flex-start;
			margin: 20px;
		}
		 aside {
      flex: 0 0 250px;
      background-color: #f4f4f4;
      padding: 20px;
    }
    .form-group {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
  }

  .form-group input {
    margin-right: 10px;
  }
		section {
			flex: 2;
			background-color: #fff;
			padding: 20px;
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		}
		
		.vertical-header {
			display: flex;
			flex-direction: row;
			align-items: center;
			height: 100%;
		}

		.container {
			display: flex;
			flex-direction: column;
			justify-content: center;
			align-items: flex-start;
			height: 100%;
		
		}

		nav {
			margin-top: 20px;
		}

		ul {
			list-style: none;
			margin: 0;
			padding: 0;
		}

		li {
			margin-bottom: 10px;
		}

		a {
			text-decoration: none;
			color: #333;
			font-weight: bold;
		}

		button {
			margin-right: 20px;
		}
                .btn btn-light{
                    margin-right: 40px;
                }

		.center {
			text-align: center;
		}
	/* ... existing CSS styles ... */

	footer {
		background-color: #343a40;
		color: #fff;
		padding: 10px;
		text-align: center;
		margin-top: auto;
		width: 100%;
	}

	.container {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	.footer-links {
		list-style: none;
		margin: 0;
		padding: 0;
		display: flex;
	}

	.footer-links li {
		margin-left: 20px;
	}

	.footer-links a {
		text-decoration: none;
		color: #fff;
		font-weight: bold;
	}
            header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      height: 60px;
      padding: 15px;
      background-color: #343a40;
      color: white;
    }
    header a {
      display: inline-block;
      margin-right: 20px;
      color: white;
      text-decoration: none;
      font-weight: bold;
    }
    header a:last-child {
      margin-right: 0;
    }
    
    .logout-button {
      color: white;
    }
</style>

</head>
<body>
  <!-- Include header -->
  <%@ include file="teachheader.jsp" %>

  <section>
    <div class="container">
      <h1>Course Data</h1>
      <div class="form-group">
        <input type="text" id="searchInput" onkeyup="searchTable()" class="form-control" placeholder="Search...">
      </div>
      <div class="table-responsive">
        <table width="100%" id="courseTable" class="table table-striped">
          <!-- Table headers -->
          <thead>
            <tr>
              <th>Id</th>
              <th>Course Code</th>
              <th>Course Title</th>
              <th>Teacher Id</th>
              <th>Teacher Name</th>
              <th>Department</th>
              <th>Class Year</th>
              <th>Semester</th>
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
                ResultSet rs = null;

                if (sessionObj != null && sessionObj.getAttribute("dpt") != null && sessionObj.getAttribute("un") != null) {
                  String dpt = (String) sessionObj.getAttribute("dpt");
                  String id = (String) sessionObj.getAttribute("un");
                  String query = "";

                  switch (dpt) {
                    case "SE":
                      query = "SELECT * FROM assignedcourse WHERE tid = '" + id + "'";
                      break;
                    case "CS":
                      query = "SELECT * FROM itassignedcourse WHERE tid = '" + id + "'";
                      break;
                    case "IS":
                      query = "SELECT * FROM csassignedcourse WHERE tid = '" + id + "'";
                      break;
                    case "ISY":
                      query = "SELECT * FROM isyassignedcourse WHERE tid = '" + id + "'";
                      break;
                    case "IT":
                      query = "SELECT * FROM isassignedcourse WHERE tid = '" + id + "'";
                      break;
                    default:
                      query = "SELECT * FROM cseassignedcourse WHERE tid = '" + id + "'";
                      break;
                  }
                  query += " LIMIT " + startRecord + ", " + recordsPerPage;
                  rs = stmt.executeQuery(query);
                }
                
                while (rs != null && rs.next()) { 
            %>
              <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("CourseCode") %></td>
                <td><%= rs.getString("courseName") %></td>
                <td><%= rs.getString("tid") %></td>
                <td><%= rs.getString("tName") %></td>
                <td><%= rs.getString("dept") %></td>
                <td><%= rs.getString("classYear") %></td>
                <td><%= rs.getString("semester") %></td>
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

      <!-- Pagination -->
      <ul class="pagination justify-content-center">
        <% 
          try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");
            Statement stmt = con.createStatement();
            int totalRecords = 0;

            // Count total records from different tables based on department
            String countQuery = "";
            switch ((String) sessionObj.getAttribute("dpt")) {
              case "SE":
                countQuery = "SELECT COUNT(*) AS total FROM assignedcourse";
                break;
              case "CS":
                countQuery = "SELECT COUNT(*) AS total FROM itassignedcourse";
                break;
              case "IS":
                countQuery = "SELECT COUNT(*) AS total FROM csassignedcourse";
                break;
              case "ISY":
                countQuery = "SELECT COUNT(*) AS total FROM isyassignedcourse";
                break;
              case "IT":
                countQuery = "SELECT COUNT(*) AS total FROM isassignedcourse";
                break;
              default:
                countQuery = "SELECT COUNT(*) AS total FROM cseassignedcourse";
                break;
            }
            ResultSet rsCount = stmt.executeQuery(countQuery);
            if (rsCount.next()) {
              totalRecords = rsCount.getInt("total");
            }
            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
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
          } 
        %>
      </ul>
    </div>
  </section>

  <!-- Include footer -->
 <%@ include file="footer.jsp" %>

  <!-- JavaScript imports and code -->
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
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
         <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
         <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
         <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/intlTelInput.min.js"></script>
</body>
</html>
<%
  } else {
    // Redirect to a login page or show an error message
    response.sendRedirect("index.jsp");
  }
%>
