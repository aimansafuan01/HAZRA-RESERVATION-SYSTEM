/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import util.DBConnection;

/**
 *
 * @author Afiq
 */
public class RoomDao {
    public String updateRoomNumber(int num,String accoid) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String UPDATE_IN_ROOM_AVAILABLE_SQL = "UPDATE ROOM SET roomNumber=? WHERE accoid =? ";

        try {
            con = DBConnection.createConnection();
            pstmt = con.prepareStatement(UPDATE_IN_ROOM_AVAILABLE_SQL);
            pstmt.setInt(1, num);
            pstmt.setString(2, accoid);
            pstmt.executeUpdate();
            return "SUCCESS";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "ERROR";
    }
}
