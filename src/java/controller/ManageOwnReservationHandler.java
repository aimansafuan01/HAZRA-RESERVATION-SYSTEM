/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;


import dao.PaymentDao;
import dao.ReservationDao;
import bean.Payment;
import bean.Refund;
import java.util.Date;
import bean.Reservation;
import dao.RefundDao;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.PriorityQueue;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.Part;
import util.DBConnection;

/**
 *
 * @author User
 */

@WebServlet(name = "ManageOwnReservationHandler", urlPatterns = {"/ManageOwnReservationHandler"})
public class ManageOwnReservationHandler extends HttpServlet {

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
            out.println("<title>Servlet ManageOwnReserveServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageOwnReserveServlet at " + request.getContextPath() + "</h1>");
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
        //new code algo will be here 
        
        String checkindate = request.getParameter("checkindate");
        String checkoutdate = request.getParameter("checkoutdate");
        
        System.out.println("Checkindate: " + checkindate);
        System.out.println("Checkoutdate: " + checkoutdate);

        //create function that can check inside reservation either already have the reservation with that specific room 
        //if there is no reservation for the specific room then no need to go through this algo 
        //if there is reservation for the specific room then need to go through this algo
        //create function to call checkindate and checkoutdate for every room that not cancelled 
        //
        
        ReservationDao reserveDao = new ReservationDao();
        
        boolean resultCheckHouse = reserveDao.checkHouse();
        boolean resultCheckRoomA = reserveDao.checkRoomA();
        boolean resultCheckRoomB = reserveDao.checkRoomB();
        boolean resultCheckRoomC = reserveDao.checkRoomC();
        
        
        System.out.println(resultCheckHouse);
        
        boolean availabilityHouse = false;
        boolean availabilityRoomA = false; 
        boolean availabilityRoomB = false;
        boolean availabilityRoomC = false;
        
        //check for House 
        if(resultCheckHouse == true)
        {
            System.out.println("in if statement");
            ArrayList<java.sql.Date> checkInDateHouse = reserveDao.checkInDate("ACCO1");
            ArrayList<java.sql.Date> checkOutDateHouse = reserveDao.checkOutDate("ACCO1");
            Date [] sampledateCID = new Date [checkInDateHouse.size()+1];
            Date [] sampledateCOD = new Date [checkOutDateHouse.size()+1];
            
            PriorityQueue<Date>pQueue= new PriorityQueue<>();
            
            for(int i=0; i<checkInDateHouse.size(); i++)
            {
                System.out.println(checkInDateHouse.get(i));
                System.out.println(checkOutDateHouse.get(i));
                sampledateCID[i]=checkInDateHouse.get(i);
                sampledateCOD[i]=checkOutDateHouse.get(i);
            }
            
            SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");
            
            try {
                sampledateCID[checkInDateHouse.size()] = sdformat.parse(checkindate);
                sampledateCOD[checkOutDateHouse.size()] = sdformat.parse(checkoutdate);
            } catch (ParseException ex) {
                Logger.getLogger(ManageOwnReservationHandler.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            int n = sampledateCID.length;
            
            int houseAvailable = 1;
            
            pQueue.add(sampledateCOD[0]);
            
            boolean result = true;

            for(int i=1; i<n;i++)
            {
                if(sampledateCID[i].compareTo(pQueue.peek()) > 0)
                {
                    pQueue.poll();
                }

                pQueue.add(sampledateCID[i]);

                if(pQueue.size()>houseAvailable)
                {
                    result=false;
                }

            }
            
            //set variable and value to send to another page
            availabilityHouse = result;
        }
        else 
        {
            //set variable and value to send to another page
            availabilityHouse = true;
        }
        
        if(resultCheckRoomA == true)
        {
            System.out.println("in if statement");
            ArrayList<java.sql.Date> checkInDateHouse = reserveDao.checkInDate("ACCO2");
            ArrayList<java.sql.Date> checkOutDateHouse = reserveDao.checkOutDate("ACCO2");
            Date [] sampledateCID = new Date [checkInDateHouse.size()+1];
            Date [] sampledateCOD = new Date [checkOutDateHouse.size()+1];
            
            PriorityQueue<Date>pQueue= new PriorityQueue<>();
            
            for(int i=0; i<checkInDateHouse.size(); i++)
            {
                System.out.println(checkInDateHouse.get(i));
                System.out.println(checkOutDateHouse.get(i));
                sampledateCID[i]=checkInDateHouse.get(i);
                sampledateCOD[i]=checkOutDateHouse.get(i);
            }
            
            SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");
            
            try {
                sampledateCID[checkInDateHouse.size()] = sdformat.parse(checkindate);
                sampledateCOD[checkOutDateHouse.size()] = sdformat.parse(checkoutdate);
            } catch (ParseException ex) {
                Logger.getLogger(ManageOwnReservationHandler.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            int n = sampledateCID.length;
            
            int roomAvailable = 1;
            
            pQueue.add(sampledateCOD[0]);
            
            boolean result = true;

            for(int i=1; i<n;i++)
            {
                if(sampledateCID[i].compareTo(pQueue.peek()) > 0)
                {
                    pQueue.poll();
                }

                pQueue.add(sampledateCID[i]);

                if(pQueue.size()>roomAvailable)
                {
                    result=false;
                }

            }
            
            //set variable and value to send to another page
            availabilityRoomA = result;
        }
        else 
        {
            availabilityRoomA = true;
        }
        
        if(resultCheckRoomB == true)
        {
            System.out.println("in if statement");
            ArrayList<java.sql.Date> checkInDateHouse = reserveDao.checkInDate("ACCO1");
            ArrayList<java.sql.Date> checkOutDateHouse = reserveDao.checkOutDate("ACCO1");
            Date[] sampledateCID = new Date[checkInDateHouse.size() + 1];
            Date[] sampledateCOD = new Date[checkOutDateHouse.size() + 1];

            PriorityQueue<Date> pQueue = new PriorityQueue<>();

            for (int i = 0; i < checkInDateHouse.size(); i++) {
                System.out.println(checkInDateHouse.get(i));
                System.out.println(checkOutDateHouse.get(i));
                sampledateCID[i] = checkInDateHouse.get(i);
                sampledateCOD[i] = checkOutDateHouse.get(i);
            }

            SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");

            try {
                sampledateCID[checkInDateHouse.size()] = sdformat.parse(checkindate);
                sampledateCOD[checkOutDateHouse.size()] = sdformat.parse(checkoutdate);
            } catch (ParseException ex) {
                Logger.getLogger(ManageOwnReservationHandler.class.getName()).log(Level.SEVERE, null, ex);
            }

            int n = sampledateCID.length;

            int roomAvailable = 1;

            pQueue.add(sampledateCOD[0]);

            boolean result = true;

            for (int i = 1; i < n; i++) {
                if (sampledateCID[i].compareTo(pQueue.peek()) > 0) {
                    pQueue.poll();
                }

                pQueue.add(sampledateCID[i]);

                if (pQueue.size() > roomAvailable) {
                    result = false;
                }

            }

            //set variable and value to send to another page
            availabilityRoomB = result;
        }
        else 
        {
            availabilityRoomB = true;
        }
        
        if(resultCheckRoomC == true)
        {
            System.out.println("in if statement");
            ArrayList<java.sql.Date> checkInDateHouse = reserveDao.checkInDate("ACCO1");
            ArrayList<java.sql.Date> checkOutDateHouse = reserveDao.checkOutDate("ACCO1");
            Date[] sampledateCID = new Date[checkInDateHouse.size() + 1];
            Date[] sampledateCOD = new Date[checkOutDateHouse.size() + 1];

            PriorityQueue<Date> pQueue = new PriorityQueue<>();

            for (int i = 0; i < checkInDateHouse.size(); i++) {
                System.out.println(checkInDateHouse.get(i));
                System.out.println(checkOutDateHouse.get(i));
                sampledateCID[i] = checkInDateHouse.get(i);
                sampledateCOD[i] = checkOutDateHouse.get(i);
            }

            SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");

            try {
                sampledateCID[checkInDateHouse.size()] = sdformat.parse(checkindate);
                sampledateCOD[checkOutDateHouse.size()] = sdformat.parse(checkoutdate);
            } catch (ParseException ex) {
                Logger.getLogger(ManageOwnReservationHandler.class.getName()).log(Level.SEVERE, null, ex);
            }

            int n = sampledateCID.length;

            int roomAvailable = 1;

            pQueue.add(sampledateCOD[0]);

            boolean result = true;

            for (int i = 1; i < n; i++) {
                if (sampledateCID[i].compareTo(pQueue.peek()) > 0) {
                    pQueue.poll();
                }

                pQueue.add(sampledateCID[i]);

                if (pQueue.size() > roomAvailable) {
                    result = false;
                }

            }

            //set variable and value to send to another page
            availabilityRoomC = result;
        }
        else 
        {
            availabilityRoomC = true;
        }
        
        request.setAttribute("resultHouse", availabilityHouse);
        request.setAttribute("resultRoomA", availabilityRoomA);
        request.setAttribute("resultRoomB", availabilityRoomB);
        request.setAttribute("resultRoomC", availabilityRoomC);
        request.setAttribute("checkindate", checkindate);
        request.setAttribute("checkoutdate", checkoutdate);
        request.getRequestDispatcher("Houseroom.jsp").forward(request, response);
        
        System.out.println("result in handler");
        System.out.println("resultHouse : " + availabilityHouse);
        System.out.println("result House : " + availabilityRoomA);
        System.out.println("result House : " + availabilityRoomB);                                
        System.out.println("result House : " + availabilityRoomC);


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
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        out.println(request.getContextPath());
        String method = request.getParameter("method");
        
    if (method.equalsIgnoreCase("Reserve"))
    {
        try {
            
            
            String reserveid = null;
            String  strindate = request.getParameter("checkindate");
            String  stroutdate = request.getParameter("checkoutdate");
            
           
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date checkindate = dateFormat.parse(strindate);
            java.util.Date checkoutdate = dateFormat.parse(stroutdate);
            String reservationstatus = null;
            String accoid = request.getParameter("accomodationId");
            String custid = request.getParameter("customerId");
            Date reservationdate = null;
          
            Reservation reservation = new Reservation(reserveid,checkindate,checkoutdate,reservationstatus,reservationdate,custid,accoid);
            ReservationDao reserveDao = new ReservationDao();
            String reservationid = reserveDao.makeReservation(reservation);
            
          if (reservationid.equalsIgnoreCase(reservationid)) {
              
                String paymentid = null;
                String paymentstatus = "Incomplete";
                String paymenttype = null;
                String proofpayment =null;
                
                Payment payment = new Payment(paymentid,paymentstatus,paymenttype,reservationid,custid,proofpayment);
                
                PaymentDao paymentDao = new PaymentDao();
                
                String successcreate = paymentDao.createPaymentid(payment); 
                   
          if (successcreate.equalsIgnoreCase("Success")) {
              
              
              request.setAttribute("payment", payment);
              
              Integer numberdays = reserveDao.calculatedate(reservationid);
               
                
             String accopriceString = request.getParameter("accoprice");
             float accoprice = Float.parseFloat(accopriceString);
             
             
             float totalpayment = payment.calculateTotalPayment(accoprice, numberdays);
             
             
             
             request.setAttribute("reservationid", reservationid);
             request.setAttribute("totalpayment", totalpayment);
             
              request.getRequestDispatcher("CustomerPayment.jsp").forward(request, response);
          }
           else {
               
                request.setAttribute("errorMessage", "We're sorry, but we were unable to make a reservation for you at this time. Please try again later.");
                request.getRequestDispatcher("Reservation.jsp").forward(request, response);
            }
                
           
          } else {
               
                request.setAttribute("errorMessage", "We're sorry, but we were unable to make a reservation for you at this time. Please try again later.");
                request.getRequestDispatcher("Reservation.jsp").forward(request, response);
            }
          
        }  
       catch(IOException | ServletException ex)
        {
            out.println(ex.getMessage());
        } 
        catch (ParseException ex) 
        {
            Logger.getLogger(ManageOwnReservationHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    } 
    else if (method.equalsIgnoreCase("updateResv")) {
            try {
                String reservationid = request.getParameter("reservationid");
                String newcheckindate = request.getParameter("newcheckindate");
                String newcheckoutdate = request.getParameter("newcheckoutdate");
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date newcheckinDate = dateFormat.parse(newcheckindate);
                java.util.Date newcheckoutDate = dateFormat.parse(newcheckoutdate);
                
                Reservation reservationobj = new Reservation();
                ReservationDao reservedao = new ReservationDao();
                String result = reservedao.updateResvDate(reservationid, newcheckindate, newcheckoutdate);
                if(result.equalsIgnoreCase("Success"))
                {
                    out.println("Reservation date has been successfully updated.");
                    reservationobj.setCheckInDate(newcheckinDate);
                    reservationobj.setCheckOutDate(newcheckoutDate);
                    response.sendRedirect("CustomerReservationList.jsp");
                }
            }
            catch(Exception ex) {
            out.println(ex.getMessage());
            }
        }
        else if (method.equalsIgnoreCase("cancelResv")) {
            try {
                String reservationid = request.getParameter("reservationid");
                
                ReservationDao reservedao = new ReservationDao();
                String result = reservedao.cancelResv(reservationid);
                
                Connection conn = DBConnection.createConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT PAYMENTTYPE FROM PAYMENT WHERE RESERVATIONID = '"+reservationid+"'");
                
   
                if(rs.next())
                {
                    String paymenttype = rs.getString("paymenttype");
                    if(result.equalsIgnoreCase("Success"))
                    {
                        
                        Payment paymentobj = new Payment();
                        PaymentDao paymentdao = new PaymentDao();
                        String result1 = paymentdao.cancelResv(reservationid);
                    
                        if(result1.equalsIgnoreCase("Success"))
                        {
                            
                            String beforeResv = request.getParameter("beforeResv");
                            int before = Integer.parseInt(beforeResv);
                            if(before < 7)
                            {
                                if(paymenttype.equalsIgnoreCase("Full-Payment"))
                                {
                                    String refundType = "Partial Refund";
                                    Refund refundobj = new Refund();
                                    RefundDao refunddao = new RefundDao();
                                    String result2 = refunddao.makeRefund(reservationid, refundType);
                                    
                                    if(result2.equalsIgnoreCase("Success"))
                                    {
                                        out.println("Refund has been successfully created.");
                                        response.sendRedirect("CustomerReservationList.jsp");
                                    }
                                }
                                else if(paymenttype.equalsIgnoreCase("Partial"))
                                {
                                    String refundType = "Full Refund";
                                    Refund refundobj = new Refund();
                                    RefundDao refunddao = new RefundDao();
                                    String result2 = refunddao.makeRefund(reservationid, refundType);
                                    
                                    if(result2.equalsIgnoreCase("Success"))
                                    {
                                        out.println("Refund has been successfully created.");
                                        response.sendRedirect("CustomerReservationList.jsp");
                                    }
                                }
                            }
                            else if(before >= 7)
                            {
                                if(paymenttype.equalsIgnoreCase("Full-Payment"))
                                {
                                    String refundType = "Full Refund";
                                    Refund refundobj = new Refund();
                                    RefundDao refunddao = new RefundDao();
                                    String result2 = refunddao.makeRefund(reservationid, refundType);
                                    
                                    if(result2.equalsIgnoreCase("Success"))
                                    {
                                        out.println("Refund has been successfully created.");
                                        response.sendRedirect("CustomerReservationList.jsp");
                                    }
                                }
                                else if(paymenttype.equalsIgnoreCase("Partial"))
                                {
                                    String refundType = "Full Refund";
                                    Refund refundobj = new Refund();
                                    RefundDao refunddao = new RefundDao();
                                    String result2 = refunddao.makeRefund(reservationid, refundType);
                                   
                                    if(result2.equalsIgnoreCase("Success"))
                                    {
                                        out.println("Refund has been successfully created.");
                                        response.sendRedirect("CustomerReservationList.jsp");
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
            catch(Exception ex) {
            out.println(ex.getMessage());
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
