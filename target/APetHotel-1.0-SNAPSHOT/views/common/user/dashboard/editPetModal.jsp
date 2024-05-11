<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="editPetModal" tabindex="-1" role="dialog" aria-labelledby="editPetModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editPetModalLabel">Edit Pet</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editPetForm" action="mainControllers?action=dashboard&action1=edit" method="POST" enctype="multipart/form-data">
                    <input type="hidden" id="petIdInput" name="petId">
                    <input type="hidden" id="userIdInput" name="userId">
                    <!--Name-->
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" class="form-control" id="petnameInput" name="name">
                        <div id="petnameError" class="error" style="color: red"></div>
                    </div>
                    <!--Type-->
                    <div class="form-group">
                        <label for="typeSelect">Type:</label>
                        <select class="form-control" id="typeSelect" name="type">
                            <c:forEach var="type" items="${sessionScope.listType}">
                                <option value="${type.typeId}">${type.typeName}</option>
                            </c:forEach>
                        </select>
                        <div id="typeError" class="error" style="color: red"></div>
                    </div>
                    <!--Breed-->
                    <div class="form-group">
                        <label for="breed">Breed:</label>
                        <input type="text" class="form-control" id="petbreedInput" name="breed">
                        <div id="petbreedError" class="error" style="color: red"></div>
                    </div>
                    <!--Weight-->
                    <div class="form-group">
                        <label for="weight">Weight:</label>
                        <input type="text" class="form-control" id="petweightInput" name="weight">
                        <div id="petweightError" class="error" style="color: red"></div>
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
                        <input type="hidden" id="currentImage2" name="currentImage2">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="validateForm()">Update</button>
            </div>
        </div>
    </div>
</div>

<script>
    function validateForm() {
        let hasError = false; // Biến kiểm tra xem có lỗi không
        let name = $('#petnameInput').val();
        let type = $('#typeSelect').val();
        let breed = $('#petbreedInput').val();
        let weight = $('#petweightInput').val();

        // Xoá thông báo lỗi hiện tại
        $('.error').html('');

        // Kiểm tra trường Tên
        if (name.trim() === '') {
            $('#petnameError').html('Tên thú cưng không được để trống');
            hasError = true; // Cập nhật trạng thái lỗi
        }

        // Kiểm tra trường Loại
        if (type.trim() === '') {
            $('#pettypeError').html('Loại thú cưng không được để trống');
            hasError = true;
        }

        // Kiểm tra trường Giống
        if (breed.trim() === '') {
            $('#petbreedError').html('Giống thú cưng không được để trống');
            hasError = true;
        }

        // Kiểm tra trường Cân nặng
        if (weight.trim() === '') {
            $('#petweightError').html('Cân nặng không được để trống');
            hasError = true;
        } else if (!$.isNumeric(weight) || parseFloat(weight) <= 0) {
            $('#petweightError').html('Cân nặng phải là số và lớn hơn 0');
            hasError = true;
        }

        // Nếu không có lỗi, submit form
        if (!hasError) {
            $('#editPetForm').submit(); // Đảm bảo sử dụng đúng ID của form
        } else {
            event.preventDefault(); // Ngăn không cho form submit nếu có lỗi
        }
    }




    function editPetModal(petId, userId, name, typeId, breed, weight, image) {
       
        $('#petIdInput').val(petId);
        $('#userIdInput').val(userId);
        $('#petnameInput').val(name);

        // Cập nhật giá trị cho dropdown menu và đặt giá trị được chọn
        $('#typeSelect').val(typeId);

        $('#petbreedInput').val(breed);
        $('#petweightInput').val(weight);
        $('#previewImage2').attr('src', image).show(); // Hiển thị hình ảnh nếu đã có

        // Đảm bảo rằng option tương ứng được chọn
        $('#typeSelect option').each(function () {
            if ($(this).val() == typeId) {
                $(this).prop('selected', true);
            }
        });
        // Cập nhật giá trị cho currentImage
        $('#currentImage2').val(image);
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


