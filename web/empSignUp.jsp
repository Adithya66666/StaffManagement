<!DOCTYPE html>
<html>
    <head>
        <title>Create Employee</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="loginCss.css" media="screen">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
    </head>
    <body>
        <div class="loginContainer">
            <h1>Staff Management</h1>
             <h2>Create Employee</h2>
             <h4 class="dangerText">
                 <%
                    HttpSession formSession = request.getSession(true);
                    String formStatus = (String)formSession.getAttribute("empcreatestatus");
                    if(formStatus != null){
                        out.println(formStatus);
                        formSession.setAttribute("empcreatestatus", "");
                    }
                 %>
             </h4>
             <form method="post" action="createEmployee">
                <div class="loginFormContainer">
                    <label>First Name</label>
                    <input type="text" name="fname" placeholder="Enter your first name" class="loginFormInput" required>
                    <label>Last Name</label>
                    <input type="text" name="lname" placeholder="Enter your last name" class="loginFormInput" required>
                    <label>Email</label>
                    <input type="text" name="email" placeholder="Enter your email" class="loginFormInput" required>
                    <label>Username</label>
                    <input type="text" name="username" placeholder="Enter a username" class="loginFormInput"required>
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Enter your password" class="loginFormInput" required>
                    <label>Confirm Password</label>
                    <input type="password" name="cpassword" placeholder="Confirm your password" class="loginFormInput" required>
                </div>
                <input type="submit" value="Create Employee" name="loginBtn" id="loginBtn" class="loginBtn">
                <a href="index.jsp" class="subAText">Already have an account? Click here to SignIn.</a>
                <a href="managerLogin.jsp" class="subAText">Are you a manager? Click here to SignIn.</a>
            </form>
        </div>
    </body>
</html>
