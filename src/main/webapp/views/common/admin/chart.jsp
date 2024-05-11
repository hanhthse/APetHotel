<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--add chart-->
<style>
    .graphBox{
        position: relative;
        width: 100%;
        padding: 20px;
        display: grid;
        grid-template-columns: 1fr 2fr;
        grid-gap: 30px;    
        min-height: 250px;
    }   
    .graphBox .box{
        position: relative;
        background: #fff;
        padding: 20px;
        width: 100%;
        box-shadow: 0 7px 25px rgba(0,0,0,0.08);
        border-radius: 20px;
    }
</style>
<div class="graphBox">
    <div class="box">
        <canvas id="myChart" width="300" height="300"></canvas>
    </div>
    <div class="box">
        <canvas id="earning"></canvas>
    </div>
    <script>
        var data = ${sessionScope.chartData};
        var dataEarning = ${sessionScope.dataEarning};
    </script>

</div>