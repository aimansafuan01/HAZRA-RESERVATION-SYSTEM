<%-- 
    Document   : Reservation
    Created on : Jan 2, 2023, 1:28:00 AM
    Author     : User
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
                            
<c:if test="${not empty message}">
    <div class="alert alert-danger">
        <c:out value="${message}" />
    </div>
</c:if>      
                           
<!DOCTYPE html>
<html lang="en">
<head>

  <title>Reservation</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
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
                <img style= "width: 100px;" src= "./logo.png" >
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
                          <a class="nav-link " href="CustomerRefundRequest.jsp"><h5>Refund Request</h5></a>
                      </li>
                      <li class="nav-item mx-4">
                          <a class="nav-link" href="updateCustomerAccount.jsp"><h5>Update Account</h5></a>
                      </li>
                      <li class="nav-item mx-4">
                          <%
                            String customerName = (String) session.getAttribute("custname");
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
    <div class="card">
        <div class="row mx-5">
            <h5>Reservation</h5>
        </div>
    </div>
    
    <div class="container">

        <div class="container-fluid my-5 pt-5 px-5">
            <div class="row justify-content-center px-4">
                <div class="col-md-12 col-lg-9">
                    <div class="card shadow-sm">
                        
                        <div class="dflex-row justify-content-start p-3">
                           <a class="btn btn-outline-secondary" href="javascript:history.back()">Back</a>
                        </div>

                        
                        <form action="ManageOwnReservationHandler" method='GET'>
                            <div class="row my-3">
                            
                           <div class="col mx-2">
                            <label>Check in Date</label>
                            <input required="true" type="text" name="checkindate" class="form-control" id="checkInDate" placeholder="Enter date">
                            <script>
                                flatpickr("#", {
                                    minDate: "today"
                                   
                                });
                            </script>
                           </div>
                           <div class="col mx-3">
                            <label>Check Out Date</label>
                            <input required="true" type="text" name="checkoutdate" class="form-control" id="checkOutDate" placeholder="Enter date">
                            <script>
                                flatpickr("#checkOutDate", {});
                                
                                const firstCalendar = flatpickr("#checkInDate", 
                                { 
                                    minDate: "today",
                                    
                                    onChange: function(selectedDates, dateStr, instance) {
                                      // Get the selected date from the first calendar
                                      const selectedDate = selectedDates[0];

                                      // Set the minimum date of the second calendar to the selected date
                                      secondCalendar.set("minDate", selectedDate);
                                    }
                                });
                                const secondCalendar = flatpickr("#checkOutDate", {
                                     minDate: "today",
                                     
                                });
                            </script>
                            
                           </div>
                           <div class="col mx-4">
                            <label>Number of people</label>
                            <input required="true" type="number" name="numpeople" class="form-control" id="exampleInputNumberOfPeople" min="1">
                            </div>
                                
                            </div>   
                            <div class="d-flex flex-row-reverse p-3">
                                <input class="btn btn-outline-secondary " type='submit' value='Find Room'>
                            </div>
                                 </form>
                            </div>
                             <%--<input type="hidden" value="checkdate">--%>
                       
                        
                    </div>
                <%--
                  <div class="card shadow-sm">
                   <div class="row my-4">
                     <div class="col mx-2">
                         <img style= "width: 100px;" src= "./Hazra.png" >
                           <button> More Details</button>
                     </div>
                        <div class="col mx-3">
                            <img style= "width: 100px;" src= "./Hazra.png" >
                             <button> More Details</button>
                        </div>
                        <div class="col mx-4">
                            <img style= "width: 100px;" src= "./Hazra.png" >
                             <button> More Details</button>
                        </div>
                        <div class="col mx-5">
                            <img style= "width: 100px;" src= "./Hazra.png" >
                             <button> More Details</button>
                        </div>
                    </div>
                        
                   </div> --%>
                </div>
            </div>
        </div>
    </div>
    
</body>
</html>
