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
import static org.jboss.weld.context.cache.RequestScopedCache.invalidate;

@WebServlet(urlPatterns = {"/logoutUser"})
public class logoutUser extends HttpServlet {
        @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        
        HttpSession userSession = request.getSession(true);
        String userType = (String)userSession.getAttribute("userType");

            userSession.invalidate();
            
            out.println(userType);
            
            if("emp".equals(userType)){
                response.sendRedirect(request.getContextPath()+"/index.jsp");
            }
            else if("leaving".equals(userType) || "hr".equals(userType)){
                response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
            }

        
    }
}
