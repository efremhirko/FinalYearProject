<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<div class="header">
    <div class="header-left">
        <div class="menu-icon dw dw-menu"></div>
        <div class="search-toggle-icon dw dw-search2" data-toggle="header_search"></div>
        <div class="header-search">
            <center><form>
                <center><div class="class="pull-center">
                 <h1 class="text-blue h4">Class Schedule and Course Distribution System</h1>
                </div></center>
            </form></center>
        </div>
    </div>
    <div class="header-right">
        <div class="dashboard-setting user-notification">
            <div class="dropdown">
                <a class="dropdown-toggle no-arrow" href="javascript:;" data-toggle="right-sidebar">
                    <i class="dw dw-settings2"></i>
                </a>
            </div>
        </div>
        <% 
             HttpSession sessionbj  = request.getSession(false);
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/cscds", "root", "");
                String tableName1 = "";
                String un = (String) session.getAttribute("un");
                String department1 = (String) session.getAttribute("dpt");

                if (un != null && department1 != null) {
                    switch (department1) {
                        case "SE":
                        case "CSE":
                            tableName1 = "sweinstructor";
                            break;
                        case "IS":
                            tableName1 = "isinstructor";
                            break;
                        case "ISY":
                            tableName1 = "isysinstructor";
                            break;
                        case "IT":
                            tableName1 = "itinstructor";
                            break;
                        case "CS":
                            tableName1 = "csinstructor";
                            break;
                        default:
                            tableName1 = "";
                            break;
                    }

                    if (!tableName1.isEmpty()) {
                        String sql = "SELECT fullName, role FROM " + tableName1 + " WHERE username = ?";
                        PreparedStatement statement = conn.prepareStatement(sql);
                        statement.setString(1, un);
                        ResultSet rs = statement.executeQuery();
                    
                        if (rs.next()) {
                            String userName = rs.getString("fullName");
                             String role = rs.getString("role");
                            sessionbj.setAttribute("userName", userName);
        %>
                            <div class="user-info-dropdown">
                                <div class="dropdown">
                                    <a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown">
                                        <span class="user-icon">
                                            <img src="" alt="">
                                        </span>
                                        <span class="user-name"><%= userName %></span>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-icon-list">
                                        <a class="dropdown-item" href="profile.html"><i class="dw dw-user1"></i> Profile</a>
                                        <a class="dropdown-item" href="profile.html"><i class="dw dw-settings2"></i> Setting</a>
                                        <a class="dropdown-item" href="faq.html"><i class="dw dw-help"></i> Help</a>
                                        <a class="dropdown-item" href="<%= request.getContextPath()%>/logout"><i class="dw dw-logout"></i> Log Out</a>
                                    </div>
                                </div>
                            </div>
        <%
                        }
                        // Close ResultSet, PreparedStatement, and Connection
                        rs.close();
                        statement.close();
                    }
                }
                // Close Connection
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
</div>
<!-- The rest of your HTML content -->

    </div>
</div>
	<div class="right-sidebar">
		<div class="sidebar-title">
			<h3 class="weight-600 font-16 text-blue">
				Layout Settings
				<span class="btn-block font-weight-400 font-12">User Interface Settings</span>
			</h3>
			<div class="close-sidebar" data-toggle="right-sidebar-close">
				<i class="icon-copy ion-close-round"></i>
			</div>
		</div>
		<div class="right-sidebar-body customscroll">
			<div class="right-sidebar-body-content">
				<h4 class="weight-600 font-18 pb-10">Header Background</h4>
				<div class="sidebar-btn-group pb-30 mb-10">
					<a href="javascript:void(0);" class="btn btn-outline-primary header-white active">White</a>
					<a href="javascript:void(0);" class="btn btn-outline-primary header-dark">Dark</a>
				</div>

				<h4 class="weight-600 font-18 pb-10">Sidebar Background</h4>
				<div class="sidebar-btn-group pb-30 mb-10">
					<a href="javascript:void(0);" class="btn btn-outline-primary sidebar-light ">White</a>
					<a href="javascript:void(0);" class="btn btn-outline-primary sidebar-dark active">Dark</a>
				</div>

				<h4 class="weight-600 font-18 pb-10">Menu Dropdown Icon</h4>
				<div class="sidebar-radio-group pb-10 mb-10">
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebaricon-1" name="menu-dropdown-icon" class="custom-control-input" value="icon-style-1" checked="">
						<label class="custom-control-label" for="sidebaricon-1"><i class="fa fa-angle-down"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebaricon-2" name="menu-dropdown-icon" class="custom-control-input" value="icon-style-2">
						<label class="custom-control-label" for="sidebaricon-2"><i class="ion-plus-round"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebaricon-3" name="menu-dropdown-icon" class="custom-control-input" value="icon-style-3">
						<label class="custom-control-label" for="sidebaricon-3"><i class="fa fa-angle-double-right"></i></label>
					</div>
				</div>

				<h4 class="weight-600 font-18 pb-10">Menu List Icon</h4>
				<div class="sidebar-radio-group pb-30 mb-10">
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-1" name="menu-list-icon" class="custom-control-input" value="icon-list-style-1" checked="">
						<label class="custom-control-label" for="sidebariconlist-1"><i class="ion-minus-round"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-2" name="menu-list-icon" class="custom-control-input" value="icon-list-style-2">
						<label class="custom-control-label" for="sidebariconlist-2"><i class="fa fa-circle-o" aria-hidden="true"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-3" name="menu-list-icon" class="custom-control-input" value="icon-list-style-3">
						<label class="custom-control-label" for="sidebariconlist-3"><i class="dw dw-check"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-4" name="menu-list-icon" class="custom-control-input" value="icon-list-style-4" checked="">
						<label class="custom-control-label" for="sidebariconlist-4"><i class="icon-copy dw dw-next-2"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-5" name="menu-list-icon" class="custom-control-input" value="icon-list-style-5">
						<label class="custom-control-label" for="sidebariconlist-5"><i class="dw dw-fast-forward-1"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-6" name="menu-list-icon" class="custom-control-input" value="icon-list-style-6">
						<label class="custom-control-label" for="sidebariconlist-6"><i class="dw dw-next"></i></label>
					</div>
				</div>

				<div class="reset-options pt-30 text-center">
					<button class="btn btn-danger" id="reset-settings">Reset Settings</button>
				</div>
			</div>
		</div>
	</div>

	<div class="left-side-bar">
		<div class="brand-logo">
			<a href="#">
				<img src="" alt="" class="dark-logo">
				<img src="src/images/siconn.jpg" alt="" class="light-logo" style="width: 20px; height: auto;">

			</a>
			<div class="close-sidebar" data-toggle="left-sidebar-close">
				<i class="ion-close-round"></i>
			</div>
		</div>
		<div class="menu-block customscroll">
			<div class="sidebar-menu">
				<ul id="accordion-menu">
					<li class="dropdown">
						<a href="javascript:;" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-house-1"></span><span class="mtext">Home</span>
						</a>
					</li>
<%
  // Check if the user is logged in and has the role of "head"
 
  if (sessionbj  != null && sessionbj .getAttribute("role") != null && sessionbj .getAttribute("role").equals("head")) {
%>                                    
					<li class="dropdown">
						<a href="javascript:;" class="dropdown-toggle">
							<span class="micon dw dw-edit2"></span><span class="mtext">Registration</span>
						</a>
						<ul class="submenu">
							<li><a href="registerTeacher.jsp">Register Teacher</a></li>
							<li><a href="registerCourse.jsp">Register Course</a></li>
							<li><a href="registerStudent.jsp">Register Student</a></li>
							
						</ul>
					</li>
                                      
					<li class="dropdown">
						<a href="javascript:;" class="dropdown-toggle">
							<span class="micon dw dw-library"></span><span class="mtext">Information</span>
						</a>
						<ul class="submenu">
							<li><a href="teacherinfoTable.jsp">See Instructors Info</a></li>
                                                        <li><a href="studentinfoTable.jsp">See Student Info</a></li>
							<li><a href="courseData.jsp">See Course Info</a></li>
                                                        <li><a href="assignedCourseall.jsp">See assigned Course</a></li>
                                                         <li><a href="wholeschedule.jsp">See Whole Schedule</a></li>
						</ul>
					</li>
					<li class="dropdown">
						<a href="javascript:;" class="dropdown-toggle">
							<span class="micon dw dw-right-arrow1"></span><span class="mtext">Assign and Schedule</span>
						</a>
						<ul class="submenu">
							<li><a href="<%= request.getContextPath()%>/SweAssignedcourse">Assign Courses</a></li>
							<li><a href="<%= request.getContextPath()%>/CourseSchedule">Generate Schedule</a></li>
							
						</ul>
					</li>
<%}
  // Check if the user is logged in and has the role of "head"
   
  if (sessionbj  != null && sessionbj .getAttribute("role") != null && sessionbj .getAttribute("role").equals("teach")) {
%>  		
                                               <li class="dropdown">
						<a href="javascript:;" class="dropdown-toggle">
							<span class="micon dw dw-library"></span><span class="mtext">Information</span>
						</a>
						<ul class="submenu">
							<li><a href="teacherinfoTable.jsp">See your Info</a></li>
							<li><a href="assignedCourseall.jsp">See assigned course for you</a></li>
                                                        <li><a href="schedule.jsp">See Schedule</a></li>
						</ul>
					</li>
                                       
                                        
                                        
<%}
  // Check if the user is logged in and has the role of "head"
  else {

}%>  

					<li>
						<a href="calendar.html" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-calendar1"></span><span class="mtext">Calendar</span>
						</a>
					</li>
					<li>
						<a href="javascript:;" class="dropdown-toggle">
							<span class="micon dw dw-edit-2"></span><span class="mtext">Documentation</span>
						</a>
						<ul class="submenu">
							<li><a href="introduction.html">Introduction</a></li>
							<li><a href="getting-started.html">Getting Started</a></li>
							<li><a href="color-settings.html">Color Settings</a></li>
							<li><a href="third-party-plugins.html">Third Party Plugins</a></li>
						</ul>
					</li>
					
				</ul>
			</div>
		</div>
	</div>
	<div class="mobile-menu-overlay"></div>