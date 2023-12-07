<%@ page import = "java.util.Date,java.text.*" %>
<%@ page import = "dao.ReservationDao;" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%-- 
    Document   : IndexBilllsManager
    Created on : Dec 31, 2022, 5:11:41 PM
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
                              <a class="nav-link" href="updateEmployeeAccountBM.jsp"><h5>Update Account</h5></a>
                          </li>
                          <li>
                              <div class="dropdown">
                                <%
                                    String empName = (String) session.getAttribute("empname");
                                %>
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
        <div class="container">
        <div class="row justify-content-center my-5">
            <div class="col-md-12">
                <div class="card shadow bg-light">
                    <div class="card-body bg-white px-5 py-3 border-bottom rounded-top">
                        <div class="mx-3 my-3">
                            <div>

                            </div>

                            <h3 class="h3 my-4">
                                Welcome to Hazra Online Reservation System
                            </h3>
                        </div>
                    </div>
                    <div class="row g-0">
                        <div class="col-md-6 pe-0">
                            <div class="card-body border-right border-bottom p-3 h-100">
                                <div class="d-flex flex-row bd-highlight mb-3">
                                    <div>
                                        <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" class="text-muted" width="32"><path d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path></svg>
                                    </div>
                                    <div class="ps-3">
                                        <div class="mb-2">
                                            <a href="UpdateReservationStatus.jsp" class="h5 font-weight-bolder text-decoration-none text-dark">Manage Customer Reservation</a>
                                        </div>
                                        <p class="text-muted">

                                        </p>
                                        <!--
                                            <div class="mt-3 d-flex align-content-center font-weight-bold text-primary">
                                                <div>Explore the documentation</div>

                                                <div class="ms-1 text-primary">
                                                    <svg viewBox="0 0 20 20" fill="currentColor" width="16" class="arrow-right w-4 h-4"><path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                                                </div>
                                            </div>
                                        </a>
                                    -->
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 pe-0">
                            <div class="card-body border-right border-bottom p-3 h-100">
                                <div class="d-flex flex-row bd-highlight mb-3">
                                    <div>
                                        <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" class="text-muted" width="32"><path d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path></svg>
                                    </div>
                                    <div class="ps-3">
                                        <div class="mb-2">
                                            <a href="UpdatePaymentStatus.jsp" class="h5 font-weight-bolder text-decoration-none text-dark">Payment Details</a>
                                        </div>
                                        <p class="text-muted">

                                        </p>
                                        <!--
                                            <div class="mt-3 d-flex align-content-center font-weight-bold text-primary">
                                                <div>Explore the documentation</div>

                                                <div class="ms-1 text-primary">
                                                    <svg viewBox="0 0 20 20" fill="currentColor" width="16" class="arrow-right w-4 h-4"><path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                                                </div>
                                            </div>
                                        </a>
                                    -->
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 ps-0">
                            <div class="card-body border-bottom p-3 h-100">
                                <div class="d-flex flex-row bd-highlight mb-3">
                                    <div>
                                        <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" class="text-muted" width="32"><path d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path></svg>
                                    </div>
                                    <div class="ps-3">
                                        <div class="mb-2">
                                            <a href="UpdateRefundStatus.jsp" class="h5 font-weight-bolder text-decoration-none text-dark">Refund Details</a>
                                        </div>

                                        <p class="text-muted">

                                        </p>    
                                        <!--
                                        <a href="https://laravel.com/docs" class="text-decoration-none">
                                            <div class="mt-3 d-flex align-content-center font-weight-bold text-primary">
                                                <div>Start watching Laracasts</div>

                                                <div class="ms-1 text-primary">
                                                    <svg viewBox="0 0 20 20" fill="currentColor" width="16" class="arrow-right w-4 h-4"><path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                                                </div>
                                            </div>
                                        </a>
                                    -->
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 ps-0">
                            <div class="card-body border-bottom p-3 h-100">
                                <div class="d-flex flex-row bd-highlight mb-3">
                                    <div>
                                        <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" class="text-muted" width="32"><path d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"></path><path d="M15 13a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>
                                    </div>
                                    <div class="ps-3">
                                        <div class="mb-2">
                                            <a href="updateEmployeeAccountBM.jsp" class="h5 font-weight-bolder text-decoration-none text-dark">Update Account</a>
                                        </div>

                                        <p class="text-muted">

                                        </p>    
                                        <!--
                                        <a href="https://laravel.com/docs" class="text-decoration-none">
                                            <div class="mt-3 d-flex align-content-center font-weight-bold text-primary">
                                                <div>Start watching Laracasts</div>

                                                <div class="ms-1 text-primary">
                                                    <svg viewBox="0 0 20 20" fill="currentColor" width="16" class="arrow-right w-4 h-4"><path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                                                </div>
                                            </div>
                                        </a>
                                    -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </body>
</html>
