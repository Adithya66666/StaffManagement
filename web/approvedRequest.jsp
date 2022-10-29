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


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Leaving Manager Dashboard</title>
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
            function rejected(){
                window.location.replace("rejectedRequest.jsp");
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
            <div class="empRequestContiner">
                <div class="leavingMNavBtnCon">
                    <button class="unclickedBtn" onclick="pending()">Pending Requests</button>
                    <button class="clickedBtn" onclick="approved()">Approved Requests</button>
                    <button class="unclickedBtn" onclick="rejected()">Rejected Requests</button>
                </div>
                <table class="requestListTable">
                    <tr>
                        <td>id</td>
                        <td>Employee</td>
                        <td>Date</td>
                        <td>Status</td>
                        <td>View</td>
                    </tr>
                <%
                        int requestCounter = 0;
                        try{
                            
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + "staffmanagement","root","");
                            Statement statement = con.createStatement();
                            String str = "SELECT * FROM leavingrequest WHERE status='Approved'";
                            ResultSet rs = statement.executeQuery(str);
                            while(rs.next()){
                                String rid = rs.getString("id");
                                String ruserid = rs.getString("userid");
                                String date = rs.getString("date");
                                String leaveDate = rs.getString("leaveDate");
                                String reason = rs.getString("reason");
                                String status = rs.getString("status");
                                String fname = "";
                                String lname = "";
                                requestCounter++;
                                                                
                                String currentdate = java.time.LocalDate.now().toString();
                                
                                String leaveArr = leaveDate;
                                String[] leavearray = leaveArr.split("-");
                                
                                String currentday= currentdate;
                                String[] currentArray = currentday.split("-");
                                
                                int currentYear = Integer.valueOf(currentArray[0]);
                                int currentMonth = Integer.valueOf(currentArray[1]);
                                int currentDay = Integer.valueOf(currentArray[2]);
                                
                                int selectedYear = Integer.valueOf(leavearray[0]);
                                int selectedMonth = Integer.valueOf(leavearray[1]);
                                int selectedDay = Integer.valueOf(leavearray[2]);
                                
                                if(currentYear < selectedYear){
                                    Statement statement_2 = con.createStatement();
                                            String str_2 = "SELECT * FROM employee WHERE id="+ruserid;
                                            ResultSet rs_2 = statement_2.executeQuery(str_2);
                                            while(rs_2.next()){
                                                fname = rs_2.getString("fname");
                                                lname = rs_2.getString("lname");
                                            }

                                            %>
                                            <tr>
                                                <td><%=requestCounter%></td>
                                                <td><%=fname+" "+lname%></td>
                                                <td><%=date%></td>
                                                <td><%=status%></td>
                                                <td><button onclick="viewRequest('<%=rid%>')">view</button></td>
                                            </tr>
                                            <%
                                }
                                else if(currentYear == selectedYear){
                                    if(currentMonth < selectedMonth){
                                        Statement statement_2 = con.createStatement();
                                            String str_2 = "SELECT * FROM employee WHERE id="+ruserid;
                                            ResultSet rs_2 = statement_2.executeQuery(str_2);
                                            while(rs_2.next()){
                                                fname = rs_2.getString("fname");
                                                lname = rs_2.getString("lname");
                                            }

                                            %>
                                            <tr>
                                                <td><%=requestCounter%></td>
                                                <td><%=fname+" "+lname%></td>
                                                <td><%=date%></td>
                                                <td><%=status%></td>
                                                <td><button onclick="viewRequest('<%=rid%>')">view</button></td>
                                            </tr>
                                            <%
                                    }
                                    else if(currentMonth == selectedMonth){
                                        if(currentDay < selectedDay){
                                            Statement statement_2 = con.createStatement();
                                            String str_2 = "SELECT * FROM employee WHERE id="+ruserid;
                                            ResultSet rs_2 = statement_2.executeQuery(str_2);
                                            while(rs_2.next()){
                                                fname = rs_2.getString("fname");
                                                lname = rs_2.getString("lname");
                                            }

                                            %>
                                            <tr>
                                                <td><%=requestCounter%></td>
                                                <td><%=fname+" "+lname%></td>
                                                <td><%=date%></td>
                                                <td><%=status%></td>
                                                <td><button onclick="viewRequest('<%=rid%>')">view</button></td>
                                            </tr>
                                            <%
                                        }
                                    }
                                }
                            }                           
                        }catch(Exception e){
                        
                        }
                
                %>
                </table>
            </div>
        </section>
        
    </body>
</html>
