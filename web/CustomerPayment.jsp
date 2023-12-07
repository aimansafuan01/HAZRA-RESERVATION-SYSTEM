
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 


    Document   : CustomerPayment
    Created on : Jan 10, 2023, 8:08:42 PM
    Author     : User
--%>
<%
String custid = (String) session.getAttribute("custid");
    if(custid == null)
    {
        response.sendRedirect("Login.jsp");
    }
    %>
<sql:setDataSource var="myDatasource"
driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@DESKTOP-5A4QUNH:1521:XE" user="HRS" password="HRS"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="path/to/stylesheet.css">
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
                          <a class="nav-link active" href="CustomerReservationList.jsp"><h5><b>Manage Reservations</b></h5></a>
                      </li>
                      <li class="nav-item mx-4">
                          <a class="nav-link " href="CustomerRefundRequest.jsp"><h5>Payment Details</h5></a>
                      </li>
                      <li class="nav-item mx-4">
                          <a class="nav-link" href="updateCustomerAccount.jsp"><h5>Update Account</h5></a>
                      </li>
                      <li class="nav-item mx-4">
                          <%
                            String customerName = (String) session.getAttribute("custname");
                            %>
                            <%
                            String customerId = (String) session.getAttribute("custid");
                            %>
                          <div class="dropdown">
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                  <a class="nav-link"><h5><%= customerName %></h5></a>
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
   
               
                             
                                
                                
    <div class="card" style="margin: 50px auto; width: 50%; display: block;">
        
       <sql:query var="result" dataSource="${myDatasource}">
            SELECT p.paymentid AS "Payment Id" ,p.reservationid AS "Reserve Id",p.paymentstatus AS Status,a.accoprice AS Price,a.accotype AS Type 
            FROM payment p 
            JOIN reservation r on r.reservationid = p.reservationid 
            JOIN accomodation a on a.accoid = r.accoid
            Where p.custid = '<%=customerId%>' and p.reservationid = '${reservationid}'
        </sql:query>

        <table class="table table-striped">
            <!-- column headers -->
           <tr class="thead-dark">
                <c:forEach var="columnName" items="${result.columnNames}">
                    <th><c:out value="${columnName}"/></th>
                    </c:forEach>
            </tr>
            <!-- column data -->
            <c:forEach var="row" items="${result.rowsByIndex}">
               <tr class="thead-dark">
                    <c:forEach var="column" items="${row}">
                        <td><c:out value="${column}"/></td>
                    </c:forEach>
                </tr>
            </c:forEach>

        </table>  
        
        <div class="d-flex flex-row-reverse">
            <p class = "justify-content-start mx-4">Full Payment: RM <b><c:out value="${totalpayment}"/></b></p>
            <p class = "justify-content-start mx-4">Deposit only: <b>RM50</b></p>
        </div>
      </div>

        <form action="upload" method="post" enctype="multipart/form-data">
             <div class="card" style="margin: 50px auto; width: 50%; display: block;">
                <div class="card-body">
                     <input type="hidden" name="customerId" value="<%= customerId %>"/>
                      <input type="hidden" name="reservationid" value="${reservationid}"/>
                    <input type="hidden" name="method" value="receipt"/>
                    <h5 class="card-title">Payment Type</h5>
                    <select class="form-select" aria-label="Default select example" name="selecttype" required>
                    <option value="Partial">Deposit Only</option>
                    <option value="Full-Payment">Full Payment</option>
                    </select>
                    <div class="mb-3">
                        <label for="formFile" class="form-label">Upload Your Receipt here</label>
                        <input class="form-control" type="file" id="formFile" name="receipt" accept="image/jpeg, image/png, image/jpg" required>
                      </div>
                </div>
                <div class="card-footer">
                    <div class="d-flex flex-row-reverse">
                        <input type="submit" class="btn btn-outline-secondary primary" value="Complete Payment"> 
                    </div>
                </div>
            </div>
        </form>

        <div class="card" style="margin: 50px auto; width: 50%; display: block;">
            <div class="card-body">
                <h5 class="card-title">Online Bank</h5>
                <select class="form-select">
                    <option>Affin Bank</option>
                    <option>Agro Bank</option>
                    <option>Alliance Bank</option>
                    <option>AmBank Bank</option>
                    <option>Bank Islam</option>
                    <option>AmBank Bank</option>
                    <option>Bank Muamalat</option>
                    <option>Bank of China</option>
                    <option>Bank Rakyat</option>
                    <option>Bank Simpanan Nasional</option>
                    <option>BNP Paribas</option>
                    <option>CIMB Bank (Clicks)</option>
                    <option>CIMB Bank (BizChannel)</option>
                    <option>Citibank</option>
                    <option>Deutsche Bank</option>
                    <option>Hong Leong Bank</option>
                    <option>HSBC Bank</option>
                    <option>Kuwait Finance House</option>
                    <option>Maybank (M2U)</option>
                    <option>Maybank (M2e)</option>
                    <option>OCBC Bank</option>
                    <option>Public Bank</option>
                    <option>RHB Bank</option>
                    <option>Standard Chartered Bank</option>
                    <option>UOB Bank</option>
                </select>

            </div>
       </div>
