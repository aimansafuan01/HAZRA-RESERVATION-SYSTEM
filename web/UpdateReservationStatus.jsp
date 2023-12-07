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
                              <a class="nav-link active" href="UpdateReservationStatus.jsp"><h5><b>Manage Reservations</b></h5></a>
                          </li>
                          <li class="nav-item mx-4">
                              <a class="nav-link " href="UpdatePaymentStatus.jsp"><h5>Payment Details</h5></a>
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
                <h5>Update Reservation Status</h5>
            </div>
        </div> 
        
        <div class="container">
            <div class="container-fluid my-5 pt-5 px-5">
                <div class="row justify-content-center px-4">
                    <div class="card text">
                        <div class="card-body">
                            <sql:query var="result" dataSource="${myDatasource}">
                                SELECT reservationid,checkindate, checkoutdate,accoid,reservationstatus from HRS.RESERVATION order by reservationid asc
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
                                      <th scope="row"><c:out value="${resultrow.reservationid}"/></th>
                                    <td>
                                        <c:set var="accoid" value="${resultrow.accoid}"/>
                                        <sql:query var="resultroom" dataSource="${myDatasource}">
                                            SELECT accotype FROM HRS.ACCOMODATION WHERE accoid = ?
                                            <sql:param value="${accoid}"/>
                                        </sql:query>
                                        <c:forEach var="result2" items="${resultroom.rows}">
                                            <p>Room Type: <c:out value="${result2.accotype}" /></p>
                                        </c:forEach>
                                            
                                        <p>Check In Date: <fmt:formatDate type = "date" value="${resultrow.checkindate}"/></p>
                                        <p>Check Out Date: <fmt:formatDate type = "date" value="${resultrow.checkoutdate}"/></p>
                                        <p>Reservation Status:<b> <c:out value="${resultrow.reservationstatus}"/></b></p>
                                    </td>
                                    <td>
                                        
                                    
                                        
                                    <div class="d-flex justify-content-around">
                                        
                                        
                                        <sql:query var="resultresv" dataSource="${myDatasource}">
                                            SELECT * FROM reservation WHERE RESERVATIONID = ?
                                            <sql:param value="${resultrow.reservationid}"/>
                                        </sql:query>
                                        
                                        <c:forEach var="resultresv" items="${resultresv.rows}">
                                            <c:set var="reservationstatus" value="${resultresv.reservationstatus}"/>
                                            <c:set var="checkindate" value="${resultresv.checkindate}"/>
                                            <c:set var="checkoutdate" value="${resultresv.checkoutdate}"/>
                                            <fmt:formatDate var="fmtcheckindate" type="both" value="${resultresv.checkindate}" pattern="yyyy-MM-dd"/>
                                            <fmt:formatDate var="fmtcheckoutdate" type="both" value="${resultresv.checkoutdate}" pattern="yyyy-MM-dd"/>
                                        </c:forEach>
                                         <c:set var="currentdate" value="<%= new java.util.Date()%>"/>
                                        
                                         <fmt:formatDate var="fmtcurrentdate" type="both" value="${currentdate}" pattern="yyyy-MM-dd hh:mm:ss"/>
                                        

                                       
                                        <c:if test="${fn:containsIgnoreCase(reservationstatus, 'Incomplete')}">
                                            <button class="btn btn-outline-secondary" value="Update Check-Out" id="button-addon2" data-bs-toggle="modal" data-bs-target="#modal2">
                                                Update Check-In
                                            </button>
                                            <div class="modal fade" id="modal2"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Alert</h5>
                                                             <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                            <div class="modal-body">
                                                                Payment status for this reservation is not yet been updated<b> please update at Update Payment Window </b>

                                                            </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                            <a href="UpdatePaymentStatus.jsp" class="btn btn-success">Go to Update Payment Status</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${fn:containsIgnoreCase(reservationstatus,'Complete - Not Check In')}">
                                            
                                            <c:if test="${fmtcheckindate eq fmtcurrentdate}">
                                                
                                                <button class="btn btn-outline-secondary" value="Update Check-Out" id="button-addon2" data-bs-toggle="modal" data-bs-target="#modal1<c:out value="${resultrow.reservationid}"/>">
                                                    Update Check-In
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
                                                                Please make sure that <b>customer is already check in </b> to the room or house
                                                                <c:out value="${resultrow.reservationid}"/>
                                                                </div>
                                                            <div class="modal-footer">
                                                                <form action="managecustomerreservation" method="POST">
                                                                    <input type="hidden" value="${resultrow.reservationid}" name="reservationid">
                                                                    <input type="hidden" value="updatereservationstatus" name="valuemethod">
                                                                     <input type="hidden" value="approve" name="updatevalue">
                                                                     <input type="hidden" value="updatecheckin" name="checkvalue">
                                                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                                    <button type="submit" class="btn btn-success" >Save</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${fmtcurrentdate gt fmtcheckindate}">
                                                <button class="btn btn-outline-secondary" value="Update Check-Out" id="button-addon2" data-bs-toggle="modal" data-bs-target="#modal1<c:out value="${resultrow.reservationid}"/>">
                                                    Update Check-In
                                                </button>
                                            <!--modal-->
                                                <div class="modal fade" id="modal1<c:out value="${resultrow.reservationid}"/>"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Alert</h5>
                                                                 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                                <div class="modal-body">
                                                                Please make sure that <b>customer is already check in </b> to the room or house
                                                                <c:out value="${resultrow.reservationid}"/>
                                                                </div>
                                                            <div class="modal-footer">
                                                                <form action="managecustomerreservation" method="POST">
                                                                    <input type="hidden" value="${resultrow.reservationid}" name="reservationid">
                                                                    <input type="hidden" value="updatereservationstatus" name="valuemethod">
                                                                     <input type="hidden" value="approve" name="updatevalue">
                                                                     <input type="hidden" value="updatecheckin" name="checkvalue">
                                                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                                    <button type="submit" class="btn btn-success" >Save</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${fmtcurrentdate lt fmtcheckindate}">
                                             
                                                <button class="btn btn-outline-secondary" value="Update Check-Out" id="button-addon2" data-bs-toggle="modal" data-bs-target="#modal1" disabled>
                                                    Update Check-In
                                                </button>
                                            <!--modal-->
                                                <div class="modal fade" id="modal1<c:out value="${resultrow.reservationid}"/>"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Alert</h5>
                                                                 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                                <div class="modal-body">
                                                                Please make sure that <b>customer is already check in </b> to the room or house

                                                                </div>
                                                            <div class="modal-footer">
                                                                <form action="managecustomerreservation" method="POST">
                                                                    <input type="hidden" value="${resultrow.reservationid}" name="reservationid">
                                                                    <input type="hidden" value="updatereservationstatus" name="valuemethod">
                                                                     <input type="hidden" value="approve" name="updatevalue">
                                                                     <input type="hidden" value="updatecheckin" name="checkvalue">
                                                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                                    <button type="submit" class="btn btn-success" >Save</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            
                                        </c:if>
                                        <c:if test="${fn:containsIgnoreCase(reservationstatus,'Complete - Check In')}">
                                            <!--<input type="button" class="btn btn-outline-secondary" value="Update Check-Out" id="button-addon2" data-bs-toggle="modal" data-bs-target="#modal1" >-->
                                            <c:if test="${fmtcurrentdate lt fmtcheckoutdate}">
                                                <button class="btn btn-outline-secondary" value="Update Check-Out" id="button-addon2" data-bs-toggle="modal" data-bs-target="#modal1">
                                                    Update Check-Out
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
                                                                    Cannot do the action because current date are not the same with check out date. Click <b>check out today</b> if customer already check out <b>today</b>
                                                                </div>
                                                            <div class="modal-footer">
                                                                <form action="managecustomerreservation" method="POST">
                                                                    <input type="hidden" value="${resultrow.reservationid}" name="reservationid">
                                                                    <input type="hidden" value="updatereservationstatus" name="valuemethod">
                                                                     <input type="hidden" value="approve" name="updatevalue">
                                                                     <input type="hidden" value="updatecheckout" name="checkvalue">
                                                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                                    <button type="submit" class="btn btn-success" >Check Out Today</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${fmtcurrentdate eq fmtcheckoutdate}">
                                                <button class="btn btn-outline-secondary" value="Update Check-Out" id="button-addon2" data-bs-toggle="modal" data-bs-target="#modal1">
                                                    Update Check-Out
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
                                                                Please make sure that <b>customer is already check out</b> from the room or house

                                                                </div>
                                                            <div class="modal-footer">
                                                                <form action="managecustomerreservation" method="POST">
                                                                    <input type="hidden" value="${resultrow.reservationid}" name="reservationid">
                                                                    <input type="hidden" value="updatereservationstatus" name="valuemethod">
                                                                     <input type="hidden" value="approve" name="updatevalue">
                                                                     <input type="hidden" value="updatecheckout" name="checkvalue">
                                                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                                    <button type="submit" class="btn btn-success" >Save</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${fmtcurrentdate gt fmtcheckoutdate}">
                                                <button class="btn btn-outline-secondary" value="Update Check-Out" id="button-addon2" data-bs-toggle="modal" data-bs-target="#modal1">
                                                    Update Check-Out
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
                                                                Please make sure that <b>customer is already check out</b> from the room or house

                                                                </div>
                                                            <div class="modal-footer">
                                                                <form action="managecustomerreservation" method="POST">
                                                                    <input type="hidden" value="${resultrow.reservationid}" name="reservationid">
                                                                    <input type="hidden" value="updatereservationstatus" name="valuemethod">
                                                                     <input type="hidden" value="approve" name="updatevalue">
                                                                     <input type="hidden" value="updatecheckout" name="checkvalue">
                                                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                                    <button type="submit" class="btn btn-success" >Save</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            
                                        </c:if>
                                        <c:if test="${fn:containsIgnoreCase(reservationstatus, 'Complete - Check Out')}">
                                            <button class="btn btn-outline-secondary" value="Update Check-Out" id="button-addon2" data-bs-toggle="modal" data-bs-target="#modal3">
                                                Update Check-Out
                                            </button>
                                            <div class="modal fade" id="modal3"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Alert</h5>
                                                             <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                            <div class="modal-body">
                                                                Reservation status has been update <b>customer has been check-out</b>

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
