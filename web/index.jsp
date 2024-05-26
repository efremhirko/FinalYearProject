

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome to Course Distribution System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #ffffff;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            font-family: Arial, sans-serif;
        }
        header {
            background-color: #343a40;
            color: white;
            padding: 15px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        header nav {
            display: flex;
            align-items: center;
            width: 100%;
        }
        header nav ul {
            list-style: none;
            padding: 0;
            display: flex;
            align-items: center;
            flex: 1;
        }
        header nav ul.left-nav {
            justify-content: flex-start;
        }
        header nav ul.right-nav {
            justify-content: flex-end;
        }
        header nav ul li {
            margin: 0 15px;
        }
        header nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }
        header h1 {
            margin: 0;
            flex: 1;
            text-align: center;
        }
        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .welcome-container {
            text-align: center;
        }
        .welcome-container h2 {
            margin-bottom: 20px;
            font-size: 2.5rem;
        }
        .welcome-container p {
            margin-bottom: 30px;
            font-size: 1.25rem;
        }
        .welcome-container .btn {
            font-size: 1.25rem;
            padding: 10px 20px;
        }
        footer {
            background-color: #343a40;
            color: white;
            padding: 10px 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <ul class="left-nav">
                <li><a href="home.jsp">Home</a></li>
                <li><a href="about.jsp">About Us</a></li>
                <li><a href="contact.jsp">Contact Us</a></li>
            </ul>
            <h1>Course Distribution System</h1>
            <ul class="right-nav">
                <li><a href="http://localhost:8080/FinalYearProject/finalyear/login.jsp">Login</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <div class="welcome-container">
            <h2>Welcome to the Course Distribution System</h2>
            <p>Efficiently manage and view your course schedules with our streamlined system.</p>
            <a href="http://localhost:8080/FinalYearProject/finalyear/login.jsp" class="btn btn-primary">Get Started</a>
        </div>
    </main>

    <footer>
        <p>&copy; 2023 Course Distribution System. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

