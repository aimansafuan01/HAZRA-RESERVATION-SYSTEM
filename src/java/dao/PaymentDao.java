/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import bean.Payment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import util.DBConnection;

/**
 *
 * @author Afiq
 */
public class PaymentDao {
    private PreparedStatement pstmt;
    
    public String updateStatus(String reservationid )
    {
        Connection conn = null;
        Statement statement = null;
        ResultSet rs = null;
        
        try
        {
            conn = DBConnection.createConnection();
            statement = conn.createStatement();
            rs= statement.executeQuery("select paymenttype,paymentid,paymentstatus from payment where reservationid = '"+reservationid+"'");
            if(rs.next())
               {
                   String type = rs.getString("paymenttype");
                   String id = rs.getString("paymentid");
                   String pstatus = rs.getString("paymentstatus");
                   if(type.equalsIgnoreCase("partial"))
                   {
                       if(pstatus.equalsIgnoreCase("incomplete"))
                       {
                            pstmt = conn.prepareStatement("update payment set paymentstatus =? where paymentid =? " );
                            String newstatus = "Partial-Complete";
                            pstmt.setString(1, newstatus);
                            pstmt.setString(2, id);
                            pstmt.executeUpdate();
                            
                            return "SUCCESS_PPC";
                       }
                       else if(pstatus.equalsIgnoreCase("partial-complete"))
                       {
                            pstmt = conn.prepareStatement("update payment set paymentstatus =? where paymentid =? " );
                            String newstatus = "Complete";
                            pstmt.setString(1, newstatus);
                            pstmt.setString(2, id);
                            pstmt.executeUpdate();
                            
                            return "SUCCESS_PC";
                       }

                   }
                   else if(type.equalsIgnoreCase("full-payment"))
                   {
                       if(pstatus.equalsIgnoreCase("incomplete"))
                       {
                            pstmt = conn.prepareStatement("update payment set paymentstatus =? where paymentid =? " );
                            String newstatus = "Complete";
                            pstmt.setString(1, newstatus);
                            pstmt.setString(2, id);
                            pstmt.executeUpdate();
                            
                            return "SUCCESS_FC";
                       }
                   }
               }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        
        return "Error at PaymentDAO";

    }
    
    public String createPaymentid(Payment payment){
        
       
        String paymenttype = payment.getPaymentType();
        String custId = payment.getCustid();
        
        String reservationid = payment.getReservationid();
        String proofpayment = payment.getProofpayment();
       
        Connection con = null;
        
       String sql= "INSERT INTO PAYMENT (paymentid,paymentstatus,paymenttype,reservationid,custid,proofpayment) VALUES ('PAY'||PAYMENT_ID.NEXTVAL,'Incomplete','"+paymenttype+"','"+reservationid+"','"+custId+"','"+proofpayment+"')";
      
       
         try {
                con = DBConnection.createConnection();
                PreparedStatement pstmt = con.prepareStatement(sql);
               
               /*pstmt.setDate(1, checkInsql);
                pstmt.setDate(2, checkOutsql);
                pstmt.setString(3, custId);
                pstmt.setString(4, accoId);*/
                pstmt.executeUpdate();
                 return "Success";
            }
         catch(SQLException ex){
           ex.getMessage();
        }
                
        return "Invalid";
    }
     
      public String uploadReceipt(Payment payment){
        
       /* String paymenttype = payment.getPaymentType();
        String custId = payment.getCustId();
        String reservationid = payment.getReservationId();
        String proofpayment = payment.getProofPayment();*/
       
        Connection con = null;
       String type = payment.getPaymentType();
       String proofpayment = payment.getProofpayment();
       String reservationid = payment.getReservationid();
       String custid = payment.getCustid();
      
     
       
       String updateSql = "UPDATE PAYMENT SET paymenttype = '"+type+"', proofpayment = '"+proofpayment+"' "
               + "WHERE reservationid = '"+reservationid+"' AND custid = '"+custid+"'";
       
            try {
                con = DBConnection.createConnection();
                 PreparedStatement pstmt = con.prepareStatement(updateSql); 

              
                pstmt.executeUpdate();
                return "Success";

            } catch (SQLException e) {
                
            }

                    return "Invalid";
                }
      
      public String cancelResv(String reservationId){
        
        String reservationid = reservationId;
        
        try{
            Connection con = DBConnection.createConnection();
            PreparedStatement pstmt = con.prepareStatement ("UPDATE PAYMENT SET PAYMENTSTATUS = 'Request-Refund' WHERE RESERVATIONID = ?");
             
            pstmt.setString(1, reservationid);
            pstmt.executeUpdate();
            return "Success";
        }
        catch(SQLException ex){
            ex.printStackTrace();
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        return "Invalid";
    }
}
