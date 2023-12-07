/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author Afiq
 */
public class ManageRoom {
    private String managesID;
    private Date ManagesDate;
    private Timestamp ManagesTime;

    public ManageRoom(String managesID, Date ManagesDate, Timestamp ManagesTime) {
        this.managesID = managesID;
        this.ManagesDate = ManagesDate;
        this.ManagesTime = ManagesTime;
    }

    public String getManagesID() {
        return managesID;
    }

    public Date getManagesDate() {
        return ManagesDate;
    }

    public Timestamp getManagesTime() {
        return ManagesTime;
    }

    public void setManagesID(String managesID) {
        this.managesID = managesID;
    }

    public void setManagesDate(Date ManagesDate) {
        this.ManagesDate = ManagesDate;
    }

    public void setManagesTime(Timestamp ManagesTime) {
        this.ManagesTime = ManagesTime;
    }
    
}
