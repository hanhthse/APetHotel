/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apethotel.dao;

import com.apethotel.entity.Status;
import com.apethotel.entity.Users;
import com.apethotel.mylib.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Acer
 */
public class StatusDAO {

    public Status findStatusByIdStatus(int id) {
        Status result = null;
        Connection cn = null;
        try {
            //make connection giua backend va sqlserver
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //viet sql va exec cau sql
                String sql = "SELECT [idStatus]\n"
                        + "      ,[nameStatus]\n"
                        + "  FROM [PetHotel].[dbo].[BookingStatus] where idStatus = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                //lay emai,password cua input params gan vao 2 cho ?
                pst.setInt(1, id);
                //run cau sql
                ResultSet table = pst.executeQuery();
                //doc data trong table
                if (table != null && table.next()) {

                    result = new Status(table.getInt("idStatus"), table.getString("nameStatus"));
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
        return result;
    }
        public static void main(String[] args) {
        StatusDAO dao = new StatusDAO();
            System.out.println(dao.getIdStatus("complete"));
    }

    public int getIdStatus(String status) {
        Connection cn = null;
        try {
            //make connection giua backend va sqlserver
            cn = DBUtils.makeConnection();
            if (cn != null) {
                //viet sql va exec cau sql
                String sql = "SELECT TOP (1000) [idStatus]\n"
                        + "      ,[nameStatus]\n"
                        + "  FROM [PetHotel].[dbo].[BookingStatus] where nameStatus = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                //lay emai,password cua input params gan vao 2 cho ?
                pst.setString(1, status);
                //run cau sql
                ResultSet table = pst.executeQuery();
                //doc data trong table
                if (table != null && table.next()) {
                    int id = table.getInt("idStatus");
                    return id;
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
        return 0;
    }
}
