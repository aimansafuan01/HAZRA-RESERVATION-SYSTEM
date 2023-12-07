/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import util.DBConnection;

/**
 *
 * @author Afiq
 */
public class ManageRoomDao {
    public String updateStatusManage(String empid, String accoid){
        Connection con = null;
        PreparedStatement pstmt = null;
        LocalDate currentDate = LocalDate.now();
        java.sql.Date sqlDate = java.sql.Date.valueOf(currentDate);
        java.util.Date currentTimestamp = new java.util.Date();
        java.sql.Timestamp timestamp = new java.sql.Timestamp(currentTimestamp.getTime());
        String INSERT_MANAGES_ROOM_SQL = "INSERT INTO MANAGEROOM "
                + "(MANAGESID, MANAGESDATE, MANAGESTIME, EMPID, ACCOID) VALUES"
                + " ('MGR'||MANAGE_ID.nextval, ?, ?, ?, ?)";

        try {
            con = DBConnection.createConnection();
            pstmt = con.prepareStatement(INSERT_MANAGES_ROOM_SQL);
            pstmt.setDate(1, sqlDate);
            pstmt.setTimestamp(2, timestamp);
            pstmt.setString(3, empid);
            pstmt.setString(4, accoid);
            pstmt.executeUpdate();
            return "SUCCESS";
        } catch (Exception e) {
            e.printStackTrace();
        }
       return "ERROR";
    }
}

