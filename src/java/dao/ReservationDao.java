/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;
import bean.Reservation;
import java.sql.*;
import java.text.SimpleDateFormat;
import util.DBConnection;
import java.time.LocalDate;
import java.util.ArrayList;
/**
 *
 * @author Afiq
 */
public class ReservationDao {
   //method update reservation status, return new update
    
    private PreparedStatement pstmt;
    public String updateStatus(String reservationid)
    {
        Connection conn = null;
        Statement statement = null;
        ResultSet rs = null;
        
        try
        {
            conn = DBConnection.createConnection();
            statement = conn.createStatement();
            pstmt = conn.prepareStatement("update reservation set reservationstatus=? where reservationid =?");
            String newstatus = "Complete - Not Check In";
            pstmt.setString(1, newstatus);
            pstmt.setString(2, reservationid);
            pstmt.executeUpdate();
            
            return "SUCCESS";
            
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        
        return "Error at ReservationDAO: updateStatus";
        
    }
    //review back
    /*
    public void autoUpdateCheckIn()
    {
        Connection conn = null;
        Statement statement = null;
        ResultSet rs = null;
        
        try
        {
            conn = DBConnection.createConnection();
            statement = conn.createStatement();
            LocalDate date = LocalDate.now();
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("select r.reservationid,p.paymentstatus from reservation r join payment p on r.reservationid = p.reservationid where to_char(checkindate,'yyyy-mm-dd') ='"+date+"' ");
            while(rs.next())
            {
                String reservationid = rs.getString("r.reservationid");
                String paymentstatus = rs.getString("p.paymentstatus");
                
                if(paymentstatus.equalsIgnoreCase("Complete"))
                {
                    pstmt = conn.prepareStatement("update reservation set reservationstatus=? where reservationid =?");
                    String newstatus = "Complete - Check In";
                    pstmt.setString(1, newstatus);
                    pstmt.setString(2, reservationid);
                    pstmt.executeUpdate();
                }
                
           
            }
            //pstmt = conn.prepareStatement("select * from reservation where to_char(checkindate,'yyyy-mm-dd') ='"+date+"' ");
            
            
            
           
            
            /*String newstatus = "Complete - Not Check In";
            pstmt.setString(1, newstatus);
            pstmt.setString(2, reservationid);
            pstmt.executeUpdate();
            
           Thread.sleep(1000);
            
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }*/
    
   public String updateCheckOut(String reservationid)
   {
        Connection conn = null;
        Statement statement = null;
        ResultSet rs = null;
       try
       {
           conn = DBConnection.createConnection();
           statement = conn.createStatement();
           pstmt = conn.prepareStatement("update reservation set reservationstatus=? where reservationid =?");
           String newstatus = "Complete - Check Out";
           pstmt.setString(1, newstatus);
           pstmt.setString(2, reservationid);
           pstmt.executeUpdate();
            
            return "SUCCESS";
       }
       catch(Exception ex)
       {
           ex.printStackTrace();
       }
       return "Error at ReservationDAO: updateCheckOut";
   }
   
   public String updateCheckIn(String reservationid)
   {
        Connection conn = null;
        Statement statement = null;
        ResultSet rs = null;
        try
        {
            conn = DBConnection.createConnection();
            statement = conn.createStatement();
            pstmt = conn.prepareStatement("update reservation set reservationstatus=? where reservationid =?");
            String newstatus = "Complete - Check In";
            pstmt.setString(1, newstatus);
            pstmt.setString(2, reservationid);
            pstmt.executeUpdate();

            return "SUCCESS";
            
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        
        return "Error at ReservationDAO: updateCheckIn";
   }
   
    public String makeReservation(Reservation reservation){
        
       
       
        java.util.Date checkIn = reservation.getCheckInDate() ;
        java.util.Date checkOut = reservation.getCheckOutDate();
        
        
        java.sql.Date checkInsql = new java.sql.Date(checkIn.getTime());
        java.sql.Date checkOutsql = new java.sql.Date(checkOut.getTime());
      
        String custId = reservation.getCustId();
        String accoId = reservation.getAccoId();
        
        Connection con = null;
        
       String sql= "INSERT INTO RESERVATION (reservationid,checkindate,checkoutdate,reservationstatus,reservationdate,custid,accoid) VALUES "
               + "('RESV'||RESV_ID.NEXTVAL,to_date('"+checkInsql+"','yyyy-mm-dd'),to_date('"+checkOutsql+"','yyyy-mm-dd'),'Incomplete',SYSDATE,'"+custId+"','"+accoId+"')";
       
         try {
                con = DBConnection.createConnection();
                PreparedStatement pstmt = con.prepareStatement(sql);
                pstmt.executeUpdate();
                String selectSql = "SELECT 'RESV' || RESV_ID.CURRVAL FROM DUAL";
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(selectSql);
                if (rs.next()) {
                    String reservationId = rs.getString(1);
                    return reservationId;
                }
            } catch (SQLException ex) {
                ex.getMessage();
            }
                
        return "Invalid";
    }
    
     public int calculatedate(String reservationId){
     
         Connection con = null;
         String sql2= "SELECT TRUNC(checkoutdate - checkindate) as no_days\n" +
                       "FROM RESERVATION where reservationid = '"+reservationId+"'";
         
                 
               try {
            con = DBConnection.createConnection();
            PreparedStatement pstmt = con.prepareStatement(sql2);
           
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int no_days = rs.getInt("no_days");
               
                return no_days;
                
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            ex.getMessage();
        }
               return 0;
     }
     
      public String updateResvDate(String reservationId, String newCheckInDate, String newCheckOutDate){
        
        String reservationid = reservationId;
        String newcheckindate = newCheckInDate;
        String newcheckoutdate = newCheckOutDate;
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");

        try {
            java.util.Date newcheckinDate = dateFormat.parse(newcheckindate);
            java.util.Date newcheckoutDate = dateFormat.parse(newcheckoutdate);
            java.sql.Date checkInsql = new java.sql.Date(newcheckinDate.getTime());
            java.sql.Date checkOutsql = new java.sql.Date(newcheckoutDate.getTime());
            Connection con = DBConnection.createConnection();
            
            PreparedStatement pstmt = con.prepareStatement ("UPDATE RESERVATION SET CHECKINDATE = TO_DATE('"+newcheckindate+"','yyyy-mm-dd'), CHECKOUTDATE = TO_DATE('"+newcheckoutdate+"','yyyy-mm-dd') WHERE RESERVATIONID=?");

            pstmt.setString(1, reservationid);
            pstmt.executeUpdate();
            return "Success";

        }
        
        catch(Exception ex){
            ex.printStackTrace();
        }
        return "Invalid";
    }
    public String cancelResv(String reservationId){
        
        String reservationid = reservationId;

        try {
            Connection con = DBConnection.createConnection();
            PreparedStatement pstmt = con.prepareStatement ("UPDATE RESERVATION SET RESERVATIONSTATUS = 'Cancelled' WHERE RESERVATIONID=?");

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
    
    public boolean checkHouse ()
    {
        
        try
        {
            Connection con = DBConnection.createConnection();
            String sql = "Select * from reservation where ACCOID = 'ACCO1'"; //House
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next())
            {
                return true;
            }
            else 
            {
                return false;
            }
            
        }
        catch(Exception ex)
        {
            
        }
        
        return false;
    }
    
    public boolean checkRoomA ()
    {
        
        try
        {
            Connection con = DBConnection.createConnection();
            String sql = "Select * from reservation where ACCOID = 'ACCO2'"; //House
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next())
            {
                return true;
            }
            else 
            {
                return false;
            }
            
        }
        catch(Exception ex)
        {
            
        }
        
        return false;
    }
    
    public boolean checkRoomB ()
    {
        
        try
        {
            Connection con = DBConnection.createConnection();
            String sql = "Select * from reservation where ACCOID = 'ACCO3'"; //House
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next())
            {
                return true;
            }
            else 
            {
                return false;
            }
            
        }
        catch(Exception ex)
        {
            
        }
        
        return false;
    }
    public boolean checkRoomC ()
    {
        
        try
        {
            Connection con = DBConnection.createConnection();
            String sql = "Select * from reservation where ACCOID = 'ACCO4'"; //House
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next())
            {
                return true;
            }
            else 
            {
                return false;
            }
            
        }
        catch(Exception ex)
        {
            
        }
        
        return false;
    }
    
    public ArrayList<Date>checkInDate(String accoid)//change this to function
    {
        ArrayList<Date>arrayCheckInDate= new ArrayList<>();
        try
        {
            Connection con = DBConnection.createConnection();
            //date to be put in the sample
            String sql = "select checkindate from reservation where ACCOID = '"+accoid+"' and reservationstatus = 'Incomplete' or reservationstatus = 'Complete - Not Check In'order by reservationid asc";
        
            PreparedStatement stmt = con.prepareStatement(sql);
            
            ResultSet rs = stmt.executeQuery();
           
            while(rs.next())
            {
                Date checkindate = rs.getDate("checkindate");
                arrayCheckInDate.add(checkindate);
            } 
        }
        catch (Exception ex)
        {
            
        }
        
        return arrayCheckInDate;
        
    }
    
    public ArrayList<Date>checkOutDate(String accoid)//change this to function
    {
        ArrayList<Date>arrayCheckOutDate= new ArrayList<>();
        try
        {
            Connection con = DBConnection.createConnection();
            //date to be put in the sample
            String sql = "select checkoutdate from reservation where ACCOID = '"+accoid+"' and reservationstatus = 'Incomplete' or reservationstatus = 'Complete - Not Check In' order by reservationid asc";
        
            PreparedStatement stmt = con.prepareStatement(sql);
            
            ResultSet rs = stmt.executeQuery();
           
            while(rs.next())
            {
                Date checkindate = rs.getDate("checkoutdate");
                arrayCheckOutDate.add(checkindate);
            } 
        }
        catch (Exception ex)
        {
            
        }
        
        return arrayCheckOutDate;
        
    }

    public ArrayList<Date> checkInDateHouse(String accO1) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public ArrayList<Date> checkOutDateHouse(String accO1) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
