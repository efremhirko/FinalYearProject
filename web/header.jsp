<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
 <header>
    <div class="left-section">
      <a href="headpage.jsp">Home</a>
      <a href="aboutus.jsp">About Us</a>
      <a href="contactus.jsp">Contact Us</a>
      <a href="courseData.jsp">Courses</a>
    </div>
    <div class="center-section">
      <h1>Class Schedule and Course Distribution</h1>
    </div>
    <div class="right-section">
      <ul class="navbar-nav">
<!--        <li class="nav-item">
          <a href="logout" class="nav-link logout-button" href="#">Logout</a>
        </li>-->
        
         <li class="dropdown">
         
          <a class="dropdown" data-toggle="dropdown">   
              <% 
                    // Assuming the user photo URL is stored in the session
                    String userPhoto = (String) session.getAttribute("userPhoto");
                %>
                <img src="<%= userPhoto %>" alt="" class="user-photo" width="40" height="40"> <span class="caret"></span></a>
             <ul class="dropdown-menu">
           
  <li class="nav-item"><a href="logout">Logout</a></li>
  <li class="nav-item"><a href="changePassword">Change Password</a></li>
</ul>
        
        </li>
      </ul>
    </div>
  </header>
	<main>
 <aside>
    <div class="vertical-header">
      <ul>
        <li><a href="#">Home</a></li>
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown">Registration <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="registerTeacher.jsp">Teacher Registration</a></li>
            <li><a href="registerCourse.jsp">Course Registration</a></li>
          </ul>
        </li>
        <li><a href="teacherinfoTable.jsp">Teacher Information</a></li>
        <li><a href="courseData.jsp">Course Information</a></li>
        <li><a href="assignedtable.jsp">Assign Course</a></li>
      </ul>
    </div>
  </aside>