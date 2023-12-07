/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.util.Date;

/**
 *
 * @author Afiq
 */
public class Reservation implements java.io.Serializable {
    String reservationID;
    Date checkInDate = new Date();
    Date checkOutDate = new Date();
    String reservationStatus;
    Date reservationDate = new Date();
    String custid;
    String accoid;
    
    public Reservation()
    {
        
    }

    public Reservation(String reservationID,Date checkInDate, Date checkOutDate,String reservationStatus,Date reservationDate,String custid,String accoid) {
         this.reservationID = reservationID;
         this.checkInDate = checkInDate ;
         this.checkOutDate = checkOutDate;
         this.reservationStatus = reservationStatus;
         this.reservationDate = reservationDate;
         this.custid = custid ;
         this.accoid = accoid ;
    }

    public String getReservationid() {
        return reservationID;
    }

    public Date getCheckInDate() {
        return checkInDate;
    }

    public Date getCheckOutDate() {
        return checkOutDate;
    }

    public String getReservationStatus() {
        return reservationStatus;
    }

    public Date getReservationDate() {
        return reservationDate;
    }

    public void setReservationid(String reservationid) {
        this.reservationID = reservationid;
    }

    public void setCheckInDate(Date checkInDate) {
        this.checkInDate = checkInDate;
    }

    public void setCheckOutDate(Date checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public void setReservationStatus(String reservationStatus) {
        this.reservationStatus = reservationStatus;
    }

    public void setReservationDate(Date reservationDate) {
        this.reservationDate = reservationDate;
    }

    public String getReservationID() {
        return reservationID;
    }

    public String getCustId() {
        return custid;
    }

    public String getAccoId() {
        return accoid;
    }

    public void setReservationID(String reservationID) {
        this.reservationID = reservationID;
    }

    public void setCustid(String custid) {
        this.custid = custid;
    }

    public void setAccoid(String accoid) {
        this.accoid = accoid;
    }
    
   
    
    

}
