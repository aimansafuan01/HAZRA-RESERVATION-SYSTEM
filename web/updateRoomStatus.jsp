<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<sql:setDataSource var="myDatasource"
driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@DESKTOP-5A4QUNH:1521:XE" user="HRS" password="HRS"/>
<%
    String roles = (String) session.getAttribute("roles");
        if(roles == null)
        {
            response.sendRedirect("Login.jsp");
        }
        else if(!(roles.equalsIgnoreCase("HouseManager")))
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
                <img style= "width: 100px;" src= "./logo.png" >
            </g>
        </a>
       
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="justify-content-center collapse navbar-collapse mx-4" id="navbarNav">
                    <ul class="navbar-nav">
                      <li class="nav-item mx-4">
                              <a class="nav-link" href="IndexBillsManager.jsp"><h5>Dashboard</h5></a>
                          </li>
                          <li class="nav-item mx-4">
                              <a class="nav-link active" href="updateRoomStatus.jsp"><h5><b>Manage House & Room</b></h5></a>
                          </li>
                          <li class="nav-item mx-4">
                              <a class="nav-link" href="updateEmployeeAccountHM.jsp"><h5>Update Account</h5></a>
                          </li>
                      <li class="nav-item mx-4">
                          <%
                            String empName = (String) session.getAttribute("empname");
                          %>
                            
                          <div class="dropdown">
                                <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                  <a class="nav-link"><h5><%= empName %></h5></a>
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
        
        <div class="container">
            <div class="container-fluid my-5 pt-5 px-5">
                <div class="row justify-content-center px-4">
       
                    <div class="card text">
                        <div class="card-body">
                            <sql:query var="result" dataSource="${myDatasource}">
                                SELECT accoid, accoavailability, accostatus from HRS.ACCOMODATION ORDER BY accoid
                            </sql:query>
                            <table class="table">
                                <thead>
                                  <tr>
                                    <th scope="col" style="text-align:center;">Room ID</th>
                                    <th scope="col" style="text-align:center;">Room Type</th>
                                    <th scope="col" style="text-align:center;">Room Availability</th>
                                    <th scope="col" style="text-align:center;">Room Status</th>
                                    <th scope="col" style="text-align:center;">Action</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <c:forEach var="resultrow" items="${result.rows}">     
                                  <tr>
                                        <th scope="row">
                                            <p style="text-align:center;">${resultrow.accoid}</p>
                                        </th>
                                    <td>
                                        
                                        <c:set var="accoid" value="${resultrow.accoid}"/>
                                        <c:set var="accoavailability" value="${resultrow.accoavailability}"/>
                                        <c:set var="accostatus" value="${resultrow.accostatus}"/>
                                        <c:choose>
                                            <c:when test="${accoid == 'ACC01'}">
                                                <c:set var="accotype" value="House"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="accotype" value="Room"/>
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <p style="text-align:center;">${accotype}</p>
                                    </td>
                                    
                                    <td>
                                        <p style="text-align:center;">${accoavailability}</p>
                                    </td>
                                    
                                    <td>
                                        <form method="POST" action="UpdateCleaningStatusHandler" id="updateForm">
                                            <select class="form-select" aria-label="Default select example" name="roomStatus">
                                                <option value="Need Cleaning" <c:if test="${accostatus == 'Need Cleaning'}"><c:out value="selected"/></c:if>>Need Cleaning</option>
                                                <option value="In cleaning process" <c:if test="${accostatus == 'In cleaning process'}"><c:out value="selected"/></c:if>>In cleaning process</option>
                                                <option value="Ready" <c:if test="${accostatus == 'Ready'}"><c:out value="selected"/></c:if>>Ready</option>
                                            </select>
                                            <input type="hidden" name="accoid" value="${accoid}">
                                                    
                                    </td>
                                    
                                    <td align="center">
                                        <input class="btn btn-outline-secondary" type="submit" value="Update" id="üpdateForm">
                                        </form>
                                    </td> 
                                  </tr>
                                  </c:forEach>
                                  <%
                                      String updateAccoSuccess = (String) request.getAttribute("updateRoomSuccessMsgs");
                                      String updateAccoError = (String) request.getAttribute("updateRoomErrorMsgs");
                                      String updatedAccoId = (String) request.getAttribute("accoid");
                                      if (updateAccoSuccess != null)
                                        out.println("<p class=\"text-success text-end\"><b>SUCCESS: " + updatedAccoId + " " + updateAccoSuccess + "</p>");
                                      
                                      if (updateAccoError != null)
                                        out.println("<p class=\"text-danger text-end\"><b>SUCCESS: " + updatedAccoId + " " + updateAccoSuccess + "</p>");
                                  %>

                                </tbody>
                              </table>     
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    </body>
</html>
