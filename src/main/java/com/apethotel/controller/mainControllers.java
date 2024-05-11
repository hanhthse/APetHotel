/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apethotel.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Acer
 */
@MultipartConfig
public class mainControllers extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //set encoding UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String url = null;
            String action = request.getParameter("action") == null ? "homePage" : request.getParameter("action");
            switch (action) {
                case "loginPage":
                    url = "views/user/home-page/login.jsp";
                    break;
                case "login":
                    url = "/authen";
                    break;
                case "register":
                    url = "/authen";
                    break;
                case "registerPage":
                    url = "views/user/home-page/register.jsp";
                    break;
                case "home":
                    url = "/home";
                    break;
                case "pagination":
                    url = "/home";
                    break;
                case "search":
                    url = "/home";
                    break;
                case "logout":
                    url = "/authen";
                    break;
                case "dashboard":
                    url = "/dashboard";
                    break;
                case "updateProfile":
                    url = "updateProfileController";
                    break;
                case "profilePage":
                    url = "views/user/dashboard/profile.jsp";
                    break;
                case "dashboardUserPage":
                    url = "views/user/dashboard/dashboard.jsp";
                    break;
                case "changepasswordPage":
                    url = "views/user/dashboard/change-password.jsp";
                    break;
                case "managerPetUserPage":
                    url = "views/user/dashboard/managerPet.jsp";
                    break;
                case "feedbackPage":
                    url = "views/user/home-page/feedBack.jsp";
                    break;
                case "feedback":
                    url = "feedBackController";
                    break;
                case "addFeedBack":
                    url = "addFeedBackController";
                    break;    
                default:
                    url = "/home";
                    break;
            }
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
