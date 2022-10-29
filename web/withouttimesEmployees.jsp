
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
            %>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HR Manager Dashboard</title>
        <link rel="stylesheet" href="loginCss.css?version=1.2" media="screen">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
        <link rel="stylesheet" href="empDashboardCSS.css?version=1.2" media="screen">
        <link rel="stylesheet" href="leavingManager.css?version=1.2" media="screen">
        <script>
            
            function viewEmployee(id){
                let userid = id;
                window.location.replace("viewEmployee.jsp?id="+userid);
            }
            function withtimeslot(){
                window.location.replace("hrManagerDashboard.jsp");
            }
            function withouttimeslot(){
                window.location.replace("withouttimesEmployees.jsp");
            }
            function onleaveemp(){
                window.location.replace("onleaveEmployees.jsp");
            }
        </script>
    </head>
    <body>
        
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
        
        <section>
            <div class="empRequestContiner">
                <div class="leavingMNavBtnCon">
                    <button class="unclickedBtn" onclick="withtimeslot()">With time slot</button>
                    <button class="clickedBtn" onclick="withouttimeslot()">Without time slot</button>
                    <button class="unclickedBtn" onclick="onleaveemp()">On leave</button>
                </div>
                <table class="requestListTable">
                    <tr>
                        <td>id</td>
                        <td>Employee Name</td>
                        <td>Email</td>
                        <td>start</td>
                        <td>End</td>
                        <td>View</td>
                    </tr>
                    <%       
                       
                        int requestCounter = 0;
                        try{
                            
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + "staffmanagement","root","");
                            
                            Statement statement = con.createStatement();
                            String str = "SELECT * FROM employee";
                            ResultSet rs = statement.executeQuery(str);
                            while(rs.next()){
                                int usercounter = 0;
                                String userid = rs.getString("id");
                                String fname = rs.getString("fname");
                                String lname = rs.getString("lname");
                                String username = rs.getString("username");
                                String email = rs.getString("email");
                                requestCounter++;
                                
                                    String start = "---";
                                    String end = "---";
                                    String location = "---";
                                    

                                Statement statement_1 = con.createStatement();
                                String str_1 = "SELECT * FROM hours WHERE empid="+userid;
                                ResultSet rs_1 = statement_1.executeQuery(str_1);
                                while(rs_1.next()){
                                       usercounter++;
                                }
                                if(usercounter == 0){
                                %>
                                <tr>
                                        <td><%=requestCounter%></td>
                                        <td><%=fname+" "+lname%></td>
                                        <td><%=email%></td>
                                        <td><%=start%></td>
                                        <td><%=end%></td>
                                        <td><button onclick="viewEmployee('<%=userid%>')">Update</button></td>
                                    </tr> 
                                    
                                    <%
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





