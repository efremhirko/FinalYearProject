<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="jakarta.servlet.ServletException" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.util.logging.*" %>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    String full_name = null;
    String email = null;
    String phone = null;
    int experience = 0;
    String department = null;
    String education_level = null;
    String fieldOfStudy = null;
    String role = null;
    String gender = null;
    int teachId = 0;

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
                    tableName = "sweinstructor";
                    break;
                case "CS":
                    tableName = "csinstructor";
                    break;
                case "IS":
                    tableName = "isinstructor";
                    break;
                case "ISY":
                    tableName = "isyinstructor";
                    break;
                case "IT":
                    tableName = "itinstructor";
                    break;
                case "CSE":
                    tableName = "cseinstructor";
                    break;
                default:
                    tableName = null; // Handle default case appropriately
                    break;
            }

            if (tableName != null) {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    teachId = Integer.parseInt(idParam);

                    // Check if the form is submitted for update
                    if (request.getMethod().equalsIgnoreCase("post")) {
                        full_name = request.getParameter("fullName");
                        email = request.getParameter("email");
                        phone = request.getParameter("phone");
                        experience = Integer.parseInt(request.getParameter("experience"));
                        department = request.getParameter("department");
                        education_level = request.getParameter("educationLevel");
                        fieldOfStudy = request.getParameter("FieldOfStudy");
                        role = request.getParameter("role");
                        gender = request.getParameter("gender");

                        PreparedStatement updateStatement = con.prepareStatement("UPDATE " + tableName + " SET fullName=?, Gender=?, Experience=?, EducationLevel=?, FieldOfStudy=?, Email=?, Phone=?, Department=?, role=? WHERE id=?");
                        updateStatement.setString(1, full_name);
                        updateStatement.setString(2, gender);
                        updateStatement.setInt(3, experience);
                        updateStatement.setString(4, education_level);
                        updateStatement.setString(5, fieldOfStudy);
                        updateStatement.setString(6, email);
                        updateStatement.setString(7, phone);
                        updateStatement.setString(8, department);
                        updateStatement.setString(9, role);
                        updateStatement.setInt(10, teachId);

                        int rowsUpdated = updateStatement.executeUpdate();
                        if (rowsUpdated > 0) {
                            // Redirect to teacher info page after successful update
                            response.sendRedirect("teacherinfoTable.jsp");
                        } else {
                            // Handle if update operation fails
                            request.setAttribute("errorMessage", "Update failed");
                            request.getRequestDispatcher("error.jsp").forward(request, response);
                        }
                    } else {
                        // Fetch teacher information for pre-populating the form fields
                        PreparedStatement selectStatement = con.prepareStatement("SELECT * FROM " + tableName + " WHERE id=?");
                        selectStatement.setInt(1, teachId);
                        ResultSet rs = selectStatement.executeQuery();

                        if (rs.next()) {
                            full_name = rs.getString("fullName");
                            email = rs.getString("Email");
                            phone = rs.getString("Phone");
                            experience = rs.getInt("Experience");
                            department = rs.getString("Department");
                            education_level = rs.getString("EducationLevel");
                            fieldOfStudy = rs.getString("FieldOfStudy");
                            role = rs.getString("role");
                            gender = rs.getString("Gender");
                        } else {
                            // Handle if teacher with the provided ID is not found
                        }
                    }
                } else {
                    // Handle if ID parameter is missing
                }
            } else {
                // Handle if tableName is null (department not recognized)
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle exceptions appropriately
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
                            <center><h4 class="text-blue h4"> Teacher Registration Form</h4></center>
                        </div>
                    </div>
                    <form action="editTeacher.jsp" method="post">
                        <input type="hidden" name="id" value="<%= teachId %>">
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="full-name">Full Name:</label>
                                <input type="text" value="<%= full_name %>" class="form-control" id="fullName" name="fullName" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="email">Email:</label>
                                <input type="email" value="<%= email %>" class="form-control" id="email" name="email" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="phone">Phone Number:</label>
                                <div class="input-group">
                                    <input type="tel" id="phone" name="phone" value="<%= phone %>" class="form-control" required>
                                </div>
                            </div>
                            <input type="hidden" id="fullPhoneNumber" name="fullPhoneNumber">
                            <div class="form-group col-md-6">
                                <label for="experience">Experience:</label>
                                <input type="number" value="<%= experience %>" class="form-control" id="experience" name="experience" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="department">Department:</label>
                                <select class="form-control" id="department" name="department" required onchange="toggleOtherDepartment()">
                                    <option value="<%= department %>"><%= department %></option>
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
                                    <option value="<%= education_level %>"><%= education_level %></option>
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
                                    <option value="<%= fieldOfStudy %>"><%= fieldOfStudy %></option>
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
