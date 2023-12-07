<%@ page import = "java.util.Date,java.text.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                              <a class="nav-link active" href="UpdatePaymentStatus.jsp"><h5><b>Payment Details</b></h5></a>
                          </li>
                          <li class="nav-item mx-4">
                              <a class="nav-link " href="UpdateRefundStatus.jsp"><h5>Refund Details</h5></a>
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
                <h5>Update Payment Status</h5>
            </div>
        </div> 
                                
        <div class="container">
            <div class="container-fluid my-5 pt-2 px-5">
                <div class="row justify-content-center px-4">
                    <div class="card text">
                        <div class="card-body">
                            <sql:query var="result" dataSource="${myDatasource}">
                                SELECT reservationid,checkindate, checkoutdate,accoid from HRS.RESERVATION order by reservationid ASC
                            </sql:query>
                            <table class="table">
                                <thead>
                                  <tr>
                                    <th scope="col" style="text-align:center;">Reservation ID</th>
                                    <th scope="col" style="text-align:center;">Reservation Description</th>
                                    <th scope="col" style="text-align:center;">Action</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <c:forEach var="resultrow" items="${result.rows}">     
                                  <tr>
                                        <th scope="row">
                                            <c:out value="${resultrow.reservationid}"/>
                                        </th>
                                    <td>
                                        
                                        <c:set var="accoid" value="${resultrow.accoid}"/>
                                        <c:set var="reservationid" value="${resultrow.reservationid}"/>
                                        
                                        <sql:query var="resultroom" dataSource="${myDatasource}">
                                            SELECT accoType FROM ACCOMODATION WHERE accoid = ?
                                            <sql:param value="${accoid}"/>
                                        </sql:query>
                                            
                                        <c:forEach var="result2" items="${resultroom.rows}">
                                            <p>Room Type: <c:out value="${result2.accotype}" /></p>
                                        </c:forEach>
                                                 
                                        <p>Check In Date: <fmt:formatDate type = "date" value="${resultrow.checkindate}"/></p>
                                        <p>Check Out Date: <fmt:formatDate type = "date" value="${resultrow.checkoutdate}"/></p>
                                       
                                        <sql:query var="resultpayment" dataSource="${myDatasource}">
                                            SELECT *  FROM payment WHERE RESERVATIONID = ?
                                            <sql:param value="${reservationid}"/>
                                        </sql:query>
                                            
                                        <c:forEach var="resultpayment" items="${resultpayment.rows}">
                                            <c:set var="paymentstatus" value="${resultpayment.paymentstatus}"/>
                                            <p>Payment Type: <b><c:out value="${resultpayment.paymenttype}" /></b></p>
                                        </c:forEach>         

                                            <c:if test="${paymentstatus == 'Incomplete'}">
                                                <p>Payment Status: <b style="color:red;"><c:out value="${paymentstatus}" /></b></p>
                                            </c:if>
                                                    
                                            <c:if test="${paymentstatus == 'Partial-Complete'}">
                                                <p>Payment Status: <b style="color:red;"><c:out value="${paymentstatus}" /></b></p>
                                            </c:if>
                                                    
                                            <c:if test="${paymentstatus == 'Complete'}"> 
                                                <p>Payment Status: <b style="color:green;"><c:out value="${paymentstatus}" /></b></p>
                                            </c:if>
                                                
                                            <c:if test="${paymentstatus == 'Request-Refund'}"> 
                                                <p>Payment Status: <b style="color:red;"><c:out value="${paymentstatus}" /></b></p>
                                                <p><b style="color:red;">*</b>Please update refund status at <b>Refund Details</b></p>
                                            </c:if>       
                                           
                                        
                                    </td>
                                    <td>
                                    
                                    <sql:query var="resultpayment" dataSource="${myDatasource}">
                                        SELECT * FROM payment WHERE RESERVATIONID = ?
                                        <sql:param value="${reservationid}"/>
                                    </sql:query>
                                    <div class="d-flex justify-content-around">
                                                               
                                        <a class="btn btn-outline-secondary primary" data-bs-toggle="collapse" href="#collapse<c:out value="${resultrow.reservationid}"/>1" role="button" aria-expanded="false" aria-controls="collapseExample">
                                            Proof Payment
                                        </a>
                                        
                                        
                                        
                                        <c:forEach var="resultpayment" items="${resultpayment.rows}">
                                            <c:set var="paymenttype" value="${resultpayment.paymenttype}"/>
                                            <c:set var="paymentstatus" value="${resultpayment.paymentstatus}"/>
                                            <c:set var="reservationid" value="${resultpayment.reservationid}"/>
                                            <c:set var="proofpayment" value="${resultpayment.proofpayment}"/>
                                        </c:forEach>
                                            
                                        
                                        <c:if test="${fn:containsIgnoreCase(paymenttype, 'partial')}">
                                            
                                            <c:if test="${fn:containsIgnoreCase(paymentstatus, 'incomplete')}">
                                                <!--<p>Partial Payment - incomplete</p>-->
                                                <a class="btn btn-outline-secondary primary" data-bs-toggle="collapse" href="#collapse<c:out value="${resultrow.reservationid}"/>" role="button" aria-expanded="false" aria-controls="collapseExample">
                                                    Update Payment Status
                                                </a>
                                                
                                                <div class="collapse" id="collapse<c:out value="${reservationid}"/>">
                                                    <div class="d-flex">
                                                            <form action="managecustomerreservation" method="POST">
                                                                <div class="input-group">
                                                                    <select class="form-select" aria-label="Default select example" name="updatevalue">
                                                                        <option value="approve">Approve</option>
                                                                        <option value="notapprove" selected>Not Approve</option>
                                                                    </select>
                                                                    <input type="hidden" value="${resultrow.reservationid}" name="reservationid">
                                                                    <input type="hidden" value="updatepaymentstatus" name="valuemethod">
                                                                    <input type="submit" class="btn btn-outline-secondary" value="Save" id="button-addon2">
                                                              </div>
                                                            </form>
                                                    </div>
                                                </div>   
                                            </c:if>
                                                
                                            <c:if test="${fn:containsIgnoreCase(paymentstatus, 'partial-complete')}">
                                                <!--<p>Partial Payment - partial-complete</p>-->
                                                <a class="btn btn-outline-secondary primary" data-bs-toggle="collapse" href="#collapse<c:out value="${resultrow.reservationid}"/>" role="button" aria-expanded="false" aria-controls="collapseExample">
                                                    Update Payment Status
                                                </a>
                                                <div class="collapse" id="collapse<c:out value="${resultrow.reservationid}"/>">
                                                    <div class="d-flex">
                                                        <div class="input-group">
                                                            
                                                            <select class="form-select" aria-label="Default select example" name="updatevalue" form="P-PCform">
                                                                <option value="approve">Approve</option>
                                                                <option value="notapprove" disabled>Not Approve</option>
                                                            </select>
                                                            
                                                            <input type="button" class="btn btn-outline-secondary" value="Save" id="button-addon2" data-bs-toggle="modal" data-bs-target="#modal<c:out value="${resultrow.reservationid}"/>" >
                                                            
                                                        </div>
                                                    </div> 
                                                </div>    
                                                    
                                                <!--Modal-->
                                                <div class="modal fade" id="modal<c:out value="${resultrow.reservationid}"/>"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                      <div class="modal-content">
                                                        <div class="modal-header">
                                                          <h5 class="modal-title" id="exampleModalLabel">Alert</h5>
                                                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                          <div class="modal-body">
                                                          Please make sure that you <b>receive the remaining payment</b> and <b> proof payment</b>  from customer
                                                          <c:out value="${paymenttype}"/>
                                                          </div>
                                                          <div class="modal-footer">
                                                            <form action="managecustomerreservation" id="P-PCform" method="POST">
                                                                <input type="hidden" value="${resultrow.reservationid}" name="reservationid">
                                                                <input type="hidden" value="updatepaymentstatus" name="valuemethod">
                                                                <input type="hidden" value="approve" name="valuemethod">
                                                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                                <button type="submit" class="btn btn-success" >Complete</button>
                                                            </form>
                                                          </div>
                                                      </div>
                                                    </div>
                                                </div> 
                                                                
                                            </c:if>
                                                
                                            <c:if test="${paymentstatus == 'complete'}">
                                                <!--<p>Partial Payment - partial-complete</p>-->
                                                <a class="btn btn-outline-secondary primary" data-bs-toggle="collapse" href="#collapse<c:out value="${resultrow.reservationid}"/>" role="button" aria-expanded="false" aria-controls="collapseExample" disabled>
                                                    Update Payment Status
                                                </a>
                                            </c:if>
                                        </c:if>
                                        
                                        <c:if test="${fn:containsIgnoreCase(paymenttype, 'full-payment')}">
                                            
                                            <c:if test="${fn:containsIgnoreCase(paymentstatus, 'incomplete')}">
                                                <!--<p>Full Payment - incomplete</p>-->
                                                <a class="btn btn-outline-secondary primary" data-bs-toggle="collapse" href="#collapse<c:out value="${resultrow.reservationid}"/>" role="button" aria-expanded="false" aria-controls="collapseExample">
                                                    Update Payment Status
                                                </a>
                                                <div class="collapse" id="collapse<c:out value="${resultrow.reservationid}"/>">
                                                    <div class="d-flex">
                                                        <div class="input-group">
                                                            
                                                            <select class="form-select" aria-label="Default select example" name="updatevalue" form="F-ICform">
                                                                <option value="approve">Approve</option>
                                                                <option value="notapprove" disabled>Not Approve</option>
                                                                
                                                            </select>
                                                            
                                                            <input type="button" class="btn btn-outline-secondary" value="Save" id="button-addon2" data-bs-toggle="modal" data-bs-target="#modal<c:out value="${resultrow.reservationid}"/>" >
                                                        </div>
                                                    </div>
                                                </div>
                                                            
                                                <!--Modal-->
                                                <div class="modal fade" id="modal<c:out value="${resultrow.reservationid}"/>"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                      <div class="modal-content">
                                                        <div class="modal-header">
                                                          <h5 class="modal-title" id="exampleModalLabel">Alert</h5>
                                                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                          <div class="modal-body">
                                                          Please make sure that you <b>receive the remaining payment</b> and <b> proof payment</b>  from customer
                                                          <c:out value="${paymenttype}"/>
                                                          </div>
                                                          <div class="modal-footer">
                                                            <form action="managecustomerreservation" id="F-ICform" method="POST">
                                                                <input type="hidden" value="${resultrow.reservationid}" name="reservationid">
                                                                <input type="hidden" value="updatepaymentstatus" name="valuemethod">
                                                                <input type="hidden" value="approve" name="valuemethod">
                                                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                                <button type="submit" class="btn btn-success" >Complete</button>
                                                            </form>
                                                          </div>
                                                      </div>
                                                    </div>
                                                </div> 
                                            </c:if>
                                                
                                            <c:if test="${paymentstatus == 'complete'}">
                                                <!--<p>Partial Payment - partial-complete</p>-->
                                                <a class="btn btn-outline-secondary primary" data-bs-toggle="collapse" href="#collapse<c:out value="${resultrow.reservationid}"/>" role="button" aria-expanded="false" aria-controls="collapseExample" disabled>
                                                    Update Payment Status
                                                </a>
                                            </c:if>
                                                
                                        </c:if>
                                               
                                    </div>
                                    
                                    
                                    <c:set var="path" value="${proofpayment}" />
                                    
                                    <c:set var="newPath" value="${fn:replace(path, '\\\\', '/')}"/>
                                    
                                    <c:set var="substring" value="${fn:substringAfter(newPath, 'C:/Users/Afiq/OneDrive/Documents/NetBeansProjects/HRS/web/')}"/>

                                    
                                    <div class="collapse p-4" id="collapse<c:out value="${resultrow.reservationid}"/>1">
                                        
                                        <img src="<c:out value="${substring}"/>" style='height: 100%; width: 100%;'>
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
