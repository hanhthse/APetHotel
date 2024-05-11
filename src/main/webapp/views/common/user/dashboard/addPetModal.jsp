<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="addPetModal" tabindex="-1" role="dialog" aria-labelledby="addPetModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addPetModalLabel">Add Pet</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addPetForm" action="mainControllers?action=dashboard&action1=addpet" method="POST" enctype="multipart/form-data">
                    <!--Name-->
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" class="form-control" id="nameInput" name="name">
                        <div id="nameError" class="error" style="color: red"></div>
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
                        <input type="text" class="form-control" id="breedInput" name="breed">
                        <div id="breedError" class="error" style="color: red"></div>
                    </div>
                    <!--Weight-->
                    <div class="form-group">
                        <label for="weight">Weight:</label>
                        <input type="text" class="form-control" id="weightInput" name="weight">
                        <div id="weightError" class="error" style="color: red"></div>
                    </div>
                    <!--Image-->
                    <div class="form-group">
                        <label for="image">Image: </label>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">Upload</span>
                            </div>
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="imageInput" name="image" onchange="displayImage(this)">
                                <label class="custom-file-label" for="image">Choose file</label>
                            </div>
                        </div>
                        <img id="previewImage" src="#" alt="Preview Image"
                             style="display: none; max-width: 300px; max-height: 300px;">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-primary" form="addPetForm" onclick="validateForm2()">Add</button>
            </div>
        </div>
    </div>
</div>

<script>
    function validateForm2() {
        let name = $('#nameInput').val();
        let type = $('#typeInput').val();
        let breed = $('#breedInput').val();
        let weight = $('#weightInput').val();

        // Xoá thông báo lỗi hiện tại
        $('.error').html('');

        // Kiểm tra trường Tên
        if (name === '') {
            $('#nameError').html('Tên thú cưng không được để trống');
        }

        // Kiểm tra trường Loại
        if (type === '') {
            $('#typeError').html('Loại thú cưng không được để trống');
        }

        // Kiểm tra trường Giống
        if (breed === '') {
            $('#breedError').html('Giống thú cưng không được để trống');
        }

        // Kiểm tra trường Cân nặng
        if (weight === '') {
            $('#weightError').html('Cân nặng không được để trống');
        } else if (!$.isNumeric(weight) || parseFloat(weight) <= 0) {
            $('#weightError').html('Cân nặng phải là số và lớn hơn 0');
        }

        // Kiểm tra nếu không có lỗi thì submit form
        let error = '';
        $('.error').each(function () {
            error += $(this).html();
        });
        if (error === '') {
            $('#addPetForm').submit();
        } else {
            event.preventDefault(); // Ngăn không cho form submit nếu có lỗi
        }
    }


    function displayImage(input) {
        var previewImage = document.getElementById("previewImage");
        var file = input.files[0];
        var reader = new FileReader();

        reader.onload = function (e) {
            previewImage.src = e.target.result;
            previewImage.style.display = "block";
        }

        reader.readAsDataURL(file);
    }


</script>


