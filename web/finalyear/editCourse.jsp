<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="jakarta.servlet.ServletException" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.util.logging.*" %>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
    int courseId = 0;
    String courseCode = null;
    String courseTitle = null;
    int ects = 0;
    int lech = 0;
    int tuth = 0;
    int labh = 0;
    int batch = 0;
    String semester = null;
    String department = null;

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
                    tableName = "swecourse";
                    break;
                case "CS":
                    tableName = "cscourse";
                    break;
                case "IS":
                    tableName = "iscourse";
                    break;
                case "ISY":
                    tableName = "isycourse";
                    break;
                case "IT":
                    tableName = "itcourse";
                    break;
                default:
                    tableName = "csecourse";
                    break;
            }

            if (tableName != null) {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    courseId = Integer.parseInt(idParam);

                    // Check if the form is submitted for update
                    if (request.getMethod().equalsIgnoreCase("post")) {
                        courseCode = request.getParameter("courseCode");
                        courseTitle = request.getParameter("courseTitle");
                        ects = Integer.parseInt(request.getParameter("ects"));
                        lech = Integer.parseInt(request.getParameter("lech"));
                        tuth = Integer.parseInt(request.getParameter("tuth"));
                        labh = Integer.parseInt(request.getParameter("labh"));
                        batch = Integer.parseInt(request.getParameter("batch"));
                        semester = request.getParameter("semester");
                        department = request.getParameter("department");

                        PreparedStatement updateStatement = con.prepareStatement("UPDATE " + tableName + " SET CourseCode=?, CourseTitle=?, ECTS=?, Lech=?, Tuth=?, Labh=?, Batch=?, Semester=?, Department=? WHERE Id=?");
                        updateStatement.setString(1, courseCode);
                        updateStatement.setString(2, courseTitle);
                        updateStatement.setInt(3, ects);
                        updateStatement.setInt(4, lech);
                        updateStatement.setInt(5, tuth);
                        updateStatement.setInt(6, labh);
                        updateStatement.setInt(7, batch);
                        updateStatement.setString(8, semester);
                        updateStatement.setString(9, department);
                        updateStatement.setInt(10, courseId);

                        int rowsUpdated = updateStatement.executeUpdate();
                        if (rowsUpdated > 0) {
                            // Redirect to course data page after successful update
                            response.sendRedirect("courseData.jsp");
                        } else {
                            // Handle if update operation fails
                            request.setAttribute("errorMessage", "Update failed");
                            request.getRequestDispatcher("error.jsp").forward(request, response);
                        }
                    } else {
                        // Fetch course information for pre-populating the form fields
                        PreparedStatement selectStatement = con.prepareStatement("SELECT * FROM " + tableName + " WHERE Id=?");
                        selectStatement.setInt(1, courseId);
                        ResultSet rs = selectStatement.executeQuery();

                        if (rs.next()) {
                            courseCode = rs.getString("CourseCode");
                            courseTitle = rs.getString("CourseTitle");
                            ects = rs.getInt("ECTS");
                            lech = rs.getInt("Lech");
                            tuth = rs.getInt("Tuth");
                            labh = rs.getInt("Labh");
                            batch = rs.getInt("Batch");
                            semester = rs.getString("Semester");
                            department = rs.getString("Department");
                        } else {
                            // Handle if course with the provided ID is not found
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
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="vendors/styles/core.css">
    <link rel="stylesheet" type="text/css" href="vendors/styles/icon-font.min.css">
    <link rel="stylesheet" type="text/css" href="vendors/styles/style.css">
</head>
<body>

<%@include file="header.jsp" %>

<div class="main-container">
    <div class="pd-ltr-20 xs-pd-20-10">
        <div class="min-height-200px">
            <div class="pd-20 card-box mb-30">
                <div class="clearfix">
                    <div class="pull-center">
                        <center>
                            <h4 class="text-blue h4">Edit Course Information</h4>
                        </center>
                    </div>
                </div>

                <form action="editCourse.jsp" method="post">
                    <input type="hidden" name="id" value="<%= courseId %>">
                    <div class="row">
                        <div class="col">
                            <div class="mb-3">
                                <label for="courseCode" class="form-label">Course Code:</label>
                                <input type="text" id="courseCode" name="courseCode" class="form-control" value="<%= courseCode %>" required>
                            </div>
                        </div>
                        <div class="col">
                            <div class="mb-3">
                                <label for="courseTitle" class="form-label">Course Title:</label>
                                <input type="text" id="courseTitle" name="courseTitle" class="form-control" value="<%= courseTitle %>" required>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="mb-3">
                                <label for="ects" class="form-label">ECTS:</label>
                                <input type="number" id="ects" name="ects" class="form-control" value="<%= ects %>" required>
                            </div>
                        </div>
                        <div class="col">
                            <div class="mb-3">
                                <label for="lech" class="form-label">Lecture Hours:</label>
                                <input type="number" id="lech" name="lech" class="form-control" value="<%= lech %>" required>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="mb-3">
                                <label for="tuth" class="form-label">Tutorial Hours:</label>
                                <input type="number" id="tuth" name="tuth" class="form-control" value="<%= tuth %>" required>
                            </div>
                        </div>
                        <div class="col">
                            <div class="mb-3">
                                <label for="labh" class="form-label">Lab Hours:</label>
                                <input type="number" id="labh" name="labh" class="form-control" value="<%= labh %>" required>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="batch" class="form-label">Batch:</label>
                                <select id="batch" name="batch" class="custom-select form-control" required>
                                    <option value="<%= batch %>" selected><%= batch %></option>
                                    <option value="2nd Year">2nd Year</option>
                                    <option value="3rd Year">3rd Year</option>
                                    <option value="4th Year">4th Year</option>
                                    <option value="5th Year">5th Year</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="semester" class="form-label">Semester:</label>
                                <select id="semester" name="semester" class="custom-select form-control" required>
                                    <option value="<%= semester %>" selected><%= semester %></option>
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
                                <select id="department" name="department" class="custom-select form-control" required disabled>
                                    <option value="<%= department %>" selected><%= department %></option>
                                    <option value="SE">Software Engineering</option>
                                    <option value="CS">Computer Science</option>
                                    <option value="IS">Information Science</option>
                                    <option value="ISY">Information System</option>
                                    <option value="IT">Information Technology</option>
                                    <option value="CSE">Computer Science and Engineering</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
 <%@ include file="footer.jsp" %>
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
