<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .fa-2x {
        font-size: 40px;
    }
    .role-admin {
        background-color: #ffdb58; /* Màu vàng */
        color: black;
    }

    .role-user {
        background-color: #1e90ff; /* Màu xanh */
        color: white;
    }

    .role-block {
        background-color: #ff0000; /* Màu đỏ */
        color: white;
    }

    .role-button {
        border: none;
        padding: 5px 10px;
        cursor: pointer;
        border-radius: 5px;
    }
    .action{
        border: none;
        background-color: white;
    }
</style>
<div class="card mb-3">
    <div class="card-header">
        <i class="fas fa-table"></i>
        ManagerAccount
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>ID User</th>
                        <th>User Name</th>
                        <th>Email</th>
                        <th>Pass word</th>
                        <th>Phone Number</th>
                        <th>Role</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th>ID User</th>
                        <th>User Name</th>
                        <th>Email</th>
                        <th>Pass word</th>
                        <th>Phone Number</th>
                        <th>Role</th>
                        <th>Action</th>
                    </tr>
                </tfoot>
                <tbody>
                    <c:forEach items="${listUser}" var="user">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.name}</td>
                            <td>${user.email}</td>
                            <td>${user.password}</td>
                            <td>${user.phoneNumber}</td>
                            <td>

                                <form action="dashboard?action=changeRole" method="post">
                                    <input type="hidden" name="useridForRole" value="${user.userId}"/> <!-- Giả sử bạn cần ID của user để xử lý -->
                                    <button type="submit" class="role-button 
                                            ${user.roleId == 1 ? 'role-admin' : 
                                              user.roleId == 2 ? 'role-user' :
                                              'role-block'}" ${user.roleId == 1 ? 'disabled' : ''} onclick="myFunction1(${user.roleId})">
                                                ${user.roleId == 1 ? 'Admin' : 
                                                  user.roleId == 2 ? 'User' :
                                                  'Blocked'}
                                            </button>
                                    </form>
                                </td>
                                <td>
                                    <span>
                                        <form action="dashboard?action=historyUser" method="POST" style="display: inline;">
                                            <input name="useridHis" value="${user.userId}" type="hidden">
                                            <button type="submit" class="fa fa-history fa-2x action" ></button>
                                        </form>
                                    </span>
                                    <c:if test="${user.roleId != 1}">
                                        <span>
                                            <form action="dashboard?action=deleteUser" method="POST" style="display: inline;">
                                                <input name="useridHis" value="${user.userId}" type="hidden">
                                                <button type="submit" class="fa fa-trash fa-2x action" style="color: #e70808" onclick="myFunction()"></button>
                                            </form>
                                        </span>
                                    </c:if>
                                    <span >
                                        <form action="dashboard?action=changeAdmin" method="POST" style="display: inline;">
                                            <input name="useridHis" value="${user.userId}" type="hidden">
                                            <c:if test="${user.roleId == 1 && sessionScope.account.userId != user.userId }">
                                                <button type="submit" class="fa fa-toggle-on fa-2x action" style="color: #168916"></button> 
                                            </c:if>
                                            <c:if test="${user.roleId == 2}">
                                                <button type="submit" class="fa fa-toggle-off fa-2x action" style="color: red"></button>
                                            </c:if>
                                        </form>
                                    </span>                                            
                                    <span>
                                        <form action="dashboard?action=viewPetByUser" method="POST" style="display: inline;">
                                            <input name="useridHis" value="${user.userId}" type="hidden">
                                            <input name="userNameHis" value="${user.name}" type="hidden">
                                            <button type="submit" class="fa fa-search-plus fa-2x action" style="color: #168916" ></button>
                                        </form>
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        function myFunction() {
            var result = confirm("Are you sure want delete this account?");
            if (!result) {
                // Ngăn chặn form được submit nếu người dùng chọn 'Cancel' trong hộp thoại confirm
                event.preventDefault();
            }
        }
        function myFunction1(roleId) {
            var message = roleId == 2 ? "Are you sure you want to block this account?" : "Are you sure you want to unblock this account?";

            var result = confirm(message);
            if (!result) {
                // Ngăn chặn form được submit nếu người dùng chọn 'Cancel' trong hộp thoại confirm
                event.preventDefault();
            }
        }

    </script>