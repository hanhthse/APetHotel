<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="addCagesModal" tabindex="-1" role="dialog" aria-labelledby="addCagesModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCagesModalLabel">Add Cage</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addCageForm" action="dashboard?action=addcages" method="POST" enctype="multipart/form-data">
                    <!--Cage Description-->
                    <div class="form-group">
                        <label for="description">Description:</label>
                        <input type="text" class="form-control" id="descriptionInput" name="description">
                        <div id="descriptionError" class="error" style="color: red"></div>
                    </div>
                    <!--Size-->
                    <div class="form-group">
                        <label for="size">Size:</label>
                        <input type="text" class="form-control" id="sizeInput" name="size">
                        <div id="sizeError" class="error" style="color: red"></div>
                    </div>
                    <!--Price Per Day-->
                    <div class="form-group">
                        <label for="pricePerDay">Price Per Day:</label>
                        <input type="text" class="form-control" id="pricePerDayInput" name="pricePerDay">
                        <div id="pricePerDayError" class="error" style="color: red"></div>
                    </div>
                    <!--Type ID-->
                    <div class="form-group">
                        <label for="typeSelect">Type:</label>
                        <select class="form-control" id="typeSelect" name="typeId">
                            <c:forEach var="type" items="${sessionScope.listType}">
                                <option value="${type.typeId}">${type.typeName}</option>
                            </c:forEach>
                        </select>
                        <div id="typeIdError" class="error" style="color: red"></div>
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
                        <img id="previewImage" src="#" alt="Preview Image" style="display: none; max-width: 300px; max-height: 300px;">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-primary" form="addCageForm" onclick="validateCageForm()">Add</button>
            </div>
        </div>
    </div>
</div>

<script>
    function validateCageForm() {
        let description = $('#descriptionInput').val();
        let size = $('#sizeInput').val();
        let pricePerDay = $('#pricePerDayInput').val();
        let typeId = $('#typeSelect').val();

        // Clear current error messages
        $('.error').html('');

        // Validate Description
        if (description === '') {
            $('#descriptionError').html('Description cannot be empty');
        }

        // Validate Size
        if (size === '') {
            $('#sizeError').html('Size cannot be empty');
        }

        // Validate Price Per Day
        if (pricePerDay === '') {
            $('#pricePerDayError').html('Price per day cannot be empty');
        } else if (!$.isNumeric(pricePerDay) || parseFloat(pricePerDay) <= 0) {
            $('#pricePerDayError').html('Price per day must be a positive number');
        }

        // Validate Type ID
        if (typeId === '') {
            $('#typeIdError').html('You must select a type');
        }

        // Check for any errors before form submission
        let error = '';
        $('.error').each(function () {
            error += $(this).html();
        });
        if (error === '') {
            $('#addCageForm').submit();
        } else {
            event.preventDefault(); // Prevent form submission if there are errors
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