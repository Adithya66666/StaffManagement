/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Adithya
 */
@WebServlet(urlPatterns = {"/LeavingRequestEdit"})
public class LeavingRequestEdit extends HttpServlet {
PreparedStatement st;
    PreparedStatement smt;
    Connection connection; 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        PrintWriter out = response.getWriter(); 
        HttpSession userSessions = request.getSession();
        
        
        String submissionType = request.getParameter("submissionType");
        String rid = request.getParameter("requestidInput");
    
        try{
            connection = dbConnection.initializeDatabase();
            Statement stmt = connection.createStatement();
            st = connection.prepareStatement("UPDATE leavingrequest SET status = '"+submissionType+"' WHERE id="+rid);
            st.executeUpdate();
            st.close();
            } catch (ClassNotFoundException | SQLException ex) {
                out.println(ex);
            }
            response.sendRedirect(request.getContextPath()+"/viewRequest.jsp?id="+rid);

        
    }
}
