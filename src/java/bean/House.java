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
public class House extends Accomodation {
    private int inRoomAvailable;
    

    public House(String accoID, float price, String availability, 
            String status, String type, int inRoomAvailable) {
        super(accoID, price, availability, status, type);
        this.inRoomAvailable = inRoomAvailable;
        
    }

    public void setInRoomAvailable(int inRoomAvailable) {
        this.inRoomAvailable = inRoomAvailable;
    }

   
    public int getInRoomAvailable() {
        return inRoomAvailable;
    }

    
}
