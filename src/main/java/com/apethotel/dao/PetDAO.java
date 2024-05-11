/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apethotel.dao;

import com.apethotel.entity.Pet;
import com.apethotel.entity.Users;
import com.apethotel.mylib.DBUtils;
import com.bookstore.Constant.Constant;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Acer
 */
public class PetDAO {

    UsersDAO2 uDAO = new UsersDAO2();

    public ArrayList<Pet> findPetByUserId(int Userid, boolean status) {
        ArrayList<Pet> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [petId]\n"
                        + "      ,[userId]\n"
                        + "      ,[name]\n"
                        + "      ,[typeId]\n"
                        + "      ,[breed]\n"
                        + "      ,[weight]\n"
                        + "      ,[image]\n"
                        + "      ,[status]\n"
                        + "  FROM [PetHotel].[dbo].[Pets]"
                        + "where userId = ? and status = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, Userid);
                pst.setBoolean(2, status);
                ResultSet table = pst.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int petId = table.getInt("petId");
                        int userId = table.getInt("userId");
                        String name = table.getString("name");
                        int type = table.getInt("typeId");
                        String breed = table.getString("breed");
                        double weight = table.getDouble("weight");
                        String image = table.getString("image");
                        list.add(new Pet(petId, uDAO.getUserById(userId), name, type, breed, weight, image, table.getBoolean("status")));
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

    public int insert(Pet pet) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO [dbo].[Pets]\n"
                        + "           ([userId]\n"
                        + "           ,[name]\n"
                        + "           ,[typeId]\n"
                        + "           ,[breed]\n"
                        + "           ,[weight]\n"
                        + "           ,[image]\n"
                        + "           ,[status])"
                        + "     VALUES \n"
                        + "           (?,?,?,?,?,?,1)";

                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, pet.getUserId().getUserId());
                st.setString(2, pet.getName());
                st.setInt(3, pet.getTypeId());
                st.setString(4, pet.getBreed());
                st.setDouble(5, pet.getWeight());
                st.setString(6, pet.getImage());
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

    public int delete(int idPet) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "UPDATE [dbo].[Pets]\n"
                        + "SET [status] = \n"
                        + "    CASE \n"
                        + "        WHEN [status] = 1 THEN 0\n"
                        + "        WHEN [status] = 0 THEN 1\n"
                        + "        ELSE [status]    \n"
                        + "    END \n"
                        + "WHERE [petId] = ? ";

                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, idPet);
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

    public int getUserId(int petId) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [userId]\n"
                        + "  FROM [dbo].[Pets]\n"
                        + "  where petId = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, petId);
                ResultSet table = pst.executeQuery();
                if (table != null && table.next()) {
                    result = table.getInt("userId");
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

    public int getPetIdByBookingId(int bookingId) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select petId\n"
                        + "from Bookings\n"
                        + "where bookingId	= ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, bookingId);
                ResultSet table = pst.executeQuery();
                if (table != null && table.next()) {
                    result = table.getInt("petId");
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

    public List<Integer> GetListBookingIdByPetid(int petId) {
        List<Integer> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select bookingId from \n"
                        + " Bookings where petId = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, petId);
                ResultSet table = pst.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        result.add(table.getInt("bookingId"));
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
        return result;
    }

    public void updatePet(Pet pet) {
        Connection cn = null;

        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {

                String sql = "UPDATE [dbo].[Pets]\n"
                        + "   SET [name] = ?\n"
                        + "      ,[typeId] = ?\n"
                        + "      ,[breed] = ?\n"
                        + "      ,[weight] = ?\n"
                        + "      ,[image] = ?\n"
                        + " WHERE [petId] = ?";
                //lồng , 2 ngày , status, image
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, pet.getName());
                st.setInt(2, pet.getTypeId());
                st.setString(3, pet.getBreed());
                st.setDouble(4, pet.getWeight());
                st.setString(5, pet.getImage());
                st.setInt(6, pet.getPetId());
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

    public ArrayList<Pet> findAll() {
        ArrayList<Pet> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [petId]\n"
                        + "      ,[userId]\n"
                        + "      ,[name]\n"
                        + "      ,[typeId]\n"
                        + "      ,[breed]\n"
                        + "      ,[weight]\n"
                        + "      ,[image]\n"
                        + "      ,[status]\n"
                        + "  FROM [PetHotel].[dbo].[Pets]";
                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null) {
                    while (table.next()) {
                        int petId = table.getInt("petId");
                        int userId = table.getInt("userId");
                        String name = table.getString("name");
                        int type = table.getInt("typeId");
                        String breed = table.getString("breed");
                        double weight = table.getDouble("weight");
                        String image = table.getString("image");
                        list.add(new Pet(petId, uDAO.getUserById(userId), name, type, breed, weight, image, table.getBoolean("status")));
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

    public ArrayList<Pet> search(String keyWord) {
        ArrayList<Pet> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [petId]\n"
                        + "      ,[userId]\n"
                        + "      ,[name]\n"
                        + "      ,[typeId]\n"
                        + "      ,[breed]\n"
                        + "      ,[weight]\n"
                        + "      ,[image]\n"
                        + "      ,[status]\n"
                        + "  FROM [PetHotel].[dbo].[Pets]\n"
                        + "where name like ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "%" + keyWord + "%");
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int petId = table.getInt("petId");
                        int userId = table.getInt("userId");
                        String name = table.getString("name");
                        int type = table.getInt("typeId");
                        String breed = table.getString("breed");
                        double weight = table.getDouble("weight");
                        String image = table.getString("image");
                        list.add(new Pet(petId, uDAO.getUserById(userId), name, type, breed, weight, image, table.getBoolean("status")));
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

    public ArrayList<Pet> searchForUser(String keyWord, int userId) {
        ArrayList<Pet> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [petId]\n"
                        + "      ,[userId]\n"
                        + "      ,[name]\n"
                        + "      ,[typeId]\n"
                        + "      ,[breed]\n"
                        + "      ,[weight]\n"
                        + "      ,[image]\n"
                        + "      ,[status]\n"
                        + "  FROM [PetHotel].[dbo].[Pets]\n"
                        + "where name like ? and userId = ? ";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "%" + keyWord + "%");
                st.setInt(2, userId);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int petId = table.getInt("petId");
                        int userId2 = table.getInt("userId");
                        String name = table.getString("name");
                        int type = table.getInt("typeId");
                        String breed = table.getString("breed");
                        double weight = table.getDouble("weight");
                        String image = table.getString("image");
                        list.add(new Pet(petId, uDAO.getUserById(userId), name, type, breed, weight, image, table.getBoolean("status")));
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

    public Pet getPetByPetID(int petId) {
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [petId]\n"
                        + "      ,[userId]\n"
                        + "      ,[name]\n"
                        + "      ,[typeId]\n"
                        + "      ,[breed]\n"
                        + "      ,[weight]\n"
                        + "      ,[image]\n"
                        + "      ,[status]\n"
                        + "  FROM [PetHotel].[dbo].[Pets] where petId = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, petId);
                ResultSet table = pst.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int petId2 = table.getInt("petId");
                        Users user = uDAO.getUserById(table.getInt("userId"));
                        String name = table.getString("name");
                        int type = table.getInt("typeId");
                        String breed = table.getString("breed");
                        double weight = table.getDouble("weight");
                        String image = table.getString("image");
                        Pet result = new Pet(petId2, user, name, type, breed, weight, image, table.getBoolean("status"));
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

    public static void main(String[] args) {
        PetDAO dao = new PetDAO();
        System.out.println(dao.delete(1));

    }

    public int findTotalRecord() {
        Connection cn = null;
        int totalRecords = 0;
        String sql = "SELECT COUNT(*) AS total FROM Pets";
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

    public ArrayList<Pet> findByPage(int page) {
        Connection cn = null;
        List<Pet> pets = new ArrayList<>();
        String sql = "select*from Pets\n"
                + "order by petId\n"
                + "offset ? rows\n"
                + "fetch next ? rows only";
        try {
            cn = DBUtils.makeConnection();
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, (page - 1) * Constant.RECORD_PER_PAGE);
            st.setInt(2, Constant.RECORD_PER_PAGE);

            ResultSet table = st.executeQuery();
            if (table != null) {
                while (table.next()) {
                    int petId2 = table.getInt("petId");
                    Users user = uDAO.getUserById(table.getInt("userId"));
                    String name = table.getString("name");
                    int type = table.getInt("typeId");
                    String breed = table.getString("breed");
                    double weight = table.getDouble("weight");
                    String image = table.getString("image");
                    Pet result = new Pet(petId2, user, name, type, breed, weight, image, table.getBoolean("status"));
                    pets.add(result);
                }
            }
        } catch (Exception e) {
        }
        return (ArrayList<Pet>) pets;
    }
}
