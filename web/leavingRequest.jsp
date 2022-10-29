
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
            
            
                    <%
                        try{
                            
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + "staffmanagement","root","");
                            Statement statement = con.createStatement();
                            String str = "SELECT * FROM leavingrequest WHERE userid="+userId;
                            ResultSet rs = statement.executeQuery(str);
                            while(rs.next()){
                                response.sendRedirect(request.getContextPath()+"/empDashboard.jsp");
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
        <link rel="stylesheet" href="empDashboardCSS.css?version=2" media="screen">   
        <link rel="stylesheet" href="leaving.css?version=1.5" media="screen">
        
        <script>
            function backBtn(){
                window.location.replace("empDashboard.jsp");
            }
        </script>
        
    </head>
    <body>
        <div class="navContainer">
            <div class="navTextContainer">
                <h1>Leaving Request Submission</h1>
                <h2>Welcome! Adithya Bandara</h2>
            </div>
            <div class="navBtnContainer">
                <button class="leaveBtn" name="leaveBtn" id="leaveBtn" onclick="backBtn()"> < Back</button>
                <form method="post" action="logoutUser">
                    <input type="submit" name="logout" value="LogOut">
                </form>
            </div>
        </div>
        
        <%
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
                    %>
        
        <section>
            <div class="contentContainer">
                <div class="leavingFormcontainer">
                    <div class="leavingUserDetails">
                        <div class="empdetcon">
                            <table>
                                <h1>Employee Details</h1> <br>
                                <tr>
                                    <td class="tableFixedText">Full Name</td>
                                    <td><%=fname+" "+lname%></td>
                                </tr>
                                <tr>
                                    <td class="tableFixedText">Email</td>
                                    <td><%=email%></td>
                                </tr>
                                <tr>
                                    <td class="tableFixedText">Username</td>
                                    <td><%=username%></td>
                                </tr>
                            </table>    
                        </div>
                        <button class="btnDashboard" onclick="backBtn()">Dashboard</button>
                    </div>
                    <form method="post" action="submitLeavingForm">
                        <label>Reason</label>
                        <textarea required name="reasonTxt" placeholder="Ënter your reason for submiting this leaving request"></textarea>
                        <div class="leaveDateContainer">
                            <label>Leave Date</label><input class="dateInput" type="date" name="leaveDate" required >
                        </div>
                        <input  class="leaveFormSubmitBtn" type="submit" id="requestSubmit">
                    </form>
                </div>
            </div>
        </section>

        
    </body>
</html>
