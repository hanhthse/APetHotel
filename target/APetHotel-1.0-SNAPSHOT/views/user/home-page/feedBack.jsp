<%@page import="com.apethotel.dao.feedbackDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${listCages == null}">
    <c:redirect url="/home"></c:redirect>
</c:if>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>PET HOTEL</title>
        <!-- Bootstrap CDN -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />
        <!-- CSS stylesheet -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/calendar-style.css" />        
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
        <!-- Font Awesome -->
        <script src="https://kit.fontawesome.com/65d7426ab6.js" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Thêm vào đầu trang của bạn -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </head>
    <body>

        <!-- Navigation Bar -->
        <jsp:include page="../../common/user/naviFeed.jsp"></jsp:include>
            <div class="bg-light p-5">  
                <div class="card" >
                    <div class="card-body">
                        <section id="feedback-section">
                            <div class="container" >
                                <h2 class="text-center">Customer Feedback</h2>
                                <div id="feedback-container">
                                    <!-- Feedback entries will be inserted here -->

                                    <div id="feedback-container" class="feedback-background">
                                    <c:forEach var="feedback" items="${feedbackList}">
                                        <div class="feedback-entry">
                                            <div class="feedback-info">
                                                <!--cần xử lý userName bởi vì trong feedback chỉ có userID-->
                                                <img src="<%=request.getContextPath()%>/image/iconUser.jpg" alt="User Icon" class="feedback-img">
                                                <h3 class="user-name"><c:out value="${feedDAO.getUserNameByID(feedback.userId)}" /></h3>
                                                <h3 class="cage-info">Cage: <c:out value="${feedDAO.getCageIdByBookingId(feedback.bookingId)}" /></h3> 
                                                <div class="rating">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <span class="fa fa-star <c:if test="${i <= feedback.rating}">checked</c:if>"></span>
                                                    </c:forEach>
                                                </div>
                                                <p class="user-feedback">${feedback.comment}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>  

        <style>
            #feedback-section {
                padding: 40px 0;
            }
            .feedback-container {
                background-image: url('<%=request.getContextPath()%>/image/viewfeedBack.jpg'); /* Update with your actual image path */
                background-size: cover;
                background-repeat: no-repeat;
                background-position: center center;
                padding: 30px; /* Add some padding */
            }
            .feedback-entry {
                background: #fff; /* White background for the feedback entries */
                border-radius: 5px; /* Rounded corners for the feedback entries */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Add some shadow for depth */
                margin-bottom: 20px; /* Add some margin between entries */
                padding: 15px; /* Add padding inside the feedback entries */
                border: 1px solid #ddd; /* Optional: Add a border around the feedback entry */
            }
            .feedback-img {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                margin-right: 20px;
            }
            .cage-info {
                font-size: 1.2em; /* Nhỏ hơn so với .user-name */
                color: #666; /* Màu sắc tùy chọn */
                margin: 5px 0; /* Khoảng cách tùy chọn */
            }
            .feedback-background {
                background-image: url('<%=request.getContextPath()%>/image/viewfeedBack.jpg');
                background-size: cover;
                background-repeat: no-repeat;
                background-position: center center;
            }

            .feedback-info {
                flex-grow: 1;
            }
            .user-name {
                margin: 0;
            }
            .rating .fa {
                color: #7e7d75;
            }
            .rating .checked {
                color: orange;
            }
            .user-feedback {margin-top: 10px;
                            font-style: italic;
            }

        </style>





        <!-- Footer -->
        <jsp:include page="../../common/user/footer.jsp"></jsp:include>


        <jsp:include page="../../common/user/detailCageModal.jsp"></jsp:include>

    </body>
    <!-- Bootstrap Scripts -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
    crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
    crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
    crossorigin="anonymous"></script>

</html>