
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
            <%
                HttpSession userSession = request.getSession(true);
                String userId = (String)userSession.getAttribute("userId");
                String userType = (String)userSession.getAttribute("userType");
                if(userId == null){
                    response.sendRedirect(request.getContextPath()+"/index.jsp");
                }
                if(userType != "emp"){
                }else{
                response.sendRedirect(request.getContextPath()+"/index.jsp");
                }
            %>
            
                    <%int counter = 0; 
                    String reason = ""; 
                    String date = "";
                    String leaveDate = "";
                    String requestid = ""; 
                    String status = "";
                        try{
                            
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + "staffmanagement","root","");
                            Statement statement = con.createStatement();
                            String str = "SELECT * FROM leavingrequest WHERE userid="+userId;
                            ResultSet rs = statement.executeQuery(str);
                            while(rs.next()){
                                reason = rs.getString("reason");
                                date = rs.getString("date");
                                leaveDate = rs.getString("leaveDate");
                                status = rs.getString("status");
                                requestid = rs.getString("id");
                                counter++;
                            }                            
                        }catch(Exception e){
                        
                        }
                        
                        String fname = ""; 
                        String lname = ""; 
                        String email = ""; 
                        String username = ""; 
                        
                        try{
                            
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + "staffmanagement","root","");
                            Statement statement = con.createStatement();
                            String str = "SELECT * FROM employee WHERE id="+userId;
                            ResultSet rs = statement.executeQuery(str);
                            while(rs.next()){
                                fname = rs.getString("fname");
                                lname = rs.getString("lname");
                                email = rs.getString("email");
                                username = rs.getString("username");
                            }                            
                        }catch(Exception e){
                        
                        }
                        
                        String location = ""; 
                        String start = ""; 
                        String end = "";  
                        int hourCounter = 0;
                        try{
                            
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + "staffmanagement","root","");
                            Statement statement = con.createStatement();
                            String str = "SELECT * FROM hours WHERE empid="+userId;
                            ResultSet rs = statement.executeQuery(str);
                            while(rs.next()){
                                location = rs.getString("location");
                                start = rs.getString("start");
                                end = rs.getString("end");
                                hourCounter++;
                            }           
                        }catch(Exception e){
                        
                        }
                    %>
            
            
            
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Employee Dashboard</title>
        <link rel="stylesheet" href="loginCss.css?version=1.2" media="screen">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
        <link rel="stylesheet" href="empDashboardCSS.css?version=1.5" media="screen">
       
        
        <script>
            function leaveBtn(count){
                if(count === 0){
                  window.location.replace("leavingRequest.jsp");   
                }
                else{
                    alert("you already requested to leave");
                }
            }
            function deleteRequest(type){
                if(type === "dis"){
                    document.getElementById("requestDeleteSubmit").click();
                }
                else if(type === "del"){
                    document.getElementById("requestDeleteAlert").style.display = "flex";
                } 
            }
            function unsetRequestDelAlert(){
                document.getElementById("requestDeleteAlert").style.display = "none";
            }
            function confirmRequestDelete(){
                document.getElementById("requestDeleteSubmit").click();
            }
        </script>
        
    </head>
    <body>
        
        <div class="requestDeleteAlert" id="requestDeleteAlert">
            <div class="rDRequestContainer">
                <p>Are you sure? <br> To delete your leaving request click "Delete" button</p>
                <div class="rDBtnContainer">
                    <button onclick="confirmRequestDelete()">Delete</button>
                    <button onclick="unsetRequestDelAlert()">Cancel</button>
                </div>
            </div>
            <div class="requestDelBackground" onclick="unsetRequestDelAlert()"></div>
        </div>
        
        <div class="navContainer">
            <div class="navTextContainer">
                <h1>Employee Dashboard</h1>
                <h2>Welcome! <%=fname+" "+lname%></h2>
            </div>
            <div class="navBtnContainer">
                <button class="leaveBtn" name="leaveBtn" id="leaveBtn" onclick="leaveBtn(<%=counter%>)">Leave</button>
                <form method="post" action="logoutUser">
                    <input type="submit" name="logout" value="LogOut">
                </form>
            </div>
        </div>
                
        
                
        <section>
            <div class="userDetAndWCon">
                <div class="mainuserDetailContainer">
                    <h1>User Details</h1>
                    <h5>Name : <%=fname+" "+lname%></h5>
                    <h5>Email : <%=email%></h5>
                    <h5>Username : <%=username%></h5>
                    <h5>Employee</h5>
                </div>
                    <div class="workTimeContainer">
                        <h1>Working Hours</h1>
                        
                        <%
                        if(hourCounter != 0){ %>
                            <h4>Location:<%=" "+location%></h4>
                            <div class="wTTimeCon">
                                <div class="timeElementContainer">
                                    <h5>Start</h5>
                                    <h1><%=start%></h1>
                                </div>
                                <div class="timeElementContainer">
                                    <h5>End</h5>
                                    <h1><%=end%></h1>
                                </div>
                            </div> <%
                        }else{%>
                        <div>No Working hours yet.</div>
                        <%}
                        %>
                    </div>
            </div>
        </section>
                
        
        
        <section>
            <div class="contentContainer">
                <div class="leavingContainer">
                    <%
                    if(counter != 0){
                    %>
                    
                    <div class="leavingCardContainer">
                        <h1>Leaving Request</h1>
                        <h5>Name : <%=fname+" "+lname%></h5>
                        <h5>Email : <%=email%></h5>
                        <br>
                        <h5>Reason : <%=reason%></h5>
                        <h5>Leave Date : <%=leaveDate%></h5>
                        <h5>Request Date : <%=date%></h5>
                        <h5>Status : <%=status%></h5>
                        <div class="requestBtnContainer">
                            <%
                            if("Rejected".equals(status)){
                            %><h5>Your request got rejected.</h5>
                            <button onclick="deleteRequest('dis')">Dismiss</button><%
                            }else{
                            %><button onclick="deleteRequest('del')">Delete</button><%
                            }
                            %>
                        </div>
                    </div>
                   <%} %>
                   <div class="errorContainer">
                       <%
                            String error = (String)userSession.getAttribute("requestsendStatus");
                            out.println(error);
                            if(error != ""){
                                userSession.setAttribute("requestsendStatus", "");
                            }
                       %>
                   </div>
                </div>
            </div>
        </section>
                
                <form method="post" action="deleteRequest">
                    <input type="submit" hidden id="requestDeleteSubmit">
                    <input type="text" value="<%=requestid%>" name="requestid" hidden>
                </form>

        
    </body>
</html>
