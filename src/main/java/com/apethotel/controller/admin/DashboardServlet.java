/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apethotel.controller.admin;

import com.apethotel.dao.BookingsDAO;
import com.apethotel.dao.CagesDAO2;
import com.apethotel.dao.PetDAO;
import com.apethotel.dao.UsersDAO2;
import com.apethotel.entity.Pet;
import com.apethotel.entity.Users;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import com.apethotel.controller.user.PetService;
import com.apethotel.dao.StatusDAO;
import com.apethotel.entity.Bookings;
import com.apethotel.entity.Cages;
import com.apethotel.entity.PageControl;
import com.bookstore.Constant.Constant;
import java.util.Date;
import java.util.HashMap;

/**
 *
 * @author Acer
 */
@MultipartConfig
public class DashboardServlet extends HttpServlet {

    // Tạo ra đối tượng DAO
    CagesDAO2 cagesDAO2 = new CagesDAO2();
    UsersDAO2 userDAO = new UsersDAO2();
    BookingsDAO bookingDAO = new BookingsDAO();
    PetDAO petDAO = new PetDAO();
    PetService petSer = new PetService();
    CagesService cageSer = new CagesService();
    StatusDAO sDAO = new StatusDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("nofication", null);
        //tim ve toan bo bookings
        List<Bookings> listBooking2 = bookingDAO.findAll();
        //pagecontroll để chia trang
        PageControl pageControl = new PageControl();
        //load type Pet 
        petSer.loadTypePet(request, response, session);
        List<Cages> listCages2 = cagesDAO2.findAllCagesTrue();
        session.setAttribute("listCages", listCages2);
        session.setAttribute(Constant.SESSISON_HISTORY, "default");
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        HashMap<Integer, String> busyDatesMap = new HashMap<>();
        List<Cages> listCages = cagesDAO2.findAllCages();
        for (Cages c : listCages) {
            ArrayList<Date> busyDates = bookingDAO.getBusyTimeOfCageByCageId(c.getCageID());
            String busyDatesJson = bookingDAO.convertDatesToJson(busyDates).trim(); // Convert to JSON
            busyDatesMap.put(c.getCageID(), busyDatesJson);
        }
        //set busydate vao session
        session.setAttribute("busyDatesMap", busyDatesMap);
        setBookingList(request, response, listBooking2, session);
        String url = "../views/admin/dashboard/dashboard.jsp";
        switch (action) {
            case "viewUnconfirm":
                session.setAttribute(Constant.SESSISON_HISTORY, "viewUnconfirm");
                listBooking2 = bookingDAO.findByProperty(1);
                break;
            case "viewConfirm":
                session.setAttribute(Constant.SESSISON_HISTORY, "viewConfirm");
                listBooking2 = bookingDAO.findByProperty(2);
                break;
            case "viewProgress":
                session.setAttribute(Constant.SESSISON_HISTORY, "viewProgress");
                listBooking2 = bookingDAO.findByProperty(3);
                break;
            case "viewCancel":
                session.setAttribute(Constant.SESSISON_HISTORY, "viewCancel");
                listBooking2 = bookingDAO.findByProperty(5);
                break;
            case "viewComplete":
                session.setAttribute(Constant.SESSISON_HISTORY, "viewComplete");
                listBooking2 = bookingDAO.findByProperty(4);
                break;
            case "default":
                listBooking2 = bookingDAO.findAll();
                break;
            case "managerAccount":
                ArrayList<Users> listUser = userDAO.findAll();
                session.setAttribute("listUser", listUser);
                url = "../views/admin/dashboard/managerAccount.jsp";
                break;
            case "managerCages":
                listCages = cagesDAO2.findAllCages();
                session.setAttribute("listOfCages", listCages);
                url = "../views/admin/dashboard/manageCagesAdmin.jsp";
                break;
            case "reportStatistics":
                listBooking2 = null;
                dataChart(session);
                url = "../views/admin/dashboard/reportStatistics.jsp";
                break;
            case "pagination":
                session.removeAttribute("nameUserFind");
                ArrayList<Pet> listPetPani = (ArrayList<Pet>) panigation(request, response, pageControl);
                session.setAttribute("listOfPets", listPetPani);
                url = "../views/admin/dashboard/managerPetAdmin.jsp";
                break;
            default:
                url = "../views/admin/dashboard/managerPetAdmin.jsp";
                break;
        }
        // chuyển qua trang dashboard.jsp
        session.setAttribute("pageControl", pageControl);
        session.setAttribute("listBookings", listBooking2);
        session.setAttribute("sDAO", sDAO);
        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //set encoding UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        //get ve action
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        request.setAttribute("nofication", null);
        session.setAttribute("nofication", null);
        //sw
        switch (action) {
            case "changeStatus":
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                Bookings booking = bookingDAO.getBookingsById(bookingId);
                changeStatusDoPost(request, response);
                String historyStatus = (String) session.getAttribute(Constant.SESSISON_HISTORY);
                if (historyStatus.equalsIgnoreCase("hisUser")) {
                    int userId = petDAO.getUserId(petDAO.getPetIdByBookingId(bookingId));
                    ListBookingOfUser(request, response, userId);
                    dataChart(session);
                    request.getRequestDispatcher("../views/admin/dashboard/dashboard.jsp").forward(request, response);
                } else if (historyStatus.equalsIgnoreCase("hisPet")) {
                    List<Bookings> list = petSer.history2(request, response, booking.getPet().getPetId(), session);
                    session.setAttribute("listBookings", list);
                    setBookingList(request, response, list, session);
                    dataChart(session);
                    request.getRequestDispatcher("../views/admin/dashboard/dashboard.jsp").forward(request, response);
                } else if (historyStatus.equalsIgnoreCase("hisCages")) {
                    int cageId = Integer.parseInt(request.getParameter("cageId"));
                    List<Bookings> listHis = cageSer.historyCage(request, response, cageId, session);
                    session.setAttribute("listBookings", listHis);
//                    setBookingList(request, response, listHis, session);
                    dataChart(session);
                    request.getRequestDispatcher("../views/admin/dashboard/dashboard.jsp").forward(request, response);
                } else if (historyStatus != null) {
                    response.sendRedirect("dashboard?action=" + historyStatus);
                } else {
                    response.sendRedirect("dashboard");
                }
                break;
            case "cancel":
                changesStatusCancelDoPost(request, response);
                response.sendRedirect("dashboard");
                break;
            case "editBooking":
                editBooking(request);
                response.sendRedirect("dashboard");
                break;
            case "historyUser":
                int userid = Integer.parseInt(request.getParameter("useridHis"));
                ListBookingOfUser(request, response, userid);
                session.setAttribute(Constant.SESSISON_HISTORY, "hisUser");
                request.getRequestDispatcher("../views/admin/dashboard/dashboard.jsp").forward(request, response);
                return;
            case "changeRole":
                changeRoleDoPost(request, response);
                response.sendRedirect("dashboard?action=managerAccount");
                return;
            case "deleteUser":
                deleteUserDoPost(request, response);
                response.sendRedirect("dashboard?action=managerAccount");
                return;
            case "changeAdmin":
                changeAdminDoPost(request, response);
                response.sendRedirect("dashboard?action=managerAccount");
                return;
            case "delete":
                petSer.delete(request, response);
                response.sendRedirect("dashboard?action=managerPet");
                break;
            case "edit":
                petSer.editPet(request, response);
                response.sendRedirect("dashboard?action=managerPet");
                break;
            case "viewPetByUser":
                int userID = Integer.parseInt(request.getParameter("useridHis"));
                String nameUser = request.getParameter("userNameHis");
                session.setAttribute("nameUserFind", nameUser);
                petSer.managerPetByUserid(request, response, session, userID);
                request.getRequestDispatcher("../views/admin/dashboard/managerPetAdmin.jsp").forward(request, response);
                break;
            case "history":
                int petId = Integer.parseInt(request.getParameter("petIdHis"));
                List<Bookings> list = petSer.history2(request, response, petId, session);
                session.setAttribute(Constant.SESSISON_HISTORY, "hisPet");
                session.setAttribute("listBookings", list);
                setBookingList(request, response, list, session);
                request.getRequestDispatcher("../views/admin/dashboard/dashboard.jsp").forward(request, response);
                break;

            case "historyOfCages":
                int cageID = Integer.parseInt(request.getParameter("cagesIdHis"));
                List<Bookings> listHis = cageSer.historyCage(request, response, cageID, session);
                session.setAttribute(Constant.SESSISON_HISTORY, "hisCages");
                session.setAttribute("listBookings", listHis);
                request.getRequestDispatcher("../views/admin/dashboard/dashboard.jsp").forward(request, response);
                break;
            case "addcages":
                cageSer.addCage(request, response);
                request.getRequestDispatcher("../views/admin/dashboard/manageCagesAdmin.jsp").forward(request, response);
                break;
            case "editCage":
                cageSer.editCage(request, response);
                response.sendRedirect("dashboard?action=managerCages");
                break;
            case "deleteCages":
                cageSer.delete(request, response);
                response.sendRedirect("dashboard?action=managerCages");
                break;
            case "searchPetManager":
                String keyWord = request.getParameter("keyword");
                ArrayList<Pet> listPet = petDAO.search(keyWord);
                session.setAttribute("listOfPets", listPet);
                request.setAttribute("findKeyWord", keyWord);
                request.getRequestDispatcher("../views/admin/dashboard/managerPetAdmin.jsp").forward(request, response);
                break;
            case "searchCage":
                cageSer.searchCage(request, response);
                request.getRequestDispatcher("../views/admin/dashboard/manageCagesAdmin.jsp").forward(request, response);
                break;
            case "loadReportStatis":
                String dateEnded = request.getParameter("dateEnded");
                String dateStarded = request.getParameter("dateStarded");
                ArrayList<Bookings> list22 = bookingDAO.listOrdersByDateStartedDateEnd(dateStarded, dateEnded);
                request.setAttribute("listBookings", list22);
                request.setAttribute("dateEnded", dateEnded);
                request.setAttribute("dateStarded", dateStarded);
                request.getRequestDispatcher("../views/admin/dashboard/reportStatistics.jsp").forward(request, response);
                break;

            default:
                throw new AssertionError();
        }

        request.getRequestDispatcher("../views/admin/dashboard/dashboard.jsp").forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    private void changeStatusDoPost(HttpServletRequest request, HttpServletResponse response) {
        //get ve bookingId
        String bookingId_raw = request.getParameter("bookingId");
        int bookingId = Integer.parseInt(bookingId_raw);
        // function change status
        bookingDAO.changeStatus(bookingId);
    }

    private void changesStatusCancelDoPost(HttpServletRequest request, HttpServletResponse response) {
        //get ve bookingId
        String bookingId_raw = request.getParameter("Id");
        int bookingId = Integer.parseInt(bookingId_raw);
        // function change status
        bookingDAO.Cancel(bookingId);
    }

    private int numberOf(int status, List<Bookings> listBookings) {
        int count = 0;
        for (Bookings bk : listBookings) {
            if (bk.getIdStatus() == status) {
                count++;
            }
        }
        return count;
    }

    private void editBooking(HttpServletRequest request) throws IOException {
        int id = Integer.parseInt(request.getParameter("bookingId"));
        Bookings bs = bookingDAO.getBookingsById(id);
        int cageId = Integer.parseInt(request.getParameter("cageId"));

        // Giả sử startDate được gửi ở dạng chuỗi "yyyy-MM-dd"
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date parsedDate = dateFormat.parse(startDateStr);
            java.util.Date parsedDateEnd = dateFormat.parse(endDateStr);
            Timestamp startDate = new Timestamp(parsedDate.getTime());
            Timestamp endDate = new Timestamp(parsedDateEnd.getTime());
            // Set startDate vào đối tượng BookingSummary của bạn
            bs.setStartDate(startDate);
            bs.setEndDate(endDate);

        } catch (Exception e) { // ParseException
            // Xử lý lỗi ở đây
        }
        double price = Double.parseDouble(request.getParameter("totalCost"));
        String status = request.getParameter("status");
        String imagePath = null;
        try {
            //get image
            Part part = request.getPart("image");
            if (part == null || part.getSize() <= 0) {
                // su dung hinh anh hien tai va cap nhat duong dan(imagePath)
                String currentImage = request.getParameter("currentImage");
                bs.setPetImage(currentImage);
            } else {
                try {
                    String path = request.getServletContext().getRealPath("/image");
                    //tao ra duong dan den file anh
                    File dir = new File(path);
                    //khong co duong dan --> tự tạo ra
                    if (!dir.exists()) {
                        dir.mkdirs();
                    }
                    //get duoi anh
                    File image = new File(dir, part.getSubmittedFileName());
                    part.write(image.getAbsolutePath());
                    imagePath = "/APetHotel/image/" + image.getName();
                } catch (Exception e) {
                    System.out.println(e.getMessage() + "Error private void edit(HttpServletRequest request)");

                }
            }
        } catch (ServletException ex) {
            Logger.getLogger(DashboardServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
            System.out.println(ex.getMessage() + "Error private void edit(HttpServletRequest request)");
        }

        //setter paramter
        bs.setCageId(cageId);
        bs.setPetImage(imagePath);
        bs.setTotalCost(price);
        bs.setIdStatus(sDAO.getIdStatus(status));
        // tạo đối tượng
        bookingDAO.updateBooking(bs);
    }

    private void setBookingList(HttpServletRequest request, HttpServletResponse response, List<Bookings> listBookings, HttpSession session) {
        int unconfirm = numberOf(1, listBookings);
        int confirm = numberOf(2, listBookings);
        int progress = numberOf(3, listBookings);
        int complete = numberOf(4, listBookings);
        int cancel = numberOf(5, listBookings);
        //set vao session
        session.setAttribute("unconfirm", unconfirm);
        session.setAttribute("confirm", confirm);
        session.setAttribute("progress", progress);
        session.setAttribute("complete", complete);
        session.setAttribute("cancel", cancel);
    }

    private void ListBookingOfUser(HttpServletRequest request, HttpServletResponse response, int userid) {
        List<Bookings> listBooking = new ArrayList<>();
        for (Bookings b : bookingDAO.findAll()) {
            if (b.getPet().getUserId().getUserId() == userid) {
                listBooking.add(b);
            }
        }
        HttpSession session = request.getSession();
        session.setAttribute("listBookings", listBooking);
        setBookingList(request, response, listBooking, session);
    }

//    private List<Bookings> history(HttpServletRequest request, HttpServletResponse response, int petId) {
//        List<Bookings> listBookings = new ArrayList<>();
//        for(Bookings b : bookingDAO.findAll()){
//            if(b.getPet().getPetId() == petId){
//                listBookings.add(b);
//            }
//        }
//        return listBookings;
//    }
    private void changeRoleDoPost(HttpServletRequest request, HttpServletResponse response) {
        int roleId = Integer.parseInt(request.getParameter("useridForRole"));
        userDAO.changeRoleBlockOrUser(roleId);

    }

    private void deleteUserDoPost(HttpServletRequest request, HttpServletResponse response) {
        int roleId = Integer.parseInt(request.getParameter("useridHis"));
        int kq = userDAO.deleteUser(roleId);
    }

    private void changeAdminDoPost(HttpServletRequest request, HttpServletResponse response) {
        int roleId = Integer.parseInt(request.getParameter("useridHis"));
        int kq = userDAO.changeAdmin(roleId);

    }

    private List<Integer> getDataList() {
        List<Integer> data = new ArrayList<>();
        for (int i = 1; i <= cagesDAO2.findAllCages().size(); i++) {
            data.add(bookingDAO.getQuantityByCageid(i));
        }
        return data;
    }

    private List<Integer> getDataEarningList() {
        List<Integer> data = new ArrayList<>();
        for (int i = 1; i <= 12; i++) {
            data.add(bookingDAO.getEarningByMonth(i));
        }
        return data;
    }

    private void dataChart(HttpSession session) {
        List<Integer> data = getDataList();
        String chartDataJson = data.toString();
        // Gán dữ liệu vào request
        session.setAttribute("chartData", chartDataJson);
        //hiển thị thông báo bao nhiêu trong từng trạng thái

        List<Integer> dataEarning = getDataEarningList();
        String chartEarning = dataEarning.toString();
        // Gán dữ liệu vào request
        session.setAttribute("dataEarning", chartEarning);
        //hiển thị thông báo bao nhiêu trong từng trạng thái
    }

    private ArrayList<Pet> panigation(HttpServletRequest request, HttpServletResponse response, PageControl pageControl) {
        int page = Integer.parseInt(request.getParameter("page"));
        //Tim kiem xem co bao nhieu record 
        int totalRecord = petDAO.findTotalRecord();
        //Tim kiem xem co bao nhieu page
        int totalPage = (totalRecord % Constant.RECORD_PER_PAGE) == 0
                ? (totalRecord % Constant.RECORD_PER_PAGE)
                : (totalRecord / Constant.RECORD_PER_PAGE) + 1;
        //set vao page Control
        pageControl.setPage(page);
        pageControl.setTotalPage(totalPage);
        pageControl.setTotalRecord(totalRecord);

        return petDAO.findByPage(page);
    }
}
