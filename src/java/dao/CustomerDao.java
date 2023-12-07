    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import bean.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBConnection;

/**
 *
 * @author User
 */
public class CustomerDao {
    
    public Customer findAccount(Customer custlogin)
    {
       
        String email = custlogin.getCustEmail();
        String password = custlogin.getCustPassword();
       
        try(Connection con = DBConnection.createConnection(); 
        PreparedStatement stmt = con.prepareStatement("SELECT * FROM CUSTOMER WHERE custemail = ? AND custpassword = ? "))
            
        {
            
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            ResultSet rs = stmt.executeQuery();
            
            while(rs.next())
             {          
                 String custid = rs.getString("custid");
                 String custname = rs.getString("custname");
                 custlogin.setCustId(custid);
                 custlogin.setCustName(custname);
                
                
                
            }
        }
        catch(SQLException ex)
        {
            
        }
        
       return custlogin;
    }
    
    public String verifyUser(Customer custlogin)
    {
       
        String email = custlogin.getCustEmail();
        String password = custlogin.getCustPassword();
       
        try(Connection con = DBConnection.createConnection(); 
            PreparedStatement stmt = con.prepareStatement("SELECT custemail,custpassword FROM CUSTOMER WHERE custemail = ? AND custpassword = ? "))
            
        {
            
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            ResultSet rs = stmt.executeQuery();
            
            while(rs.next())
             {          
                 
                 String emailDB = rs.getString("custemail");
                 String passDB = rs.getString("custpassword");
                
                if(email.equals(emailDB) && password.equals(passDB))
                {
                    return "SUCCESS";
                }
            }
        }
        catch(SQLException ex)
        {
            //close(con);
        }
        
        return "Invalid user credentials";
        
    }
    
    public String registerUser(Customer c) {
        String custName = c.getCustName();
        String custEmail = c.getCustEmail();
        String custPhoneNum = c.getCustPhoneNum();
        String custPass= c.getCustPassword();
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;
        int row = 0;
        String custId = "";
        

        String INSERT_CUSTOMER_SQL = "INSERT INTO CUSTOMER "
                + "(custId, custName, custEmail, custPhoneNum, custPassword) VALUES"
                + " ('CU'||CUST_ID.nextval, ?, ?, ?, ?)";
        
        try {
            con = DBConnection.createConnection();
            String result = validateUserEmail(custEmail);
            if (result.equals("ERROR")) {
                return "ERROR";
            }
            pstmt = con.prepareStatement(INSERT_CUSTOMER_SQL);
            pstmt.setString(1, custName);
            pstmt.setString(2, custEmail);
            pstmt.setString(3, custPhoneNum);
            pstmt.setString(4, custPass);
            pstmt.executeUpdate();
            pstmt.close();
            con.close();
            return "SUCCESS"; 
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public String validateUserPassword (String id, String password){
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;
        String userPass = "";
        String GET_CUSTOMER_PASSWORD_SQL = "SELECT CUSTPASSWORD FROM CUSTOMER WHERE CUSTID = ?";
        
        try {
            con = DBConnection.createConnection();
            pstmt = con.prepareStatement(GET_CUSTOMER_PASSWORD_SQL);
            pstmt.setString(1, id);
            resultSet = pstmt.executeQuery();
            while (resultSet.next()){
                userPass = resultSet.getString(1);
            }
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        if (userPass.equals(password)) {
            return "valid";
        } else {
            return "invalid";
        }
    };
    
    public String updateUser (Customer c) {
        String id = c.getCustId();
        String name = c.getCustName();
        String email = c.getCustEmail();
        String password = c.getCustPassword();
        String phone = c.getCustPhoneNum();
        String result = "";
        Connection con = null;
        PreparedStatement pstmt = null;
        String UPDATE_CUSTOMER_SQL = "UPDATE CUSTOMER SET CUSTNAME=?, CUSTEMAIL=?, CUSTPHONENUM=?, CUSTPASSWORD=? WHERE CUSTID=?";
        
        try {
            con = DBConnection.createConnection();
            result = validateUserEmail(email,id);
            if (result.equals("ERROR")) {
                return "ERROR";
            }
            pstmt = con.prepareStatement(UPDATE_CUSTOMER_SQL);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, phone);
            pstmt.setString(4, password);
            pstmt.setString(5, id);
            pstmt.executeUpdate();
            pstmt.close();
            return result = "UPDATE SUCCESS";
        } catch (Exception e) {
            e.printStackTrace();
            result = "UPDATE FAILED";
        }
        return result;
    };
    
     public String validateUserEmail (String email,String custid) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;
        String userEmail = "";
        String GET_CUSTOMER_EMAIL_SQL = "SELECT CUSTEMAIL FROM CUSTOMER WHERE CUSTID <> '"+custid+"'";
        
         try {
            con = DBConnection.createConnection();
            pstmt = con.prepareStatement(GET_CUSTOMER_EMAIL_SQL);
            resultSet = pstmt.executeQuery();
            while (resultSet.next()){
                userEmail = resultSet.getString(1);
                if (userEmail.equals(email)) {
                    return "ERROR";
                }
            }
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "SUCCESS";
    }
     
      public String validateUserEmail (String email) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;
        String userEmail = "";
        String GET_CUSTOMER_EMAIL_SQL = "SELECT CUSTEMAIL FROM CUSTOMER";
        
         try {
            con = DBConnection.createConnection();
            pstmt = con.prepareStatement(GET_CUSTOMER_EMAIL_SQL);
            resultSet = pstmt.executeQuery();
            while (resultSet.next()){
                userEmail = resultSet.getString(1);
                if (userEmail.equals(email)) {
                    return "ERROR";
                }
            }
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "SUCCESS";
    }
}
