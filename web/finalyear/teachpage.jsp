<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    	<!-- Site favicon
	<link rel="apple-touch-icon" sizes="180x180" href="vendors/images/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="vendors/images/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="vendors/images/favicon-16x16.png"> -->

	<!-- Mobile Specific Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
	<!-- CSS -->
	<link rel="stylesheet" type="text/css" href="vendors/styles/core.css">
	<link rel="stylesheet" type="text/css" href="vendors/styles/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="vendors/styles/style.css">

	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-119386393-1"></script>
 
</head>
<body>
    
    
    	
   <%@include file="header.jsp" %>
	<div class="mobile-menu-overlay"></div>

	<div class="main-container">
		<div class="pd-ltr-20 xs-pd-20-10">
			
				
				<div class="row clearfix">
                                    
					<div class="col-md-4 col-sm-12 mb-30">
                                            <a href="assignedCourse.jsp" > 
						<div class="card text-white bg-primary card-box">
							<div class="card-header">See Assigned Course</div>
							<div class="card-body">
								<h5 class="card-title text-white"></h5>
                                                                <p class="card-text">Welcome <%= sessionbj .getAttribute("userName") %> now you can see your courses for this semester<br>wish you happy teaching time, guiding student is not an easy task you greet honor </p>
							</div>
						</div>
                                                </a>
					</div>
                                        
					<div class="col-md-4 col-sm-12 mb-30">
                                              <a href="schedule.jsp" > 
						<div class="card text-white bg-secondary card-box">
							<div class="card-header">see schedule</div>
							<div class="card-body">
								<h5 class="card-title text-white">  </h5>
								<p class="card-text">your schedule for this semester</p>
							</div>
                                              
						</div>
                                                  </a>
					</div>
					
					
				</div>
				
				
			</div>
			<%@ include file="footer.jsp" %>
		</div>
</body>
<script src="vendors/scripts/core.js"></script>
	<script src="vendors/scripts/script.min.js"></script>
	<script src="vendors/scripts/process.js"></script>
	<script src="vendors/scripts/layout-settings.js"></script>
	<script src="src/plugins/datatables/js/jquery.dataTables.min.js"></script>
	<script src="src/plugins/datatables/js/dataTables.bootstrap4.min.js"></script>
	<script src="src/plugins/datatables/js/dataTables.responsive.min.js"></script>
	<script src="src/plugins/datatables/js/responsive.bootstrap4.min.js"></script>
	<!-- buttons for Export datatable -->
	<script src="src/plugins/datatables/js/dataTables.buttons.min.js"></script>
	<script src="src/plugins/datatables/js/buttons.bootstrap4.min.js"></script>
	<script src="src/plugins/datatables/js/buttons.print.min.js"></script>
	<script src="src/plugins/datatables/js/buttons.html5.min.js"></script>
	<script src="src/plugins/datatables/js/buttons.flash.min.js"></script>
	<script src="src/plugins/datatables/js/pdfmake.min.js"></script>
	<script src="src/plugins/datatables/js/vfs_fonts.js"></script>
	<!-- Datatable Setting js -->
	<script src="vendors/scripts/datatable-setting.js"></script></body>
</html>
