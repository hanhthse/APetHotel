<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.bookstore.Constant.Constant"%>
<%@page import="com.apethotel.entity.Users"%>
<%@page import="com.apethotel.entity.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand navbar-dark bg-dark static-top">
    <c:choose>
        <c:when test="${not empty sessionScope.account}">
            <!-- User is present; display the user's name -->
            <a class="navbar-brand mr-1" href="#">${account.name}</a>
        </c:when>
        <c:otherwise>
            <!-- User is not present; display default message -->
            <a class="navbar-brand mr-1" href="#">Khong co session</a>
        </c:otherwise>
    </c:choose>



    <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
        <i class="fas fa-bars"></i>
    </button>

    <!-- Navbar Search -->
    <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
    </form>


    <ul class="navbar-nav ml-auto ml-md-0">
        <li class="nav-item dropdown no-arrow">
            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-user-circle fa-fw"></i>
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="mainControllers?action=home">Back Home</a>
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">Logout</a>
            </div>
        </li>
    </ul>
</nav>


