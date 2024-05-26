<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
  // Check if the user is logged in and has the role of "head"
  HttpSession sessionObj  = request.getSession(false);
  if (sessionObj  != null && sessionObj .getAttribute("role") != null && sessionObj .getAttribute("role").equals("head")) {
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
	<link rel="stylesheet" type="text/css" href="vendors/styles/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/intlTelInput.min.js"></script>


	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-119386393-1"></script>
	
</head>
<body>
	

	<%@include file="header.jsp" %>


	
<div class="main-container">
		<div class="pd-ltr-20 xs-pd-20-10">
			<div class="min-height-200px">
				<!-- Form grid Start -->
				<div class="pd-20 card-box mb-30">
					<div class="clearfix">
                                            <div class="pull-center">
							<center> <h4 class="text-blue h4"> Course Registration Form</h4>
							</center>
                                                </div>
						
					</div>
		 
    <form  action="<%= request.getContextPath()%>/CourseRegistration" method="post">
        <c:if test="$not empty errorMessage"%>
            <div class="error-message" style="color: red">${errorMessage} </div>
        </c:if> 
  <div class="row">
    <div class="col">
      <div class="mb-3">
        <label for="course_code" class="form-label">Course Code:</label>
        <input type="text" id="courseCode" name="courseCode" class="form-control" required>
      </div>
    </div>
    <div class="col">
      <div class="mb-3">
        <label for="course_title" class="form-label">Course Title:</label>
        <input type="text" id="courseTitle" name="courseTitle" class="form-control" required>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col">
      <div class="mb-3">
        <label for="ects" class="form-label">ECTS:</label>
        <input type="number" id="ects" name="ects" class="form-control" required>
      </div>
    </div>
    <div class="col">
      <div class="mb-3">
        <label for="lec" class="form-label">Lecture Hours:</label>
        <input type="number" id="lectureHours" name="lectureHours" class="form-control" required>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col">
      <div class="mb-3">
        <label for="tut" class="form-label">Tutorial Hours:</label>
        <input type="number" id="tutorialHours" name="tutorialHours" class="form-control" required>
      </div>
    </div>
    <div class="col">
      <div class="mb-3">
        <label for="lab" class="form-label">Lab Hours:</label>
        <input type="number" id="labHours" name="labHours" class="form-control" required>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-6">
      <div class="form-group">
        <label for="department" class="form-label">Batch:</label>
        <select id="batch" type="number" name="batch" class="custom-select form-control" required>
          <option value="">Select Batch:</option>
          <option value="2">2nd Year</option>
          <option value="3">3rd Year</option>
          <option value="4">4th Year</option>
          <option value="5">5th Year</option>
        </select>
      </div>
    </div>
    <div class="col-md-6">
      <div class="form-group">
        <label for="semester" class="form-label">Semester:</label>
        <select id="semester" name="semester" class="custom-select form-control" required>
          <option value="">Select Semester</option>
          <option value="1">1</option>
          <option value="2">2</option>
        </select>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-6">
      <div class="form-group">
        <label for="department" class="form-label">Department:</label>
        <select style="width: 50%"id="department" name="department" class="custom-select form-control" required disabled>
    
<%
  if (sessionObj  != null && sessionObj .getAttribute("dpt") != null && sessionObj .getAttribute("dpt").equals("SE")) {
%>
          <option value="SE">Software Engineering</option>
     <%}else if(sessionObj  != null && sessionObj .getAttribute("dpt") != null && sessionObj .getAttribute("dpt").equals("CS")) { %>    
          <option value="CS">Computer Science</option>
       <%} else if (sessionObj  != null && sessionObj .getAttribute("dpt") != null && sessionObj .getAttribute("dpt").equals("IS")) {%>   
          <option value="IS">Information Science</option>
        <%} else if (sessionObj  != null && sessionObj .getAttribute("dpt") != null && sessionObj .getAttribute("dpt").equals("ISY")) { %>  
          <option value="ISY">Information System</option>
       <%} else if (sessionObj  != null && sessionObj .getAttribute("dpt") != null && sessionObj .getAttribute("dpt").equals("IT")) {%>   
          <option value="IT">Information Technology</option>
        <%} else {%>  
           <option value="CSE">Computer Science and Engineering</option>
          <%} %>
        </select>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col">
      <button type="submit" class="btn btn-primary">Register</button>
    </div>
  </div>
   	  </form>
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
  
</body>
</html>
<%
  } else {
    // Redirect to a login page or show an error message
    response.sendRedirect(request.getContextPath() + "/index.jsp");
  }
%>