/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import util.DBConnection;

/**
 *
 * @author Afiq
 */
public class RefundDao {
    private PreparedStatement pstmt;
    
    public String updateRefundStatus(String refundid)
    {
        Connection conn = null;
        Statement statement = null;
        ResultSet rs = null;
        try
        {
            conn = DBConnection.createConnection();
            statement = conn.createStatement();
            pstmt = conn.prepareStatement("update refund set refundstatus=? where refundid =?");
            String newstatus = "Complete";
            pstmt.setString(1, newstatus);
            pstmt.setString(2, refundid);
            pstmt.executeUpdate();

            return "SUCCESS";
            
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return "Error at RefundDAO: updateRefundStatus";
    }
    
    public String makeRefund(String reservationid, String refundtype)
    {
        Connection conn = DBConnection.createConnection();
        try
        {
            pstmt = conn.prepareStatement("INSERT INTO REFUND (REFUNDID, REFUNDTYPE, REFUNDSTATUS, RESERVATIONID, EMPID) VALUES ('REF'||REFUND_ID.NEXTVAL, '"+refundtype+"', 'Incomplete','"+reservationid+"', 'EMP1')");
            pstmt.executeUpdate();

            return "Success";
            
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return "Invalid";
    }
}
