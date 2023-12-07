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
public class Customer implements java.io.Serializable{
   
    private String custID;
    private String custName;
    private String custEmail;
    private String custPhoneNum;
    private String custPassword;
    
    public Customer (String custID,String custName,String custEmail,String custPhoneNum,String custPassword){
       this.custID = custID;
       this.custName = custName;
       this.custEmail = custEmail;
       this.custPhoneNum = custPhoneNum;
       this.custPassword = custPassword;
     
    }
    
    public String getCustId(){
        return custID;
    }
    public String getCustName(){
        return custName;
    }
    public String getCustEmail(){
        return custEmail;
    }
    public String getCustPhoneNum(){
        return custPhoneNum;
    }
    public String getCustPassword(){
        return custPassword;
    }
    
    
    public void setCustId(String custID ){
        this.custID = custID;
    }
    public void setCustName(String custName ){
        this.custName = custName;
    }
    public void setCustEmail(String custEmail ){
        this.custEmail = custEmail;
    }
    public void setCustPhoneNum(String custPhoneNum ){
        this.custPhoneNum = custPhoneNum;
    }
    public void setCustPassword(String custPassword ){
        this.custPassword = custPassword;
    }
    
}
