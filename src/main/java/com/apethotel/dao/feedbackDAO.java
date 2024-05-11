/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apethotel.dao;

import com.apethotel.entity.Cages;
import com.apethotel.entity.FeedBack;
import com.apethotel.entity.Users;
import com.apethotel.mylib.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Acer
 */
public class feedbackDAO {

    public List<FeedBack> getAllFeedback() {
        ArrayList<FeedBack> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [feedbackId]\n"
                        + "      ,[bookingId]\n"
                        + "      ,[userId]\n"
                        + "      ,[comment]\n"
                        + "      ,[rating]\n"
                        + "  FROM [dbo].[Feedback]";
                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null) {
                    while (table.next()) {
                        int m_feedbackId = table.getInt("feedbackId");
                        int m_bookingId = table.getInt("bookingId");
                        int m_userId = table.getInt("userId");
                        String m_comment = table.getString("comment");
                        int m_rating = table.getInt("rating");
                        list.add(new FeedBack(m_feedbackId, m_bookingId, m_userId, m_comment, m_rating));
                    }
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public String getUserNameByID(int userID) throws Exception {
        String userName = null;
        Connection cn = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            // Establish the connection to the database
            cn = DBUtils.makeConnection();

            // Prepare a statement to execute the SQL query
            String query = "SELECT [name]\n"
                    + "FROM [dbo].[Users]\n"
                    + "where [userId] = ?";
            preparedStatement = cn.prepareStatement(query);
            preparedStatement.setInt(1, userID);

            // Execute the query
            resultSet = preparedStatement.executeQuery();

            // Retrieve the user name from the result set
            if (resultSet.next()) {
                userName = resultSet.getString("name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle any SQL exceptions here
        } finally {
            // Close the resultSet, preparedStatement, and connection to avoid memory leaks
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
                // Handle any SQL exceptions during close here
            }
        }
        return userName;
    }

    public int getCageIdByBookingId(int id) throws Exception {
        int cageID = 0;
        Connection cn = null;

        try {
            // Establish the connection to the database
            cn = DBUtils.makeConnection();

            // Prepare a statement to execute the SQL query
            String query = "SELECT [cageId]\n"
                    + "FROM [dbo].[Bookings]\n"
                    + "where bookingId = ?";
            PreparedStatement st = cn.prepareStatement(query);
            st.setInt(1, id);

            // Execute the query
            ResultSet table = st.executeQuery();

            // Retrieve the user name from the result set
            if (table.next()) {
                cageID = table.getInt("cageId");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle any SQL exceptions here
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return cageID;
    }

//    public static void main(String[] args) throws Exception {
//        feedbackDAO dao = new feedbackDAO();
//        System.out.println(dao.getCageIdByBookingId(1));
//    }
    public int addFeedBack(int bookingId, int rating, String feedback) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO [dbo].[Feedback]\n"
                        + "           ([bookingId]\n"
                        + "           ,[userId]\n"
                        + "           ,[comment]\n"
                        + "           ,[rating])\n"
                        + "SELECT \n"
                        + "    ?, p.userId, ?, ?\n"
                        + "FROM \n"
                        + "    Bookings b\n"
                        + "INNER JOIN \n"
                        + "    Pets p ON p.petId = b.petId and b.bookingId = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, bookingId);
                pst.setString(2, feedback);
                pst.setInt(3, rating);
                pst.setInt(4, bookingId);
                result = pst.executeUpdate();

            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;

    }

    public boolean checkValid(int bookingId) {
        boolean result = true;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT TOP (1000) [feedbackId]\n"
                        + "      ,[bookingId]\n"
                        + "      ,[userId]\n"
                        + "      ,[comment]\n"
                        + "      ,[rating]\n"
                        + "  FROM [PetHotel].[dbo].[Feedback]\n"
                        + "  where bookingId = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, bookingId);
                ResultSet table = pst.executeQuery();
                if (table != null && table.next()) {
                    result = false;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;

    }

    public static void main(String[] args) {
        feedbackDAO dao = new feedbackDAO();
        System.out.println(dao.checkValid(1));
    }
}
//        public static void main(String[] args) {
//        UsersDAO dao = new UsersDAO();
//        System.out.println(dao.getUserByuserid("QL002"));
//    }
