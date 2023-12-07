<%@ page import = "java.util.Date,java.text.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<sql:setDataSource var="myDatasource"
driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@DESKTOP-5A4QUNH:1521:XE" user="HRS" password="HRS"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String employeeName = (String) session.getAttribute("empname");
    String employeeid = (String) session.getAttribute("empid");
    String passErr = (String) request.getAttribute("passErr");
    String emailErr = (String) request.getAttribute("emailError");
    String roles = (String) session.getAttribute("roles");
    if(roles == null)
    {
        response.sendRedirect("Login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <title>JSP Page</title>
    </head>
    <body>
  
        <div class="d-flex flex-row justify-content-center bg-light">
        <a class="navbar-brand ">
            <g clip-path="url(#clip0)" fill="#EF3B2D">
                <img style= "width: 100px;" src= "./logo.png" >
            </g>
        </a>
       
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="justify-content-center collapse navbar-collapse mx-4" id="navbarNav">
                    <ul class="navbar-nav">
                      <li class="nav-item mx-4">
                              <a class="nav-link" href="IndexHouseManager.jsp"><h5>Dashboard</h5></a>
                          </li>
                          <li class="nav-item mx-4">
                              <a class="nav-link" href="updateRoomStatus.jsp"><h5>Manage House & Room</h5></a>
                          </li>
                          <li class="nav-item mx-4">
                              <a class="nav-link active" href="updateEmployeeAccountHM.jsp"><h5><b>Update Account</b></h5></a>
                          </li>
                      <li class="nav-item mx-4">
                          ${customerName}
                          <div class="dropdown">
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                  <a class="nav-link"><h5><%= employeeName %></h5></a>
                                </button>
                                <ul class="dropdown-menu">
                                  <li>
                                      <a href="LogoutHandler" class="dropdown-item" >Log out</a>   
                                  </li>
                                </ul>
                          </div>
                      </li>
                    </ul>
                </div>
            </nav>
        </div>
        
        <div class="card">
            <div class="row mx-5">
                <h5>Update Account</h5>
            </div>
        </div> 
        
        <div class="container">
            <div class="container-fluid my-5 pt-2 px-5">
                <div class="shadow bg-light p-4 mx-5 mb-5">  
                    <sql:query var="resultemployee" dataSource="${myDatasource}">
                        SELECT * FROM EMPLOYEE WHERE EMPID = ?
                        <sql:param value="<%=employeeid%>"/>
                    </sql:query>

                    <c:forEach var="result" items="${resultemployee.rows}">
                        <form method="POST" action="EmployeeHandler">
                            <div class="mb-3">
                                <label for="nameInput" class="form-label">Name</label>
                                <input type="text" class="form-control shadow-sm" id="nameInput" name="newName" placeholder="${result.EMPNAME}" value="${param.newName}">
                                <input type="hidden" value="${result.EMPNAME}" name="oldName">
                                <input type="hidden" value="update" name="source">
                                <input type="hidden" name="roles" value="<%=roles%>">
                            </div>
                            <div class="mb-3">
                                <label for="emailnput" class="form-label">Email</label>
                                <input type="text" class="form-control shadow-sm" id="emailInput" name="newEmail" placeholder="${result.EMPEMAIL}" value="${param.newEmail}">
                                <input type="hidden" value="${result.EMPEMAIL}" name="oldEmail">
                                <%
                                    if (emailErr != null) {
                                        out.println("<p style=\"color: red\"><i>" + emailErr + "</i></p>");
                                    }
                                %>
                            </div>
                            <div class="mb-3">
                                <label for="phoneNumInput" class="form-label">Phone Number</label>
                                <input type="text" class="form-control shadow-sm" id="phoneNumInput" name="newPhoneNumber" placeholder="${result.EMPPHONENUM}" value="${param.newPhoneNumber}">
                                <input type="hidden" value="${result.EMPPHONENUM}" name="oldPhoneNumber">
                            </div>
                            <div class="mb-3">
                                <label for="oldPasswordInput" class="form-label">Old Password</label>
                                <input type="password" class="form-control shadow-sm" id="oldPasswordInput" name="password" required>
                                <% 
                                    if (passErr != null) {
                                        out.println("<p style=\"color: red\"><i>" + passErr + "</i></p>");
                                    }
                                %>
                            </div>
                            <div class="mb-3">
                                <label for="newPasswordInput" class="form-label">New Password</label>
                                <input type="password" class="form-control shadow-sm" id="newPasswordInput" name="newPassword" placeholder="Optional">
                            </div>
                            <div class="mb-3">
                                <label for="confirmPasswordInput" class="form-label">Confirm New Password</label>
                                <input type="password" class="form-control shadow-sm" id="confirmPasswordInput" name="newConfirmPassword" placeholder="Optional">
                            </div>
                            <div class="d-grid gap-2 m-3">
                                <button type="submit" class="btn btn-dark btn-lg col-7 mx-auto">Update</button>
                            </div>
                        </form>
                    </c:forEach>
                </div>
            </div>
        </div>  
    </body>
</html>
