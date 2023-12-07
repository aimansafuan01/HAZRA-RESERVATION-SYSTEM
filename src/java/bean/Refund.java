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
public class Refund {
    
    private String refundID;
    private String refundType;
    private String refundStatus;
    
    public Refund() {
    }

    public Refund(String refundID, String refundType, String refundStatus) {
        this.refundID = refundID;
        this.refundType = refundType;
        this.refundStatus = refundStatus;
    }

    public String getRefundID() {
        return refundID;
    }

    public String getRefundType() {
        return refundType;
    }

    public String getRefundStatus() {
        return refundStatus;
    }

    public void setRefundID(String refundID) {
        this.refundID = refundID;
    }

    public void setRefundType(String refundType) {
        this.refundType = refundType;
    }

    public void setRefundStatus(String refundStatus) {
        this.refundStatus = refundStatus;
    }
    
    
    
}
