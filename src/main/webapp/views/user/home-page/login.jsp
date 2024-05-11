<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <!-- Font Awesome CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .login-container {
                max-width: 400px;
                margin: 0 auto;
                margin-top: 100px;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                border-radius: 5px;
            }
            .login-container h2 {
                text-align: center;
                margin-bottom: 30px;
                color: #007bff;
            }
            .login-container .form-group {
                margin-bottom: 20px;
            }
            .login-container label {
                font-weight: bold;
                color: #333;
            }
            .login-container .btn {
                width: 100%;
                background-color: #007bff;
                border-color: #007bff;
            }
            .login-container .btn-link {
                background-color: transparent;
                color: #007bff;
                border-color: transparent;
            }
            .login-container .btn-link:hover {
                background-color: transparent;
                color: #0056b3;
                border-color: transparent;
                text-decoration: none;
            }

            .login-container {
                max-width: 400px;
                margin: 0 auto;
                margin-top: 100px;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                border-radius: 5px;
            }
            .form-control{
                background-color: rgba(255, 255, 255, 0.5);
            }
            .btn-primary {
                background-color: rgba(0, 123, 255, 0.5) !important; /* Màu ban đầu với độ trong suốt */
                transition: background-color 0.3s ease !important; /* Thêm hiệu ứng chuyển đổi mượt mà */
            }
            .btn-primary:hover {
                background-color: rgba(0, 0, 0, 0.5) !important; /* Thay đổi màu khi hover */
            }

        </style>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
    </head>
    <body id="backgroundCustom">
        <!-- Navigation Bar -->
        <jsp:include page="../../common/nofication.jsp"></jsp:include>
            <div class="container">
                <div class="login-container login">
                    <h2>Login</h2>
                <c:set var="cookie" value="${pageContext.request.cookies}"/>
                    <form action="mainControllers?action=login" method="POST">
                        <div class="form-group">
                            <label for="username">Email</label>
                            <input type="text" class="form-control" id="username" placeholder="Enter your username"
                                   name="email" value="${cookie.cuser.value}">
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="password" placeholder="Enter your password"
                                   name="password" value="${cookie.cpass.value}">
                        </div>
                        <div class="form-group">
                            <div style="color:red">${error}</div>
                    </div>
                    <input type="checkbox"  ${(cookie.crem != null ?'checked':'')} name="rem" value="ON"/> Remember Me <br/>
                    
                    <button type="submit" class="btn btn-primary btn-transparent">Login</button>
                    <div class="text-center mt-3 d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/mainControllers?action=registerPage" class="btn btn-link">Register</a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Footer -->
        <div class="dog">
        </div>
        <jsp:include page="../../common/user/footer.jsp"></jsp:include>

        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    </body>
</html>

