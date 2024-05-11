
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade" id="calendarModal" tabindex="-1" aria-labelledby="calendarModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h2 type="text" class="modal-title" id="calendarModalLabel"></h2>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="wrapper">
                    <header>
                        <p class="current-date"></p>
                        <div class="icons">
                            <span id="prev" class="material-symbols-rounded">chevron_left</span>
                            <span id="next" class="material-symbols-rounded">chevron_right</span>
                        </div>
                    </header>
                    <div class="calendar">
                        <ul class="weeks">
                            <li>Sun</li>
                            <li>Mon</li>
                            <li>Tue</li>
                            <li>Wed</li>
                            <li>Thu</li>
                            <li>Fri</li>
                            <li>Sat</li>
                        </ul>
                        <ul class="days"></ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var specialDates = []; // Khởi tạo mảng rỗng
    var date = new Date(); // Biến toàn cục để lưu trữ ngày hiện tại
    var currYear = date.getFullYear(); // Lưu trữ năm hiện tại
    var currMonth = date.getMonth(); // Lưu trữ tháng hiện tại
    // Hàm cập nhật specialDates và tái tạo lịch
    function BusydateFromAttribute(busyDatesString, cageID) {
        $('#calendarModalLabel').text("Thời gian của lồng số "+cageID);
        try {
            specialDates = JSON.parse(busyDatesString);
            console.log("Các ngày bận:", specialDates);
            renderCalendar(); // Gọi hàm để cập nhật lịch
        } catch (error) {
            console.error("Lỗi khi parse JSON:", error);
        }
    }

    // Hàm vẽ lịch dựa trên specialDates
    function renderCalendar() {
        const daysTag = document.querySelector(".days"),
                currentDate = document.querySelector(".current-date"),
                prevNextIcon = document.querySelectorAll(".icons span");
        const months = [
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
        ];
        daysTag.innerHTML = ""; // Xóa các ngày hiện tại
        let firstDayOfMonth = new Date(currYear, currMonth, 1).getDay(),
                lastDateOfMonth = new Date(currYear, currMonth + 1, 0).getDate(),
                lastDayOfMonth = new Date(currYear, currMonth, lastDateOfMonth).getDay(),
                lastDateOfLastMonth = new Date(currYear, currMonth, 0).getDate();
        let liTag = "";

        // Tạo các ngày không hoạt động và ngày hoạt động
        for (let i = firstDayOfMonth; i > 0; i--) {
            liTag += '<li class="inactive">' + (lastDateOfLastMonth - i + 1) + '</li>';
        }

        for (let i = 1; i <= lastDateOfMonth; i++) {
            let fullDate = currYear + '-' +
                    ('0' + (currMonth + 1)).slice(-2) + '-' +
                    ('0' + i).slice(-2);
            let isToday = i === new Date().getDate() && currMonth === new Date().getMonth() && currYear === new Date().getFullYear() ? "active" : "";
            let isSpecialDay = specialDates.includes(fullDate) ? "special-day" : "";
            liTag += '<li class="' + (isToday + ' ' + isSpecialDay).trim() + '">' + i + '</li>';
        }

        for (let i = 1; i < 7 - lastDayOfMonth; i++) {
            liTag += '<li class="inactive">' + i + '</li>';
        }
        daysTag.innerHTML = liTag;
        currentDate.textContent = months[currMonth] + ' ' + currYear;
    }

    // Cài đặt sự kiện cho nút điều hướng tháng
    document.addEventListener('DOMContentLoaded', function () {
        const prevNextIcon = document.querySelectorAll(".icons span");
        prevNextIcon.forEach(icon => {
            icon.addEventListener("click", function () {
                if (this.id === "prev")
                    currMonth -= 1;
                else
                    currMonth += 1;
                if (currMonth < 0 || currMonth > 11) {
                    date.setMonth(currMonth);
                    currYear = date.getFullYear();
                    currMonth = date.getMonth();
                }
                renderCalendar();
            });
        });
        renderCalendar(); // Gọi hàm khi trang tải xong để hiển thị lịch
    });
</script>





