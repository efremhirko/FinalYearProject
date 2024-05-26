<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="jakarta.servlet.ServletException" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.util.logging.*" %>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    String fullname = null;
    String department = null;
    int classyear = 0;
    String role = null;
    String gender = null;
    int studid = 0;

    HttpSession ss = request.getSession(false);
    if (ss != null && ss.getAttribute("role") != null && ss.getAttribute("role").equals("head")) {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");

            // Get department of the logged-in user
            String departmentAbbreviation = (String) ss.getAttribute("dpt");

            // Determine the table name based on department
            String tableName;
            switch (departmentAbbreviation) {
                case "SE":
                    tableName = "swestudent";
                    break;
                case "CS":
                    tableName = "csstudent";
                    break;
                case "IS":
                    tableName = "isstudent";
                    break;
                case "ISY":
                    tableName = "isystudent";
                    break;
                case "IT":
                    tableName = "itstudent";
                    break;
                case "CSE":
                    tableName = "csestudent";
                    break;
                default:
                    tableName = null; // Handle default case appropriately
                    break;
            }

            if (tableName != null) {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    studid = Integer.parseInt(idParam);

                    // Check if the form is submitted for update
                    if (request.getMethod().equalsIgnoreCase("POST")) {
                        fullname = request.getParameter("fullname");
                        department = request.getParameter("department");
                        classyear = Integer.parseInt(request.getParameter("classyear"));
                        role = request.getParameter("role");
                        gender = request.getParameter("gender");

                        PreparedStatement updateStatement = con.prepareStatement("UPDATE " + tableName + " SET fullname=?, department=?, classyear=?, role=?, gender=? WHERE id=?");

                        updateStatement.setString(1, fullname);
                        updateStatement.setString(2, department);
                        updateStatement.setInt(3, classyear);
                        updateStatement.setString(4, role);
                        updateStatement.setString(5, gender);
                        updateStatement.setInt(6, studid);

                        int rowsUpdated = updateStatement.executeUpdate();
                        if (rowsUpdated > 0) {
                            // Redirect to student info page after successful update
                            response.sendRedirect("studentinfoTable.jsp");
                        } else {
                            // Handle if update operation fails
                            request.setAttribute("errorMessage", "Update failed");
                            request.getRequestDispatcher("error.jsp").forward(request, response);
                        }
                    } else {
                        // Fetch student information for pre-populating the form fields
                        PreparedStatement selectStatement = con.prepareStatement("SELECT * FROM " + tableName + " WHERE id=?");
                        selectStatement.setInt(1, studid);
                        ResultSet rs = selectStatement.executeQuery();

                        if (rs.next()) {
                            fullname = rs.getString("fullname");
                            department = rs.getString("department");
                            classyear = rs.getInt("classyear");
                            role = rs.getString("role");
                            gender = rs.getString("gender");
                        } else {
                            // Handle if student with the provided ID is not found
                            request.setAttribute("errorMessage", "Student not found");
                            request.getRequestDispatcher("error.jsp").forward(request, response);
                        }
                    }
                } else {
                    // Handle if ID parameter is missing
                    request.setAttribute("errorMessage", "Invalid student ID");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            } else {
                // Handle if tableName is null (department not recognized)
                request.setAttribute("errorMessage", "Department not recognized");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle exceptions appropriately
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle exceptions appropriately
            }
        }
%>

<!DOCTYPE html>
<html>
<head>
    <!-- Basic Page Info -->
    <meta charset="utf-8">
    <title>CSCDS</title>
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
                            <center><h4 class="text-blue h4">Student Registration Form</h4></center>
                        </div>
                    </div>
                    <form action="editStudent.jsp" method="post">
                        <input type="hidden" name="id" value="<%= studid %>">
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="fullname">Full Name:</label>
                                <input type="text" class="form-control" value="<%= fullname %>" id="fullname" name="fullname" required>
                            </div>
                              <div class="form-group col-md-6">
                                <label for="department">Department:</label>
                                <select class="form-control" id="department" name="department" required>
                                    <option value="<%= department %>"><%= department %></option>
                                    <option value="SE">Software Engineering</option>
                                    <option value="CS">Computer Science</option>
                                    <option value="ISY">Information System</option>
                                    <option value="IT">Information Technology</option>
                                    <option value="IS">Information Science</option>
                                    <option value="CSE">Computer Science and Engineering</option>
                                    
                                </select>
                            </div>
                            
                        </div>
                        <div class="form-row">
                           <div class="form-group col-md-6">
                                <label for="classyear">Class Year</label>
                                <select class="form-control" id="classyear" name="classyear" required>
                                    <option value="<%= classyear %>"><%= classyear %></option>
                                    <option value="2">Second Year</option>
                                    <option value="3">Third Year</option>
                                    <option value="4">Fourth Year</option>
                                    <option value="5">Fifth Year</option>
                                </select>
                            </div>
                                     <div class="form-group col-md-6">
                                <label for="role">Role:</label>
                                <select class="form-control" id="role" name="role" required>
                                    <% if (ss != null && ss.getAttribute("role") != null && ss.getAttribute("role").equals("dean")) { %>
                                    <option value="<%= role %>"><%= role %></option>
                                    <option value="head">Head</option>
                                    <option value="teach">Teacher</option>
                                    <% } else { %>
                                    <option value="<%= role %>"><%= role %></option>
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
                                    <input class="form-check-input" type="radio" name="gender" id="male" value="male" <%= (gender != null && gender.equalsIgnoreCase("male")) ? "checked" : "" %> required>
                                    <label class="form-check-label" for="male">Male</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="gender" id="female" value="female" <%= (gender != null && gender.equalsIgnoreCase("female")) ? "checked" : "" %> required>
                                    <label class="form-check-label" for="female">Female</label>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Submit</button>
                        <button type="reset" class="btn btn-secondary">Reset</button>
                    </form>
                </div>
                <!-- Form grid End -->
            </div>
        </div>
    </div>
    <%@ include file="footer.jsp" %>

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
            var countryCode = '+251'; // Fixed country code
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
