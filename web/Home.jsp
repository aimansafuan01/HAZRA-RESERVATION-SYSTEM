<%-- 
    Document   : Home
    Created on : Jan 8, 2023, 6:11:05 PM
    Author     : User
--%>
<%-- --%>
<%
String custid = (String) session.getAttribute("custid");
    if(custid == null)
    {
        response.sendRedirect("Login.jsp");
    }
    %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Main Page</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
    <script>
    setTimeout(function(){ 
        document.getElementById("success-message").style.display = "none";
    }, 1000);
</script>
  </head>
    <body >
       <div id="success-message" class="alert alert-success">
        ${successMessage}
            </div>
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
                          <a class="nav-link active" href="Home.jsp"><h5><b>Dashboard</b></h5></a>
                      </li>
                      <li class="nav-item mx-4">
                          <a class="nav-link" href="CustomerReservationList.jsp"><h5>Manage Reservations</h5></a>
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
      
                         
      <div class="container">
          <div class="container-fluid my-5 pt-5 px-5">
              <div class="row justify-content-center px-4">
                  <div class="col-md-12 col-lg-9">
                      
                  <div class="col">
                      <div class="p-3">
                      <img src="./logo.png" width="200" class="image-fluid" alt="Hazra Icon">
                    </div>
                  </div>
                      <div class="card shadow-sm">
                          <div class="row">
                              <div class="col-md-6 pr-0">
                                  <div class="card-body border-right border-bottom p-3 h-100">
                                      <div class="d-flex flex-row bd-highlight pt-2">
                                          <div>
                                              <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" class="text-muted" width="32"><path d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path></svg>
                                          </div>
                                          <div class="p-2">
                                              <div class="mb-2">
                                                  <a class="h5 font-weight-bolder text-dark" href="Reservation.jsp">Make Reservation</a>
                                                  
                                              </div>
  
                                              <p class="text-muted small">
                                                  There are number of choices available for our customer. All of the house are available now, choose and reserve one that suits your needs online with the system
                                              </p>
  
                                          </div>
                                      </div>
                                  </div>
                              </div>
                              <div class="col-md-6 pl-0">
                                  <div class="card-body border-bottom p-3 h-100">
                                      <div class="d-flex flex-row bd-highlight pt-2">
                                          <div>
                                              <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" class="text-muted" width="32"><path d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"></path><path d="M15 13a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>
                                          </div>
                                          <div class="p-2">
                                              <div class="mb-2">
                                                  <a href="https://laracasts.com" class="h5 font-weight-bolder text-dark">New Promotion</a>
                                              </div>
  
                                              <p class="text-muted small">
                                                  There are no promotions right now, so please comeback later.
                                              </p>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                              <div class="col-md-6 pr-0">
                                  <div class="card-body border-right p-3 h-100">
                                      <div class="d-flex flex-row bd-highlight pt-2">
                                          <div>
                                              <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" class="text-muted" width="32"><path d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z"></path></svg>
                                          </div>
                                          <div class="p-2">
                                              <div class="mb-2">
                                                  <a href="https://laravel-news.com/" class="h5 font-weight-bolder text-dark">Join Us Now</a>
                                              </div>
                                              <p class="text-muted small">
                                                  Join the line with us now as a worker or manager. Please contact the manager number to learn more about it.                                        </p>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                              <div class="col-md-6 pl-0">
                                  <div class="card-body p-3 h-100">
                                      <div class="d-flex flex-row bd-highlight pt-2">
                                          <div>
                                              <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" class="text-muted" width="32"><path d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                          </div>
                                          <div class="p-2">
                                              <div class="mb-2">
                                                  <span class="h5 font-weight-bolder text-dark">About Us</span>
                                              </div>
                                              <p class="text-muted small">
                                                  Take a deep dive and learn more about our homestay, organizations, and the online system.
                                              </p>
                                          </div>
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
