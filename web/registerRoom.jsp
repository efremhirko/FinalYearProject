<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  // Check if the user is logged in and has the role of "head"
  HttpSession sessionObj  = request.getSession(false);
  if (sessionObj  != null && sessionObj .getAttribute("role") != null && sessionObj .getAttribute("role").equals("dean")) {
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
    <form method="post" action="RoomRegistration">
    <div class="form-row">
        <div class="form-group col-md-6">
            <label for="full-name">buildingNo:</label>
            <input type="number" class="form-control" id="buildingNo" name="buildingNo" required>
        </div>
        <div class="form-group col-md-6">
            <label for="email">floor</label>
            <input type="number" class="form-control" id="floor" name="floor" required>
        </div>
    </div>
    <div class="form-row">
        <div class="form-group col-md-6">
            <label for="username">roomNo</label>
            <input type="number" class="form-control" id="roomNo" name="roomNo" required>
        </div>
        <div class="form-group col-md-6">
            <label for="password">classType:</label>
            <input type="text" class="form-control" id="classType" name="classType" required>
        </div>
    </div>
    <button type="submit" class="btn btn-primary">Submit</button>
    <button type="reset" class="btn btn-secondary">Reset</button>
</form>
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