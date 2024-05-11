<%@page contentType="text/html" pageEncoding="UTF-8"%>
<ul class="sidebar navbar-nav">
    <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/mainControllers?action=dashboard">
            <i class="fas fa-fw fa-business-time"></i>
            <span>Booking</span>
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/mainControllers?action=dashboard&page=profile">
            <i class="fas fa-fw fa-address-card"></i>
            <span>Profile</span>
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/mainControllers?action=dashboard&page=change-password">
            <i class="fas fa-fw fa-edit"></i>
            <span>Change password</span>
        </a>
    </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/mainControllers?action=dashboard&page=managerPet">
                <i class="fas fa-fw fa-table"></i>
                <span>Manager Your Pet</span>
            </a>
        </li>
</ul>

