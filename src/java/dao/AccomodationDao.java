/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import util.DBConnection;

/**
 *
 * @author Afiq
 */
public class AccomodationDao {
    public String updateCleaningStatus (String accoid, String accostatus, String empid) {
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;
        int row = 0;
        String manageId = "";
        
        String EDIT_ACCOMODATION_STATUS_SQL = "UPDATE ACCOMODATION SET ACCOSTATUS=? WHERE ACCOID=?";
        String INSERT_MANAGES_ROOM_SQL = "INSERT INTO MANAGEROOM "
                + "(MANAGESID, MANAGESDATE, MANAGESTIME, EMPID, ACCOID) VALUES"
                + " ('MGR'||MANAGE_ID.nextval, ?, ?, ?, ?)";
        
        try {
            con = DBConnection.createConnection();
            pstmt = con.prepareStatement(EDIT_ACCOMODATION_STATUS_SQL);
            pstmt.setString(1, accostatus);
            pstmt.setString(2, accoid);
            pstmt.executeUpdate();
            try {
                LocalDate currentDate = LocalDate.now();
                java.sql.Date sqlDate = java.sql.Date.valueOf(currentDate);
                java.util.Date currentTimestamp = new java.util.Date();
                java.sql.Timestamp timestamp = new java.sql.Timestamp(currentTimestamp.getTime());
                pstmt = con.prepareStatement(INSERT_MANAGES_ROOM_SQL);
                pstmt.setDate(1, sqlDate);
                pstmt.setTimestamp(2, timestamp);
                pstmt.setString(3, "EMP2");
                pstmt.setString(4, accoid);
                pstmt.executeUpdate();
            } catch (SQLException e) {
            e.printStackTrace();
            return "Manages SQL Failure";
            }
            pstmt.close();
            con.close();
            return "SUCCESS"; 
        } catch (SQLException e) {
            e.printStackTrace();
            return "Update Room SQL Failure";
        }
    };
}
