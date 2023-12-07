<%-- 
    Document   : Houseroomguest
    Created on : Jan 24, 2023, 2:29:03 PM
    Author     : Arif
--%>

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
    
                     <%  
                      String checkindate = request.getParameter("checkindate");
                      String checkoutdate = request.getParameter("checkoutdate");
                      %>
                      
                       
 <div class ="container">  
       
      <sql:query var="resultroom" dataSource="${myDatasource}">
          
        
          
          <%--  select accoid from accomodation where accoid not in 
            (
            SELECT r.accoid FROM accomodation a join reservation r on r.accoid = a.accoid 
            WHERE ( to_date(?,'yyyy-mm-dd') > r.checkindate AND to_date(?,'yyyy-mm-dd') < r.checkoutdate )
            OR (r.checkindate < to_date(?,'yyyy-mm-dd') AND to_date(?,'yyyy-mm-dd') > r.checkoutdate ) 
            AND (to_date(?,'yyyy-mm-dd') != r.checkoutdate ) AND a.accoavailability = 'Unavailable' 
            )
           <sql:param  value="${param.checkindate}"/>
           --%>
            
            select accoid from accomodation where accoid not in (
            SELECT r.accoid FROM accomodation a join reservation r on r.accoid = a.accoid 
            WHERE (r.checkindate >= to_date(?,'yyyy-mm-dd')and r.checkindate <= to_date(?,'yyyy-mm-dd'))
            or (r.checkoutdate >= to_date(?,'yyyy-mm-dd') and r.checkoutdate <= to_date(?,'yyyy-mm-dd')) 
            AND a.accoavailability = 'Unavailable' )

          <sql:param  value="${param.checkindate}"/>
           <sql:param value="${param.checkindate}"/>
          <sql:param  value="${param.checkoutdate}"/>
          <sql:param value="${param.checkoutdate}"/>
          
        </sql:query>
           
            <c:choose>
                <c:when  test="${empty resultroom.rows}"> 
                     <c:set var="message" value="No Room Available!" scope="session"/>
                   <c:redirect url="/Reservation.jsp"/>
            </c:when>
            </c:choose>
            
   
        
           <c:forEach items='${resultroom.rows}' var="row">
           <c:choose>
               
            <c:when  test="${row.accoid == 'ACCO1'}"> 
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
                <form action="Login.jsp" method="POST">
                <input type="submit" class="btn btn-outline-secondary primary" value="Make Reservation">
                </form>
                 
                
            </div>
        </div>
      </div>
    </div>
        </c:when>
            
            <c:when  test="${row.accoid  == 'ACCO2'}"> 
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
                     <form action="Login.jsp" method="POST">
                <input type="submit" class="btn btn-outline-secondary primary" value="Make Reservation">
                </form>
                </div>
            </div>
        </div>
    </div>
       </c:when>
            <c:when  test="${row.accoid  == 'ACCO3'}"> 
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
                       <form action="Login.jsp" method="POST">
                <input type="submit" class="btn btn-outline-secondary primary" value="Make Reservation">
                </form>
                </div>
            </div>
        </div>
    </div>
         </c:when>
            <c:when  test="${row.accoid  == 'ACCO4'}"> 
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
                       <form action="Login.jsp" method="POST">
                <input type="submit" class="btn btn-outline-secondary primary" value="Make Reservation">
                </form>     
                </div>
            </div>
        </div>
                </c:when>
            
            </c:choose>
            
 </c:forEach> 
   </div>
       
  
</body>
</html>
