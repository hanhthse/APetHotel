<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <section id="page-navigation" class="d-flex justify-content-center">
            <ul class="pagination">
                <li class="page-item">
                    <a class="page-link" href="dashboard?action=pagination&page=1"
                       style="${pageControl.page == pageControl.totalPage ? '' : 'display:none'} ">First</a></li>
                <li class="page-item ${pageControl.page == 1 ? 'disabled' : ''}">
                    <a class="page-link"href="dashboard?action=pagination&page=${pageControl.page - 1}">Previous</a></li>

                <li class="page-item">
                    <a class="page-link" href="dashboard?action=pagination&page=${pageControl.page}">${pageControl.page}</a></li>

                <li class="page-item">
                    <a class="page-link" href="dashboard?action=pagination&page=${pageControl.page+1}"
                       style="${pageControl.page +1 > pageControl.totalPage ? 'display:none' : ''} ">${pageControl.page+1}</a></li>

                <li class="page-item">
                    <a class="page-link" href="dashboard?action=pagination&page=${pageControl.page+2}"
                       style="${pageControl.page +2 > pageControl.totalPage ? 'display:none' : ''} ">${pageControl.page+2}</a></li>

                <li class="page-item">
                    <a class="page-link" href="dashboard?action=pagination&page=${pageControl.page + 1}"
                       style="${pageControl.page == pageControl.totalPage ? 'display:none' : ''} ">next</a></li>
                <li class="page-item">
                    <a class="page-link" href="dashboard?action=pagination&page=${pageControl.totalPage}"
                       style="${pageControl.page == pageControl.totalPage ? 'display:none' : ''} ">Last</a></li>


            </ul>
        </section>
    </body>
</html>
