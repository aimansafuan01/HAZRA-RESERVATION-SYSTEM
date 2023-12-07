<%-- 
    Document   : Login
    Created on : Jan 2, 2023, 1:14:53 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
  <head>
    <title>Login</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <!-- Option 1: Bootstrap Bundle with Popper -->
 </head>
    <body class="bg-light">
        
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
    
       
        <div class="container min-vh-100 d-flex justify-content-center align-items-center">
          <div class="d-flex flex-column align-items-center">
            <div class="p-3">
              <img src="./logo.png" width="200" class="image-fluid" alt="Hazra Icon">
            </div>
            
            <div class="card text-bg-white p-3">
              <form action="CustomerHandler" method="POST">
                <div class="input-group mb-3">
                  <span class="input-group-text" id="basic-addon1">Email</span>
                  <input required="true" type="text" name="email" class="form-control" placeholder="Email"  aria-describedby="basic-addon1">
                </div>
                <div class="input-group mb-3">
                   <span class="input-group-text" id="basic-addon1">Password</span>
                   <input required="true" type="password" name="password" class="form-control" placeholder="Password"  aria-describedby="basic-addon1">
                </div>
                 <input type="hidden" value="login" name="source">
                <%
                    if(request.getAttribute("errMessage") != null)
                    {
                %>
                        <p style="color:red;" class="text-center"><%=request.getAttribute("errMessage")%></p>
                <% 
                    } 
                %>
                  
                <div class="d-flex justify-content-evenly mt-3">
                    <button type="submit" value="submit" class="btn btn-dark">Sign in</button>
                    <a type="button" href="index.jsp"class="btn btn-dark">Back to Homepage</a>
                 </div>
                
                </form>
                
                
                  
                <div class="d-flex justify-content-center pt-3">
                    <a href="LoginEmp.jsp" class="link-secondary">Employee Login Here</a>
                </div> 
        </div>
    </div>
</div>
      </body>
      
</html>
