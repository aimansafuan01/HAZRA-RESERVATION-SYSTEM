<sql:setDataSource var="myDatasource"
driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@DESKTOP-5A4QUNH:1521:XE" user="HRS" password="HRS"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String nameError = (String) request.getAttribute("nameError");           
    String emailError = (String) request.getAttribute("emailError");           
    String phoneNumError = (String) request.getAttribute("phoneNumError");           
    String passError = (String) request.getAttribute("passError");           
    String confirmPassError = (String) request.getAttribute("confirmPassError");           
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="d-flex flex-row justify-content-center bg-body mt-5">
            <a class="navbar-brand" href="index.jsp">
                    <g clip-path="url(#clip0)" fill="#EF3B2D">
                        <img style= "width: 200px;" src= "logo.png" >
                    </g>
            </a>
        </div>
        
        <div class="container bg-light mx-auto mt-5 p-4 shadow-lg">  
            <form method="POST" action="CustomerHandler">
                <input type="hidden" value="register" name="source">
                <div class="mb-3">
                    <label for="nameInput" class="form-label">Name</label>
                    <input type="text" class="form-control shadow-sm" id="nameInput" name="custName" value="${param.custName}">
                    <%
                        if (nameError != null) {       
                            out.println("<p style=\"color: red\"><i>" + nameError + "</i></p>");
                        }
                    %>
                </div>
                <div class="mb-3">
                    <label for="emailnput" class="form-label">Email</label>
                    <input type="text" class="form-control shadow-sm" id="emailInput" name="custEmail" value="${param.custEmail}">
                    <%
                        if (emailError != null) {
                            out.println("<p style=\"color: red\"><i>" + emailError + "</i></p>");
                        }
                    %>
                </div>
                <div class="mb-3">
                    <label for="phoneNumInput" class="form-label">Phone Number</label>
                    <input type="text" class="form-control shadow-sm" id="phoneNumInput" name="custPhoneNum" value="${param.custPhoneNum}">
                    <%
                        if (phoneNumError != null) {
                            out.println("<p style=\"color: red\"><i>" + phoneNumError + "</i></p>");
                        }
                    %>
                </div>
                <div class="mb-3">
                    <label for="passwordInput" class="form-label">Password</label>
                    <input type="password" class="form-control shadow-sm" id="passwordInput" name="custPass">
                    <%
                        if (passError != null) {
                            out.println("<p style=\"color: red\"><i>" + passError + "</i></p>");
                        }
                    %>
                </div>
                <div class="mb-3">
                    <label for="confirmPasswordInput" class="form-label">Confirm Password</label>
                    <input type="password" class="form-control shadow-sm" id="confirmPasswordInput" name="custConfirmPass">
                    <%
                        if (confirmPassError != null) {
                            out.println("<p style=\"color: red\"><i>" + confirmPassError + "</i></p>");
                        }
                    %>
                </div>
                <div class="d-grid gap-2 m-3">
                <button type="submit" class="btn btn-dark btn-lg col-7 mx-auto">Register</button>
                </div>
                <div class="mx-auto text-muted">
                    Already registered? <a href="Login.jsp"><i><u>Login Here</u></i></a>
                </div>
                
            </form>
        </div>    
    </body>
</html>