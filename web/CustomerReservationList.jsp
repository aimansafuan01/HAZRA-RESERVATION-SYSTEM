<%@ page import = "java.util.Date,java.text.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%-- 
    Document   : CustomerReservationList
    Created on : Jan 7, 2023, 11:46:43 PM
    Author     : ariff
--%>
<sql:setDataSource var="myDatasource"
driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@DESKTOP-5A4QUNH:1521:XE" user="HRS" password="HRS"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manage Reservation</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
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
                            <a class="nav-link" href="Home.jsp"><h5>Dashboard</h5></a>
                            </li>
                            <li class="nav-item mx-4">
                                <a class="nav-link active" href="CustomerReservationList.jsp"><h5><b>Manage Reservations</b></h5></a>
                            </li>
                            <li class="nav-item mx-4">
                                <a class="nav-link" href="CustomerRefundRequest.jsp"><h5>Refund Request</h5></a>
                            </li>
                            <li class="nav-item mx-4">
                                <a class="nav-link" href="updateCustomerAccount.jsp"><h5>Update Account</h5></a>
                            </li>
                          <li>
                            <%
                                String customerName = (String) session.getAttribute("custname");
                                String custid = (String) session.getAttribute("custid");
                            %>
                              <div class="dropdown">
                                <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                    <h5><%=customerName%></h5>
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
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
                <h5>Manage Reservation</h5>
            </div>
        </div> 
        
        
        <div class="container">
            <div class="container-fluid my-5 pt-5 px-5">
                <div class="row justify-content-center px-4">
                    <div class="card text">
                        <div class="card-body">
                            <sql:query var="result" dataSource="${myDatasource}">
                                SELECT * from RESERVATION WHERE CUSTID = '<%=custid%>' and reservationstatus <> 'Cancelled' 
                            </sql:query>
                            <sql:query var="customer" dataSource="${myDatasource}">
                                SELECT * from CUSTOMER WHERE CUSTID = '<%=custid%>'
                            </sql:query>
                            <c:forEach var="customerrow" items="${customer.rows}">
                                <c:set var="custname" value="${customerrow.custname}"/>
                                <c:set var="custemail" value="${customerrow.custemail}"/>
                                <c:set var="custphonenum" value="${customerrow.custphonenum}"/>
                            </c:forEach>
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
                                        <c:set var="currentDate" value="<%= new java.util.Date()%>"/>
                                        <c:set var="checkinDate" value="${result.rows[0].checkindate}"/>
                                        <c:set var="checkoutDate" value="${result.rows[0].checkoutdate}"/>
                                        <c:set var="calBeforeResv" value="${checkinDate.time - currentDate.time}"/>
                                        <fmt:formatNumber value="${calBeforeResv / (1000 * 60 * 60 * 24)}" pattern="#0" var="beforeResv"/>
                                        <c:set var="calDuration" value="${checkoutDate.time - checkinDate.time}"/>
                                        <fmt:formatNumber value="${calDuration / (1000 * 60 * 60 * 24)}" pattern="#0" var="duration"/>
                                        
                                        <tr>
                                            <th scope="row" style="text-align:center;">
                                                <c:out value="${resultrow.reservationid}"/>
                                            </th>
                                            
                                            <td>
                                                <c:set var="reservationid" value="${resultrow.reservationid}"/>
                                                <c:set var="accoid" value="${resultrow.accoid}"/>
                                                <c:set var="checkindate" value="${resultrow.checkindate}"/>
                                                <c:set var="checkoutdate" value="${resultrow.checkoutdate}"/>
                                                <c:set var="reservationstatus" value ="${resultrow.reservationstatus}"/>
                                                <sql:query var="resultroom" dataSource="${myDatasource}">
                                                    SELECT * FROM ACCOMODATION WHERE ACCOID = ?
                                                    <sql:param value="${accoid}"/>
                                                </sql:query>
                                                <c:forEach var="result2" items="${resultroom.rows}">
                                                    <c:set var="accoprice" value="${result2.accoprice}"/>
                                                    <c:set var="accotype" value="${result2.accotype}"/>
                                                </c:forEach>
                                                <p style="text-align:center;">Accommodation Type: <c:out value="${accotype}"/></p>
                                                <p style="text-align:center;">Reservation Date: <fmt:formatDate type = "date" value="${checkindate}"/></p>
                                                <c:if test="${fn:containsIgnoreCase(reservationstatus,'Incomplete')}">
                                                    <p style="text-align:center;">Reservation Status: <b>Your reservation is in process</b></p>
                                                </c:if>
                                                <c:if test="${fn:containsIgnoreCase(reservationstatus,'Complete - Not Check In')}">
                                                    <p style="text-align:center;">Reservation Status: Reservation is Complete <b>(Not Check In)</b></p>
                                                </c:if>
                                                    
                                                <c:if test="${fn:containsIgnoreCase(reservationstatus,'Complete - Check In')}">
                                                    <p style="text-align:center;">Reservation Status: Reservation is Complete <b>(Check In)</b></b></p>
                                                </c:if>
                                                    
                                                 <c:if test="${fn:containsIgnoreCase(reservationstatus,'Complete - Check Out')}">
                                                     <p style="text-align:center;">Reservation Status: Reservation is Complete <b>(Check Out)</b></p>
                                                </c:if>
                                            </td>
                                            
                                            <td>
                                                
                                            <c:choose>
                                                <%--
                                               <c:when test="${fn:containsIgnoreCase(reservationstatus, 'Complete - Not Check In')}">
                                                    <div class="d-flex justify-content-around ">
                                                    <sql:query var="resultresv" dataSource="${myDatasource}">
                                                        SELECT * FROM reservation WHERE RESERVATIONID = ?
                                                        <sql:param value="${resultrow.reservationid}"/>
                                                    </sql:query>
                                                    <c:forEach var="resultresvrow" items="${resultresv.rows}">
                                                        <c:set var="reservationid1" value="${resultresvrow.reservationid}"/>
                                                        <c:set var="accoid1" value="${resultresvrow.accoid}"/>
                                                        <c:set var="checkindate1" value="${resultresvrow.checkindate}"/>
                                                        <c:set var="checkoutdate1" value="${resultresvrow.checkoutdate}"/>
                                                        <c:set var="currentDate1" value="<%= new java.util.Date()%>"/>
                                                        <c:set var="checkinDate1" value="${resultresv.rows[0].checkindate}"/>
                                                        <c:set var="checkoutDate1" value="${resultresv.rows[0].checkoutdate}"/>
                                                        <c:set var="calBeforeResv1" value="${checkinDate1.time - currentDate1.time}"/>
                                                        <fmt:formatNumber value="${calBeforeResv1 / (1000 * 60 * 60 * 24)}" pattern="#0" var="beforeResv1"/>
                                                        <c:set var="calDuration1" value="${checkoutDate1.time - checkinDate1.time}"/>
                                                        <fmt:formatNumber value="${calDuration1 / (1000 * 60 * 60 * 24)}" pattern="#0" var="duration1"/>

                                                        <sql:query var="resultresvroom" dataSource="${myDatasource}">
                                                            SELECT * FROM ACCOMODATION WHERE ACCOID = ?
                                                            <sql:param value="${accoid1}"/>
                                                        </sql:query>
                                                        <c:forEach var="result3" items="${resultresvroom.rows}">
                                                            <c:set var="accoprice1" value="${result3.accoprice}"/>
                                                            <c:set var="accotype1" value="${result3.accotype}"/>
                                                        </c:forEach>
                                                        <!--View Modal!-->
                                                        <div class="modal fade" id="ViewModal${reservationid1}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered ">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h4 class="modal-title" id="exampleModalLabel">Reservation Details</h4>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <p>
                                                                        <p>Reservation Date : <fmt:formatDate type = "date" value="${checkindate1}"/></p>
                                                                        <p>Duration : <c:out value="${duration1}"/> Day(s)</p>
                                                                        <p>Accommodation Type : <c:out value="${accotype1}"/></p>
                                                                        <p>Price : RM<c:out value="${accoprice1}"/> Per Night</p>
                                                                        <p><b>Customer details :</b></p><p>Name : <c:out value="${custname}"/></p>
                                                                        <p>Email : <c:out value="${custemail}"/></p>
                                                                        <p>Phone Number : <c:out value="${custphonenum}"/></p>
                                                                        <table class="table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th scope="col" style="text-align:center;">Description</th>
                                                                                    <th scope="col" style="text-align:center;">Amount</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr style="text-align: center;">
                                                                                    <td>Deposit</td>
                                                                                    <td>RM50.00</td>
                                                                                </tr>
                                                                                <tr style="text-align: center;">
                                                                                    <td>Accommodation Price</td>
                                                                                    <td>RM<c:out value="${accoprice1 * duration1}"/>.00</td>
                                                                                </tr>
                                                                                <tr style="text-align: center; color: green">
                                                                                    <td><b>Total</b></td>
                                                                                    <td><b>RM<c:out value="${accoprice1 * duration1 + 50}"/>.00</b></td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--InvalidUpdateModal!-->
                                                        
                                                        <!--Update Modal!-->
                                                        
                                                        <!--Cancel Modal!-->
                                                        
                                                    </c:forEach>
                                                        
                                                    <a href="" class="btn btn-outline-secondary primary" data-bs-toggle="modal" data-bs-target="#ViewModal${reservationid1}">View</a>
                                                </div>
                                               </c:when>
                                               --%>
                                               
                                               <c:when test="${fn:containsIgnoreCase(reservationstatus, 'Complete - Check In')}">
                                                  <div class="d-flex justify-content-around ">
                                                    <sql:query var="resultresv" dataSource="${myDatasource}">
                                                        SELECT * FROM reservation WHERE RESERVATIONID = ?
                                                        <sql:param value="${resultrow.reservationid}"/>
                                                    </sql:query>
                                                    <c:forEach var="resultresvrow" items="${resultresv.rows}">
                                                        <c:set var="reservationid1" value="${resultresvrow.reservationid}"/>
                                                        <c:set var="accoid1" value="${resultresvrow.accoid}"/>
                                                        <c:set var="checkindate1" value="${resultresvrow.checkindate}"/>
                                                        <c:set var="checkoutdate1" value="${resultresvrow.checkoutdate}"/>
                                                        <c:set var="currentDate1" value="<%= new java.util.Date()%>"/>
                                                        <c:set var="checkinDate1" value="${resultresv.rows[0].checkindate}"/>
                                                        <c:set var="checkoutDate1" value="${resultresv.rows[0].checkoutdate}"/>
                                                        <c:set var="calBeforeResv1" value="${checkinDate1.time - currentDate1.time}"/>
                                                        <fmt:formatNumber value="${calBeforeResv1 / (1000 * 60 * 60 * 24)}" pattern="#0" var="beforeResv1"/>
                                                        <c:set var="calDuration1" value="${checkoutDate1.time - checkinDate1.time}"/>
                                                        <fmt:formatNumber value="${calDuration1 / (1000 * 60 * 60 * 24)}" pattern="#0" var="duration1"/>

                                                        <sql:query var="resultresvroom" dataSource="${myDatasource}">
                                                            SELECT * FROM ACCOMODATION WHERE ACCOID = ?
                                                            <sql:param value="${accoid1}"/>
                                                        </sql:query>
                                                        <c:forEach var="result3" items="${resultresvroom.rows}">
                                                            <c:set var="accoprice1" value="${result3.accoprice}"/>
                                                            <c:set var="accotype1" value="${result3.accotype}"/>
                                                        </c:forEach>
                                                        <!--View Modal!-->
                                                        <div class="modal fade" id="ViewModal${reservationid1}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered ">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h4 class="modal-title" id="exampleModalLabel">Reservation Details</h4>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <p>
                                                                        <p>Reservation Date : <fmt:formatDate type = "date" value="${checkindate1}"/></p>
                                                                        <p>Duration : <c:out value="${duration1}"/> Day(s)</p>
                                                                        <p>Accommodation Type : <c:out value="${accotype1}"/></p>
                                                                        <p>Price : RM<c:out value="${accoprice1}"/> Per Night</p>
                                                                        <p><b>Customer details :</b></p><p>Name : <c:out value="${custname}"/></p>
                                                                        <p>Email : <c:out value="${custemail}"/></p>
                                                                        <p>Phone Number : <c:out value="${custphonenum}"/></p>
                                                                        <table class="table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th scope="col" style="text-align:center;">Description</th>
                                                                                    <th scope="col" style="text-align:center;">Amount</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr style="text-align: center;">
                                                                                    <td>Deposit</td>
                                                                                    <td>RM50.00</td>
                                                                                </tr>
                                                                                <tr style="text-align: center;">
                                                                                    <td>Accommodation Price</td>
                                                                                    <td>RM<c:out value="${accoprice1 * duration1}"/>.00</td>
                                                                                </tr>
                                                                                <tr style="text-align: center; color: green">
                                                                                    <td><b>Total</b></td>
                                                                                    <td><b>RM<c:out value="${accoprice1 * duration1 + 50}"/>.00</b></td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--InvalidUpdateModal!-->
                                                        
                                                        <!--Update Modal!-->
                                                        
                                                        <!--Cancel Modal!-->
                                                        
                                                    </c:forEach>
                                                        
                                                    <a href="" class="btn btn-outline-secondary primary" data-bs-toggle="modal" data-bs-target="#ViewModal${reservationid1}">View</a>
                                                </div>
                                               </c:when>
                                                
                                               <c:when test="${fn:containsIgnoreCase(reservationstatus, 'Complete - Check Out')}">
                                                     <div class="d-flex justify-content-around ">
                                                    <sql:query var="resultresv" dataSource="${myDatasource}">
                                                        SELECT * FROM reservation WHERE RESERVATIONID = ?
                                                        <sql:param value="${resultrow.reservationid}"/>
                                                    </sql:query>
                                                    <c:forEach var="resultresvrow" items="${resultresv.rows}">
                                                        <c:set var="reservationid1" value="${resultresvrow.reservationid}"/>
                                                        <c:set var="accoid1" value="${resultresvrow.accoid}"/>
                                                        <c:set var="checkindate1" value="${resultresvrow.checkindate}"/>
                                                        <c:set var="checkoutdate1" value="${resultresvrow.checkoutdate}"/>
                                                        <c:set var="currentDate1" value="<%= new java.util.Date()%>"/>
                                                        <c:set var="checkinDate1" value="${resultresv.rows[0].checkindate}"/>
                                                        <c:set var="checkoutDate1" value="${resultresv.rows[0].checkoutdate}"/>
                                                        <c:set var="calBeforeResv1" value="${checkinDate1.time - currentDate1.time}"/>
                                                        <fmt:formatNumber value="${calBeforeResv1 / (1000 * 60 * 60 * 24)}" pattern="#0" var="beforeResv1"/>
                                                        <c:set var="calDuration1" value="${checkoutDate1.time - checkinDate1.time}"/>
                                                        <fmt:formatNumber value="${calDuration1 / (1000 * 60 * 60 * 24)}" pattern="#0" var="duration1"/>

                                                        <sql:query var="resultresvroom" dataSource="${myDatasource}">
                                                            SELECT * FROM ACCOMODATION WHERE ACCOID = ?
                                                            <sql:param value="${accoid1}"/>
                                                        </sql:query>
                                                        <c:forEach var="result3" items="${resultresvroom.rows}">
                                                            <c:set var="accoprice1" value="${result3.accoprice}"/>
                                                            <c:set var="accotype1" value="${result3.accotype}"/>
                                                        </c:forEach>
                                                        <!--View Modal!-->
                                                        <div class="modal fade" id="ViewModal${reservationid1}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered ">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h4 class="modal-title" id="exampleModalLabel">Reservation Details</h4>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <p>
                                                                        <p>Reservation Date : <fmt:formatDate type = "date" value="${checkindate1}"/></p>
                                                                        <p>Duration : <c:out value="${duration1}"/> Day(s)</p>
                                                                        <p>Accommodation Type : <c:out value="${accotype1}"/></p>
                                                                        <p>Price : RM<c:out value="${accoprice1}"/> Per Night</p>
                                                                        <p><b>Customer details :</b></p><p>Name : <c:out value="${custname}"/></p>
                                                                        <p>Email : <c:out value="${custemail}"/></p>
                                                                        <p>Phone Number : <c:out value="${custphonenum}"/></p>
                                                                        <table class="table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th scope="col" style="text-align:center;">Description</th>
                                                                                    <th scope="col" style="text-align:center;">Amount</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr style="text-align: center;">
                                                                                    <td>Deposit</td>
                                                                                    <td>RM50.00</td>
                                                                                </tr>
                                                                                <tr style="text-align: center;">
                                                                                    <td>Accommodation Price</td>
                                                                                    <td>RM<c:out value="${accoprice1 * duration1}"/>.00</td>
                                                                                </tr>
                                                                                <tr style="text-align: center; color: green">
                                                                                    <td><b>Total</b></td>
                                                                                    <td><b>RM<c:out value="${accoprice1 * duration1 + 50}"/>.00</b></td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--InvalidUpdateModal!-->
                                                        
                                                        <!--Update Modal!-->
                                                        
                                                        <!--Cancel Modal!-->
                                                        
                                                    </c:forEach>
                                                        
                                                    <a href="" class="btn btn-outline-secondary primary" data-bs-toggle="modal" data-bs-target="#ViewModal${reservationid1}">View</a>
                                                </div>
                                               </c:when>
                                                
                                               <c:otherwise>
                                                    <div class="d-flex justify-content-around ">
                                                    <sql:query var="resultresv" dataSource="${myDatasource}">
                                                        SELECT * FROM reservation WHERE RESERVATIONID = ?
                                                        <sql:param value="${resultrow.reservationid}"/>
                                                    </sql:query>
                                                    <c:forEach var="resultresvrow" items="${resultresv.rows}">
                                                        <c:set var="reservationid1" value="${resultresvrow.reservationid}"/>
                                                        <c:set var="accoid1" value="${resultresvrow.accoid}"/>
                                                        <c:set var="checkindate1" value="${resultresvrow.checkindate}"/>
                                                        <c:set var="checkoutdate1" value="${resultresvrow.checkoutdate}"/>
                                                        <c:set var="currentDate1" value="<%= new java.util.Date()%>"/>
                                                        <c:set var="checkinDate1" value="${resultresv.rows[0].checkindate}"/>
                                                        <c:set var="checkoutDate1" value="${resultresv.rows[0].checkoutdate}"/>
                                                        <c:set var="calBeforeResv1" value="${checkinDate1.time - currentDate1.time}"/>
                                                        <fmt:formatNumber value="${calBeforeResv1 / (1000 * 60 * 60 * 24)}" pattern="#0" var="beforeResv1"/>
                                                        <c:set var="calDuration1" value="${checkoutDate1.time - checkinDate1.time}"/>
                                                        <fmt:formatNumber value="${calDuration1 / (1000 * 60 * 60 * 24)}" pattern="#0" var="duration1"/>

                                                        <sql:query var="resultresvroom" dataSource="${myDatasource}">
                                                            SELECT * FROM ACCOMODATION WHERE ACCOID = ?
                                                            <sql:param value="${accoid1}"/>
                                                        </sql:query>
                                                        <c:forEach var="result3" items="${resultresvroom.rows}">
                                                            <c:set var="accoprice1" value="${result3.accoprice}"/>
                                                            <c:set var="accotype1" value="${result3.accotype}"/>
                                                        </c:forEach>
                                                        <!--View Modal!-->
                                                        <div class="modal fade" id="ViewModal${reservationid1}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered ">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h4 class="modal-title" id="exampleModalLabel">Reservation Details</h4>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <p>
                                                                        <p>Reservation Date : <fmt:formatDate type = "date" value="${checkindate1}"/></p>
                                                                        <p>Duration : <c:out value="${duration1}"/> Day(s)</p>
                                                                        <p>Accommodation Type : <c:out value="${accotype1}"/></p>
                                                                        <p>Price : RM<c:out value="${accoprice1}"/> Per Night</p>
                                                                        <p><b>Customer details :</b></p><p>Name : <c:out value="${custname}"/></p>
                                                                        <p>Email : <c:out value="${custemail}"/></p>
                                                                        <p>Phone Number : <c:out value="${custphonenum}"/></p>
                                                                        <table class="table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th scope="col" style="text-align:center;">Description</th>
                                                                                    <th scope="col" style="text-align:center;">Amount</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr style="text-align: center;">
                                                                                    <td>Deposit</td>
                                                                                    <td>RM50.00</td>
                                                                                </tr>
                                                                                <tr style="text-align: center;">
                                                                                    <td>Accommodation Price</td>
                                                                                    <td>RM<c:out value="${accoprice1 * duration1}"/>.00</td>
                                                                                </tr>
                                                                                <tr style="text-align: center; color: green">
                                                                                    <td><b>Total</b></td>
                                                                                    <td><b>RM<c:out value="${accoprice1 * duration1 + 50}"/>.00</b></td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--InvalidUpdateModal!-->
                                                        <div class="modal fade" id="InvalidUpdateModal${reservationid1}"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                            <div class="modal-dialog">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title" id="exampleModalLabel">Alert</h5>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <p style="color:red"><b>Reservations can only be updated at least a week before actual reservation date.</b></p>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--Update Modal!-->
                                                        <div class="modal fade" id="UpdateModal${reservationid1}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered ">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h4 class="modal-title" id="exampleModalLabel">Update Reservation</h4>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <p><b>Enter new check-in date.</b></p>
                                                                        <p>New check-out date will be locked automatically according to the duration of reservation.</p>
                                                                        <form action="ManageOwnReservationHandler" method='POST'>
                                                                            <div class="row my-3">
                                                                                <div class="col mx-2">
                                                                                    <label>Check In Date</label>
                                                                                    <input required="true" type="text" name="newcheckindate" class="form-control" id="checkInDate${reservationid1}" placeholder="Enter date">
                                                                                    <script>
                                                                                        flatpickr("checkInDate${reservationid1}", {minDate: "today"});
                                                                                    </script>
                                                                                </div>
                                                                                <div class="col mx-3">
                                                                                    <label>Check Out Date</label>
                                                                                    <input required="true" type="text" name="newcheckoutdate" class="form-control" id="checkOutDate${reservationid1}" placeholder="Enter date">
                                                                                    <script>
                                                                                        flatpickr("#checkOutDate${reservationid1}", {});
                                                                                        const firstCalendar${reservationid1} = flatpickr("#checkInDate${reservationid1}", {minDate: "today",
                                                                                            onChange: function(selectedDates, dateStr, instance) {
                                                                                                // Get the selected date from the first calendar
                                                                                                const selectedDate = selectedDates[0];

                                                                                                // Add the number of days to the selected date
                                                                                                const maximumDate = new Date(selectedDate);
                                                                                                maximumDate.setDate(maximumDate.getDate() + <c:out value="${duration1}"/>);

                                                                                                // Set the minimum date of the second calendar to the selected date
                                                                                                secondCalendar${reservationid1}.set("minDate", maximumDate);

                                                                                                // Set the maximum date of the second calendar to the calculated date
                                                                                                secondCalendar${reservationid1}.set("maxDate", maximumDate);
                                                                                            }
                                                                                        });
                                                                                        const secondCalendar${reservationid1} = flatpickr("#checkOutDate${reservationid1}", {minDate: "today",});
                                                                                    </script>
                                                                                </div>
                                                                            </div>
                                                                            <p>Confirm update reservation details?</p>
                                                                            <div class="d-flex flex-row-reverse">
                                                                                <input type="hidden" name="method" value="updateResv"/>
                                                                                <input type="hidden" name="reservationid" value="<c:out value="${reservationid}"/>"/>
                                                                                <input class="btn btn-secondary" type="submit" value="Update">
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--Cancel Modal!-->
                                                        <div class="modal fade" id="CancelModal${reservationid1}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered ">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h4 class="modal-title" id="exampleModalLabel">Cancel Reservation</h4>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <p style="color:red"><b>Note: Deposit will not be refunded for cancellation made less than one week before actual reservation date.</b></p>
                                                                        <p>Reservation Date : <fmt:formatDate type = "date" value="${checkindate1}"/></p>
                                                                        <p>Duration : <c:out value="${duration1}"/> Day(s)</p>
                                                                        <p>Accommodation Type : <c:out value="${accotype1}"/></p>
                                                                        <p>Price : RM<c:out value="${accoprice1}"/> Per Night</p>
                                                                        <p><b>Customer details :</b></p><p>Name : <c:out value="${custname}"/></p>
                                                                        <p>Email : <c:out value="${custemail}"/></p>
                                                                        <p>Phone Number : <c:out value="${custphonenum}"/></p>
                                                                        <table class="table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th scope="col" style="text-align:center;">Description</th>
                                                                                    <th scope="col" style="text-align:center;">Eligible Refund Amount</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <c:if test="${beforeResv1 >= 7}">
                                                                                    <tr style="text-align: center;">
                                                                                        <td>Deposit</td>
                                                                                        <td>RM50.00</td>
                                                                                    </tr>
                                                                                </c:if>

                                                                                <tr style="text-align: center;">
                                                                                    <td>Accommodation Price</td>
                                                                                    <td>RM<c:out value="${accoprice1 * duration1}"/>.00</td>
                                                                                </tr>
                                                                                <tr style="text-align: center; color: green">
                                                                                    <td><b>Total</b></td>
                                                                                    <c:if test="${beforeResv1 >= 7}">
                                                                                        <td>RM<c:out value="${accoprice1 * duration1 + 50}"/>.00</td>
                                                                                    </c:if>
                                                                                    <c:if test="${beforeResv1 < 7}">
                                                                                        <td>RM<c:out value="${accoprice1 * duration1}"/>.00</td>
                                                                                    </c:if>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <p>Confirm cancel reservation?</p>
                                                                        <form action="ManageOwnReservationHandler" method="POST">
                                                                            <input type="hidden" name="method" value="cancelResv">
                                                                            <input type="hidden" name="reservationid" value="<c:out value="${reservationid1}"/>">
                                                                            <input type="hidden" name="beforeResv" value="<c:out value="${beforeResv1}"/>">
                                                                            <button type="submit" class="btn btn-danger" id="liveAlertBtn">Cancel</button>
                                                                        </form>
                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                        
                                                    <a href="" class="btn btn-outline-secondary primary" data-bs-toggle="modal" data-bs-target="#ViewModal${reservationid1}">View</a>
                                                    <c:if test="${beforeResv1 < 7}">
                                                        <a href="" class="btn btn-outline-secondary primary" data-bs-toggle="modal" data-bs-target="#InvalidUpdateModal${reservationid1}">Update</a>
                                                    </c:if>
                                                    <c:if test="${beforeResv1 >= 7}">
                                                        <a href="" class="btn btn-outline-secondary primary" data-bs-toggle="modal" data-bs-target="#UpdateModal${reservationid1}">Update</a>
                                                    </c:if>

                                                    <fmt:formatDate var="fmtcheckindate" type="both" value="${checkindate1}" pattern="yyyy-MM-dd hh:mm:ss"/>

                                                    <c:set var="currentdate" value="<%= new java.util.Date()%>"/>
                                                    <fmt:formatDate var="fmtcurrentdate" type="both" value="${currentdate}" pattern="yyyy-MM-dd hh:mm:ss"/>

                                                    <c:if test="${fmtcurrentdate gt fmtcheckindate}">
                                                         <a href="" class="btn btn-outline-secondary primary disabled" data-bs-toggle="modal" data-bs-target="#CancelModal${reservationid1}" aria-disabled="true">Cancel</a>
                                                    </c:if>
                                                    <c:if test="${fmtcheckindate gt fmtcurrentdate}">
                                                         <a href="" class="btn btn-outline-secondary primary" data-bs-toggle="modal" data-bs-target="#CancelModal${reservationid1}">Cancel</a>
                                                    </c:if>

                                                </div>
                                               </c:otherwise>
                                                
                                            </c:choose>
                                                
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
