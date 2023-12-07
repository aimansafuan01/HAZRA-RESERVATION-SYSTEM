/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

/**
 *
 * @author Arif
 */
public class Employee implements java.io.Serializable{
   
    private String empID;
    private String empName;
    private String empEmail ;
    private String empPass;
    private String empPhoneNum;
    private String empRoles;
    private String empSupervise;
    
    public Employee (String empID,String empName,String empEmail,String empPhoneNum,String empPass,String empRoles, String empSupervise)
    {
       this.empID = empID;
       this.empName = empName;
       this.empEmail = empEmail;
       this.empPhoneNum = empPhoneNum;
       this.empPass = empPass;
       this.empRoles = empRoles;
       this.empSupervise = empSupervise;
    }
    
    public String getEmployeeId(){
        return empID;
    }
    public String getEmployeeName(){
        return empName;
    }
    public String getEmployeeEmail(){
        return empEmail;
    }
    public String getEmployeePhoneNum(){
        return empPhoneNum;
    }
    public String getEmployeePass(){
        return empPass;
    }
    public String getEmployeeRoles(){
        return empRoles;
    }

    public String getEmpSupervise() {
        return empSupervise;
    }
    
    public void setEmployeeId(String empID ){
        this.empID = empID;
    }
    public void setEmployeeName(String empName ){
        this.empName = empName;
    }
    public void setEmployeeEmail(String empEmail ){
        this.empEmail = empEmail;
    }
    public void setEmployeePhoneNum(String empPhoneNum ){
        this.empPhoneNum = empPhoneNum;
    }
    public void setEmployeePass(String empPass ){
        this.empPass = empPass;
    }
    public void setEmployeeRoles(String empRoles ){
        this.empRoles = empRoles;
    }

    public void setEmpSupervise(String empSupervise) {
        this.empSupervise = empSupervise;
    }
    
}
