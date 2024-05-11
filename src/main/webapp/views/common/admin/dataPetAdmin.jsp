<%@page import="com.apethotel.entity.Pet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <!-- Tiêu đề Danh sách Pet ở giữa row -->
    <div class="row">
        <c:if test="${sessionScope.nameUserFind != null}">
            <div class="col-12 text-center">
                <h2>Danh sách Pet của UserName: ${nameUserFind}</h2>
            </div>
        </c:if>
        <c:if test="${sessionScope.nameUserFind == null}">
            <div class="col-7" style="text-align: right">
                <h2>Danh sách Pet của bạn</h2>
            </div>
            <div class="col-5">
                <nav class="navbar navbar-light pl-sm-0 justify-content-end">
                    <form class="form-inline" action="dashboard?action=searchPetManager" method="post">
                        <input class="form-control mr-sm-2" 
                               type="search"
                               placeholder="Enter pet name"
                               aria-label="Search"
                               name="keyword"
                               value="${requestScope.findKeyWord}">
                        <button class="btn btn-outline-success my-2 my-sm-0 ml-sm-0" type="submit">Search</button>
                    </form>
                </nav>
            </div>

        </c:if>

    </div>
    <!-- Thanh phân cách (hr) đặt ở giữa và chiếm toàn bộ chiều rộng của row -->
    <div class="row">
        <div class="col-12">
            <hr>
        </div>
    </div>
    <div class="row">
        <!-- Sử dụng forEach để lặp qua danh sách pet -->
        <c:forEach items="${listOfPets}" var="pet" varStatus="status">
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
                                <span>${pet.name}</span>
                                <img src="${pet.image}" alt="Pet image" style="width: 50px; height: 50px; border-radius: 50%;" class="ml-2">
                            </h5>
                            <p class="card-text">Loại: ${pet.typeId == 1 ? "Chó":"Mèo"}</p>
                            <p class="card-text">Giống: ${pet.breed}</p>
                            <p class="card-text">Cân nặng: ${pet.weight} kg</p>
                            <i class="fa fa-edit fa-2x"
                               style="color: #469408"
                               data-toggle="modal"
                               data-target="#editPetModal"
                               onclick="editPetModal(${pet.petId},
                               ${pet.userId.userId},
                                               '${pet.name}',
                                               '${pet.typeId}',
                                               '${pet.breed}',
                               ${pet.weight},
                                               '${pet.image}')">
                            </i>
                            <!--Delete-->
                            <i class="fa fa-trash fa-2x"
                               style="color: #e70808"
                               data-toggle="modal"
                               data-target="#delete-modal"
                               onclick="deletePetModal(${pet.petId})">
                            </i>
                            <i class="fa fa-history fa-2x"
                               style="color: rgb(30 48 80)"
                               onclick="submitFormHistory('${pet.petId}')"> 
                            </i>
                            <form action="dashboard?action=history" method="POST" id="formHistory${pet.petId}">
                                <input type="hidden" name="petIdHis" value="${pet.petId}" >
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script type="text/javascript">
    function submitFormHistory(petId) {
        document.getElementById('formHistory' + petId).submit();
    }
</script>