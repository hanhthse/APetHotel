<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${account == null}">
    <c:redirect url="/mainControllers"></c:redirect>
</c:if>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <!-- Custom fonts for this template-->
        <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

        <!-- Page level plugin CSS-->
        <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="${pageContext.request.contextPath}/css/sb-admin.css" rel="stylesheet">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/colReorder-bootstrap4.css">
    </head>
    <body>
    <body id="page-top">
        <jsp:include page="nofication.jsp"></jsp:include>
        <jsp:include page="../../common/user/dashboard/navigationBar.jsp"></jsp:include>

            <div id="wrapper">

                <!-- Sidebar -->
            <jsp:include page="../../common/user/dashboard/sideBar.jsp"></jsp:include>

                <div id="content-wrapper">

                    <div class="container-fluid">
                        <!--Profile-->
                        <div class="container-fluid">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-12 text-center">
                                            <h4>Thông tin cá nhân</h4>
                                            <hr>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12 justify-content-center">
                                            <form class="justify-content-center" action="mainControllers?action=dashboard&action1=profile" method="POST">
                                                <!-- Email -->
                                                <div class="form-group justify-content-center row">
                                                    <label for="email" class="col-2 col-form-label">Email</label>
                                                    <div class="col-6">
                                                        <input id="username" name="email" placeholder="" readonly class="form-control here"
                                                               type="text" value="${sessionScope.account.email}">
                                                </div>
                                            </div>
                                            <!-- Name -->
                                            <div class="form-group justify-content-center row">
                                                <label for="name" class="col-2 col-form-label">Name</label>
                                                <div class="col-6">
                                                    <input id="email" name="name" placeholder="Họ và tên" class="form-control here" 
                                                           type="text" value="${sessionScope.account.name}">

                                                    <span style="color: red">${nameError}</span>
                                                </div>
                                            </div>
                                            <!-- phoneNumber -->
                                            <div class="form-group justify-content-center row">
                                                <label for="address" class="col-2 col-form-label">Phone Number</label>
                                                <div class="col-6">
                                                    <input id="address" name="phonenumber" placeholder="" 
                                                           class="form-control here" type="text"
                                                           value="${sessionScope.account.phoneNumber}">
                                                    <span style="color: red">${phoneError}</span>
                                                </div>
                                            </div>

                                            <!-- Save button -->
                                            <div class="form-group justify-content-center row">
                                                <div class="offset-4 col-8">
                                                    <button name="submit" type="submit" class="btn btn-primary">Lưu thông tin</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                            </div>
                        </div>


                    </div>
                    <!-- /.container-fluid -->

                    <!-- Sticky Footer -->
                    <jsp:include page="../../common/user/dashboard/stickyFooter.jsp"></jsp:include>

                    </div>
                    <!-- /.content-wrapper -->

                </div>
                <!-- /#wrapper -->

                <!-- Scroll to Top Button-->
            <jsp:include page="../../common/user/dashboard/scrollTopButton.jsp"></jsp:include>


                <!-- Logout Modal-->
            <jsp:include page="../../common/user/dashboard/logOutModal.jsp"></jsp:include>

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
            <script src="${pageContext.request.contextPath}/js/colReorder-bootstrap4-min.js"></script>
            <script src="${pageContext.request.contextPath}/js/colReorder-dataTables-min.js"></script>

            <!-- Demo scripts for this page-->
            <script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>
            <script src="${pageContext.request.contextPath}/js/demo/chart-area-demo.js"></script>
            <script src="${pageContext.request.contextPath}/js/colReorder-dataTables-min.js"></script>
            <script src="${pageContext.request.contextPath}/js/colReorder-bootstrap4-min.js"></script>


    </body>
</body>
</html>