<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
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
    <link rel="stylesheet" type="text/css" href="src/plugins/datatables/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" type="text/css" href="src/plugins/datatables/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" type="text/css" href="vendors/styles/style.css">
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-119386393-1"></script>
</head>
<body>
    <%@ include file="header.jsp" %>
    <div class="main-container">
        <div class="pd-ltr-20 xs-pd-20-10">
            <div class="min-height-200px">
                <div class="page-header"></div>
                <div class="row clearfix">
                    <!-- Large modal -->
                    <div class="col-md-4 col-sm-12 mb-30">
                        <div class="pd-20 card-box height-100-p">
                            <h5 class="h4">Large modal</h5>
                            <div class="row">
                                <div class="col-6">
                                    <a href="#" class="btn-block" data-toggle="modal" data-target="#software2ndyear">
                                        <img src="vendors/images/modal-img1.jpg" alt="software2ndyear">
                                        <p>Software 2nd Year</p>
                                    </a>
                                </div>
                                <div class="col-6">
                                    <a href="#" class="btn-block" data-toggle="modal" data-target="#software3rdyear">
                                        <img src="vendors/images/modal-img1.jpg" alt="software3rdyear">
                                        <p>Software 3rd Year</p>
                                    </a>
                                </div>
                                <div class="col-6">
                                    <a href="#" class="btn-block" data-toggle="modal" data-target="#software4thyear">
                                        <img src="vendors/images/modal-img1.jpg" alt="software4thyear">
                                        <p>Software 4th Year</p>
                                    </a>
                                </div>
                                <div class="col-6">
                                    <a href="#" class="btn-block" data-toggle="modal" data-target="#software5thyear">
                                        <img src="vendors/images/modal-img1.jpg" alt="software5thyear">
                                        <p>Software 5th Year</p>
                                    </a>
                                </div>
                            </div>
                            <!-- Modal Template -->
                            <div class="modal fade bs-example-modal-lg" id="modal-template" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="myLargeModalLabel">Large modal</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="pb-20">
                                                <table class="table hover multiple-select-row data-table-export nowrap">
                                                    <thead>
                                                        <tr>
                                                            <th class="table-plus datatable-nosort">id</th>
                                                            <th class="nosort">time</th>
                                                            <th>Monday</th>
                                                            <th>Tuesday</th>
                                                            <th>Wednesday</th>
                                                            <th>Thursday</th>
                                                            <th>Friday</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="modalTableBody"></tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Specific Modals -->
                            <div id="software2ndyear" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                <jsp:include page="scheduleModal.jsp">
                                    <jsp:param name="tableName" value="software2ndyear" />
                                </jsp:include>
                            </div>
                            <div id="software3rdyear" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                <jsp:include page="scheduleModal.jsp">
                                    <jsp:param name="tableName" value="software3rdyear" />
                                </jsp:include>
                            </div>
                            <div id="software4thyear" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                <jsp:include page="scheduleModal.jsp">
                                    <jsp:param name="tableName" value="software4thyear" />
                                </jsp:include>
                            </div>
                            <div id="software5thyear" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                <jsp:include page="scheduleModal.jsp">
                                    <jsp:param name="tableName" value="software5thyear" />
                                </jsp:include>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file="footer.jsp" %>
        </div>
    </div>
    <!-- js -->
    <script src="vendors/scripts/core.js"></script>
    <script src="vendors/scripts/script.min.js"></script>
    <script src="vendors/scripts/process.js"></script>
    <script src="vendors/scripts/layout-settings.js"></script>
    <script src="src/plugins/datatables/js/jquery.dataTables.min.js"></script>
    <script src="src/plugins/datatables/js/dataTables.bootstrap4.min.js"></script>
    <script src="src/plugins/datatables/js/dataTables.responsive.min.js"></script>
    <script src="src/plugins/datatables/js/responsive.bootstrap4.min.js"></script>
    <script src="src/plugins/datatables/js/dataTables.buttons.min.js"></script>
    <script src="src/plugins/datatables/js/buttons.bootstrap4.min.js"></script>
    <script src="src/plugins/datatables/js/buttons.print.min.js"></script>
    <script src="src/plugins/datatables/js/buttons.html5.min.js"></script>
    <script src="src/plugins/datatables/js/buttons.flash.min.js"></script>
    <script src="src/plugins/datatables/js/pdfmake.min.js"></script>
    <script src="src/plugins/datatables/js/vfs_fonts.js"></script>
    <script src="vendors/scripts/datatable-setting.js"></script>
</body>
</html>
