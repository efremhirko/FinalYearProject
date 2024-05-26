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
							<center> <h4 class="text-blue h4"> Teacher Registration Form</h4>
							</center>
                                                </div>
						
					</div>
		 
      
                    <form action="<%= request.getContextPath()%>/TeacherRegistration" method="post">
    <div class="form-row">
        <div class="form-group col-md-6">
            <label for="full-name">Full Name:</label>
            <input type="text" class="form-control" id="fullName" name="fullName" required>
        </div>
        <div class="form-group col-md-6">
            <label for="email">Email:</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
    </div>
    <div class="form-row">
        <div class="form-group col-md-6">
            <label for="username">Username:</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="form-group col-md-6">
            <label for="password">Password:</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
    </div>
    <div class="form-row">
      <div class="form-group col-md-6">
        <label for="phone">Phone Number:</label>
      
        <div class="input-group">
           <input type="tel" id="phone" name="phone" class="form-control" required
               pattern="^[0-9]{9}$"
               title="Enter a 9-digit phone number"
               style="width: 725px;">
    </div>
      </div>
      <input type="hidden" id="fullPhoneNumber" name="fullPhoneNumber">
        
        <div class="form-group col-md-6">
            <label for="experience">Experience:</label>
            <input type="number" class="form-control" id="experience" name="experience" required>
        </div>
    </div>
    <div class="form-row">
        <div class="form-group col-md-6">
            <label for="department">Department:</label>
            <select class="form-control" id="department" name="department" required onchange="toggleOtherDepartment()">
                <option value="SE">Software Engineering</option>
                <option value="CS">Computer Science</option>
                <option value="ISY">Information System</option>
                <option value="IT">Information Technology</option>
                <option value="IS">Information Science</option>
                <option value="CSE">Computer Science and Engineering</option>
                <option value="Other">Other</option>
            </select>
            <input type="text" class="form-control mt-2" id="otherDepartment" name="otherDepartment" placeholder="Please specify your department" style="display:none;">
        </div>
      
        <div class="form-group col-md-6">
            <label for="education-level">Education Level:</label>
            <select class="form-control" id="educationLevel" name="educationLevel" required>
                <option value="BA">Bachelor's Degree</option>
                <option value="MA">Master's Degree</option>
                <option value="Phd">Doctorate</option>
                <option value="Pro">Professor</option>
            </select>
        </div>
    </div>
    <div class="form-row">
        <div class="form-group col-md-6">
            <label for="FieldOfStudy">Field of Study:</label>
            <select class="form-control" id="FieldOfStudy" name="FieldOfStudy" required onchange="toggleOtherFieldOfStudy()">
                <option value="SE">Software Engineering</option>
                <option value="CS">Computer Science</option>
                <option value="ISY">Information System</option>
                <option value="IT">Information Technology</option>
                <option value="IS">Information Science</option>
                <option value="CSE">Computer Science and Engineering</option>
                <option value="Other">Other</option>
            </select>
            <input type="text" class="form-control mt-2" id="otherFieldOfStudy" name="otherFieldOfStudy" placeholder="Please specify your field of study" style="display:none;">
        </div>
        <div class="form-group col-md-6">
            <label for="role">Role:</label>
            <select class="form-control" id="role" name="role" required>
                <% if (sessionObj != null && sessionObj.getAttribute("role") != null && sessionObj.getAttribute("role").equals("dean")) { %>
                    <option value="head">Head</option>
                    <option value="teach">Teacher</option>
                <% } else { %>
                    <option value="teach">Teacher</option>
                    <option value="stud">Student</option>
                <% } %>
            </select>
        </div>
    </div>
    <div class="form-row">
        <div class="form-group col-md-6">
            <label for="gender">Gender:</label>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="gender" id="male" value="male" required>
                <label class="form-check-label" for="male">
                    Male
                </label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="gender" id="female" value="female" required>
                <label class="form-check-label" for="female">
                    Female
                </label>
            </div>
        </div>
    </div>
    <button type="submit" class="btn btn-primary">Submit</button>
    <button type="reset" class="btn btn-secondary">Reset</button>
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
        <script>
  var input = document.querySelector("#phone");
  var iti = window.intlTelInput(input, {
    initialCountry: "ET",
    separateDialCode: true,
    utilsScript: "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js"
  });
</script>
<script>
    document.querySelector('form').addEventListener('submit', function(e) {
        var countryCode = '+91'; // Fixed country code
        var phone = document.getElementById('phone').value;
        document.getElementById('fullPhoneNumber').value = countryCode + phone;
    });
</script>
</body>
</html>
<%
  } else {
    // Redirect to a login page or show an error message
    response.sendRedirect(request.getContextPath() + "/index.jsp");
  }
%>