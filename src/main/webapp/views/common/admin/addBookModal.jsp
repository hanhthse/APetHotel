<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="addBookModal" tabindex="-1" role="dialog" aria-labelledby="addBookModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addBookModalLabel">Add Booking</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addBookForm" action="mainControllers?action=dashboard&action1=add" method="POST" enctype="multipart/form-data">
                    <!-- Pet Name Dropdown -->
                    <div class="form-group">
                        <label for="petName">Pet Name</label>
                        <select class="form-control" id="petName" name="petId" onchange="filterCages()">
                            <c:forEach items="${sessionScope.listOfPets}" var="pet">
                                <option value="${pet.petId}" data-typeid="${pet.typeId}" data-weight="${pet.weight}">${pet.name}</option>
                            </c:forEach>
                        </select>
                    </div>


                    <!-- Cage Dropdown -->
                    <select class="form-control" id="cage" name="cageId" onchange="updatePrice()">
                        <c:forEach items="${sessionScope.listCages}" var="cage">
                            <option value="${cage.cageID}" data-typeid="${cage.typeId}" data-priceperday="${cage.pricePerDay}" class="cage-option ${cage.size}">${cage.description}</option>
                        </c:forEach>
                    </select>


                    <!-- Date Start -->
                    <div class="form-group">
                        <label for="startDateEditInput">Ngày Bắt Đầu:</label>
                        <input type="date" class="form-control" id="startDateEditInput" name="datestart">
                        <div id="startDateError" class="error" style="color: red"></div> 
                    </div>
                    <!-- Date End -->
                    <div class="form-group">
                        <label for="endDateEditInput">Ngày Kết Thúc:</label>
                        <input type="date" class="form-control" id="endDateEditInput" name="dateend">
                        <div id="endDateError" class="error" style="color: red"></div>
                    </div>

                    <!--Price-->
                    <div class="form-group">
                        <label for="price">Price</label>
                        <input type="text" class="form-control" id="priceInput" name="price" readonly="  ">
                        <div id="quantityError" class="error"></div>
                    </div>

                    <!--note khack hang-->
                    <div class="form-group">
                        <label for="description">Customer Note: </label>
                        <textarea class="form-control" name="customerNote"></textarea>
                    </div>
                </form>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-primary" form="addBookForm" onclick="validateFormAddBook()">Add</button>
            </div>
        </div>
    </div>
</div>

<script>
    function validateFormAddBook() {
        // Xoá thông báo lỗi hiện tại
        $('.error').html('');

        let hasError = false;

        // Lấy giá trị từ input
        let startDate = $('#startDateEditInput').val();
        let endDate = $('#endDateEditInput').val();
        let today = new Date();
        today.setHours(0, 0, 0, 0); // Chỉnh sửa để chỉ so sánh ngày không tính giờ

        let startDateObj = new Date(startDate);
        let endDateObj = new Date(endDate);

        // Kiểm tra ngày bắt đầu
        if (startDate === '') {
            $('#startDateError').html('Ngày bắt đầu không được để trống');
            hasError = true;
        } else if (startDateObj < today) {
            $('#startDateError').html('Ngày bắt đầu không được trước ngày hôm nay');
            hasError = true;
        }

        // Kiểm tra ngày kết thúc
        if (endDate === '') {
            $('#endDateError').html('Ngày kết thúc không được để trống');
            hasError = true;
        } else if (endDateObj <= startDateObj) {
            $('#endDateError').html('Ngày kết thúc phải sau ngày bắt đầu và không được trùng');
            hasError = true;
        }

        // Nếu không có lỗi thì submit form
        if (!hasError) {
            $('#addBookForm').submit();
        } else {
            event.preventDefault(); // Ngăn không cho form submit nếu có lỗi
        }
    }



    function filterCages() {
        //lấy toàn bộ select từ id là petName
        var petSelect = document.getElementById('petName');
        //lấy ra được pet đã select
        var selectedPet = petSelect.options[petSelect.selectedIndex];
        //lấy được type của pet đã select
        var selectedType = selectedPet.getAttribute('data-typeid');
        var selectedWeight = parseFloat(selectedPet.getAttribute('data-weight'));
        //lấy tất cả các option của select có id là cage
        var cageOptions = document.querySelectorAll('.cage-option');
        //duyệt qua từng phần tử của select bằng var là option và thực hiện function vs từng option
        cageOptions.forEach(function (option) {
            //lấy về giá trị data-typeid
            var optionType = option.getAttribute('data-typeid');
            // so sánh giá trị với giá trị với type của pet đc select
            var isTypeMatch = optionType === selectedType;
            // so sánh các giá trị classlist từ class="cage-option ${cage.size}" để so sánh
            var isSizeAllowed = isCageSizeAllowed(option.classList, selectedWeight);
            if (isTypeMatch && isSizeAllowed) {
                option.style.display = '';
            } else {
                option.style.display = 'none';
            }
        });
    }

    function isCageSizeAllowed(classList, weight) {
        if (weight < 3)
            return true; // Tất cả các lồng đều được chọn
        if (weight > 5 && classList.contains('Nhỏ'))
            return false;
        if (weight > 7 && classList.contains('Trung bình'))
            return false;
        if (weight > 10 && classList.contains('Lớn'))
            return false;
        if (weight > 15 && classList.contains('Rất lớn'))
            return false;
        if (weight > 20 && !classList.contains('Cực lớn'))
            return false;
        return true;
    }

    function updatePrice() {
        var cageSelect = document.getElementById('cage');
        var selectedCage = cageSelect.options[cageSelect.selectedIndex];
        var pricePerDay = selectedCage.getAttribute('data-priceperday');
        var startDate = document.getElementById('startDateEditInput').value;
        var endDate = document.getElementById('endDateEditInput').value;
        if (startDate && endDate) {
            var start = new Date(startDate);
            var end = new Date(endDate);
            var diffTime = Math.abs(end - start);
            var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
            var totalPrice = diffDays * pricePerDay;
            document.getElementById('priceInput').value = totalPrice.toFixed(0);
        } else {
            document.getElementById('priceInput').value = pricePerDay; // Default to price per day if dates are not selected
        }
    }

    // Add event listeners to date inputs to update the price when dates are changed
    document.getElementById('startDateEditInput').addEventListener('change', updatePrice);
    document.getElementById('endDateEditInput').addEventListener('change', updatePrice);


</script>


