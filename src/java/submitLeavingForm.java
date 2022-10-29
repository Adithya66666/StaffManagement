
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/submitLeavingForm"})
public class submitLeavingForm extends HttpServlet {
    PreparedStatement st;
    PreparedStatement smt;
    Connection connection; 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        PrintWriter out = response.getWriter(); 
        HttpSession userSessions = request.getSession();
        
        
        String reason = request.getParameter("reasonTxt");
        String userid = (String)userSessions.getAttribute("userId");
        String date = java.time.LocalDate.now().toString();
        
        String leaveDate = request.getParameter("leaveDate");
        String[] currentArray;
        currentArray = date.split("-");
        
        String[] leaveArray;
        leaveArray = leaveDate.split("-");
        
        int cyear = Integer.valueOf(currentArray[0]);
        int cmonth = Integer.valueOf(currentArray[1]);
        int cdate = Integer.valueOf(currentArray[2]);
        
        
        
        int lyear = Integer.valueOf(leaveArray[0]);
        int lmonth = Integer.valueOf(leaveArray[1]);
        int ldate = Integer.valueOf(leaveArray[2]);
        
                                if(lyear < cyear){
                                    userSessions.setAttribute("requestsendStatus", "Failed to add your request.");
                                }
                                else if(lyear == cyear){
                                    if(lmonth < cmonth){
                                        userSessions.setAttribute("requestsendStatus", "Failed to add your request.");
                                    }
                                    else if(lmonth == cmonth){
                                        if(ldate < cdate){
                                            userSessions.setAttribute("requestsendStatus", "Failed to add your request.");
                                        }
                                        else{
                                            userSessions.setAttribute("requestsendStatus", "Request sent succesfully");
                                        //pass
                                            try{
                                            connection = dbConnection.initializeDatabase();
                                            Statement stmt = connection.createStatement();
                                            st = connection.prepareStatement("insert into leavingrequest(userid,date,leaveDate,reason) values('"+userid+"','"+date+"','"+leaveDate+"','"+reason+"')");
                                            st.executeUpdate();
                                            st.close();
                                            } catch (ClassNotFoundException | SQLException ex) {
                                                out.println(ex);
                                            }
                                        }
                                    }
                                    else{
                                        userSessions.setAttribute("requestsendStatus", "Request sent succesfully");
                                    //pass
                                        try{
                                        connection = dbConnection.initializeDatabase();
                                        Statement stmt = connection.createStatement();
                                        st = connection.prepareStatement("insert into leavingrequest(userid,date,leaveDate,reason) values('"+userid+"','"+date+"','"+leaveDate+"','"+reason+"')");
                                        st.executeUpdate();
                                        st.close();
                                        } catch (ClassNotFoundException | SQLException ex) {
                                            out.println(ex);
                                        }
                                    }
                                }else{
                                    userSessions.setAttribute("requestsendStatus", "Request sent succesfully");
                                    //pass
                                    try{
                                    connection = dbConnection.initializeDatabase();
                                    Statement stmt = connection.createStatement();
                                    st = connection.prepareStatement("insert into leavingrequest(userid,date,leaveDate,reason) values('"+userid+"','"+date+"','"+leaveDate+"','"+reason+"')");
                                    st.executeUpdate();
                                    st.close();
                                    } catch (ClassNotFoundException | SQLException ex) {
                                        out.println(ex);
                                    }
                                } 
                                         

            
            response.sendRedirect(request.getContextPath()+"/empDashboard.jsp");
    
    }
}
