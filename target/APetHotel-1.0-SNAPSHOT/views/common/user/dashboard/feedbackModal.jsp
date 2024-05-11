<%-- 
    Document   : feedbackModal
    Created on : Mar 17, 2024, 8:10:25 PM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade" id="feedbackModal" tabindex="-1" role="dialog" aria-labelledby="feedbackModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="feedbackModalLabel">Customer Feedback</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Đây là nơi bạn thêm form để khách hàng điền feedback -->
                <form id="feedbackForm" method="POST" action="mainControllers?action=addFeedBack">
                    <input type="hidden" id="bookingIdField" name="bookingId" value="">
                    <label for="customerRating">Rating</label>
                    <select class="form-control" id="customerRating" name="customerRating">
                        <option value="1">1 Star</option>
                        <option value="2">2 Stars</option>
                        <option value="3">3 Stars</option>
                        <option value="4">4 Stars</option>
                        <option value="5" selected>5 Stars</option>
                    </select>
                    <div class="form-group">
                        <label for="customerFeedback">Feedback</label>
                        <textarea class="form-control" id="customerFeedback" name="customerFeedback" rows="3"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary" form="feedbackForm">Submit Feedback</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        $('#feedbackModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var bookingId = button.data('id'); // Extract info from data-* attributes

            // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
            var modal = $(this);
            modal.find('#bookingIdField').val(bookingId);
        });
    });
</script>