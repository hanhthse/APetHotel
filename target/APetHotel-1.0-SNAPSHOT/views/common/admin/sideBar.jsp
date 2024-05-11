<%@page contentType="text/html" pageEncoding="UTF-8"%>
<ul class="sidebar navbar-nav">
    <li class="nav-item active">
        <a class="nav-link" href="dashboard">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </a>
    </li>
    <li class="nav-item dropdown">
        <a class="nav-link " href="dashboard?action=managerAccount">
            <i class="fas fa-fw fa-user"></i>
            <span>Customers</span>
        </a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="dashboard?action=pagination&page=1">
            <i class="fas fa-fw fa-table"></i>
            <span>Manager Pet</span></a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="dashboard?action=managerCages">
            <i class="fas fa-fw fa-folder"></i>
            <span>Manager Cages</span></a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="dashboard?action=reportStatistics">
            <i class="fas fa-fw fa-folder"></i>
            <span>Report Statistics</span></a>
    </li>
</ul>
