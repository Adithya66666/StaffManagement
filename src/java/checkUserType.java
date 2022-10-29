/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/checkUserType"})
public class checkUserType extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession userSession = request.getSession(true);
        String userType = (String)userSession.getAttribute("userType");
        String userId = (String)userSession.getAttribute("userId");
            
        
        if(!"".equals(userType)){
            switch (userType) {
               case "emp":
                   response.sendRedirect(request.getContextPath()+"/empDashboard.jsp");
                   break;
               case "leaving":
                   response.sendRedirect(request.getContextPath()+"/leavingManagerDashboard.jsp");
                   break;
               case "hr":
                   response.sendRedirect(request.getContextPath()+"/hrManagerDashboard.jsp");
                   break;
               default:
                   userSession.invalidate();
                   response.sendRedirect(request.getContextPath()+"/index.jsp");
                   break;
           }   
        }
        else{
        userSession.invalidate();
        response.sendRedirect(request.getContextPath()+"/index.jsp");   
        }
    }
    
}
