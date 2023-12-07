/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.PaymentDao;
import bean.Payment;
import java.io.File;
import java.io.FileOutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;

@WebServlet("/upload")
@MultipartConfig
/**
 *
 * @author Arif
 */
public class FileUploadServlet extends HttpServlet {

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
            out.println("<title>Servlet FileUploadServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FileUploadServlet at " + request.getContextPath() + "</h1>");
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
       
            
                String paymentid = null;
                String paymentstatus = null;
                String paymenttype =  request.getParameter("selecttype");
                Part filePart = request.getPart("receipt");
                
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                InputStream fileContent = filePart.getInputStream();
                String filePath = "C:\\Users\\Afiq\\OneDrive\\Documents\\NetBeansProjects\\HRS\\web\\Receipt\\";

                // Save the file to the specified path
                FileOutputStream fos = new FileOutputStream(filePath + File.separator + fileName);
                int read = 0;
                final byte[] bytes = new byte[1024];
                while ((read = fileContent.read(bytes)) != -1) {
                    fos.write(bytes, 0, read);
                }
                fos.close();
                
                
                
                String reservationid = request.getParameter("reservationid");
                String custid = request.getParameter("customerId");
                String proofpayment = filePath + fileName;
                
                Payment payment = new Payment(paymentid,paymentstatus,paymenttype,reservationid,custid,proofpayment);
                
                PaymentDao paymentDao = new PaymentDao();
                
                String successupload = paymentDao.uploadReceipt(payment); 
                
                 if (successupload.equalsIgnoreCase("Success")) {
                     
                     request.setAttribute("successMessage", "Success Payment, Thank you!");
                     request.getRequestDispatcher("Home.jsp").forward(request, response);
                 }
                  else {
               
                request.setAttribute("errorMessage", "We're sorry, but we were unable to make a reservation for you at this time. Please try again later.");
                request.getRequestDispatcher("Reservation.jsp").forward(request, response);
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
