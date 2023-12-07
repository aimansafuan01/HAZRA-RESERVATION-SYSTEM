/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

/**
 *
 * @author Afiq
 */
public class Payment implements java.io.Serializable{
    String paymentID; 
    String paymentStatus;
    String paymentType; 
    float totalPayment;
    String reservationid;
    String custid;
    String proofpayment;

    public Payment()
    {
        
    }
    
    public Payment(String paymentId,String paymentStatus,String paymentType,String reservationid,String custid,String proofpayment) {
         this.paymentID = paymentId;
        this.paymentStatus = paymentStatus;
        this.paymentType = paymentType;
        this.reservationid = reservationid;
        this.custid = custid;
        this.proofpayment = proofpayment;
    }

    public String getPaymentID() {
        return paymentID;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public float getTotalPayment() {
        return totalPayment;
    }

    public String getReservationid() {
        return reservationid;
    }

    public String getCustid() {
        return custid;
    }

    public String getProofpayment() {
        return proofpayment;
    }
    
    public void setPaymentID(String paymentID) {
        this.paymentID = paymentID;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public void setTotalPayment(float totalPayment) {
        this.totalPayment = totalPayment;
    }
    
    public Float calculateTotalPayment(float accoprice,Integer days){
        totalPayment = accoprice * days;
        return totalPayment;
    }
    public void setReservationid(String reservationid) {
        this.reservationid = reservationid;
    }

    public void setCustid(String custid) {
        this.custid = custid;
    }

    public void setProofpayment(String proofpayment) {
        this.proofpayment = proofpayment;
    }
    
    
}
