<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.apethotel.entity.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.bookstore.Constant.Constant"%>
<style>
    .dropdown {
        position: relative;
        display: inline-block;
    }

    .dropdown-content {
        display: none;
        position: absolute;
        background-color: #f9f9f9;
        min-width: 160px;
        margin-left: 10px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1;
    }

    .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }

    .dropdown-content a:hover {background-color: #f1f1f1}

    .dropbtn {
        background-color: white;
        color: black;
        padding:5px;
        font-size: 18px;
        border: 1;
        cursor: pointer;
    }

    .dropbtn:hover, .dropbtn:focus {
        background-color: #3e8e41;
    }

    .dropdown:hover .dropdown-content {
        display: block;
    }

    .dropdown:hover .dropbtn {
        background-color: #007bff;
    }

</style>

<section id="navigation-bar">
    <div class="container-fluid">
        <nav class="navbar navbar-expand-lg navbar-light ">

            <a href="home" class="navbar-brand logo"><img src="<%=request.getContextPath()%>/image/logo.png" alt="logo" border="0" style="height: 100px"></a>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo01"
                    aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item"> <a href="home" class="nav-link">Home</a> </li>
                </ul>
                <c:choose>
                    <c:when test="${empty sessionScope.account}">
                        <a href="${pageContext.request.contextPath}/authen?action=login">
                            <button class="btn btn-outline-primary ml-2">Login</button>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <div class="dropdown user-info">
                            <button class="btn btn-outline-primary ml-2 dropbtn">${sessionScope.account.name}</button>
                            <div class="dropdown-content">
                                <a href="${pageContext.request.contextPath}/dashboard">Profile setting</a>
                                <a href="${pageContext.request.contextPath}/authen?action=logout">Sign out</a>
                            </div>
                        </div>
                        <c:if test="${sessionScope.account.roleId == 1}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard">
                                <button class="btn btn-outline-secondary ml-2">Manages</button>
                            </a>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>

        </nav>
    </div>
</section>
