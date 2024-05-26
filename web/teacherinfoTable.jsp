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
  <meta charset="UTF-8">
  <title>Course Data</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.min.css">
  <style>
    th, td {
      text-align: center;
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
    .btn.btn-light {
      margin-right: 40px;
    }
    .center {
      text-align: center;
    }
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
    img {
      border-radius: 50%;
    }
  </style>
</head>
<body>
<%@ include file="header.jsp" %>
<section>
    <div class="container">
      <h1>Teacher Information</h1>

      <div class="form-group">
        <input type="text" id="searchInput" onkeyup="searchTable()" class="form-control" placeholder="Search...">
      </div>

      <div class="table-responsive">
        <table width="100%" id="courseTable" class="table table-striped">
          <!-- Table headers -->
          <thead>
            <tr>
                            <th>Id</th>
                            <th>Full Name</th>
                            <th>Username</th>
                            <th>Password</th>
                            <th>Gender</th>
                            <th>Experience</th>
                            <th>Education level</th>
                            <th>Field of Study</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Department</th>
                            <th>Role</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% 
                        int recordsPerPage = 10;
                        int currentPage = 1;

                        if (request.getParameter("currentPage") != null) {
                            currentPage = Integer.parseInt(request.getParameter("currentPage"));
                        }

                        int startRecord = (currentPage - 1) * recordsPerPage;

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");
                            PreparedStatement pstmt = con.prepareStatement("SELECT * FROM sweinstructor WHERE role != 'dean' LIMIT ?, ?");
                            pstmt.setInt(1, startRecord);
                            pstmt.setInt(2, recordsPerPage);
                            ResultSet rs = pstmt.executeQuery();

                            while (rs.next()) {
                    %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("fullName") %></td>
                            <td><%= rs.getString("username") %></td>
                            <td><%= rs.getString("password") %></td>
                            <td><%= rs.getString("gender") %></td>
                            <td><%= rs.getString("experience") %></td>
                            <td><%= rs.getString("educationLevel") %></td>
                            <td><%= rs.getString("fieldOfStudy") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("phone") %></td>
                            <td><%= rs.getString("department") %></td>
                            <td><%= rs.getString("role") %></td>
                            <td>
                                <div class="btn-group">
                                    <a href="deleteTeacher?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this teacher?')">Delete</a>
                                    <a href="editTeacher?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-primary" onclick="return confirm('Are you sure you want to update this teacher info?')">Edit</a>
                                </div>
                            </td>
                        </tr>
                    <% 
                            }
                            rs.close();
                            pstmt.close();
                            con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                    </tbody>
                </table>
                <% 
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");
                        PreparedStatement pstmt = con.prepareStatement("SELECT COUNT(*) FROM sweinstructor WHERE role != 'dean'");
                        ResultSet rs = pstmt.executeQuery();
                        int totalRecords = 0;
                        if (rs.next()) {
                            totalRecords = rs.getInt(1);
                        }
                        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

                        rs.close();
                        pstmt.close();
                        con.close();
                %>
                <nav>
                    <ul class="pagination">
                        <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
                            <a class="page-link" href="?currentPage=<%= currentPage - 1 %>">Previous</a>
                        </li>
                        <% for (int i = 1; i <= totalPages; i++) { %>
                        <li class="page-item <%= (currentPage == i) ? "active" : "" %>">
                            <a class="page-link" href="?currentPage=<%= i %>"><%= i %></a>
                        </li>
                        <% } %>
                        <li class="page-item <%= (currentPage == totalPages) ? "disabled" : "" %>">
                            <a class="page-link" href="?currentPage=<%= currentPage + 1 %>">Next</a>
                        </li>
                    </ul>
                </nav>
                <% 
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </div>
        </div>
    </section>

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
  
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
         <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
         <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
         <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/intlTelInput.min.js"></script>
        
         <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
     


</body>
</html>

<%
  } else {
    // Redirect to a login page or show an error message
    response.sendRedirect("index.jsp");
  }
%>
