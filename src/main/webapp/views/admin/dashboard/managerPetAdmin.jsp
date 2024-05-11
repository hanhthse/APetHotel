<%@page import="com.apethotel.entity.Pet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${account == null}">
    <c:redirect url="/mainControllers"></c:redirect>
</c:if>
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
    <body id="page-top">
        <jsp:include page="../../common/admin/navigationBar.jsp"></jsp:include>

            <!--thông báo-->
        <jsp:include page="../../common/nofication.jsp"></jsp:include>
            <div id="wrapper">

                <!-- Sidebar -->
            <jsp:include page="../../common/admin/sideBar.jsp"></jsp:include>
                <div id="content-wrapper">

                    <!--ListPet-->
                <jsp:include page="../../common/admin/dataPetAdmin.jsp"></jsp:include>
                    <br>
                <jsp:include page="../../common/admin/pagination.jsp"/>  
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
        <!--AddPet Modal-->
    <jsp:include page="../../common/user/dashboard/addPetModal.jsp"></jsp:include>
        <!--delete Modal-->
    <jsp:include page="../../common/admin/deletePetModalAdmin.jsp"></jsp:include>
        <!--Edit Pet Modal-->
    <jsp:include page="../../common/admin/editPetModal.jsp"></jsp:include>
        <!--HIstory Pet Modal-->
    <jsp:include page="../../common/user/dashboard/history-modal.jsp"></jsp:include>
        <!-- Logout Modal-->
    <jsp:include page="../../common/admin/logOutModal.jsp"></jsp:include>

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
</html>
