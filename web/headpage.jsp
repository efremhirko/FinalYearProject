<%@ page session="false" %>
<%@ page import="java.sql.*, javax.naming.*, java.util.*, java.io.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
HttpSession session = request.getSession();
String role = (String) session.getAttribute("role");
if (session != null && session.getAttribute("role") != null && role.equals("head")) {%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Teacher Page</title>
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>

  <style>
    html, body {
      height: 100%;
    }
    body {
      margin: 0;
      min-height: 100vh;
      background-image: url("photo/background.jpg");
      background-size: cover;
     background-size: 100% 100%;
    }
    .main-content {
      min-height: 75vh;
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
    footer {
      text-align: center;
      background-color: #343a40;
      padding: 20px;
      color: white;
    }
    footer img {
      height: 100px;
    }
    .logout-button {
      color: white;
    }
  </style>
</head>
<body>
 <header>
    <div class="left-section">
      <a href="headpage.jsp">Home</a>
      <a href="aboutus.jsp">About Us</a>
      <a href="contactus.jsp">Contact Us</a>
      <a href="courseData.jsp">Courses</a>
    </div>
    <div class="center-section">
      <h1>Course Distribution</h1>
    </div>
    <div class="right-section">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a href="logout" class="nav-link logout-button" href="#">Logout</a>
        </li>
      </ul>
    </div>
  </header>
  <!-- Main content -->
  <div class="container my-5 main-content">
    <div class="row">
      
<div class="container">
 <h1 style="color:black" class="text-center mb-5">Select What You Want to Do</h1>
  <div class="card-columns">
    <div class="card bg-primary">
      <div class="card-body text-center">
        <a href="registerTeacher.jsp" class="list-group-item list-group-item-action">Register Teacher</a>
      </div>
    </div>
       <div class="card bg-primary">
      <div class="card-body text-center">
        <a href="registerStudent.jsp" class="list-group-item list-group-item-action">Register Student</a>
      </div>
    </div>
      
      <div class="card bg-primary">
      <div class="card-body text-center">
        <a href="registerCourse.jsp" class="list-group-item list-group-item-action">Register Course</a>
      </div>
    </div>
    <div class="card bg-warning">
      <div class="card-body text-center">
      <a href="http://localhost:8080/FinalYearProject/finalyear/teacherinfoTable.jsp" class="list-group-item list-group-item-action">See Teacher Information</a>
     </div>
    </div>
       
 <div class="card bg-success">
    <div class="card-body text-center">
        <a id="initiateAssignmentLink" class="list-group-item list-group-item-action" style="cursor:pointer;">Initiate Assignment</a>
    </div>
</div>  
      
 <div class="card bg-success">
    <div class="card-body text-center">
        <a id="schedulelink" class="list-group-item list-group-item-action" style="cursor:pointer;">Generate Schedule</a>
    </div>
</div>
<!-- 
<script>
    // JavaScript to redirect to servlet when "Initiate Assignment" is clicked
    document.getElementById("initiateAssignmentLink").addEventListener("click", function() {
        window.location.href = "CourseAssignment"; // Replace "login" with the correct URL for your servlet
    });
</script>-->





<script>
    document.getElementById("schedulelink").addEventListener("click", function() {
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "CourseSchedule");
        document.body.appendChild(form);
        form.submit();
    });
</script>

<script>
    document.getElementById("initiateAssignmentLink").addEventListener("click", function() {
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "CourseAssignment");
        document.body.appendChild(form);
        form.submit();
    });
</script>

  </div>
</div>     
    </div>
  </div>
  
  <!-- Footer -->
 <%@ include file="footer.jsp" %>
  <!-- Bootstrap JavaScript -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<% }else{
  response.sendRedirect("index.jsp");
}%>

