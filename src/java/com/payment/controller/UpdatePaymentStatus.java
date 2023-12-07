/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.payment.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 *
 * @author Afiq
 */
public class UpdatePaymentStatus extends HttpServlet {

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
            out.println("<title>Servlet UpdatePaymentStatus</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdatePaymentStatus at " + request.getContextPath() + "</h1>");
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
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String status = request.getParameter("updatevalue");
        String reservationid = request.getParameter("reservationid");
        
        out.println(status + " " + reservationid );
        
        out.println("<h1>Servlet UpdatePaymentStatus at " + request.getContextPath() + "</h1>");
        
       try
        {
            String driver = "oracle.jdbc.OracleDriver";
            String connectionString = "jdbc:derby://localhost:1527/HRS;create=true;user=HRS;password=HRS;";
            Class.forName(driver);
            
            Connection conn = DriverManager.getConnection(connectionString);
            
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select paymenttype,paymentid,paymentstatus from payment where reservationid = '"+reservationid+"'");
            
           if(rs.next())
           {
               String type = rs.getString("paymenttype");
               String id = rs.getString("paymentid");
               String pstatus = rs.getString("paymentstatus");
               if(type.equalsIgnoreCase("partial"))
               {
                   if(pstatus.equalsIgnoreCase("incomplete"))
                   {
                        pstmt = conn.prepareStatement("update payment set paymentstatus =? where paymentid =? " );
                        String newstatus = "Partial-Complete";
                        pstmt.setString(1, newstatus);
                        pstmt.setString(2, id);
                        pstmt.executeUpdate();
                        out.println("done update to partial-complete");
                   }
                   else if(pstatus.equalsIgnoreCase("partial-complete"))
                   {
                        pstmt = conn.prepareStatement("update payment set paymentstatus =? where paymentid =? " );
                        String newstatus = "Complete";
                        pstmt.setString(1, newstatus);
                        pstmt.setString(2, id);
                        pstmt.executeUpdate();
                        out.println("done update to complete");
                   }
                  
               }
               else if(type.equalsIgnoreCase("full-payment"))
               {
                   if(pstatus.equalsIgnoreCase("incomplete"))
                   {
                        pstmt = conn.prepareStatement("update payment set paymentstatus =? where paymentid =? " );
                        String newstatus = "Complete";
                        pstmt.setString(1, newstatus);
                        pstmt.setString(2, id);
                        pstmt.executeUpdate();
                        out.println("done update to complete");
                   }
               }
           }
                
        }
        catch(Exception ex)
        {
            out.println("Error: " + ex.getMessage());
        }
       finally
       {
            out.close();
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
