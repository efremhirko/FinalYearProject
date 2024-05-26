

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  // Check if the user is logged in and has the role of "head"
  HttpSession sessionObj  = request.getSession(false);
  if (sessionObj  != null && sessionObj .getAttribute("role") != null && sessionObj .getAttribute("role").equals("head")) {
%>
<!DOCTYPE html>
<html>
<head>
	<title>Course Distribution System</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">

	<!-- Custom CSS -->
	<style>
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
			justify-content: center;
			align-items: flex-start;
			margin: 20px;
		}
		aside {
			flex: 1;
			margin-right: 20px;
			background-color: #fff;
			padding: 20px;
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
    <%@include file="header.jsp" %>
    
		<section>
		
                    
                    <form method="post" action="TeacherRegistration">
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
            <input type="tel" id="phone" name="phone" class="form-control" required>
        </div>
    </div>
        <div class="form-group col-md-6">
            <label for="experience">Experience:</label>
            <input type="text" class="form-control" id="experience" name="experience" required>
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

<script>
    function toggleOtherDepartment() {
        var departmentSelect = document.getElementById('department');
        var otherDepartmentInput = document.getElementById('otherDepartment');
        if (departmentSelect.value === 'Other') {
            otherDepartmentInput.style.display = 'block';
            otherDepartmentInput.required = true;
        } else {
            otherDepartmentInput.style.display = 'none';
            otherDepartmentInput.required = false;
        }
    }

    function toggleOtherFieldOfStudy() {
        var fieldOfStudySelect = document.getElementById('FieldOfStudy');
        var otherFieldOfStudyInput = document.getElementById('otherFieldOfStudy');
        if (fieldOfStudySelect.value === 'Other') {
            otherFieldOfStudyInput.style.display = 'block';
            otherFieldOfStudyInput.required = true;
        } else {
            otherFieldOfStudyInput.style.display = 'none';
            otherFieldOfStudyInput.required = false;
        }
    }

    function updateCustomFields() {
        var departmentSelect = document.getElementById('department');
        var otherDepartmentInput = document.getElementById('otherDepartment');
        if (departmentSelect.value === 'Other') {
            departmentSelect.value = otherDepartmentInput.value;
        }

        var fieldOfStudySelect = document.getElementById('FieldOfStudy');
        var otherFieldOfStudyInput = document.getElementById('otherFieldOfStudy');
        if (fieldOfStudySelect.value === 'Other') {
            fieldOfStudySelect.value = otherFieldOfStudyInput.value;
        }

        return true;
    }
</script>

	
                </section>
		<aside>
			<!-- Information about Bule Hora University -->
		</aside>
	</main>

	 <%@ include file="footer.jsp" %>
	
	<!-- Bootstrap JS -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
       <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/intlTelInput.min.js"></script>
<script>
  var input = document.querySelector("#phone");
  var iti = window.intlTelInput(input, {
    initialCountry: "ET",
    separateDialCode: true,
    utilsScript: "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js"
  });
</script>
</body>
</html>
<%
  } else {
    // Redirect to a login page or show an error message
    response.sendRedirect("index.jsp");
  }
%>