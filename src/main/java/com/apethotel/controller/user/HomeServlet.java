/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apethotel.controller.user;

import com.apethotel.dao.BookingsDAO;
import com.apethotel.dao.CagesDAO2;
import com.apethotel.entity.Cages;
import com.apethotel.entity.PageControl;
import com.apethotel.entity.Pet;
import com.bookstore.Constant.Constant;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Acer
 */
public class HomeServlet extends HttpServlet {

    CagesDAO2 cagesDAO2 = new CagesDAO2();
    BookingsDAO bookingDAO = new BookingsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //set encoding UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        //tao ra session
        HttpSession session = request.getSession();
        //tao DAO
        ArrayList<Cages> listCages;
        //get du lieu tu database len
        //get ve action
        PageControl pageControl = new PageControl();

        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        switch (action) {
            case "search":
                listCages = findByKeyWord(request, response);
                break;
            case "pagination":
                int page = Integer.parseInt(request.getParameter("page"));
                listCages = panigation(request, response, pageControl, page);
                break;
            default:
                int pageDefault = 1;
                listCages = panigation(request, response, pageControl, pageDefault);
        }
        HashMap<Integer, String> busyDatesMap = new HashMap<>();
        for (Cages c : listCages) {
            ArrayList<Date> busyDates = bookingDAO.getBusyTimeOfCageByCageId(c.getCageID());
            String busyDatesJson = bookingDAO.convertDatesToJson(busyDates).trim(); // Convert to JSON
            busyDatesMap.put(c.getCageID(), busyDatesJson);
        }
        //set busydate vao session
        session.setAttribute("busyDatesMap", busyDatesMap);
        //set listBook vao session
        session.setAttribute("listCages", listCages);
        session.setAttribute("pageControl", pageControl);
        // go to homepage
        request.getRequestDispatcher("views/user/home-page/homePage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    private ArrayList<Cages> findByKeyWord(HttpServletRequest request, HttpServletResponse response) {
        //get ve keyword
        String keyword = request.getParameter("keyword");
        request.setAttribute("findKeyWord", keyword);
        // tao ra DAO
        return cagesDAO2.findByKeyWord(keyword, true);
    }

    private ArrayList<Cages> panigation(HttpServletRequest request, HttpServletResponse response, PageControl pageControl, int page) {
        //Tim kiem xem co bao nhieu record 
        int totalRecord = cagesDAO2.findTotalRecord();
        //Tim kiem xem co bao nhieu page
        int totalPage = (totalRecord % Constant.RECORD_PER_PAGE) == 0
                ? (totalRecord % Constant.RECORD_PER_PAGE)
                : (totalRecord / Constant.RECORD_PER_PAGE) + 1;
        //set vao page Control
        pageControl.setPage(page);
        pageControl.setTotalPage(totalPage);
        pageControl.setTotalRecord(totalRecord);

        return cagesDAO2.findByPage(page);
    }
}
