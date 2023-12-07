/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import bean.Payment;
import bean.Refund;
import bean.Reservation;
import dao.PaymentDao;
import dao.RefundDao;
import dao.ReservationDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Afiq
 */
public class ManageCustomerReservationHandler extends HttpServlet {
    
    private PreparedStatement pstmt;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageCustomerReservationHandlerController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageCustomerReservationHandlerController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        //processRequest(request, response);
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String updatevalue = request.getParameter("updatevalue");
        String reservationid = request.getParameter("reservationid");
        
        out.println(updatevalue + " " + reservationid );
        
        String valuemethod = request.getParameter("valuemethod");
        //use 
       if(updatevalue.equalsIgnoreCase("approve"))
       {
            if(valuemethod.equalsIgnoreCase("updatepaymentstatus"))
            {
                Payment paymentobj = new Payment();
                
                Reservation reservationobj = new Reservation();
                
                PaymentDao paymentdao = new PaymentDao();
                
                ReservationDao reservationdao = new ReservationDao();

                String result = paymentdao.updateStatus(reservationid);
              
                
                if(result.equalsIgnoreCase("SUCCESS_PPC"))
                {
                    paymentobj.setPaymentStatus("Partial_Complete");
                    response.sendRedirect("UpdatePaymentStatus.jsp");
                }
                else if (result.equalsIgnoreCase("SUCCESS_PC"))
                {
                    paymentobj.setPaymentStatus("Complete");
                    
                    String result2 = reservationdao.updateStatus(reservationid);
                    if(result2.equalsIgnoreCase("SUCCESS"))
                    {
                        reservationobj.setReservationStatus("Complete - Not Check In");
                        response.sendRedirect("UpdatePaymentStatus.jsp");
                    }
                    
                }
                else if(result.equalsIgnoreCase("SUCCESS_FC"))
                {
                    paymentobj.setPaymentStatus("Complete");
                    String result2 = reservationdao.updateStatus(reservationid);
                    if(result2.equalsIgnoreCase("SUCCESS"))
                    {
                        reservationobj.setReservationStatus("Complete - Not Check In");
                        response.sendRedirect("UpdatePaymentStatus.jsp");
                    }
                }
                
            }
            else if(valuemethod.equalsIgnoreCase("updatereservationstatus"))
            {

                Reservation reservationobj = new Reservation();
                
                ReservationDao reservationdao = new ReservationDao();
                
                String checkvalue = request.getParameter("checkvalue");
                
                if(checkvalue.equalsIgnoreCase("updatecheckin"))
                {
                    String result = reservationdao.updateCheckIn(reservationid);
                    if(result.equalsIgnoreCase("SUCCESS"))
                    {
                        reservationobj.setReservationStatus("Complete Check In");
                        response.sendRedirect("UpdateReservationStatus.jsp");
                    }
                }
                else if(checkvalue.equalsIgnoreCase("updatecheckout"))
                {
                    String result = reservationdao.updateCheckOut(reservationid);
                
                    if(result.equalsIgnoreCase("SUCCESS"))
                    {
                        reservationobj.setReservationStatus("Complete Check Out");
                        response.sendRedirect("UpdateReservationStatus.jsp");
                    }
                }
                
            }
            else if(valuemethod.equalsIgnoreCase("updaterefundstatus"))
            {
                Refund refundobj = new Refund();
                
                RefundDao refunddao = new RefundDao();
                
                String refundid = reservationid;
                
                String result = refunddao.updateRefundStatus(refundid);
                
                if(result.equalsIgnoreCase("SUCCESS"))
                {
                    refundobj.setRefundStatus("Complete");
                    response.sendRedirect("UpdateRefundStatus.jsp");
                }
                
            }
       }
       else 
       {
          
            if(valuemethod.equalsIgnoreCase("updatepaymentstatus"))
            {
                response.sendRedirect("UpdatePaymentStatus.jsp");
            }
            else if(valuemethod.equalsIgnoreCase("updatereservationstatus"))
            { 
                response.sendRedirect("UpdateReservationStatus.jsp");
            }
            else if(valuemethod.equalsIgnoreCase("updaterefundstatus"))
            {
                response.sendRedirect("UpdateRefundStatus.jsp");
            }
       }
       
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
