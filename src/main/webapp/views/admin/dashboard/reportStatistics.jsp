<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${account == null}">
    <c:redirect url="/mainControllers"></c:redirect>
</c:if>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>SB Admin - Dashboard</title>

        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

        <!-- Page level plugin CSS-->
        <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/css/sb-admin.css" rel="stylesheet">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/colReorder-bootstrap4.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/calendar-style.css" />        
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
        <style>
            .error {
                color: red;
            }
        </style>
    </head>

    <body id="page-top">
        <jsp:include page="../../common/admin/navigationBar.jsp"></jsp:include>

            <div id="wrapper">

                <!-- Sidebar -->
            <jsp:include page="../../common/admin/sideBar.jsp"></jsp:include>

                <div id="content-wrapper">

                    <div class="container-fluid">
                        <!--chart-->
                    <jsp:include page="../../common/admin/chart.jsp"></jsp:include>
                        <!--input Report-->
                    <jsp:include page="../../common/admin/inputReport.jsp"></jsp:include>
                    <br><br/>
                        <!-- DataTables Example -->
                    <jsp:include page="../../common/admin/dataExample.jsp"></jsp:include>
                    </div>

                    <!-- Sticky Footer -->
                <jsp:include page="../../common/admin/stickFooter.jsp"></jsp:include>

                    <!--calendarModal-->
                <jsp:include page="../../user/home-page/calendarModal.jsp"></jsp:include>
                </div>
                <!-- /.content-wrapper -->

            </div>
            <!-- /#wrapper -->

            <!-- Scroll to Top Button-->
        <jsp:include page="../../common/admin/scrollUpToButton.jsp"></jsp:include>


            <!-- Logout Modal-->
        <jsp:include page="../../common/admin/logOutModal.jsp"></jsp:include>

            <!--Add boook modal-->
        <jsp:include page="../../common/admin/addBookModal.jsp"></jsp:include>

            <!--Delete book modal-->
        <jsp:include page="../../common/admin/deleteBookModal.jsp"></jsp:include>

            <!--Edit Book Modal-->
        <jsp:include page="../../common/admin/editBookModal.jsp"></jsp:include>

            <!-- Bootstrap core JavaScript-->
            <script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Page level plugin JavaScript-->
        <script src="${pageContext.request.contextPath}/vendor/chart.js/Chart.min.js"></script>
        <script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.js"></script>
        <script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="${pageContext.request.contextPath}/js/sb-admin.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/my_chart.js"></script>
        <script src="${pageContext.request.contextPath}/js/chart-updater.js"></script>
        <script src="${pageContext.request.contextPath}/js/colReorder-bootstrap4-min.js"></script>
        <script src="${pageContext.request.contextPath}/js/colReorder-dataTables-min.js"></script>

        <!-- Demo scripts for this page-->
        <script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>
        <script src="${pageContext.request.contextPath}/js/demo/chart-area-demo.js"></script>
        <script src="${pageContext.request.contextPath}/js/colReorder-dataTables-min.js"></script>
        <script src="${pageContext.request.contextPath}/js/colReorder-bootstrap4-min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.2/dist/chart.umd.min.js"></script>
        <script>
            function validateReportForm() {
                let hasError = false; // Biến để kiểm tra lỗi

                // Lấy giá trị từ các input trong form
                let dateStarded = $('#dateStarded').val();
                let dateEnded = $('#dateEnded').val();

                // Xóa các thông báo lỗi hiện tại
                $('.error').html('');

                // Lấy ngày hiện tại dưới dạng 'yyyy-MM-dd'
                let currentDate = new Date().toISOString().split('T')[0];

                // Validate Date Started không được null và phải là quá khứ hoặc hôm nay
                if (!dateStarded) {
                    $('#dateStardedError').html('Date Started cannot be empty');
                    hasError = true;
                } else if (dateStarded > currentDate) {
                    $('#dateStardedError').html('Date Started must be today or in the past');
                    hasError = true;
                }

                // Validate Date Ended không được null và phải là quá khứ hoặc hôm nay
                if (!dateEnded) {
                    $('#dateEndedError').html('Date End cannot be empty');
                    hasError = true;
                } else if (dateEnded > currentDate) {
                    $('#dateEndedError').html('Date End must be today or in the past');
                    hasError = true;
                }

                // So sánh Date Started và Date Ended
                if (dateStarded && dateEnded && dateStarded > dateEnded) {
                    $('#dateStardedError').html('Date Started must not be later than Date End');
                    $('#dateEndedError').html('Date End must not be earlier than Date Started');
                    hasError = true;
                }

                // Ngăn việc gửi form nếu có lỗi
                if (hasError) {
                    event.preventDefault();
                }
            }

            // Gắn hàm validation vào sự kiện submit của form
            $(document).ready(function () {
                $('#reportStatis').submit(function (event) {
                    validateReportForm();
                });
            });
        </script>
    </body>

</html>
