<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


            <%
                HttpSession userSession = request.getSession(true);
                String userId = (String)userSession.getAttribute("userId");
                String userType = (String)userSession.getAttribute("userType");
                if("".equals(userId)){
                    response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
                }
                else if(!"leaving".equals(userType)){
                    response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
                }
            %>
            
            
            <%
                String requestid = request.getParameter("id");
            %>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View leaving request</title>
        <link rel="stylesheet" href="loginCss.css?version=1.2" media="screen">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
        <link rel="stylesheet" href="empDashboardCSS.css?version=1.2" media="screen">
        <link rel="stylesheet" href="leavingManager.css?version=1.2" media="screen">
        <script>
            
            function viewRequest(rid){
                let requestid = rid;
                window.location.replace("viewRequest.jsp?id="+requestid);
            }
            function pending(){
                window.location.replace("leavingManagerDashboard.jsp");
            }
            function approved(){
                window.location.replace("approvedRequest.jsp");
            }
            function approveRequest(){
                document.getElementById("submitStatus").value = "Approved";
                document.getElementById("approveBtn").click();
            }
            function rejectRequest(){
                document.getElementById("submitStatus").value = "Rejected";
                document.getElementById("approveBtn").click();
            }
            function pendingRequest(){
                document.getElementById("submitStatus").value = "Pending";
                document.getElementById("approveBtn").click();
            }
        </script>
    </head>
    <body>
        
        <div class="navContainer">
            <div class="navTextContainer">
                <a href="leavingManagerDashboard.jsp">
                    <h1>Leaving Manager Dashboard</h1>
                </a>
                <h2>Welcome! Manager</h2>
            </div>
            <div class="navBtnContainer">
                <form method="post" action="logoutUser">
                    <input type="submit" name="logout" value="LogOut">
                </form>
            </div>
        </div>
        
        <section>
            <% 
                String ruserid = ""; 
                String date = ""; 
                String leaveDate = ""; 
                String reason = ""; 
                String status = ""; 
                String fname = "";
                String lname = "";
                String username = "";
                String email = "";
                String empType = ""; 
                
                        try{
                            
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + "staffmanagement","root","");
                            Statement statement = con.createStatement();
                            String str = "SELECT * FROM leavingrequest WHERE id="+requestid;
                            ResultSet rs = statement.executeQuery(str);
                            while(rs.next()){
                                ruserid = rs.getString("userid");
                                date = rs.getString("date");
                                leaveDate = rs.getString("leaveDate");
                                reason = rs.getString("reason");
                                status = rs.getString("status");
                                
                                Statement statement_2 = con.createStatement();
                                String str_2 = "SELECT * FROM employee WHERE id="+ruserid;
                                ResultSet rs_2 = statement_2.executeQuery(str_2);
                                while(rs_2.next()){
                                    fname = rs_2.getString("fname");
                                    lname = rs_2.getString("lname");
                                    email = rs_2.getString("email");
                                    username = rs_2.getString("username");
                                    empType = "Employee";
                                }
                            }                            
                        }catch(Exception e){
                        
                        }
            
            %>
            
            
            
            <div class="requestViewContainer">
                <div class="lrvTopic"><h1>Leaving Request</h1></div>
                <div class="leaveRequestUserDetails">
                    <h5>Employee Name : <%=fname+" "+lname%></h5>
                    <h5>Username : <%=username%></h5>
                    <h5>Email : <%=email%></h5>
                    <h5><%=empType%></h5>
                </div>
                <div class="leaveRequestRequestDetails">
                    <div class="requestStatus">
                        <h1><%=status%></h1>
                    </div>
                    <div class="requestSubDetailcon">
                        <h5 class="sPtextHighlight">Leave Date : <%=leaveDate%></h5>
                        <h5>Request Date : <%=date%></h5>
                        <h5>Reason : <%=reason%></h5>
                        <h5><%=empType%></h5>
                    </div>
                </div>
                <div class="leaveRequestbuttonContainer">
                    <% if("Pending".equals(status)){%>
                    <button onclick="rejectRequest()">Reject</button>
                        <button onclick="approveRequest()">Approve</button>
                    <%}else{%>
                        <button onclick="rejectRequest()">Reject</button>
                        <button onclick="pendingRequest()">Pending</button>
                    <%}%>
                    
                </div>
            </div>
            
        </section>
                    <form method="post" action="LeavingRequestEdit">
                        <input type="submit" hidden id="approveBtn">
                        <input type="text" hidden id="submitStatus" name="submissionType">
                        <input type="text" hidden value="<%=requestid%>" name="requestidInput">
                    </form>
        
    </body>
</html>
