<!DOCTYPE html>

<%
    
HttpSession formSession = request.getSession(true);
String userType = (String)formSession.getAttribute("userType");
String userId = (String)formSession.getAttribute("userId");
    if(userId != null && userType != null){
        response.sendRedirect(request.getContextPath()+"/checkUserType");
    }
%>


<html>
    <head>
        <title>Manager Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="loginCss.css" media="screen">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
    </head>
    <body>
        <div class="loginContainer">
            <h1>Staff Management</h1>
             <h2>Manager LogIn</h2>
             <form method="post" action="manLogin">
                <div class="loginFormContainer">
                    <label>Username</label>
                    <input type="text" placeholder="Enter your username / email" class="loginFormInput" name="email" required>
                    <label>Password</label>
                    <input type="password" placeholder="Enter your password" class="loginFormInput" name="password" required>
                    <input type="text" value="manager" hidden name="status">
                </div>
                <input type="submit" value="LogIn" name="loginBtn" class="loginBtn">
                <a href="index.jsp" class="subAText">Are you an employee? Click here to login.</a>
                <h4 class="dangerText">
                    <%
                        String loginStatus = (String)formSession.getAttribute("loginStatus");
                        if(loginStatus != null){
                            out.println(loginStatus);
                            formSession.setAttribute("loginStatus", "");
                        }
                    %>
                </h4>
            </form>
        </div>
    </body>
</html>
