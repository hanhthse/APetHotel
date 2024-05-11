/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apethotel.dao;

import com.apethotel.entity.Types;
import com.apethotel.mylib.DBUtils;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Acer
 */
public class TypesDAO {

    public List<Types> findAll() {
        ArrayList<Types> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT [typeId]\n"
                        + "      ,[typeName]\n"
                        + "  FROM [dbo].[Types]";
                Statement st = cn.createStatement();
                ResultSet table = st.executeQuery(sql);
                if (table != null) {
                    while (table.next()) {
                        list.add(new Types(table.getInt("typeId"), table.getString("typeName")));
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
        TypesDAO dao = new TypesDAO();
        for(Types p : dao.findAll()){
            System.out.println(p);
        }
    }
}
