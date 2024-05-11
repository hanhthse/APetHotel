package com.apethotel.controller.admin;

import com.apethotel.dao.BookingsDAO;
import com.apethotel.dao.CagesDAO2;
import com.apethotel.entity.Bookings;
import com.apethotel.entity.Cages;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author ASUS
 */
public class CagesService {

    BookingsDAO bookings = new BookingsDAO();
    CagesDAO2 cageDao = new CagesDAO2();

    public void delete(HttpServletRequest request, HttpServletResponse response) {
        int cageID = Integer.parseInt(request.getParameter("idDelete"));
        int done = cageDao.delete(cageID);
    }

    public void addCage(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String imagePath = null;
        // Thu thập thông tin từ request
        String description = request.getParameter("description");
        String size = request.getParameter("size");
        double pricePerDay = Double.parseDouble(request.getParameter("pricePerDay"));
        int typeId = Integer.parseInt(request.getParameter("typeId"));
        try {
            Part part = request.getPart("image"); // Lấy hình ảnh từ form
            // Đường dẫn lưu ảnh
            String path = request.getServletContext().getRealPath("/images");
            File dir = new File(path);
            // Nếu không có đường dẫn thì tự tạo ra
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // Lưu file hình ảnh
            File imageFile = new File(dir, part.getSubmittedFileName());
            part.write(imageFile.getAbsolutePath());
            imagePath = "/APetHotel/images/" + imageFile.getName(); // Lưu đường dẫn để lưu vào DB
        } catch (Exception e) {
            e.printStackTrace(); // In ra lỗi nếu có
        }

        // Tạo đối tượng Cages
        Cages newCage = new Cages();
        newCage.setDescription(description);
        newCage.setSize(size);
        newCage.setPricePerDay(pricePerDay);
        newCage.setTypeId(typeId);
        newCage.setImage(imagePath);

        // Thêm lồng vào cơ sở dữ liệu
        int result = cageDao.insert(newCage);

        // Xử lý kết quả
        if (result > 0) {
            // Thêm thành công, chuyển hướng hoặc gửi thông báo thành công
            ArrayList<Cages> list = new ArrayList<>();
            list = cageDao.findAllCages();
            session.setAttribute("listOfCages", list);
            session.setAttribute("nofication", "Thêm lồng thành công!");
        } else {
            // Thêm thất bại, chuyển hướng hoặc gửi thông báo lỗi
            session.setAttribute("nofication", "Thêm lồng thất bại. Vui lòng thử lại!");
        }

    }

    public void editCage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Cages cage = new Cages();
        System.out.println("kết quả của cage ID: " + request.getParameter("cageID"));
        int cageId = Integer.parseInt(request.getParameter("cageID"));
        String description = request.getParameter("description");
        String size = request.getParameter("size");
        double pricePerDay = Double.parseDouble(request.getParameter("pricePerDay"));
        int typeId = Integer.parseInt(request.getParameter("type"));

        String imagePath = null;
        try {
            //get image
            Part part = request.getPart("image");
            if (part == null || part.getSize() <= 0) {
                // su dung hinh anh hien tai va cap nhat duong dan(imagePath)
                imagePath = request.getParameter("currentImage2");
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
        cage.setCageID(cageId);
        cage.setDescription(description);
        cage.setSize(size);
        cage.setPricePerDay(pricePerDay);
        cage.setTypeId(typeId);
        cage.setImage(imagePath);
        System.out.println(cage);
        // tạo đối tượng
        cageDao.updateCages(cage);
        //set vao session
        HttpSession session = request.getSession();
        ArrayList<Cages> list = new ArrayList<>();
        list = cageDao.findAllCages();
        session.setAttribute("listOfCages", list);
    }

    public List<Bookings> historyCage(HttpServletRequest request, HttpServletResponse response, int cageID, HttpSession session) {
        List<Bookings> listBookings = new ArrayList<>();
        listBookings = bookings.findHistoryByCageId(cageID);
        return listBookings;
    }

    public void searchCage(HttpServletRequest request, HttpServletResponse response) {
        String keyword = request.getParameter("keyword");
        ArrayList<Cages> cage = (ArrayList<Cages>) cageDao.findByKeyWord2(keyword);
        request.setAttribute("listOfCages", cage);
        request.setAttribute("findKeyWord", keyword);
    }
}
