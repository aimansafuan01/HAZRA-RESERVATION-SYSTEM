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
public class Accomodation {
    private String accoID;
    private float accoPrice;
    private String accoStatus;
    private String accoType;
    private String accoAvailalbility;
    
    public Accomodation(String accoID,float price,String availability, 
            String status, String type){
        
        this.accoID = accoID;
        accoPrice = price;
        accoStatus = status;
        accoType = type;
        accoAvailalbility = availability;
    }
    
    public void setAccoPrice(float price){
        accoPrice = price;
    }
    
     public void setAccoStatus(String status){
        accoStatus = status;
    }
    public void setAccoType(String type){
        accoType = type;
    } 
    public void setAccoAvailability(String availability){
        accoAvailalbility = availability;
    }
    
    public String getAccoID(){
        return accoID;
    } 
    public float getAccoPrice(){
        return accoPrice;
    } 
    public String getAccoType(){
        return accoType;
    } 
     public String getAccoStatus(){
        return accoStatus;
    } 
    public String getAccoAvailability(){
        return accoAvailalbility;
    } 
}

