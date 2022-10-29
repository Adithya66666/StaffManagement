
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


            <%
                HttpSession userSession = request.getSession(true);
                String userId = (String)userSession.getAttribute("userId");
                String userType = (String)userSession.getAttribute("userType");
                if(userId == null){
                    response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
                }
                if(userType != "hr"){
                }else{
                response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
                }
                
                String employeeId = request.getParameter("id");
            %>
            
            <%
                String fname = "";
                String lname = "";
                String username = "";
                String email = "";

                String location = "---";
                String start = "---";
                String end = "---";
                String hourId = "";

                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + "staffmanagement","root","");

                Statement statement = con.createStatement();
                String str = "SELECT * FROM employee WHERE id="+employeeId;
                ResultSet rs = statement.executeQuery(str);
                while(rs.next()){
                    fname = rs.getString("fname");
                    lname = rs.getString("lname");
                    username = rs.getString("username");
                    email = rs.getString("email");

                    Statement statement_1 = con.createStatement();
                    String str_1 = "SELECT * FROM hours WHERE empid="+employeeId;
                    ResultSet rs_1 = statement_1.executeQuery(str_1);
                    while(rs_1.next()){
                        hourId = rs_1.getString("id");
                        location = rs_1.getString("location");
                        start = rs_1.getString("start");
                        end = rs_1.getString("end");
                    }
                }
            %>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HR Manager Dashboard</title>
        <link rel="stylesheet" href="loginCss.css?version=1.2" media="screen">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
        <link rel="stylesheet" href="empDashboardCSS.css?version=1.2" media="screen">
        <link rel="stylesheet" href="leavingManager.css?version=1.2" media="screen">
        <link rel="stylesheet" href="viewEmpCss.css?version=1.2" media="screen">
        <script>
            function startTimeloader(time){
                document.getElementById("startTimeInput").value = time;
            }
            function endTimeLoader(time){
                document.getElementById("endTimeInput").value = time;
            }
            function checkType(s,t,empid,location){
                if(s === "---" || t === "---"){
                    document.getElementById("typeText").value = "none";
                }
                else{
                    document.getElementById("typeText").value = "time";
                }
                
                if(location != ""){
                    document.getElementById("locationText").value = location;
                }
                
                document.getElementById("userid").value = empid;
                
                alert(document.getElementById("hourId").value);
            }
        </script>
    </head>
    <body onload="startTimeloader('<%=start%>') ,endTimeLoader('<%=end%>'),checkType('<%=start%>','<%=end%>','<%=employeeId%>','<%=location%>')">
        
        <div class="navContainer">
            <div class="navTextContainer">
                <a href="leavingManagerDashboard.jsp">
                    <h1>HR Manager Dashboard</h1>
                </a>
                <h2>Welcome!</h2>
            </div>
            <div class="navBtnContainer">
                <form method="post" action="logoutUser">
                    <input type="submit" name="logout" value="LogOut">
                </form>
            </div>
        </div>
        <div class="userDetailsContainer_empview">
            <div class="userImagecontainer">UserImage</div>
            <div class="userDelConSI">
                <label>Employee Name : <%=fname+" "+lname%></label>
                <label>Username : <%=username%></label>
                <label>Email : <%=email%></label>
            </div>
        </div>
        <div class="timeSlotFormContainer">
            <form method="post" action="submitHours">
                <h5> <%
                    out.println(userSession.getAttribute("houradd"));
                    if(userSession.getAttribute("houradd") != "" ){
                        userSession.setAttribute("houradd","");
                    }
                    %> </h5>
            <label>Start time</label>
            <input type="time" name="starttime" class="timeInput" id="startTimeInput" required>
            <label>End time</label>
            <input type="time" name="endtime" class="timeInput" id="endTimeInput" required>
            <label>Location</label>
            <input type="text" name="location" id="locationText" placeholder="Enter the location" required>
            <input type="submit" value="Add Time" class="submitBTN">
            <input type="text" hidden name="typeText" id="typeText" value="summa">
            <input type="text" hidden name="userid" id="userid">
        </form>
        </div>
    </body>
</html>





