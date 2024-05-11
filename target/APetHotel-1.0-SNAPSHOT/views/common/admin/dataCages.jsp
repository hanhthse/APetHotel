<%@page import="com.apethotel.entity.Pet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <!-- Tiêu đề Danh sách Pet ở giữa row -->
    <div class="row">

        <div class="col-12 text-center">
            <h2>Danh sách Cages của bạn</h2>
        </div>

    </div>
    <!-- Thanh phân cách (hr) đặt ở giữa và chiếm toàn bộ chiều rộng của row -->
    <div class="row">
        <div class="col-12">
            <hr>
        </div>
    </div>
    <div class="row">
        <!-- Sử dụng forEach để lặp qua danh sách pet -->
        <c:forEach items="${listOfCages}" var="cages" varStatus="status">
            <!-- Mở một row mới sau mỗi 3 pet -->
            <c:if test="${status.index % 3 == 0 && status.index != 0}">
            </div><div class="row">
            </c:if>

            <div class="col-md-4">
                <div class="card">
                    <div class="card-body d-flex">
                        <div class="w-75">
                            <!--name and pet details-->
                            <h5 class="card-title d-flex justify-content-between">
                                <span>Lồng số: ${cages.cageID}</span>
                                <img src="${cages.image}" alt="Pet image" style="width: 50px; height: 50px; border-radius: 50%;" class="ml-2">
                            </h5>
                            <p class="card-text">Loại: ${cages.typeId == 1 ? "Chó":"Mèo"}</p>
                            <p class="card-text">Size: ${cages.size}</p>
                            <p class="card-text">Giá: ${cages.pricePerDay} VND</p>
                            <p class="card-text">Mô tả: ${cages.description} </p>
                            <i class="fa fa-edit fa-2x"
                               style="color: #469408"
                               data-toggle="modal"
                               data-target="#editCageModal"
                               onclick="editCageModal(${cages.cageID},
                                               '${cages.description}',
                                               '${cages.size}',
                               ${cages.pricePerDay},
                               ${cages.typeId},
                                               '${cages.image}')">
                            </i>
                            <!--Delete-->
                            <i class="fa fa-trash fa-2x"
                               style="color: ${cages.status == true ? '#e70808' : '#52dd5f' } "
                               data-toggle="modal"
                               data-target="#delete-modal"
                               onclick="deleteCagesModal(${cages.cageID})">
                            </i>
                            <i class="fa fa-history fa-2x"
                               style="color: rgb(30 48 80)"
                               onclick="submitFormHistory('${cages.cageID}')"> 
                            </i>
                            <form action="dashboard?action=historyOfCages" method="POST" id="formHistory${cages.cageID}">
                                <input type="hidden" name="cagesIdHis" value="${cages.cageID}" >
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script type="text/javascript">
    function submitFormHistory(CageID) {
        document.getElementById('formHistory' + CageID).submit();
    }
</script>