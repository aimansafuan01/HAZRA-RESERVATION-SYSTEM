/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Afiq
 */
public class DBConnection {
    public static Connection createConnection()
    {   String driver = "oracle.jdbc.OracleDriver";
        String connectionString = "jdbc:oracle:thin:@DESKTOP-5A4QUNH:1521/XE";
        try
        {
            Class.forName(driver);
            return DriverManager.getConnection(connectionString,"HRS","HRS");
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return null;
    } 
}
