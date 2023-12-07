/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import bean.Employee;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBConnection;

/**
 *
 * @author Arif
 */
public class EmployeeDao {
    public Employee findAccount(Employee emplogin)
    {
       
        String email = emplogin.getEmployeeEmail();
        String password = emplogin.getEmployeePass();
       
        try(Connection con = DBConnection.createConnection(); 
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM EMPLOYEE WHERE empemail = ? AND emppass = ? "))
            
        {
            
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            ResultSet rs = stmt.executeQuery();
            
            while(rs.next())
             {          
                 String empid = rs.getString("empid");
                 String empname = rs.getString("empname");
                 String roles = rs.getString("emproles");
                 
                 
                 emplogin.setEmployeeId(empid);
                 emplogin.setEmployeeName(empname);
                 emplogin.setEmployeeRoles(roles);
                 
                 
            }
        }
        catch(SQLException ex)
        {
            
        }
        
       return emplogin;
    }
    
    public String verifyUser(Employee emplogin)
    {
       
        String email = emplogin.getEmployeeEmail();
        String password = emplogin.getEmployeePass();
       
        try(Connection con = DBConnection.createConnection(); 
            PreparedStatement stmt = con.prepareStatement("SELECT empemail,emppass FROM EMPLOYEE WHERE empemail = ? AND emppass = ? "))
            
        {
            
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            ResultSet rs = stmt.executeQuery();
            
            while(rs.next())
             {          
                 
                 String emailDB = rs.getString("empemail");
                 String passDB = rs.getString("emppass");
                
                if(email.equals(emailDB) && password.equals(passDB))
                {
                    
                    return "SUCCESS";
                }
            }
        }
        catch(SQLException ex)
        {
            ex.getMessage();
        }
        
        return "Invalid user credentials";
        
    }
    
    public String validateUserPassword (String id, String password){
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;
        String userPass = "";
        String GET_EMPLOYEE_PASSWORD_SQL = "SELECT EMPPASS FROM EMPLOYEE WHERE EMPID = ?";
        
        try {
            con = DBConnection.createConnection();
            pstmt = con.prepareStatement(GET_EMPLOYEE_PASSWORD_SQL);
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
    }
    
    public String updateUser (Employee e) {
        String id = e.getEmployeeId();
        String name = e.getEmployeeName();
        String email = e.getEmployeeEmail();
        String password = e.getEmployeePass();
        String phone = e.getEmployeePhoneNum();
        String result = "";
        Connection con = null;
        PreparedStatement pstmt = null;
        String UPDATE_CUSTOMER_SQL = "UPDATE EMPLOYEE SET EMPNAME=?, EMPEMAIL=?, EMPPHONENUM=?, EMPPASS=? WHERE EMPID=?";
        
        try {
            con = DBConnection.createConnection();
            result = validateEmployeeEmail(email,id);
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
        } catch (Exception ex) {
            ex.printStackTrace();
            result = "UPDATE FAILED";
        }
        return result;
    }
    
    public String validateEmployeeEmail (String email,String empid) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;
        String empEmail = "";
        String GET_CUSTOMER_EMAIL_SQL = "SELECT EMPEMAIL FROM EMPLOYEE WHERE EMPID <>'"+empid+"'";
        
         try {
            con = DBConnection.createConnection();
            pstmt = con.prepareStatement(GET_CUSTOMER_EMAIL_SQL);
            resultSet = pstmt.executeQuery();
            while (resultSet.next()){
                empEmail = resultSet.getString(1);
                if (empEmail.equals(email)) {
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
