<%@ page import = "java.util.Date,java.text.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : Houseroom
    Created on : Jan 2, 2023, 1:47:24 AM
    Author     : User
--%>
<sql:setDataSource var="myDatasource"
driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@DESKTOP-5A4QUNH:1521:XE" user="HRS" password="HRS"/>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
  <title>House & Room</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
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
                        <a class="nav-link" href="javascript:history.back()"><h5>Back</h5></a>
                      </li>
                      <li class="nav-item mx-4">
                          <a class="nav-link active" href="CustomerReservationList.jsp"><h5><b>Manage Reservations</b></h5></a>
                      </li>
                      <li class="nav-item mx-4">
                          <a class="nav-link " href="CustomerRefundRequest.jsp"><h5>Refund Request</h5></a>
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
                     <% 
                        String checkindate = request.getParameter("checkindate");
                        String checkoutdate = request.getParameter("checkoutdate");
                    
                        String resultHouse = request.getParameter("resultHouse");
                        String resultRoomA = request.getParameter("resultRoomA");
                        String resultRoomB = request.getParameter("resultRoomB");
                        String resultRoomC = request.getParameter("resultRoomC");

                      %>
                      
                      <%--<c:out value="${checkindate}"/>
                      <c:out value="${checkoutdate}"/>
                      <c:out value="${resultHouse}"/>
                      <c:out value="${resultRoomA}"/>
                      <c:out value="${resultRoomB}"/>
                      <c:out value="${resultRoomC}"/>%
                      --%>
                      <%
                        System.out.println("Result in houseroom");
                        System.out.println("result House : " + resultHouse);
                        System.out.println("result Room A : " + resultRoomA);
                        System.out.println("result Room B : " + resultRoomB);
                        System.out.println("result Room C : " + resultRoomC);

                       %>
                       
 <div class ="container">  
     
    <c:if test="${resultHouse == 'true'}">
    <div class="d-flex justify-content-around">
    <div class="card" style="width:25%;">
      <div class="card-body">
            <p class="card-text" >
                <img src="https://images.pexels.com/photos/3952048/pexels-photo-3952048.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" class="card-img-top" alt="...">
            </p>
        </div>
    </div>

    <div class="card" style="width:70%;" id="house">
        <div class="card-body">
            <h4 class="card-title">House</h4>
              <p class="card-text" >
                <h6>
                <ul>
                <li>Price : RM 250 per day</li>
                <li>22 hours per day</li>
                <li>Four bedrooms</li>
                <li>Kitchen</li>
                <li>Two air conditioner available </li>
                <li>Two toilet available </li>
                <li>Living room </li>
                <li>Dining area </li>
                <li>One television </li>
                <li>Required upfront payment  </li>
                </ul>  
                </h6> 
              </p>
        </div>
        <div class = "card-footer">
            <div class="d-flex flex-row-reverse">
                <form action="ManageOwnReservationHandler" method="POST">
                 <input type="hidden" name="accomodationId" value="ACCO1"/>
                  <input type="hidden" name="customerId" value="<%= customerId %>"/>
                  <input type="hidden" name="method" value="Reserve"/>
                 <input type="hidden" name="accoprice" value="250" />
                 <input type="hidden" name="checkindate" value="<%= checkindate %>">
                 <input type="hidden" name="checkoutdate" value="<%= checkoutdate %>">
                <input type="submit" class="btn btn-outline-secondary primary" value="Make Reservation">
                </form>
                 
                
            </div>
        </div>
      </div>
    </div>
    </c:if>
        
    <c:if test="${resultRoomA == 'true'}">
        <div class="d-flex justify-content-around mt-2">
        <div class="card" style="width:25%;">
            <div class="card-body">
                <p class="card-text" >
                    <img src=" https://images.pexels.com/photos/534172/pexels-photo-534172.jpeg?cs=srgb&dl=pexels-pixabay-534172.jpg&fm=jpg" class="card-img-top" alt="...">
                </p>
            </div>
        </div>
    
        <div class="card" style="width:70%;" id="roomA">
            <div class="card-body">
                <h4 class="card-title">Room A</h4>
                <p class="card-text" >
                    <h6>
                    <ul>
                    <li>Price : RM120 per day</li>
                    <li>22 hours per day</li>
                    <li>Two bed</li>
                    <li>No Kitchen</li>
                    <li>One Toilet</li>
                    <li>One tv</li>
                    <li>No dining room</li>
                    <li>No living room </li>
                    <li>One air conditioner </li>
                    </ul>  
                    </h6> 
                </p>
            </div>
            <div class = "card-footer">
                <div class="d-flex flex-row-reverse">
                   <form action="ManageOwnReservationHandler" method="POST">
                 <input type="hidden" name="accomodationId" value="ACCO2"/>
                  <input type="hidden" name="customerId" value="<%= customerId %>"/>
                     <input type="hidden" name="method" value="Reserve"/>
                  <input type="hidden" name="accoprice" value="120" />
                 <input type="hidden" name="checkindate" value="<%= checkindate %>">
                 <input type="hidden" name="checkoutdate" value="<%= checkoutdate %>">
                <input type="submit" class="btn btn-outline-secondary primary" value="Make Reservation">
                </form>
                </div>
            </div>
        </div>
    </div>
    </c:if>            
    
    <c:if test="${resultRoomB == 'true'}">
        <div class="d-flex justify-content-around mt-2">
        <div class="card" style="width:25%;">
            <div class="card-body">
                <p class="card-text" >
                    <img src=" https://images.pexels.com/photos/534172/pexels-photo-534172.jpeg?cs=srgb&dl=pexels-pixabay-534172.jpg&fm=jpg" class="card-img-top" alt="...">
                </p>
            </div>
        </div>
    
        <div class="card" style="width:70%;" id="roomB">
            <div class="card-body">
                <h4 class="card-title">Room B</h4>
                <p class="card-text" >
                    <h6>
                    <ul>
                    <li>Price : RM120  per day</li>
                    <li>22 hours per day</li>
                    <li>One bed</li>
                    <li>No Kitchen</li>
                    <li>One toilet </li>
                    <li>One Tv </li>
                    <li>No Living room </li>
                    <li>No Dining area </li>
                    <li>One air conditioner</li>
                    </ul>  
                    </h6> 
                </p>
            </div>
            <div class = "card-footer">
                <div class="d-flex flex-row-reverse">
                     <form action="ManageOwnReservationHandler" method="POST">
                 <input type="hidden" name="accomodationId" value="ACCO3"/>
                  <input type="hidden" name="customerId" value="<%= customerId %>"/>
                     <input type="hidden" name="method" value="Reserve"/>
                  <input type="hidden" name="accoprice" value="120" />
                 <input type="hidden" name="checkindate" value="<%= checkindate %>">
                 <input type="hidden" name="checkoutdate" value="<%= checkoutdate %>">
                <input type="submit" class="btn btn-outline-secondary primary" value="Make Reservation">
                </form>
                </div>
            </div>
        </div>
    </div>
    </c:if>
        
     <c:if test="${resultRoomC == 'true'}">
        <div class="d-flex justify-content-around mt-2">
        <div class="card" style="width:25%;">
            <div class="card-body">
                <p class="card-text" >
                    <img src=" https://images.pexels.com/photos/534172/pexels-photo-534172.jpeg?cs=srgb&dl=pexels-pixabay-534172.jpg&fm=jpg" class="card-img-top" alt="...">
                </p>
            </div>
        </div>
    
        <div class="card" style="width:70%;" id="roomC">
            <div class="card-body">
                <h4 class="card-title">Room C</h4>
                <p class="card-text" >
                    <h6>
                    <ul>
                    <li>Price : RM130 per day</li>
                    <li>22 hours per day</li>
                    <li>One bed</li>
                    <li>One Kitchen</li>
                    <li>One toilet </li>
                    <li>One Tv </li>
                    <li>No Living room </li>
                    <li>No Dining area </li>
                    <li>One air conditioner</li>
                    </ul>  
                    </h6> 
                </p>
            </div>
            <div class = "card-footer">
                <div class="d-flex flex-row-reverse">
                     <form action="ManageOwnReservationHandler" method="POST">
                 <input type="hidden" name="accomodationId" value="ACCO4" />
                  <input type="hidden" name="customerId" value="<%= customerId %>" />
                     <input type="hidden" name="method" value="Reserve"/>
                  <input type="hidden" name="accoprice" value="130" />
                 <input type="hidden" name="checkindate" value="<%= checkindate %>">
                 <input type="hidden" name="checkoutdate" value="<%= checkoutdate %>">
                <input type="submit" class="btn btn-outline-secondary primary" value="Make Reservation">
                </form>                
                </div>
            </div>
        </div> 
   </div>
  </c:if>
 </div>
    
       
  
</body>
</html>
