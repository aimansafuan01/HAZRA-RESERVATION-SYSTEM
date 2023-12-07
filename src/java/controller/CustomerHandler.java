/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;


import dao.CustomerDao;
import dao.LoginDao;
import bean.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
@WebServlet(name = "CustomerHandler", urlPatterns = {"/CustomerHandler"})
public class CustomerHandler extends HttpServlet {

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
            out.println("<title>Servlet LoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
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
        out.println(request.getContextPath());
        HttpSession session = request.getSession();
        String source = request.getParameter("source");
        
        switch (source)
        {
            case "login":
                try
                {   
                    String name = null;
                    String custid = null;
                    String phonenum = null;         
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");

                    Customer custlogin = new Customer(custid,name,email,phonenum,password);
                    CustomerDao custDao = new CustomerDao();

                    custlogin = custDao.findAccount(custlogin);
                    custid = custlogin.getCustId();
                    name = custlogin.getCustName();

                    String userValidate = custDao.verifyUser(custlogin);
                    
                    
                   if(userValidate.equals("SUCCESS"))
                    {   

                        session.setAttribute("custemail",userValidate);
                        session.setAttribute("custname",name);
                        session.setAttribute("custid",custid);
                        request.setAttribute("successMessage", "Welcome to Hazra Homestay Website!");
                        request.getRequestDispatcher("/Home.jsp").forward(request,response);

                    }
                    else
                    {

                        request.setAttribute("errMessage", userValidate);
                        request.getRequestDispatcher("/Login.jsp").forward(request,response);
                    }
                }

                catch(IOException | ServletException ex)
                {
                    out.println(ex.getMessage());
                }
            break;
            
            case "register":
                String custName = request.getParameter("custName");
                String custEmail = request.getParameter("custEmail");
                String custPhoneNum = request.getParameter("custPhoneNum");
                String custPass = request.getParameter("custPass");
                String custConfirmPass = request.getParameter("custConfirmPass");
                String result = "";
                List errMsgs = new LinkedList();
                Customer c = new Customer("", custName, custEmail, custPhoneNum, custPass);
                if (custName == null || custName.trim().length() == 0) {
                    errMsgs.add("");
                    request.setAttribute("nameError", "Please enter your name");
                }
                
                if (custEmail == null || custEmail.trim().length() == 0) {
                    errMsgs.add("");
                    request.setAttribute("emailError", "Please enter your email");          
                }
                
                if (custPhoneNum == null || custPhoneNum.trim().length() == 0) {
                    errMsgs.add("");
                    request.setAttribute("phoneNumError", "Please enter your phone number");
                }
                
                if (custPass == null || custPass.trim().length() == 0) {
                    errMsgs.add("");
                    request.setAttribute("passError", "Please enter your password");
                }
                
                if (custConfirmPass == null || custConfirmPass.trim().length() == 0) {
                    errMsgs.add("");
                    request.setAttribute("confirmPassError", "Please enter your confirm password");
                } else if (!custPass.equals(custConfirmPass)) {
                    errMsgs.add("");
                    request.setAttribute("confirmPassError", "Password and confirm password does not match");
                }
                
                if (errMsgs.isEmpty()){
                    CustomerDao cd = new CustomerDao();
                    try {
                        result = cd.registerUser(c);

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                    request
                        .getRequestDispatcher("/Register.jsp")
                        .forward(request, response);
                }

                if (result.equals("SUCCESS")) {
                    String custid = null;
                    Customer custlogin = new Customer(custid,custName,custEmail,custPhoneNum,custPass);
                    CustomerDao custDao = new CustomerDao();

                    custlogin = custDao.findAccount(custlogin);
                    custid = custlogin.getCustId();
                    custName = custlogin.getCustName();
                    session.setAttribute("custname",custName);
                    session.setAttribute("custid",custid);
                    
                    request.setAttribute("successMessage", "Congratulations. Your account has been registered");
                    request
                        .getRequestDispatcher("/Home.jsp")
                        .forward(request, response);

                }
                
                if (result.equals("ERROR")) {
                    request.setAttribute("emailError", "Email is tied to a registered account. Please provide another email address");
                    request
                        .getRequestDispatcher("/Register.jsp")
                        .forward(request, response);
                }  
                break;
                
                case "update":
                    
                String name = request.getParameter("newName");
                if ( name == null || name.trim().length() == 0) {
                    name = request.getParameter("oldName");
                }
                String email = request.getParameter("newEmail");
                if ( email == null || email.trim().length() == 0) {
                    email = request.getParameter("oldEmail");
                }
                String phoneNumber = request.getParameter("newPhoneNumber");
                if ( phoneNumber == null || phoneNumber.trim().length() == 0) {
                    phoneNumber = request.getParameter("oldPhoneNumber");
                }
                
                String password = request.getParameter("password");
                
                if ( password == null || password.trim().length() == 0) {
                    request.setAttribute("passErr", "Please enter your current password");
                    request
                        .getRequestDispatcher("/updateCustomerAccount.jsp")
                        .forward(request, response);
                }
                
                String custid = (String) session.getAttribute("custid");
                CustomerDao cd = new CustomerDao();
                result = cd.validateUserPassword( custid, password);
                
                if (result.equals("valid")) {
                    String newPassword = request.getParameter("newPassword");
                    
                    if (!(newPassword.equals(""))) {
                        password = newPassword;
                    }

                    c = new Customer(custid, name, email, phoneNumber, password);

                    result = cd.updateUser(c);
                } else {
                    request.setAttribute("passErr", "Old password is incorrect");
                    request
                        .getRequestDispatcher("/updateCustomerAccount.jsp")
                        .forward(request, response);
                }
                
                if (result.equals("UPDATE SUCCESS")) {
                    
                    session.setAttribute("custname",name);
                    session.setAttribute("custid",custid);
                    request.setAttribute("updateSuccess", "Your account has been updated");
                    request
                        .getRequestDispatcher("/Home.jsp")
                        .forward(request, response);
                }
                if (result.equals("ERROR")) {
                    request.setAttribute("emailError", "Email is tied to a registered account. Please provide another email address");
                    request
                        .getRequestDispatcher("/updateCustomerAccount.jsp")
                        .forward(request, response);
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

