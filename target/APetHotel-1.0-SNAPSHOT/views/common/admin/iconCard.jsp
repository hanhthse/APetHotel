<%@page contentType="text/html" pageEncoding="UTF-8"%>
<head>
    <!-- Thêm Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>

<style>
    .row{
        display: flex;
        justify-content: space-around;
    }
</style>
<div class="row">
    <div class="col-xl-2 col-sm-6 mb-3">
        <div class="card text-white bg-primary o-hidden h-100">
            <div class="card-body">
                <div class="card-body-icon">
                    <i class="fas fa-fw fa-shopping-cart"></i>
                </div>
                <div class="mr-5">${sessionScope.unconfirm} Unconfirm</div>
            </div>
            <a class="card-footer text-white clearfix small z-1" href="dashboard?action=viewUnconfirm">

                <span class="float-left">View Details</span>
                <span class="float-right">
                    <i class="fas fa-angle-right"></i>
                </span>
            </a>
        </div>
    </div>
    <div class="col-xl-2 col-sm-6 mb-3">
        <div class="card text-white bg-warning o-hidden h-100">
            <div class="card-body">
                <div class="card-body-icon">
                    <i class="fa-solid fa-list-check"></i>
                </div>
                <div class="mr-5">${sessionScope.confirm} Confirm</div>

            </div>
            <a class="card-footer text-white clearfix small z-1" href="dashboard?action=viewConfirm">
                <span class="float-left">View Details</span>
                <span class="float-right">
                    <i class="fas fa-angle-right"></i>
                </span>
            </a>
        </div>
    </div>
    <div class="col-xl-2 col-sm-6 mb-3">
        <div class="card text-white bg-success o-hidden h-100">
            <div class="card-body">
                <div class="card-body-icon">
                    <i class="fa-solid fa-seedling"></i>         
                </div>
                <div class="mr-5">${sessionScope.progress} Progress</div>

            </div>
            <a class="card-footer text-white clearfix small z-1" href="dashboard?action=viewProgress">
                <span class="float-left">View Details</span>
                <span class="float-right">
                    <i class="fas fa-angle-right"></i>
                </span>
            </a>
        </div>
    </div>
    <div class="col-xl-2 col-sm-6 mb-3">
        <div class="card text-white bg-danger o-hidden h-100">
            <div class="card-body">
                <div class="card-body-icon">
                    <i class="fa-solid fa-circle-xmark"></i>

                </div>
                <div class="mr-5">${sessionScope.cancel} Cancel</div>

            </div>
            <a class="card-footer text-white clearfix small z-1" href="dashboard?action=viewCancel">
                <span class="float-left">View Details</span>
                <span class="float-right">
                    <i class="fas fa-angle-right"></i>
                </span>
            </a>
        </div>
    </div>
    <div class="col-xl-2 col-sm-6 mb-3">
        <div class="card text-white bg-secondary o-hidden h-100">
            <div class="card-body">
                <div class="card-body-icon">
                    <i class="fa-solid fa-square-check"></i>
                </div>
                <div class="mr-5">${sessionScope.complete} Complete</div>
            </div>
            <a class="card-footer text-white clearfix small z-1" href="dashboard?action=viewComplete">
                <span class="float-left">View Details</span>
                <span class="float-right">
                    <i class="fas fa-angle-right"></i>
                </span>
            </a>
        </div>
    </div>

</div>