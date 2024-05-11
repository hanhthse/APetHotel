<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <div class="card-header">
        <i class="fas fa-table"></i>
        Your booking list
    </div>
    <jsp:include page="feedbackModal.jsp"></jsp:include>

        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
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
                    <c:forEach items="${listHistory}" var= "book">
                        <fmt:formatDate value="${book.startDate}" pattern="yyyy-MM-dd" var="formattedStartDate"/>
                        <fmt:formatDate value="${book.bookingDate}" pattern="yyyy-MM-dd" var="formattedBookingDate"/>
                        <fmt:formatDate value="${book.endDate}" pattern="yyyy-MM-dd" var="formattedEndDate"/>
                        <tr>
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
                                <button class="status-button 
                                        ${book.idStatus == 1 ? 'status-unconfirm' : 
                                          book.idStatus == 2 ? 'status-confirm' :
                                          book.idStatus == 3 ? 'status-progress' :
                                          book.idStatus == 5 ? 'status-cancel' :
                                          book.idStatus == 4 ? 'status-complete' : ''}"
                                          ${book.idStatus == 4 || book.idStatus == 5 ? 'disabled' : ''}>
                                            ${sDAO.findStatusByIdStatus(book.idStatus).nameStatus}
                                        </button>
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
                                        <c:when test="${book.idStatus == 1}">
                                            <!--Chỉ uncomfirm mới đc hủy--> 
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
                                            <c:if test="${book.idStatus == 4 && feedDAO.checkValid(book.bookingId)}">
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-id="${book.bookingId}" data-target="#feedbackModal">
                                                    Feedback
                                                </button>
                                            </c:if>
                                            <c:if test="${book.idStatus == 4 && !feedDAO.checkValid(book.bookingId)}">
                                                <button type="button" class="btn btn-secondary">
                                                    Feedback
                                                </button>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
