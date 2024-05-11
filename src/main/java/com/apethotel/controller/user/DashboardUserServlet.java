/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apethotel.controller.user;

import com.apethotel.dao.BookingsDAO;
import com.apethotel.dao.CagesDAO2;
import com.apethotel.dao.PetDAO;
import com.apethotel.dao.StatusDAO;
import com.apethotel.dao.UsersDAO2;
import com.apethotel.dao.feedbackDAO;
import com.apethotel.entity.Bookings;
import com.apethotel.entity.Cages;
import com.apethotel.entity.Pet;
import com.apethotel.entity.Users;
import com.bookstore.Constant.Constant;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Acer
 */
@MultipartConfig
public class DashboardUserServlet extends HttpServlet {

    UsersDAO2 userDAO = new UsersDAO2();
    PetDAO petDAO = new PetDAO();
    CagesDAO2 cagesDAO2 = new CagesDAO2();
    BookingsDAO bDAO = new BookingsDAO();
    PetService petSer = new PetService();
    StatusDAO sDAO = new StatusDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //set encoding UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        HttpSession session = request.getSession();
        petSer.loadTypePet(request, response, session);
        //Lấy về đc list pet và gắn vào session
        // Lấy về cages và set vào session
        List<Cages> listCages = cagesDAO2.findAllCagesTrue();
        session.setAttribute("listCages", listCages);

        //get ve session user hiện tại để lấy userid
        Users UserSession = (Users) session.getAttribute(Constant.SESSION_ACCOUNT);

        ArrayList<Pet> listPet = new ArrayList<>();
        listPet = petDAO.findPetByUserId(UserSession.getUserId(), true);
        session.setAttribute("listOfPets", listPet);

        //lấy đc tất cả các booking đã thực hiện nhờ vào userid
        //lấy đc list pet từ userid
        //lấy đc list booking từng pet rồi add lại
        List<Bookings> listBooking = new ArrayList<>();
        for (Bookings b : bDAO.findAll()) {
            if (b.getPet().getUserId().getUserId() == UserSession.getUserId()) {
                listBooking.add(b);
            }
        }

        session.setAttribute("sDAO", sDAO);
        session.setAttribute("listHistory", listBooking);

        feedbackDAO feedDAO = new feedbackDAO();
        request.setAttribute("feedDAO", feedDAO);

        String page = request.getParameter("page") == null ? "" : request.getParameter("page");
        String url;
        switch (page) {
            case "profile":
                url = "views/user/dashboard/profile.jsp";
                break;
            case "change-password":
                url = "views/user/dashboard/change-password.jsp";
                break;
            case "managerPet":
                petSer.managerPetByUserid(request, response, session, UserSession.getUserId());
                url = "views/user/dashboard/managerPet.jsp";
                break;
            default:
                url = "views/user/dashboard/dashboard.jsp";
                break;
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //set encoding UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String url = "";
        request.setAttribute("nofication", null);
        HttpSession session = request.getSession();
        String action = request.getParameter("action1") == null ? "" : request.getParameter("action1");
        switch (action) {
            case "profile":
                updateProfileDoPost(request, response);

                request.getRequestDispatcher("mainControllers?action=profilePage").forward(request, response);
                break;
            case "change-password":
                changePassWord(request, response);
                request.getRequestDispatcher("mainControllers?action=changepasswordPage").forward(request, response);
                break;
            case "edit":
                //chỗ này là chỗ Tân sẽ làm 
                //edit lấy các thông tin từ editPetModal.jsp nhé
                petSer.editPet(request, response);
                request.getRequestDispatcher("mainControllers?action=managerPetUserPage").forward(request, response);
                break;
            case "addpet":
                //add book lấy thong tin pet từ addPetModal.jsp
                //nhưng userId sẽ lấy từ session
                
                addPetDoPost(request, response);
                request.getRequestDispatcher("mainControllers?action=managerPetUserPage").forward(request, response);
                break;
            case "delete":
                petSer.delete(request, response);
                request.getRequestDispatcher("mainControllers?action=managerPetUserPage").forward(request, response);
                break;
            case "history":
                int petId = Integer.parseInt(request.getParameter("petIdHis"));
                List<Bookings> list = petSer.history2(request, response, petId, session);
                session.setAttribute("listHistory", list);
                request.getRequestDispatcher("mainControllers?action=dashboardUserPage").forward(request, response);
                break;
            case "cancel":
                changesStatusCancelDoPost(request, response);
                response.sendRedirect("mainControllers?action=dashboard");
                return;
            case "add":
                addBooking(request, response);
                response.sendRedirect("mainControllers?action=dashboard");
                return;
            case "searchPetManager":
                searchPetByName(request, response);
                request.getRequestDispatcher("mainControllers?action=managerPetUserPage").forward(request, response);
                break;
            default:
                url = "dashboard";
                break;
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void addBooking(HttpServletRequest request, HttpServletResponse response) {
        //tạo new Booking
        Bookings b = new Bookings();
        //lấy thông tin
        int petId = Integer.parseInt(request.getParameter("petId"));
        int cageId = Integer.parseInt(request.getParameter("cageId"));
        // Giả sử startDate được gửi ở dạng chuỗi "yyyy-MM-dd"
        String startDateStr = request.getParameter("datestart");
        String endDateStr = request.getParameter("dateend");
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date parsedDate = dateFormat.parse(startDateStr);
            java.util.Date parsedDateEnd = dateFormat.parse(endDateStr);
            Timestamp startDate = new Timestamp(parsedDate.getTime());
            Timestamp endDate = new Timestamp(parsedDateEnd.getTime());
            // Set startDate vào đối tượng Booking
            b.setStartDate(startDate);
            b.setEndDate(endDate);

        } catch (Exception e) { // ParseException
            // Xử lý lỗi ở đây
        }
        String cusNote = request.getParameter("customerNote");
        b.setPet(petDAO.getPetByPetID(petId));
        b.setCageId(cageId);
        b.setCustomerNote(cusNote);
        bDAO.insertBooking(b);
    }

    private void updateProfileDoPost(HttpServletRequest request, HttpServletResponse response) {
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phonenumber");
        boolean hasError = false;
        if (name == null || name.isEmpty()) {
            request.setAttribute("nameError", "Tên không được để trống");
            hasError = true;
        }

        if (phoneNumber == null || phoneNumber.isEmpty() || !phoneNumber.matches("\\d+")) {
            request.setAttribute("phoneError", "Số điện thoại không hợp lệ");
            hasError = true;
        }
        if (hasError) {
            return;
        }
        userDAO.updateProfile(email, name, phoneNumber);
        HttpSession session = request.getSession();
        Users userNew = (Users) session.getAttribute(Constant.SESSION_ACCOUNT);
        userNew.setName(name);
        userNew.setPhoneNumber(phoneNumber);
        request.setAttribute("nofication", "information changed successfully");
        session.setAttribute(Constant.SESSION_ACCOUNT, userNew);
    }

    private void changesStatusCancelDoPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //get ve bookingId
        String bookingId_raw = request.getParameter("Id");
        int bookingId = Integer.parseInt(bookingId_raw);
        // function change status
        request.setAttribute("nofication", "cancel booking successfully");
        bDAO.Cancel(bookingId);
    }

    private void changePassWord(HttpServletRequest request, HttpServletResponse response) {
        String email = request.getParameter("email");
        String oldpass = request.getParameter("password");
        String newpass = request.getParameter("newPassword");
        //lay ve session
        HttpSession session = request.getSession();
        Users userSession = (Users) session.getAttribute(Constant.SESSION_ACCOUNT);

        if (oldpass.equals(userSession.getPassword())) {
            userDAO.updatePassword(email, newpass);
            userSession.setPassword(newpass);
            session.setAttribute(Constant.SESSION_ACCOUNT, userSession);
            request.setAttribute("success", "Thay đổi mật khẩu thành công!");
        } else {
            request.setAttribute("passError", "Incorrect password ");
            return;
        }

    }

    private void addPetDoPost(HttpServletRequest request, HttpServletResponse response) {
        //lay user userid tu session
        HttpSession session = request.getSession();
        Users UserSession = (Users) session.getAttribute(Constant.SESSION_ACCOUNT);
        int userId = UserSession.getUserId();
        String name = request.getParameter("name");
        int type = Integer.parseInt(request.getParameter("type"));
        String breed = request.getParameter("breed");
        double weight = Double.parseDouble(request.getParameter("weight"));
        String imagePath = null;
        try {
            Part part = request.getPart("image");
            //đường dẫn lưu ảnh
            String path = request.getServletContext().getRealPath("/images");
            File dir = new File(path);
            //ko có đường dẫn => tự tạo ra
            if (!dir.exists()) {
                dir.mkdirs();
            }

            File image = new File(dir, part.getSubmittedFileName());
            part.write(image.getAbsolutePath());
            imagePath = "/APetHotel/images/" + image.getName();
        } catch (Exception e) {
        }

        Pet pet = Pet.builder()
                .userId(userDAO.getUserById(userId))
                .name(name)
                .typeId(type)
                .breed(breed)
                .weight(weight)
                .image(imagePath)
                .build();

        petDAO.insert(pet);
        //set lai list of pet trong session de hien thi lai 
        ArrayList<Pet> list = new ArrayList<>();
        list = petDAO.findPetByUserId(UserSession.getUserId(), true);
        session.setAttribute("listOfPets", list);
        request.setAttribute("nofication", "Thêm thú cưng thành công!");
    }

    private void searchPetByName(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        Users UserSession = (Users) session.getAttribute(Constant.SESSION_ACCOUNT);
        int userId = UserSession.getUserId();
        String keyword = request.getParameter("keyword");
        //set lai list of pet trong session de hien thi lai 
        ArrayList<Pet> list = new ArrayList<>();
        list = petDAO.searchForUser(keyword, userId);
        session.setAttribute("listOfPets", list);
    }

}
