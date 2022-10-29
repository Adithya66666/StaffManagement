<!DOCTYPE html>

<%
HttpSession formSession = request.getSession(true);
String userType = (String)formSession.getAttribute("userType");
String userId = (String)formSession.getAttribute("userId");
    if(userId != null && userType != null){
        response.sendRedirect(request.getContextPath()+"/checkUserType");
    }
    //out.println((String)formSession.getAttribute("userId"));

%>


<html>
    <head>
        <title>Staff Management</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="loginCss.css?version=1.1" media="screen">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
    </head>
    <body>
        <div class="loginContainer">
            <h1>Staff Management</h1>
             <h2>Employee LogIn</h2>
             <form method="post" action="userLogin">
                <div class="loginFormContainer">
                    <label>Username</label>
                    <input type="text" placeholder="Enter your username / email" class="loginFormInput" name="email" required>
                    <label>Password</label>
                    <input type="password" placeholder="Enter your password" class="loginFormInput" name="password" required>
                    <input type="text" value="employee" hidden name="status">
                </div>
                <input type="submit" value="LogIn" name="loginBtn" class="loginBtn">
                <a href="empSignUp.jsp" class="subAText">Do not have an account? Click here to signup.</a>
                <a href="managerLogin.jsp" class="subAText">Are you a manager? Click here to login.</a>
                
                <h4 class="StatusTxt">
                <%
                String formStatus = (String)formSession.getAttribute("empcreatestatus");
                if(formStatus != null){
                    out.println(formStatus);
                    formSession.setAttribute("empcreatestatus", "");
                }

                %>  
                </h4>
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
