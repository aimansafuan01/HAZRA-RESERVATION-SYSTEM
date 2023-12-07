/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

/**
 *
 * @author User
 */
public class Room extends Accomodation {
    private int roomNumber;
    

    public Room(String accoID, float price, String availability, 
            String status, String type, int roomNumber) {
        super(accoID, price, availability, status, type);
        this.roomNumber = roomNumber;
        
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

   
    public int getRoomNumber() {
        return roomNumber;
    }

    
}
