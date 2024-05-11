<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-md-4">
    <form class="container-fluid" id="reportStatis" action="dashboard" method="POST">
        <input name="action" value="loadReportStatis" type="hidden"/>
        <!-- Date Started -->
        <div class="form-group">
            <label for="dateStarded">Date Started: </label>
            <input type="date" class="form-control" id="dateStarded" name="dateStarded">
            <div id="dateStardedError" class="error" style="color: red"></div> 
        </div>
        <!-- Date End -->
        <div class="form-group">
            <label for="dateEnded">Date End: </label>
            <input type="date" class="form-control" id="dateEnded" name="dateEnded">
            <div id="dateEndedError" class="error" style="color: red"></div>
        </div>
        <h4 style="color: red"> ${ERROR}</h4>
        <button class="btn btn-info btn-lg text-white">FIND</button>
    </form>
</div>


