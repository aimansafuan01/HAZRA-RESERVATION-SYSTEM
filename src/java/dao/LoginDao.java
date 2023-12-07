/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

/**
 *
 * @author User
 */
import bean.Customer;
import java.sql.*;
import util.DBConnection;

public class LoginDao {
    
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
            
        }
        
        return "Invalid user credentials";
        
    }
     
}
