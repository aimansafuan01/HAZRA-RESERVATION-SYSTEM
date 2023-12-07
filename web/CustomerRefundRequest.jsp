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
                
                <!--
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon">
                    </span>
                </button>
                -->
                
                    <div class="justify-content-center collapse navbar-collapse mx-4" id="navbarNav">
                        <ul class="navbar-nav">
                          <li class="nav-item mx-4">
                            <a class="nav-link" href="Home.jsp"><h5>Dashboard</h5></a>
                            </li>
                            <li class="nav-item mx-4">
                                <a class="nav-link" href="CustomerReservationList.jsp"><h5>Manage Reservations</h5></a>
                            </li>
                            <li class="nav-item mx-4">
                                <a class="nav-link active" href="CustomerRefundRequest.jsp"><h5><b>Refund Request</b></h5></a>
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
                <h5>Refund Status</h5>
            </div>
        </div> 
            
        <div class="container">
            <div class="container-fluid my-5 pt-2 px-5">
                <div class="row justify-content-center px-4">
                    <div class="card text">
                        <div class="card-body">
                            
                            <sql:query var="result" dataSource="${myDatasource}">
                                SELECT * FROM REFUND r join reservation rs on r.reservationid = rs.reservationid and rs.custid = ?
                                <sql:param value="<%=custid%>"/>
                            </sql:query>
                               
                            <table class="table">
                                <thead>
                                  <tr>
                                    <th scope="col" style="text-align:center;">Refund ID</th>
                                    <th scope="col" style="text-align:center;">Refund Description</th>
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

                                        <p>Reservation ID: <c:out value="${reservationid}"/></p>
                                        <p>Reservation Date: <fmt:formatDate type = "date" value="${reservationdate}"/> </p>
                                        
                                        <c:if test="${resultrow.refundstatus == 'Incomplete'}">
                                            <p>Refund Status: <b style="color:red;"><c:out value="${resultrow.refundstatus}"/></b></p>
                                        </c:if>
                                        <c:if test="${resultrow.refundstatus == 'Complete'}">
                                            <p>Refund Status: <b style="color:green;"><c:out value="${resultrow.refundstatus}"/></b></p>
                                        </c:if>
                                       
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
