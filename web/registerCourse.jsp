
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
  // Check if the user is logged in and has the role of "head"
  HttpSession sessionObj  = request.getSession(false);
  if (sessionObj  != null && sessionObj .getAttribute("role") != null && sessionObj .getAttribute("role").equals("head")) {
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Course Data</title>
  <style>
    th, td {
      text-align: center;
    }
  </style>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css">
   

	<!-- Custom CSS -->
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
  <%@include file="header.jsp" %>
	
		<section>
  <div style="width: 80%;" class="container">
       
      <h3 class="mb-5">Course Registration Form</h3>
      <div style="width: 100%;" class="form-container">
    <form  action="CourseRegistration" method="post">
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
    <div class="col">
      <div class="mb-3">
        <label for="department" class="form-label">Batch:</label>
        <select id="batch" name="batch" class="form-select" required>
          <option value="">Select Batch:</option>
          <option value="1st Year">1st Year</option>
          <option value="2nd Year">2nd Year</option>
          <option value="3rd Year">3rd Year</option>
          <option value="4th Year">4th Year</option>
          <option value="5th Year">5th Year</option>
        </select>
      </div>
    </div>
    <div class="col">
      <div class="mb-3">
        <label for="semester" class="form-label">Semester:</label>
        <select id="semester" name="semester" class="form-select" required>
          <option value="">Select Semester</option>
          <option value="1">1</option>
          <option value="2">2</option>
        </select>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col">
      <div class="mb-3">
        <label for="department" class="form-label">Department:</label>
        <select style="width: 50%"id="department" name="department" class="form-select" required disabled>
          
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

           </section>
		<aside>
			<!-- Information about Bule Hora University -->
		</aside>
	</main>

    <%@ include file="footer.jsp" %>

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