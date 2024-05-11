/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apethotel.controller.user;

import com.apethotel.controller.admin.DashboardServlet;
import com.apethotel.dao.BookingsDAO;
import com.apethotel.dao.PetDAO;
import com.apethotel.dao.TypesDAO;
import com.apethotel.dao.UsersDAO2;
import com.apethotel.entity.Bookings;
import com.apethotel.entity.Pet;
import com.apethotel.entity.Types;
import com.apethotel.entity.Users;
import com.bookstore.Constant.Constant;
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
 * @author Acer
 */
public class PetService {

    BookingsDAO bookings = new BookingsDAO();
    TypesDAO typeDAO = new TypesDAO();
    public PetDAO petDAO = new PetDAO();
    UsersDAO2 uDAO = new UsersDAO2();

    public void delete(HttpServletRequest request, HttpServletResponse response) {
        int idPet = Integer.parseInt(request.getParameter("idDelete"));
        HttpSession session = request.getSession();
        int delete = petDAO.delete(idPet);
        //set lai list of pet trong session de hien thi lai 
        if (delete == 0) {
            request.setAttribute("nofication", "Không thể xóa thú cưng đã tham gia dịch vụ!");
        } else {
            ArrayList<Pet> list = new ArrayList<>();
            Users UserSession = (Users) session.getAttribute(Constant.SESSION_ACCOUNT);
            list = petDAO.findPetByUserId(UserSession.getUserId(),true);
            session.setAttribute("listOfPets", list);
            request.setAttribute("nofication", "Xóa thành công!");
        }

    }

    public void editPet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        int petId = Integer.parseInt(request.getParameter("petId"));
        Pet pet = petDAO.getPetByPetID(petId);
        String petName = request.getParameter("name");
        int typePet = Integer.parseInt(request.getParameter("type"));
        String breed = request.getParameter("breed");
        double weight = Double.parseDouble(request.getParameter("weight"));
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
        pet.setName(petName);
        pet.setTypeId(typePet);
        pet.setBreed(breed);
        pet.setWeight(weight);
        pet.setImage(imagePath);
        // tạo đối tượng
        petDAO.updatePet(pet);
        //set vao session
        HttpSession session = request.getSession();
        Users UserSession = (Users) session.getAttribute(Constant.SESSION_ACCOUNT);
        ArrayList<Pet> list = petDAO.findPetByUserId(UserSession.getUserId(),true);
        session.setAttribute("listOfPets", list);
        request.setAttribute("nofication", "Cập nhật thành công!");
    }

    public void loadTypePet(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        List<Types> listTypes = typeDAO.findAll();
        session.setAttribute("listType", listTypes);
    }

    public void managerPetByUserid(HttpServletRequest request, HttpServletResponse response, HttpSession session, int userId) {
        //list để chứa pet
        ArrayList<Pet> list = new ArrayList<>();
        //get ve session user hiện tại để lấy userid
        list = petDAO.findPetByUserId(userId,true);
        session.setAttribute("listOfPets", list);
    }


    public List<Bookings> history2(HttpServletRequest request, HttpServletResponse response, int petId, HttpSession session) {
        List<Bookings> listBookings = new ArrayList<>();
        for (Bookings b : bookings.findAll()) {
            if (b.getPet().getPetId() == petId) {
                listBookings.add(b);
            }
        }
        return listBookings;
    }
}
