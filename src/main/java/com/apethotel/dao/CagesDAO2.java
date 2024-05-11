/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apethotel.dao;

import com.apethotel.entity.Cages;
import com.apethotel.entity.Pet;
import com.apethotel.entity.Users;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import com.apethotel.mylib.DBUtils;
import com.bookstore.Constant.Constant;

/**
 *
 * @author Acer
 */
public class CagesDAO2 {

    //lấy tất cả các cages có sẵn
    public ArrayList<Cages> findAllCages() {
        ArrayList<Cages> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [cageId]\n"
                        + "      ,[description]\n"
                        + "      ,[size]\n"
                        + "      ,[pricePerDay]\n"
                        + "      ,[typeId]\n"
                        + "      ,[image]\n"
                        + "      ,[status]\n"
                        + "  FROM [PetHotel].[dbo].[Cages]";
                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null) {
                    while (table.next()) {
                        int m_cageId = table.getInt("cageId");
                        String m_des = table.getString("description");
                        String m_size = table.getString("size");
                        double m_pirce = table.getDouble("pricePerDay");
                        int m_typeId = table.getInt("typeId");
                        String m_image = table.getString("image");
                        list.add(new Cages(m_cageId, m_des, m_size, m_pirce, m_typeId, m_image, table.getBoolean("status")));
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

    //lấy tất cả các cages có sẵn
    public ArrayList<Cages> findAllCagesTrue() {
        ArrayList<Cages> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [cageId]\n"
                        + "      ,[description]\n"
                        + "      ,[size]\n"
                        + "      ,[pricePerDay]\n"
                        + "      ,[typeId]\n"
                        + "      ,[image]\n"
                        + "      ,[status]\n"
                        + "  FROM [PetHotel].[dbo].[Cages]"
                        + "where status = 1 ";
                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null) {
                    while (table.next()) {
                        int m_cageId = table.getInt("cageId");
                        String m_des = table.getString("description");
                        String m_size = table.getString("size");
                        double m_pirce = table.getDouble("pricePerDay");
                        int m_typeId = table.getInt("typeId");
                        String m_image = table.getString("image");
                        list.add(new Cages(m_cageId, m_des, m_size, m_pirce, m_typeId, m_image, table.getBoolean("status")));
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

    public ArrayList<Cages> findByKeyWord(String keyword, boolean status) {
        ArrayList<Cages> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [cageId]\n"
                        + "      ,[description]\n"
                        + "      ,[size]\n"
                        + "      ,[pricePerDay]\n"
                        + "      ,[typeId]\n"
                        + "      ,[image]\n"
                        + "      ,[status]\n"
                        + "  FROM [dbo].[Cages]"
                        + "where description like ? and status = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
                pst.setBoolean(2, status);
                ResultSet table = pst.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int m_cageId = table.getInt("cageId");
                        String m_des = table.getString("description");
                        String m_size = table.getString("size");
                        double m_pirce = table.getDouble("pricePerDay");
                        String m_image = table.getString("image");
                        int m_typeId = table.getInt("typeId");
                        list.add(new Cages(m_cageId, m_des, m_size, m_pirce, m_typeId, m_image, table.getBoolean("status")));
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

    public List<Cages> findByKeyWord2(String keyword) {
        List<Cages> list = new ArrayList<>();

        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [cageId]\n"
                        + "      ,[description]\n"
                        + "      ,[size]\n"
                        + "      ,[pricePerDay]\n"
                        + "      ,[typeId]\n"
                        + "      ,[image]\n"
                        + "      ,[status]\n"
                        + "  FROM [dbo].[Cages]"
                        + " WHERE description LIKE ? OR size LIKE ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
                pst.setString(2, "%" + keyword + "%");
                ResultSet table = pst.executeQuery();
                while (table.next()) {
                    int m_cageId = table.getInt("cageId");
                    String m_des = table.getString("description");
                    String m_size = table.getString("size");
                    double m_price = table.getDouble("pricePerDay");
                    String m_image = table.getString("image");
                    int m_typeId = table.getInt("typeId");
                    list.add(new Cages(m_cageId, m_des, m_size, m_price, m_typeId, m_image, table.getBoolean("status")));
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

    public int delete(int cageID) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "UPDATE [dbo].[Cages]\n"
                        + "SET [status] = \n"
                        + "    CASE \n"
                        + "        WHEN [status] = 1 THEN 0\n"
                        + "        WHEN [status] = 0 THEN 1\n"
                        + "        ELSE [status]    \n"
                        + "    END\n"
                        + "WHERE cageId = ? ";

                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, cageID);
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

    public Cages getCagesByid(int id) {
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [cageId]\n"
                        + "      ,[description]\n"
                        + "      ,[size]\n"
                        + "      ,[pricePerDay]\n"
                        + "      ,[typeId]\n"
                        + "      ,[image]\n"
                        + "      ,[status]\n"
                        + "  FROM [dbo].[Cages]"
                        + " WHERE cageId = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, id);
                ResultSet table = pst.executeQuery();
                while (table.next()) {
                    int m_cageId = table.getInt("cageId");
                    String m_des = table.getString("description");
                    String m_size = table.getString("size");
                    double m_price = table.getDouble("pricePerDay");
                    String m_image = table.getString("image");
                    int m_typeId = table.getInt("typeId");
                    Cages result = new Cages(m_cageId, m_des, m_size, m_price, m_typeId, m_image, table.getBoolean("status"));
                    return result;
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

//
//    public boolean isCageEmpty(int cageId) {
//        Connection cn = null;
//        boolean isEmpty = true; // Giả định lồng trống ban đầu
//        try {
//            cn = DBUtils.makeConnection();
//            if (cn != null) {
//                // Truy vấn để kiểm tra xem có booking nào trong khoảng thời gian hiện tại cho cageId này không
//                String sql = "SELECT COUNT(*) AS bookingCount FROM [PetHotel].[dbo].[Bookings] "
//                        + "WHERE cageId = ? AND startDate <= GETDATE() AND endDate >= GETDATE()";
//
//                PreparedStatement pst = cn.prepareStatement(sql);
//                pst.setInt(1, cageId);
//                ResultSet rs = pst.executeQuery();
//
//                if (rs != null && rs.next()) {
//                    // Nếu có ít nhất một booking trong khoảng thời gian hiện tại, lồng không trống
//                    int bookingCount = rs.getInt("bookingCount");
//                    isEmpty = bookingCount == 0;
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            isEmpty = false; // Nếu có lỗi, giả định lồng không trống để tránh xóa lồng đang được sử dụng
//        } finally {
//            if (cn != null) {
//                try {
//                    cn.close();
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//        return isEmpty;
//    }
    public int insert(Cages cage) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO [dbo].[Cages]\n"
                        + "           ([description]\n"
                        + "           ,[size]\n"
                        + "           ,[pricePerDay]\n"
                        + "           ,[typeId]\n"
                        + "           ,[image]\n"
                        + "           ,[status])\n"
                        + "VALUES (?,?,?,?,?,1)";

                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, cage.getDescription());
                st.setString(2, cage.getSize());
                st.setDouble(3, cage.getPricePerDay());
                st.setInt(4, cage.getTypeId());
                st.setString(5, cage.getImage());
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

    public void updateCages(Cages cage) {
        Connection cn = null;

        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {

                String sql = "UPDATE [dbo].[Cages]\n"
                        + "   SET [description] = ?\n"
                        + "      ,[size] = ?\n"
                        + "      ,[pricePerDay] = ?\n"
                        + "      ,[typeId] = ?\n"
                        + "      ,[image] = ?\n"
                        + " WHERE cageId = ?";
                //lồng , 2 ngày , status, image
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, cage.getDescription());
                st.setString(2, cage.getSize());
                st.setDouble(3, cage.getPricePerDay());
                st.setInt(4, cage.getTypeId());
                st.setString(5, cage.getImage());
                st.setInt(6, cage.getCageID());
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

    public static void main(String[] args) {
        CagesDAO2 dao = new CagesDAO2();
        for (Cages c : dao.findByPage(2)) {
            System.out.println(c);
        }
    }

    public int findTotalRecord() {
        Connection cn = null;
        int totalRecords = 0;
        String sql = "SELECT COUNT(*) AS total FROM Cages";
        try {
            cn = DBUtils.makeConnection();
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                totalRecords = rs.getInt("total");
            }

        } catch (Exception e) {
        }
        return totalRecords;
    }

    public ArrayList<Cages> findByPage(int page) {
        Connection cn = null;
        ArrayList<Cages> ListCages = new ArrayList<>();
        String sql = "select * from cages\n"
                + "where status = 1 order by cageId \n"
                + "offset ? rows \n"
                + "fetch next ? rows only ";
        try {
            cn = DBUtils.makeConnection();
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, (page - 1) * 6);
            st.setInt(2, 6);

            ResultSet table = st.executeQuery();
            if (table != null) {
                while (table.next()) {
                    int m_cageId = table.getInt("cageId");
                    String m_des = table.getString("description");
                    String m_size = table.getString("size");
                    double m_pirce = table.getDouble("pricePerDay");
                    int m_typeId = table.getInt("typeId");
                    String m_image = table.getString("image");
                    ListCages.add(new Cages(m_cageId, m_des, m_size, m_pirce, m_typeId, m_image, table.getBoolean("status")));
                }
            }
        } catch (Exception e) {
        }
        return ListCages;
    }
}
