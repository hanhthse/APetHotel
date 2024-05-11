<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal fade" id="editBookModal" tabindex="-1" role="dialog" aria-labelledby="editBookModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editBookModalLabel">Chỉnh Sửa Đặt Phòng</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editBookForm" action="dashboard?action=editBooking" method="POST" enctype="multipart/form-data">
                    <div class="modal-body">
                        <input type="hidden" class="form-control" id="idEditInput" name="bookingId">

                        <!-- User Name -->
                        <div class="form-group">
                            <label for="userNameEditInput">Tên Người Dùng:</label>
                            <input type="text" class="form-control" id="userNameEditInput" name="uName" readonly>
                        </div>

                        <!-- Pet Name -->
                        <div class="form-group">
                            <label for="petNameEditInput">Tên Thú Cưng:</label>
                            <input type="text" class="form-control" id="petNameEditInput" name="pName" readonly>
                        </div>

<!--                         Cage ID 
                        <div class="form-group">
                            <label for="cageIdEditInput">Mã Lồng:</label>
                            <input type="number" class="form-control" id="cageIdEditInput" name="cageId">
                        </div>-->
                        <select class="form-control" id="cage" name="cageId">
                            <option value="" selected disabled hidden>Mã Lồng:</option>
                            <c:forEach items="${sessionScope.listCages}" var="cage">
                                <option value="${cage.cageID}" data-typeid="${cage.typeId}" data-priceperday="${cage.pricePerDay}" class="cage-option ${cage.size}">${cage.cageID}</option>
                            </c:forEach>
                        </select>
                        <!-- Date Start -->
                        <div class="form-group">
                            <label for="startDateEditInput">Ngày Bắt Đầu:</label>
                            <input type="date" class="form-control" id="startDateEditInput2" name="startDate">
                        </div>

                        <!-- Date End -->
                        <div class="form-group">
                            <label for="endDateEditInput">Ngày Kết Thúc:</label>
                            <input type="date" class="form-control" id="endDateEditInput2" name="endDate">
                        </div>

                        <!-- Price -->
                        <div class="form-group">
                            <label for="totalCostEditInput">Giá:</label>
                            <input type="number" class="form-control" id="totalCostEditInput" name="totalCost" readonly>
                        </div>

                        <!-- Status -->
                        <div class="form-group">
                            <label for="statusEditInput">Trạng Thái:</label>
                            <select class="form-control" id="statusEditInput" name="status">
                                <option value="unconfirm">Chưa Xác Nhận</option>
                                <option value="confirm">Đã Xác Nhận</option>
                                <option value="progress">Đang Tiến Hành</option>
                                <option value="cancel">Đã Hủy</option>
                                <option value="complete">Hoàn Thành</option>
                            </select>
                        </div>

                        <!--Image-->
                        <div class="form-group">
                            <label for="image">Image: </label>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">Upload</span>
                                </div>
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="imageEdit" name="image"
                                           onchange="displayImage2(this)">
                                    <label class="custom-file-label">Choose file</label>
                                </div>
                            </div>
                            <img id="previewImage2" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="Preview"
                                 style="display: none; max-width: 300px; max-height: 300px;">
                            <input type="hidden" id="currentImage" name="currentImage" value="">
                        </div>
                    </div>

                </form> 
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                    <button type="submit" form="editBookForm" class="btn btn-primary">Cập Nhật</button>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    // JavaScript để cập nhật các trường input dựa trên dữ liệu được truyền vào từ nút chỉnh sửa
    function editBookModal(bookingId, userName, petName, cageId, startDate, endDate, totalCost, status, image) {
        var startDateFormatted = new Date(startDate).toISOString().split('T')[0];
        var endDateFormatted = new Date(endDate).toISOString().split('T')[0];
        console.log(bookingId, userName, petName, cageId, startDateFormatted, endDateFormatted, totalCost, status, image);
        $('#idEditInput').val(bookingId);
        $('#userNameEditInput').val(userName);
        $('#petNameEditInput').val(petName);
        $('#cageIdEditInput').val(cageId);
        $('#startDateEditInput2').val(startDateFormatted);
        $('#endDateEditInput2').val(endDateFormatted);
        $('#totalCostEditInput').val(totalCost);
        $('#statusEditInput').val(status);
        $('#currentImage').val(image);
        $('#previewImage2').attr('src', image).show();
    }
    function displayImage2(input) {
        var previewImage = document.getElementById("previewImage2");
        var file = input.files[0];
        var reader = new FileReader();

        reader.onload = function (e) {
            previewImage.src = e.target.result;
            previewImage.style.display = "block";
        }

        reader.readAsDataURL(file);
    }

</script>
