<%@page import="com.apethotel.dao.StatusDAO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .fa-2x {
        font-size: 40px;
    }
    .status-unconfirm {
        background-color: #1e90ff; /* Màu xanh biển */
        color: white;
    }

    .status-confirm {
        background-color: #ffdb58; /* Màu vàng */
        color: black;
    }

    .status-progress {
        background-color: #00ff00; /* Màu xanh lá */
        color: black;
    }

    .status-cancel {
        background-color: #ff0000; /* Màu đỏ */
        color: white;
    }

    .status-complete {
        background-color: #808080; /* Màu xám */
        color: white;
    }

    .status-button {
        border: none;
        padding: 5px 10px;
        cursor: pointer;
        border-radius: 5px;
    }

</style>
<div class="card mb-3">
    <c:if test="${listBookings != null && listBookings.size() >0 }" >
        <div class="card-header">
            <i class="fas fa-table"></i>
            Table booking list
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Booking Id</th>
                            <th>User Name</th>
                            <th>Pet Name</th>
                            <th>Cage ID</th>
                            <th>Date Booking</th>
                            <th>Date Start</th>
                            <th>Date End</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th>Image</th>
                            <th>Action</th>

                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th>Booking Id</th>
                            <th>User Name</th>
                            <th>Pet Name</th>
                            <th>Cage ID</th>
                            <th>Date Booking</th>
                            <th>Date Start</th>
                            <th>Date End</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th>Image</th>
                            <th>Action</th>

                        </tr>
                    </tfoot>
                    <tbody>
                        <c:forEach items="${listBookings}" var= "book">
                            <fmt:formatDate value="${book.startDate}" pattern="yyyy-MM-dd" var="formattedStartDate"/>
                            <fmt:formatDate value="${book.bookingDate}" pattern="yyyy-MM-dd" var="formattedBookingDate"/>
                            <fmt:formatDate value="${book.endDate}" pattern="yyyy-MM-dd" var="formattedEndDate"/>
                            <tr>
                                <!--Name-->
                                <td>${book.bookingId}</td>
                                <!--User name-->
                                <td>${book.pet.userId.name}</td>
                                <!--Pet name-->
                                <td>${book.pet.name}</td>
                                <!--Cage Id-->
                                <td>${book.cageId}</td>
                                <!--Date Booking-->
                                <td>${formattedBookingDate}</td>
                                <!--Date Start-->
                                <td>${formattedStartDate}</td>
                                <!--Date End-->
                                <td>${formattedEndDate}</td>
                                <!--Date Price-->
                                <td>${book.totalCost}</td>
                                <!--Date status-->

                                <td>

                                    <form action="dashboard?action=changeStatus" method="post">
                                        <input type="hidden" name="bookingId" value="${book.bookingId}"/> 
                                        <input type="hidden" name="cageId" value="${book.cageId}"/>
                                        <!--  cần ID của booking để xử lý -->
                                        <button type="submit" class="status-button 
                                                ${book.idStatus == 1 ? 'status-unconfirm' : 
                                                  book.idStatus == 2 ? 'status-confirm' :
                                                  book.idStatus == 3 ? 'status-progress' :
                                                  book.idStatus == 5 ? 'status-cancel' :
                                                  book.idStatus == 4 ? 'status-complete' : ''}"
                                                  ${book.idStatus == 4 || book.idStatus == 5 ? 'disabled' : ''}>
                                                    ${sDAO.findStatusByIdStatus(book.idStatus).nameStatus}
                                                </button>
                                        </form>
                                        <br>
                                        <c:if test="${book.idStatus == 1}">
                                            <button class="contact-button btn btn-danger" 
                                                    data-toggle="modal" 
                                                    data-target="#calendarModal"
                                                    data-busydates='${busyDatesMap[book.cageId]}'
                                                    onclick="BusydateFromAttribute(this.getAttribute('data-busydates'),${book.cageId})"
                                                    >Xem lịch trống</button>
                                        </c:if>

                                    </td>

                                    <!--Image-->
                                    <td>
                                        <img  width="100px"
                                              height="100px"
                                              src="${book.petImage}" 
                                              alt="${book.petImage}" class="card-img-top">
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${sDAO.findStatusByIdStatus(book.idStatus).nameStatus != 'cancel' && sDAO.findStatusByIdStatus(book.idStatus).nameStatus != 'complete'}">
                                                <!-- Nếu trạng thái không phải là "cancel" và 'complete', hiển thị biểu tượng Edit và Delete -->
                                                <!-- Edit -->
                                                <!--Edit-->

                                                <i class="fa fa-tools fa-2x"
                                                   style="color: #469408"
                                                   data-toggle="modal"
                                                   data-target="#editBookModal"
                                                   onclick="editBookModal(${book.bookingId},
                                                                   '${book.pet.userId.name}',
                                                                   '${book.pet.name}',
                                                                   '${book.cageId}',
                                                                   '${book.startDate}',
                                                                   '${book.endDate}',
                                                                   '${book.totalCost}',
                                                                   '${sDAO.findStatusByIdStatus(book.idStatus).nameStatus}',
                                                                   '${book.petImage}')">
                                                </i>
                                                &nbsp;&nbsp;&nbsp;
                                                <!--Delete-->
                                                <i class="fa fa-trash fa-2x"
                                                   style="color: #e70808"
                                                   data-toggle="modal"
                                                   data-target="#delete-modal"
                                                   onclick="deleteBookModal(${book.bookingId})">
                                                </i>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Nếu trạng thái là "cancel", không hiển thị biểu tượng hoặc làm cho chúng không thể click -->
                                                <!-- Bạn có thể để trống hoặc hiển thị thông tin phù hợp tại đây -->
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
    </div>
