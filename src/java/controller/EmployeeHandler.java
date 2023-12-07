/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.EmployeeDao;
import bean.Employee;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 *
 * @author Arif
 */
@WebServlet(name = "EmployeeHandler", urlPatterns = {"/EmployeeHandler"})
public class EmployeeHandler extends HttpServlet {

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
            out.println("<title>Servlet EmployeeHandler</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EmployeeHandler at " + request.getContextPath() + "</h1>");
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
         response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println(request.getContextPath());
        HttpSession session = request.getSession();
        String source = request.getParameter("source");
        
        if (source.equalsIgnoreCase("login"))
        {
            try
            {   
                String name = null;
                String empid = null;
                String phonenum = null;  
                String roles = null;
                String supervise = null;
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                Employee emplogin = new Employee(empid,name,email,phonenum,password,roles,supervise);
                EmployeeDao empDao = new EmployeeDao();

                emplogin = empDao.findAccount(emplogin);

                empid = emplogin.getEmployeeId();
                name = emplogin.getEmployeeName();
                roles = emplogin.getEmployeeRoles();

                String userValidate = empDao.verifyUser(emplogin);

                out.println (userValidate);

                if(userValidate.equals("SUCCESS"))
                {   
                    
                    session.setAttribute("empname",name);
                    session.setAttribute("empid",empid);
                    session.setAttribute("roles",roles);

                    if(roles.equalsIgnoreCase("BillsManager"))
                    {
                        request.getRequestDispatcher("/IndexBillsManager.jsp").forward(request,response);
                    }
                    else if(roles.equalsIgnoreCase("HouseManager"))
                    {
                        request.getRequestDispatcher("/IndexHouseManager.jsp").forward(request,response);
                    }
                }
                else
                {

                    request.setAttribute("errMessage", userValidate);
                    request.getRequestDispatcher("/LoginEmp.jsp").forward(request,response);
                }
            }
            catch(IOException | ServletException ex)
            {
                out.println(ex.getMessage());
            }
        }
        
        else if (source.equalsIgnoreCase("update"))
        {
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
                        .getRequestDispatcher("/updateEmployeeAccount.jsp")
                        .forward(request, response);
                }
                
                String empid = (String) session.getAttribute("empid");
                
                EmployeeDao ed = new EmployeeDao();
                String result = ed.validateUserPassword( empid, password);
                
                if (result.equals("valid")) 
                {
                    String newPassword = request.getParameter("newPassword");
                    
                    if (!(newPassword.equals(""))) {
                        password = newPassword;
                    }
                    
                    String roles = request.getParameter("roles");
                    Employee e = new Employee(empid, name, email, phoneNumber, password,roles ,"");

                    result = ed.updateUser(e);
                    
                } 
                else 
                {
                    String roles = request.getParameter("roles");
                    if(roles.equalsIgnoreCase("BillsManager"))
                    {
                        request.setAttribute("passErr", "Old password is incorrect");
                        request
                        .getRequestDispatcher("/updateEmployeeAccountBM.jsp")
                        .forward(request, response);
                        
                    }
                    else if(roles.equalsIgnoreCase("HouseManager"))
                    {
                        request.setAttribute("passErr", "Old password is incorrect");
                        request
                        .getRequestDispatcher("/updateEmployeeAccountHM.jsp")
                        .forward(request, response);
                    }
                    
                }
                
                if (result.equals("UPDATE SUCCESS")) 
                {
                    
                    String roles = request.getParameter("roles");
                    session.setAttribute("empname",name);
                    session.setAttribute("empid",empid);
                    session.setAttribute("roles",roles);
                    
                    if(roles.equalsIgnoreCase("BillsManager"))
                    {
                        request.setAttribute("updateSuccess", "Your account has been updated");
                        request
                                .getRequestDispatcher("/IndexBillsManager.jsp")
                                .forward(request, response);
                    }
                    else if(roles.equalsIgnoreCase("HouseManager"))
                    {
                        request.setAttribute("updateSuccess", "Your account has been updated");
                        request
                                .getRequestDispatcher("/IndexHouseManager.jsp")
                                .forward(request, response);
                    }
                }
                
                if (result.equals("ERROR")) {
                    String roles = request.getParameter("roles");
                    if(roles.equalsIgnoreCase("BillsManager"))
                    {
                        request.setAttribute("emailError", "Email is tied to a registered account. Please provide another email address");
                        request
                                .getRequestDispatcher("/updateEmployeeAccountBM.jsp")
                                .forward(request, response);
                    }
                    else if(roles.equalsIgnoreCase("HouseManager"))
                    {
                        request.setAttribute("emailError", "Email is tied to a registered account. Please provide another email address");
                        request
                                .getRequestDispatcher("/updateEmployeeAccountHM.jsp")
                                .forward(request, response);
                    }
                    
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
