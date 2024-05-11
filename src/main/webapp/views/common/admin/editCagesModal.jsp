<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="editCageModal" tabindex="-1" role="dialog" aria-labelledby="editCageModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editCageModalLabel">Edit Cages</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editCageForm" action="dashboard?action=editCage" method="POST" enctype="multipart/form-data">
                    <input type="hidden" class="form-control" id="cageIdInput2" name="cageID">
                    <!--Description-->
                    <div class="form-group">
                        <label for="description">Description</label>
                        <input type="text" class="form-control" id="descriptionInput2" name="description">
                        <div id="descriptionError2" class="error" style="color: red"></div>
                    </div>

                    <!--Size-->
                    <div class="form-group">
                        <label for="size">Size</label>
                        <input type="text" class="form-control" id="sizeInput2" name="size">
                        <div id="sizeError2" class="error" style="color: red"></div>
                    </div>
                    <!--PricePerDay-->
                    <div class="form-group">
                        <label for="pricePerDay">PricePerDay</label>
                        <input type="text" class="form-control" id="pricePerDayInput2" name="pricePerDay">
                        <div id="pricePerDayError2" class="error" style="color: red"></div>
                    </div>
                    <!--typeId-->
                    <div class="form-group">
                        <label for="typeSelect">Type:</label>
                        <select class="form-control" id="typeSelect2" name="type">
                            <c:forEach var="type" items="${sessionScope.listType}">
                                <option value="${type.typeId}">${type.typeName}</option>
                            </c:forEach>
                        </select>
                        <div id="typeIdError2" class="error" style="color: red"></div>
                    </div>
                    <!--Image-->
                    <div class="form-group">
                        <label for="image">Image: </label>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend"><span class="input-group-text">Upload</span>
                            </div>
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="imageEdit" name="image"
                                       onchange="displayImage2(this)">
                                <label class="custom-file-label">Choose file</label>
                            </div>
                        </div>
                        <img id="previewImage2" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="Preview"
                             style="display: none; max-width: 300px; max-height: 300px;">
                        <input type="hidden" id="currentImage2" name="currentImage2">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="validateForm1()">Update</button>
            </div>
        </div>
    </div>
</div>

<script>
    function validateForm1() {
        let hasError = false; // Biến kiểm tra xem có lỗi không
        let description = $('#descriptionInput2').val();
        let size = $('#sizeInput2').val();
        let pricePerDay = $('#pricePerDayInput2').val();
        let typeId = $('#typeSelect2').val();

        // Xoá thông báo lỗi hiện tại
        $('.error').html('');

        // Kiểm tra trường Mô tả
        if (description.trim() === '') {
            $('#descriptionError2').html('Mô tả không được để trống');
            hasError = true;
        }

        // Kiểm tra trường Kích thước
        if (size.trim() === '') {
            $('#sizeError2').html('Kích thước không được để trống');
            hasError = true;
        }

        // Kiểm tra trường Giá mỗi ngày
        if (pricePerDay.trim() === '') {
            $('#pricePerDayError2').html('Giá mỗi ngày không được để trống');
            hasError = true;
        } else if (!$.isNumeric(pricePerDay) || parseFloat(pricePerDay) <= 0) {
            $('#pricePerDayError2').html('Giá mỗi ngày phải là số và lớn hơn 0');
            hasError = true;
        }

        // Kiểm tra trường Loại
        if (typeId.trim() === '') {
            $('#typeIdError2').html('Loại không được để trống');
            hasError = true;
        }

        // Nếu không có lỗi, submit form
        if (!hasError) {
            $('#editCageForm').submit(); // Đảm bảo sử dụng đúng ID của form
        } else {
            event.preventDefault(); // Ngăn không cho form submit nếu có lỗi
        }

    }




    function editCageModal(cageID, description, size, pricePerDay, typeId, image) {//        console.log("Nằm ở EditPetModal: " + cageID, description, size, pricePerDay, typeId, image);

        // Đặt giá trị cho các trường input trong form
        $('#cageIdInput2').val(cageID);
        $('#descriptionInput2').val(description); // Sửa lại ID này cho đúng với ID trong form
        $('#sizeInput2').val(size);
        $('#pricePerDayInput2').val(pricePerDay);
        $('#typeSelect2').val(typeId); // Đảm bảo rằng giá trị typeId phù hợp với một trong các option

        // Cập nhật hình ảnh xem trước và đường dẫn hình ảnh hiện tại
        if (image) {
            $('#previewImage2').attr('src', image).show();
            $('#currentImage2').val(image);
            $('.custom-file-label').text(image.split('/').pop()); // Cập nhật tên file hiển thị
        } else {
            $('#previewImage2').hide(); // Ẩn hình ảnh xem trước nếu không có hình ảnh
            $('.custom-file-label').text('Choose file'); // Reset lại tên file
        }
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