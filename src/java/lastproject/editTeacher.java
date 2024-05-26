package lastproject;


import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class editTeacher extends HttpServlet {

    Connection conn = null;
    PreparedStatement statement = null;
    ResultSet rs = null;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
   response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
    
        int teachId = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");

            String sql = "SELECT * FROM instructor WHERE id=?";
            statement = conn.prepareStatement(sql);
            statement.setInt(1, teachId);

            rs = statement.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String full_name = rs.getString("fullName");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String gender = rs.getString("Gender");
                int experience = rs.getInt("Experience");
                String education_level = rs.getString("EducationLevel");
                String FieldOfStudy = rs.getString("FieldOfStudy");
                String email = rs.getString("Email");
                String phone = rs.getString("Phone");
                String department = rs.getString("Department");
                String role = rs.getString("role");

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Edit Course</title>");
            out.println("<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css\">\n" +
"  <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js\"></script>\n" +
"  <style>\n" +
"    th, td {\n" +
"      text-align: center;\n" +
"    }\n" +
"  </style>\n" +
"        <link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css\">\n" +
"        <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css\" integrity=\"sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T\" crossorigin=\"anonymous\">\n" +
"        <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.css\" />\n" +
"        <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.css\"/>\n" +
"        <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/css/intlTelInput.min.css\">\n" +
"        <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css\">\n" +
"\n" +
"	<!-- Custom CSS -->\n" +
"	<style>\n" +
"             th, td {\n" +
"      text-align: center;\n" +
"    }\n" +
"		body {\n" +
"			background-color: #f8f9fa;\n" +
"			display: flex;\n" +
"			flex-direction: column;\n" +
"			min-height: 100vh;\n" +
"		}\n" +
"		header {\n" +
"			background-color: #343a40;\n" +
"			color: #fff;\n" +
"			padding: 10px;\n" +
"		}\n" +
"		h1 {\n" +
"			margin: 0;\n" +
"		}\n" +
"		nav ul {\n" +
"			list-style: none;\n" +
"			margin: 0;\n" +
"			padding: 0;\n" +
"			display: flex;\n" +
"			align-items: center;\n" +
"		}\n" +
"		nav li {\n" +
"			margin-right: 20px;\n" +
"		}\n" +
"		nav a {\n" +
"			color: #fff;\n" +
"			text-decoration: none;\n" +
"		}\n" +
"		nav button {\n" +
"			margin-left: auto;\n" +
"		}\n" +
"		main {\n" +
"			flex: 1;\n" +
"			display: flex;\n" +
"			flex-wrap: wrap;\n" +
"			justify-content: center;\n" +
"			align-items: flex-start;\n" +
"			margin: 20px;\n" +
"		}\n" +
"		 aside {\n" +
"      flex: 0 0 250px;\n" +
"      background-color: #f4f4f4;\n" +
"      padding: 20px;\n" +
"    }\n" +
"		section {\n" +
"			flex: 2;\n" +
"			background-color: #fff;\n" +
"			padding: 20px;\n" +
"			box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\n" +
"		}\n" +
"		\n" +
"		.vertical-header {\n" +
"			display: flex;\n" +
"			flex-direction: row;\n" +
"			align-items: center;\n" +
"			height: 100%;\n" +
"		}\n" +
"\n" +
"		.container {\n" +
"			display: flex;\n" +
"			flex-direction: column;\n" +
"			justify-content: center;\n" +
"			align-items: flex-start;\n" +
"			height: 100%;\n" +
"		\n" +
"		}\n" +
"\n" +
"		nav {\n" +
"			margin-top: 20px;\n" +
"		}\n" +
"\n" +
"		ul {\n" +
"			list-style: none;\n" +
"			margin: 0;\n" +
"			padding: 0;\n" +
"		}\n" +
"\n" +
"		li {\n" +
"			margin-bottom: 10px;\n" +
"		}\n" +
"\n" +
"		a {\n" +
"			text-decoration: none;\n" +
"			color: #333;\n" +
"			font-weight: bold;\n" +
"		}\n" +
"\n" +
"		button {\n" +
"			margin-right: 20px;\n" +
"		}\n" +
"                .btn btn-light{\n" +
"                    margin-right: 40px;\n" +
"                }\n" +
"\n" +
"		.center {\n" +
"			text-align: center;\n" +
"		}\n" +
"	/* ... existing CSS styles ... */\n" +
"\n" +
"	footer {\n" +
"		background-color: #343a40;\n" +
"		color: #fff;\n" +
"		padding: 10px;\n" +
"		text-align: center;\n" +
"		margin-top: auto;\n" +
"		width: 100%;\n" +
"	}\n" +
"\n" +
"	.container {\n" +
"		display: flex;\n" +
"		justify-content: space-between;\n" +
"		align-items: center;\n" +
"	}\n" +
"\n" +
"	.footer-links {\n" +
"		list-style: none;\n" +
"		margin: 0;\n" +
"		padding: 0;\n" +
"		display: flex;\n" +
"	}\n" +
"\n" +
"	.footer-links li {\n" +
"		margin-left: 20px;\n" +
"	}\n" +
"\n" +
"	.footer-links a {\n" +
"		text-decoration: none;\n" +
"		color: #fff;\n" +
"		font-weight: bold;\n" +
"	}\n" +
"</style>\n" +
"");
            out.println("</head>");
            out.println("<body>");
            out.println("  <header>\n" +
"		<div class=\"container\">\n" +
"                  <h1 class=\"center\">Course Distribution System</h1>\n" +
"		</div>\n" +
"	</header>\n" +
"	<main>\n" +
"	\n" +
"			<aside>\n" +
"			<div class=\"vertical-header\">\n" +
"				<ul>\n" +
"					<li><a href=\"#\">Home</a></li>\n" +
"                                        <li><a href=\"#\">Registration</a></li>\n" +
"					<li><a href=\"#\">Teacher Information</a></li>\n" +
"                                        <li><a href=\"courseData.jsp\">Course Information</a></li>\n" +
"					<li><a href=\"#\">Courses</a></li>\n" +
"				</ul>\n" +
"			</div>\n" +
"		</aside>\n" +
"		\n" +
"		<section>\n" +
"  <div class=\"container\">");
out.println("<h1>Edit Teacher Information</h1>");

out.println("<form method=\"post\" action=\"editTeacher\"> <!-- Ensure action points to the servlet URL -->");
out.println("<input type=\"hidden\" name=\"id\" value=\"" + id + "\">"); // Include the teachId as a hidden field
out.println("<div class=\"form-row\">");
out.println("<div class=\"form-group col-md-6\">");
out.println("<label for=\"full-name\">Full Name:</label>");
out.println("<input type=\"text\" class=\"form-control\" id=\"fullname\" name=\"full_name\" value=\"" + full_name + "\">");
out.println("</div>");
out.println("<div class=\"form-group col-md-6\">");
out.println("<label for=\"email\">Email:</label>");
out.println("<input type=\"email\" class=\"form-control\" id=\"email\" name=\"email\" value=\"" + email + "\">");
out.println("</div>");
out.println("</div>");

out.println( "<div class=\"form-row\">");
out.println( "<div class=\"form-group col-md-6\">");
out.println( "    <label for=\"phone\">Phone Number:</label>");
out.println( "    <div class=\"input-group\">");
out.println( " <input type=\"tel\" id=\"phone\" name=\"phone\" class=\"form-control\" value=\""+phone+"\">");
out.println( "    </div>");
out.println( "</div>"); 
out.println( "<div class=\"form-group col-md-6\">");
out.println( "<label for=\"experience\">Experience:</label>");
out.println( "<input type=\"text\" class=\"form-control\" id=\"experience\" name=\"experience\" value=\""+experience+"\">");
out.println( "</div>");
out.println( "    </div>");

out.println( "    <div class=\"form-row\">");
out.println( "        <div class=\"form-group col-md-6\">");
out.println( "            <label for=\"department\">Department:</label>");
out.println( "            <select class=\"form-control\" id=\"department\" name=\"department\" >");
out.println( "                <option value=\""+department+"\">"+department+"</option>");
out.println( "               <option value=\"SE\">Software Engineering </option>");
out.println( "             <option value=\"CS\">Computer Science</option>");
out.println( "              <option value=\"ISY\">Information System</option>");
out.println( "              <option value=\"IT\">Information Technology</option>");
out.println( "              <option value=\"IS\">Information Science</option>");
out.println( "              <option value=\"CSE\">Computer Science and Engineering</option>");
out.println( "            </select>");
out.println( "        </div>");
out.println( "        <div class=\"form-group col-md-6\">");
out.println( "            <label for=\"education-level\">Education Level:</label>");
out.println( "            <select class=\"form-control\" id=\"educationlevel\" name=\"education_level\">");
out.println( "                <option value=\""+education_level+"\">"+education_level+"</option>");
out.println( "                <option value=\"BA\">Bachelor's Degree</option>");
out.println( "                <option value=\"MA\">Master's Degree</option>");
out.println( "                <option value=\"phd\">Doctorate</option>");
out.println( "            </select>");
out.println( "        </div>");
out.println( "    </div>");
        
        
out.println( "<div class=\"form-row\">");     
out.println( "       <div class=\"form-group col-md-6\">");
out.println( "          <label for=\"FieldOfStudy\">Field of Study:</label>");
out.println( "          <select class=\"form-control\" id=\"FieldOfStudy\" name=\"FieldOfStudy\">");
out.println( "             <option value=\""+FieldOfStudy+"\">"+FieldOfStudy+"</option>");
out.println( "             <option value=\"SE\">Software Engineering </option>");
out.println( "             <option value=\"CS\">Computer Science</option>");
out.println( "              <option value=\"ISY\">Information System</option>");
out.println( "              <option value=\"IT\">Information Technology</option>");
out.println( "              <option value=\"IS\">Information Science</option>");
out.println( "              <option value=\"CSE\">Computer Science and Engineering</option>");
out.println( "         </select>");
out.println( "       </div>"); 
        
out.println( "<div class=\"form-group col-md-6\">");
out.println( "            <label for=\"education-level\">Role:</label>");
out.println( "            <select class=\"form-control\" id=\"role\" name=\"role\">");
out.println( "                <option value=\""+role+"\">"+role+"</option>");
out.println( "                <option value=\"teach\">Teacher</option>");
out.println(         "<option value=\"head\">Head</option>");
out.println( "            </select>");
out.println( "        </div>");
out.println( "    </div>");


out.println(" <div class=\"form-row\">");
out.println(" <div class=\"form-group col-md-6\">");
out.println(" <label for=\"gender\">Gender:</label>");
out.println(" <div class=\"form-check\">");
out.println("  <input class=\"form-check-input\" type=\"radio\" name=\"gender\" id=\"male\" value=\"male\"" + (gender.equalsIgnoreCase("male") ? " checked" : "") + ">");
out.println(" <label class=\"form-check-label\" for=\"male\">");
out.println("     Male");
out.println(" </label>");
out.println(" </div>");
out.println(" <div class=\"form-check\">");
out.println(" <input class=\"form-check-input\" type=\"radio\" name=\"gender\" id=\"female\" value=\"female\"" + (gender.equalsIgnoreCase("female") ? " checked" : "") + ">");
out.println("   <label class=\"form-check-label\" for=\"female\">");
out.println("     Female");
out.println(" </label>");
out.println(" </div>");
out.println(" </div>");
out.println(" </div>");

out.println(" <div class=\"form-row\">");
out.println("    <button type=\"submit\" class=\"btn btn-primary\">Submit</button>");
out.println("    <button type=\"reset\" class=\"btn btn-secondary\">Reset</button>");
out.println(" </div>");


out.println( "</form>");
out.println("</div>");

out.println( "</section>");
out.println( "<aside>\n"+
"<!-- Information about Bule Hora University -->\n" +
"</aside>\n" +
"	</main>");
            out.println("<footer>\n" +
"	<div class=\"container\">\n" +
"		<ul class=\"footer-links\">\n" +
"			<li><a href=\"#\">Contact Us</a></li>\n" +
"			<li><a href=\"#\">About Us</a></li>\n" +
"		</ul>\n" +
"		<p>© 2023 Course Distribution System</p>\n" +
"	</div>\n" +
"</footer>");
 out.println(" <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js\"></script>\n"  +
"	<script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js\"></script>\n" +
"       <script src=\"https://code.jquery.com/jquery-3.3.1.slim.min.js\" integrity=\"sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo\" crossorigin=\"anonymous\"></script>\n" +
"    <script src=\"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/intlTelInput.min.js\"></script>\n" +
"    <script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js\" integrity=\"sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1\" crossorigin=\"anonymous\"></script>\n" +
"    <script src=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js\" integrity=\"sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM\" crossorigin=\"anonymous\"></script>\n" +
"");
 out.println("<script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js\"></script>\n" +
"	<script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js\"></script>\n" +
"       <script src=\"https://code.jquery.com/jquery-3.3.1.slim.min.js\" integrity=\"sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo\" crossorigin=\"anonymous\"></script>\n" +
"    <script src=\"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/intlTelInput.min.js\"></script>\n" +
"<script>\n" +
"  var input = document.querySelector(\"#phone\");\n" +
"  var iti = window.intlTelInput(input, {\n" +
"    initialCountry: \"ET\",\n" +
"    separateDialCode: true,\n" +
"    utilsScript: \"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js\"\n" +
"  });\n" +
"</script>");
            out.println("</body>");
            out.println("</html>");
            } 
        }catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException ex) {
            Logger.getLogger(editTeacher.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String full_name = request.getParameter("full_name");
    String gender = request.getParameter("gender");
    int experience = Integer.parseInt(request.getParameter("experience"));
    String education_level = request.getParameter("education_level");
    String FieldOfStudy = request.getParameter("FieldOfStudy");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String department = request.getParameter("department");
    String role = request.getParameter("role");
    int teachId = Integer.parseInt(request.getParameter("id")); // Retrieve teachId from request

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");

        PreparedStatement statement = conn.prepareStatement("UPDATE instructor SET fullName=?, Gender=?, Experience=?, EducationLevel=?, FieldOfStudy=?, Email=?, Phone=?, Department=?, role=? WHERE id=?");
        statement.setString(1, full_name);
        statement.setString(2, gender);
        statement.setInt(3, experience);
        statement.setString(4, education_level);
        statement.setString(5, FieldOfStudy);
        statement.setString(6, email);
        statement.setString(7, phone);
        statement.setString(8, department);
        statement.setString(9, role);
        statement.setInt(10, teachId); // Set teachId in the PreparedStatement

        int rowsUpdated = statement.executeUpdate();
        if (rowsUpdated > 0) {
            response.sendRedirect("teacherinfoTable.jsp");
        } else {
            request.setAttribute("errorMessage", "Not updated");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }

    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        // Handle exceptions appropriately
    } finally {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions appropriately
        }
    }
}
}
