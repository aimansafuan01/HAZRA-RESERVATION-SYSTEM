<%@ page import = "java.util.Date,java.text.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
 <sql:setDataSource var="myDatasource"
    driver="oracle.jdbc.driver.OracleDriver"
    url="jdbc:oracle:thin:@DESKTOP-5A4QUNH:1521:XE" user="HRS" password="HRS"/>
<%-- 
    Document   : UpdateCustomerReservation
    Created on : Dec 31, 2022, 12:43:16 AM
    Author     : Afiq
--%>
<%
  String roles = (String) session.getAttribute("roles");
  if(roles == null)
  {
      response.sendRedirect("Login.jsp");
  }
  else if(!(roles.equalsIgnoreCase("BillsManager")))
  {
      response.sendRedirect("Login.jsp");
  }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <img style= "width: 100px;" src= "logo.png" >
                </g>
            </a>
            
            
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                
                    <div class="justify-content-center collapse navbar-collapse mx-4" id="navbarNav">
                        <ul class="navbar-nav">
                          <li class="nav-item mx-4">
                              <a class="nav-link" href="IndexBillsManager.jsp"><h5>Dashboard</h5></a>
                          </li>
                          <li class="nav-item mx-4">
                              <a class="nav-link" href="UpdateReservationStatus.jsp"><h5>Manage Reservations</h5></a>
                          </li>
                          <li class="nav-item mx-4">
                              <a class="nav-link " href="UpdatePaymentStatus.jsp"><h5>Payment Details</h5></a>
                          </li>
                          <li class="nav-item mx-4">
                              <a class="nav-link active" href="UpdateRefundStatus.jsp"><h5><b>Refund Details</b></h5></a>
                          </li>
                          <li class="nav-item mx-4">
                              <a class="nav-link" href="updateEmployeeAccountBM.jsp"><h5>Update Account</h5></a>
                          </li>
                          <li>
                            <%
                                String empName = (String) session.getAttribute("empname");
                            %>
                              <div class="dropdown">
                                <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                    <h5><%=empName%></h5>
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                   <li><a class="dropdown-item" href="Analysis.jsp">Analysis</a></li>
                                  <li><a class="dropdown-item" href="LogoutHandler">Logout</a></li>
                                </ul>
                              </div>
                          </li>
                        </ul>
                    </div>
                </nav>
        </div>
        
        <div class="card">
            <div class="row mx-5">
                <h5>Update Refund Status</h5>
            </div>
        </div> 
            
        <div class="container">
            <div class="container-fluid my-5 pt-5 px-5">
                <div class="row justify-content-center px-4">
                    <div class="card text">
                        <div class="card-body">
                            
                            <sql:query var="result" dataSource="${myDatasource}">
                                SELECT * FROM REFUND order by refundid asc
                            </sql:query>
                               
                            <table class="table">
                                <thead>
                                  <tr>
                                    <th scope="col" style="text-align:center;">Refund ID</th>
                                    <th scope="col" style="text-align:center;">Refund Description</th>
                                    <th scope="col" style="text-align:center;">Action</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <c:forEach var="resultrow" items="${result.rows}">
                                  <tr>
                                      <th scope="row" style="text-align:center;"><c:out value="${resultrow.refundid}"/></th>
                                    <td>
                                        <!--continue here -->
                                        
                                        <sql:query var="result2" dataSource="${myDatasource}">
                                            SELECT * FROM reservation WHERE reservationid = ?
                                            <sql:param value="${resultrow.reservationid}"/>
                                        </sql:query>
                                        
                                        <c:forEach var="result2row" items="${result2.rows}">
                                            <c:set var="reservationid" value="${result2row.reservationid}"/>
                                            <c:set var="reservationdate" value="${result2row.reservationdate}"/>
                                        </c:forEach>

                                            <p>Reservation ID:<b> <c:out value="${reservationid}"/></b></p>
                                        <p>Reservation Date: <fmt:formatDate type = "date" value="${reservationdate}"/> </p>
                                        
                                        <c:if test="${resultrow.refundstatus == 'Incomplete'}">
                                            <p>Refund Status: <b style="color:red;"><c:out value="${resultrow.refundstatus}"/></b></p>
                                        </c:if>
                                        <c:if test="${resultrow.refundstatus == 'Complete'}">
                                            <p>Refund Status: <b style="color:green;"><c:out value="${resultrow.refundstatus}"/></b></p>
                                        </c:if>
                                       
                                    </td>
                                    <td>
                                    <div class="d-flex justify-content-around ">
                                        <c:if test="${resultrow.refundstatus == 'Incomplete'}">
                                            <button class="btn btn-outline-secondary" value="Update Check-Out" id="button-addon2" data-bs-toggle="modal" data-bs-target="#modal1">
                                                Update Refund Status
                                            </button>
                                        <!--modal-->
                                            <div class="modal fade" id="modal1"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Alert</h5>
                                                             <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                            <div class="modal-body">
                                                            Please make sure that <b>customer refund is already been done </b>
                                                            </div>
                                                        <div class="modal-footer">
                                                            <form action="managecustomerreservation" method="POST">
                                                                <input type="hidden" value="${resultrow.refundid}" name="reservationid">
                                                                <input type="hidden" value="updaterefundstatus" name="valuemethod">
                                                                 <input type="hidden" value="approve" name="updatevalue">
                                                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                                <button type="submit" class="btn btn-success" >Complete</button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${resultrow.refundstatus == 'Complete'}">
                                            <button class="btn btn-outline-secondary" value="Update Check-Out" id="button-addon2" data-bs-toggle="modal" data-bs-target="#modal2">
                                                Update Refund Status
                                            </button>
                                        <!--modal-->
                                            <div class="modal fade" id="modal2"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Alert</h5>
                                                             <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                            <div class="modal-body">
                                                            The refund is already been <b>done</b>
                                                            </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-success" data-bs-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                        
                                    </div>
                                    </td>
                                  </tr>
                                  </c:forEach>
                                </tbody>
                              </table>
                        </div>
                    </div>
                </div>
            </div>
                
            
        </div>
    </body>
</html>
