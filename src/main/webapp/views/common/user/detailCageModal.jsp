<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    /* CSS cho modal detail */
    #viewDetail .modal-content {
        background-color: #f9f9f9;
    }

    #viewDetail .modal-header, #viewDetail .modal-body, #viewDetail .modal-footer {
        padding: 20px;
    }

    #viewDetail .modal-title {
        margin: 0 auto;
    }

    #viewDetail img {
        max-width: 100%;
        height: auto;
    }

    #viewDetail .detail-item {
        margin-bottom: 10px;
    }

</style>
<!-- Modal Detail Structure -->
<div class="modal fade" id="viewDetail" tabindex="-1" aria-labelledby="viewDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="viewDetailModalLabel">Chi Tiết Chuồng</h2>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="wrapper">
                    <div class="detail-item"><strong>Lồng số:</strong> <span id="cageId"></span></div>
                    <div class="detail-item"><strong>Mô Tả:</strong> <span id="description"></span></div>
                    <div class="detail-item"><strong>Kích Thước:</strong> <span id="size"></span></div>
                    <div class="detail-item"><strong>Giá Mỗi Ngày:</strong> <span id="pricePerDay"></span></div>
                    <div class="detail-item"><strong>Loại:</strong> <span id="typeId"></span></div>
                    <img id="cageImage" src="" alt="Hình Ảnh Chuồng" />
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).on('click', '.viewDetail', function () {
        var cageId = $(this).attr('data-cageid');
        var description = $(this).attr('data-description');
        var size = $(this).attr('data-size');
        var pricePerDay = $(this).attr('data-priceperday');
        var typeId = $(this).attr('data-typeid');
        var image = $(this).attr('data-image');

        // Cập nhật thông tin vào modal
        $('#viewDetail #cageId').text(cageId);
        $('#viewDetail #description').text(description);
        $('#viewDetail #size').text(size);
        $('#viewDetail #pricePerDay').text(pricePerDay);
        $('#viewDetail #typeId').text(typeId);
        $('#viewDetail #cageImage').attr('src', image);

        // Hiển thị modal
        $('#viewDetail').modal('show');
    });

</script>





