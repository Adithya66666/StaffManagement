/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/userLogin"})
public class userLogin extends HttpServlet {
        PreparedStatement st;
        PreparedStatement smt;
        Connection connection; 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        PrintWriter out = response.getWriter(); 
            HttpSession userSession = request.getSession();
               
            String username = request.getParameter("email"); 
            String password = request.getParameter("password"); 
            int usercounter = 0;
                try{
                connection = dbConnection.initializeDatabase();
                Statement stmt = connection.createStatement();
                String query = "SELECT id,email,username,password,type FROM employee;";
                ResultSet rs = stmt.executeQuery(query);
                    while(rs.next()){
                        String email_db = rs.getString("email");
                        String username_db = rs.getString("username");
                        String password_db = rs.getString("password");
                        String userType = rs.getString("type");
                        String userid = rs.getString("id"); 
                        
                        if(username_db.equals(username) || email_db.equals(username)){
                            if(password_db.equals(password)){
                                userSession.setAttribute("userId", userid);
                                userSession.setAttribute("userType", userType);
                                userSession.setAttribute("loginStatus", "Login success!");
                                break;
                            }
                            else{
                                userSession.setAttribute("loginStatus", "Failed. Entered password is wrong");
                                break;
                            }
                        }
                        else{
                            userSession.setAttribute("loginStatus", "Login Failed. Try again..");
                        }
                    }
                }catch(SQLException |ClassNotFoundException e){}
                response.sendRedirect(request.getContextPath()+"/index.jsp");
                
    }

}
