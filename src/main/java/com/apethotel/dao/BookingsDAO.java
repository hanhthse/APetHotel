/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apethotel.dao;

import com.apethotel.entity.Bookings;
import com.apethotel.entity.Pet;
import com.apethotel.mylib.DBUtils;
import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Acer
 */
public class BookingsDAO {

    PetDAO pDAO = new PetDAO();

    public ArrayList<Bookings> findAll() {
        ArrayList<Bookings> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [bookingId]\n"
                        + "      ,[petId]\n"
                        + "      ,[cageId]\n"
                        + "      ,[startDate]\n"
                        + "      ,[endDate]\n"
                        + "      ,[customerNote]\n"
                        + "      ,[petImage]\n"
                        + "      ,[totalCost]\n"
                        + "      ,[idStatus]\n"
                        + "      ,[bookingDate]\n"
                        + "  FROM [PetHotel].[dbo].[Bookings]";
                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null) {
                    while (table.next()) {
                        int bookingId = table.getInt("bookingId");
                        Pet pet = pDAO.getPetByPetID(table.getInt("petId"));
                        int cageId = table.getInt("cageId");
                        Timestamp startDate = table.getTimestamp("startDate");
                        Timestamp endDate = table.getTimestamp("endDate");
                        Timestamp bookingDate = table.getTimestamp("BookingDate");
                        String customerNote = table.getString("customerNote");
                        double totalCost = table.getDouble("totalCost");
                        String image = table.getString("petImage");
                        int status = table.getInt("idStatus");
                        list.add(new Bookings(bookingId, pet, cageId, startDate, endDate, customerNote, "", image, totalCost, status, bookingDate));
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

    public List<Bookings> findHistoryByCageId(int cageID) {
        ArrayList<Bookings> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [bookingId]\n"
                        + "      ,[petId]\n"
                        + "      ,[cageId]\n"
                        + "      ,[startDate]\n"
                        + "      ,[endDate]\n"
                        + "      ,[customerNote]\n"
                        + "      ,[employeeNote]\n"
                        + "      ,[petImage]\n"
                        + "      ,[totalCost]\n"
                        + "      ,[idStatus]\n"
                        + "      ,[bookingDate]\n"
                        + "  FROM [PetHotel].[dbo].[Bookings]"
                        + "where cageId = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, cageID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingId = table.getInt("bookingId");
                        Pet pet = pDAO.getPetByPetID(table.getInt("petId"));
                        int cageId = table.getInt("cageId");
                        Timestamp startDate = table.getTimestamp("startDate");
                        Timestamp endDate = table.getTimestamp("endDate");
                        Timestamp bookingDate = table.getTimestamp("BookingDate");
                        String customerNote = table.getString("customerNote");
                        double totalCost = table.getDouble("totalCost");
                        String image = table.getString("petImage");
                        int status = table.getInt("idStatus");
                        list.add(new Bookings(bookingId, pet, cageId, startDate, endDate, customerNote, "", image, totalCost, status, bookingDate));
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

    public int changeStatus(int bookingId) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "UPDATE [dbo].[Bookings]\n"
                        + "   SET [idStatus] = idStatus + 1 \n"
                        + " WHERE  bookingId = ?";

                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookingId);
                result = st.executeUpdate();
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

    public int  updateBooking(Bookings bs) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {

                String sql = "UPDATE [dbo].[Bookings]\n"
                        + " SET [cageId] = ? \n"
                        + " ,[startDate] = ? \n"
                        + ",[endDate] = ? \n"
                        + ",[idStatus] = ? \n"
                        + ",[petImage] = ? \n"
                        + "WHERE bookingId = ?";
                //lồng , 2 ngày , status, image
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bs.getCageId());
                st.setTimestamp(2, bs.getStartDate());
                st.setTimestamp(3, bs.getEndDate());
                st.setInt(4, bs.getIdStatus());
                st.setString(5, bs.getPetImage());
                st.setInt(6, bs.getBookingId());
               result = st.executeUpdate();
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

    public int Cancel(int bookingId) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "update Bookings\n"
                        + "set IdStatus = 5 \n"
                        + "where bookingId = ?";

                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookingId);
                result = st.executeUpdate();
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

    public Bookings getBookingsById(int bookingId) {
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [bookingId]\n"
                        + "      ,[petId]\n"
                        + "      ,[cageId]\n"
                        + "      ,[startDate]\n"
                        + "      ,[endDate]\n"
                        + "      ,[customerNote]\n"
                        + "      ,[petImage]\n"
                        + "      ,[totalCost]\n"
                        + "      ,[idStatus]\n"
                        + "      ,[bookingDate]\n"
                        + "  FROM [PetHotel].[dbo].[Bookings]"
                        + "where bookingId = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookingId);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingId2 = table.getInt("bookingId");
                        Pet pet = pDAO.getPetByPetID(table.getInt("petId"));
                        int cageId = table.getInt("cageId");
                        Timestamp startDate = table.getTimestamp("startDate");
                        Timestamp endDate = table.getTimestamp("endDate");
                        Timestamp bookingDate = table.getTimestamp("BookingDate");
                        String customerNote = table.getString("customerNote");
                        double totalCost = table.getDouble("totalCost");
                        String image = table.getString("petImage");
                        int status = table.getInt("idStatus");
                        Bookings result = new Bookings(bookingId, pet, cageId, startDate, endDate, customerNote, "", image, totalCost, status, bookingDate);
                        return result;
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
        return null;

    }

    public ArrayList<Bookings> findByProperty(int idStatus) {
        ArrayList<Bookings> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [bookingId]\n"
                        + "      ,[petId]\n"
                        + "      ,[cageId]\n"
                        + "      ,[startDate]\n"
                        + "      ,[endDate]\n"
                        + "      ,[customerNote]\n"
                        + "      ,[employeeNote]\n"
                        + "      ,[petImage]\n"
                        + "      ,[totalCost]\n"
                        + "      ,[idStatus]\n"
                        + "      ,[bookingDate]\n"
                        + "  FROM [PetHotel].[dbo].[Bookings]"
                        + "where idStatus = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, idStatus);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingId = table.getInt("bookingId");
                        Pet pet = pDAO.getPetByPetID(table.getInt("petId"));
                        int cageId = table.getInt("cageId");
                        Timestamp startDate = table.getTimestamp("startDate");
                        Timestamp endDate = table.getTimestamp("endDate");
                        Timestamp bookingDate = table.getTimestamp("BookingDate");
                        String customerNote = table.getString("customerNote");
                        double totalCost = table.getDouble("totalCost");
                        String image = table.getString("petImage");
                        int status = table.getInt("idStatus");
                        list.add(new Bookings(bookingId, pet, cageId, startDate, endDate, customerNote, "", image, totalCost, status, bookingDate));
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

    public Integer getQuantityByCageid(int cageId) {
        int quantity = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT  COUNT(bookingId) as 'quantity'\n"
                        + "  FROM [PetHotel].[dbo].[Bookings]\n"
                        + "  where cageId = ? AND YEAR(bookingDate) = YEAR(GETDATE()) and idStatus = 4";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, cageId);
                ResultSet table = pst.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        quantity = table.getInt("quantity");
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
        return quantity;
    }

    public void insertBooking(Bookings b) {
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO [dbo].[Bookings]\n"
                        + "           ([petId]\n"
                        + "           ,[cageId]\n"
                        + "           ,[startDate]\n"
                        + "           ,[endDate]\n"
                        + "           ,[customerNote]\n"
                        + "           ,[idStatus]\n"
                        + "           ,[bookingDate])\n"
                        + "     VALUES (?,?,?,?,?,1,?)";

                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, b.getPet().getPetId());
                st.setInt(2, b.getCageId());
                st.setTimestamp(3, b.getStartDate());
                st.setTimestamp(4, b.getEndDate());
                st.setString(5, b.getCustomerNote());
                st.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
                st.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public ArrayList<Date> getBusyTimeOfCageByCageId(int cageId) {
        Connection cn = null;
        ArrayList<Date> busyDates = new ArrayList<>();
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [startDate]\n"
                        + "      ,[endDate]\n"
                        + "  FROM [PetHotel].[dbo].[Bookings]\n"
                        + "  where cageId = ? and idStatus != 1 and idStatus != 5 ";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, cageId);
                ResultSet table = pst.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        // Assuming startDate and endDate are of type 'Date' in the database
                        Date startDate = table.getDate("startDate");
                        Date endDate = table.getDate("endDate");
                        if (startDate != null && endDate != null) {
                            for (Date date = startDate; !date.after(endDate); date = new Date(date.getTime() + (1000 * 60 * 60 * 24))) {
                                busyDates.add(date);
                            }
                        }

                    }
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
        return busyDates;
    }

    public String convertDatesToJson(ArrayList<Date> dates) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        StringBuilder json = new StringBuilder("[");

        for (int i = 0; i < dates.size(); i++) {
            Date date = dates.get(i);
            json.append("\"").append(sdf.format(date)).append("\"");
            if (i < dates.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");

        return json.toString();
    }

    public Integer getEarningByMonth(int month) {
        int earning = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT \n"
                        + "  SUM(totalCost) AS Earnings\n"
                        + "FROM \n"
                        + "  [PetHotel].[dbo].[Bookings]\n"
                        + "WHERE \n"
                        + "  MONTH(bookingDate) = ? AND \n"
                        + "  YEAR(bookingDate) = YEAR(GETDATE()) and idStatus = 4";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, month);
                ResultSet table = pst.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        earning = table.getInt("Earnings");
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
        return earning;
    }

    public ArrayList<Bookings> listOrdersByDateStartedDateEnd(String dateStarded, String dateEnded) {
        ArrayList<Bookings> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [bookingId]\n"
                        + "      ,[petId]\n"
                        + "      ,[cageId]\n"
                        + "      ,[startDate]\n"
                        + "      ,[endDate]\n"
                        + "      ,[customerNote]\n"
                        + "      ,[employeeNote]\n"
                        + "      ,[petImage]\n"
                        + "      ,[totalCost]\n"
                        + "      ,[idStatus]\n"
                        + "      ,[bookingDate]\n"
                        + "FROM [PetHotel].[dbo].[Bookings]\n"
                        + "WHERE [bookingDate] BETWEEN ? AND ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, dateStarded);
                st.setString(2, dateEnded);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingId = table.getInt("bookingId");
                        Pet pet = pDAO.getPetByPetID(table.getInt("petId"));
                        int cageId = table.getInt("cageId");
                        Timestamp startDate = table.getTimestamp("startDate");
                        Timestamp endDate = table.getTimestamp("endDate");
                        Timestamp bookingDate = table.getTimestamp("BookingDate");
                        String customerNote = table.getString("customerNote");
                        double totalCost = table.getDouble("totalCost");
                        String image = table.getString("petImage");
                        int status = table.getInt("idStatus");
                        list.add(new Bookings(bookingId, pet, cageId, startDate, endDate, customerNote, "", image, totalCost, status, bookingDate));
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

    public static void main(String[] args) {
        BookingsDAO dao = new BookingsDAO();
        for (Bookings b : dao.listOrdersByDateStartedDateEnd("2024-01-07","2024-02-04")) {
            System.out.println(b);
        }
//        System.out.println(dao.changeStatus(24));
    }
}
