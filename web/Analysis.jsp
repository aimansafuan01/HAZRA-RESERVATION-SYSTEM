<%-- 
    Document   : Analysis
    Created on : Jan 20, 2023, 1:46:32 AM
    Author     : Afiq
--%>
<%@ page import = "java.util.Date,java.text.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
  <sql:setDataSource var="myDatasource"
    driver="oracle.jdbc.driver.OracleDriver"
    url="jdbc:oracle:thin:@DESKTOP-5A4QUNH:1521:XE" user="HRS" password="HRS"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
       
       
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
                    button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon">
                        </span>
                    </button>
                    --><!--
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon">
                        </span>
                    </button>
                    -->
                        <div class="justify-content-center collapse navbar-collapse mx-4" id="navbarNav">
                            <ul class="navbar-nav">
                              <li class="nav-item mx-4">
                                  <a class="nav-link active" href="IndexBillsManager.jsp"><h5><b>Dashboard</b></h5></a>
                              </li>
                              <li class="nav-item mx-4">
                                  <a class="nav-link" href="UpdateReservationStatus.jsp"><h5>Manage Reservations</h5></a>
                              </li>
                              <li class="nav-item mx-4">
                                  <a class="nav-link " href="UpdatePaymentStatus.jsp"><h5>Payment Details</h5></a>
                              </li>
                              <li class="nav-item mx-4">
                                  <a class="nav-link " href="UpdateRefundStatus.jsp"><h5>Refund Details</h5></a>
                              </li>
                              <li class="nav-item mx-4">
                                  <a class="nav-link" href="UpdateAccount.jsp"><h5>Update Account</h5></a>
                              </li>
                              <li>
                                <%
                                    String empName = (String) session.getAttribute("empname");
                                %>
                                  <div class="dropdown">
                                    <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                        <h5><%= empName%></h5>
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
        </div
        <div class="container">
            <div class="container-fluid my-5 pt-5 px-5">
                <div class="row justify-content-center px-4">
                    <div class="card text">
                        <p><h5>Analysis</h5></p> 
                        <sql:query var="resultcount" dataSource="${myDatasource}">
                            select count(r.accoid) countresult from reservation r join accomodation a on r.accoid = a.accoid group by a.accoid ORDER BY a.accoid ASC
                        </sql:query>
                      
                         <sql:query var="resultresv" dataSource="${myDatasource}">
                            SELECT count(reservationid) countid from reservation
                        </sql:query>
                            
                        <c:forEach var="resultrowresv" items="${resultresv.rows}"> 
                            <c:set var="countidresv" value="${resultrowresv.countid}"/>
                        </c:forEach>
                        
                        <sql:query var="resultcust" dataSource="${myDatasource}">
                            SELECT count(custid) countid from customer
                        </sql:query>
                            
                        <c:forEach var="resultrowcust" items="${resultcust.rows}"> 
                            <c:set var="countidcust" value="${resultrowcust.countid}"/>
                        </c:forEach>
                        
                        <sql:query var="resultsum" dataSource="${myDatasource}">
                            select  sum(a.accoprice) totalincome from reservation r join accomodation a on r.accoid = a.accoid where r.reservationstatus like 'Complete%'
                        </sql:query>
                            
                        <c:forEach var="resulttotal" items="${resultsum.rows}"> 
                            <c:set var="totalincome" value="${resulttotal.totalincome}"/>
                        </c:forEach>
                            
                        <div class="card-body">
                            <div class="d-flex justify-content-evenly">
                                <div class="card" style="width: 25rem;">
                                    <div class="card-header"><b>Number of Reservation</b></div>
                                    <div class="card-body">
                                        <h2 class="card-title"><b><c:out value="${countidresv}"/></b></h2>
                                        <p class="card-text">Number of reservation that has been made: <b><c:out value="${countidresv}"/></b> </p>
                                    </div>
                                </div>
                                <div class="card" style="width: 25rem;">
                                    <div class="card-header"><b>Number of Registered Customer</b></div>
                                    <div class="card-body">
                                        <h2 class="card-title"><b><c:out value="${countidcust}"/></b></h2>
                                        <p class="card-text">Number of customer that has been registered in the system:<b> <c:out value="${countidcust}"/></b></p>
                                    </div>
                                </div>
                                <div class="card" style="width: 25rem;">
                                    <div class="card-header"><b>Total Income</b></div>
                                    <div class="card-body">
                                        <h2 class="card-title"><b>RM <c:out value="${totalincome}"/></b></h2>
                                        <p class="card-text">Total income from completed reservation:<b> RM <c:out value="${totalincome}"/></b></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    
                        <div class="card-body justify-content-center">
                            <div>
                                <canvas id="myChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
       
    </body>
  
    <script>
        const ctx = document.getElementById('myChart');

        new Chart(ctx, {
          type: 'bar',
          data: {
                
            labels: ['Room 1', 'Room 2', 'Room 3', 'Room 4', 'House'],
            datasets: [{
              label: '#Number of room reserve by customer',
              data: [
                        <c:forEach var="resultcountid" items="${resultcount.rows}"> 
                            <c:out value="${resultcountid.countresult}"/>,
                        </c:forEach>
                    ],
              borderWidth: 1
            }]
          },
          options: {
            scales: {
              y: {
                beginAtZero: true
              }
            }
          }
        });
    </script>
</html>
