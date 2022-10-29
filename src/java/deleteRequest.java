
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

@WebServlet(urlPatterns = {"/deleteRequest"})
public class deleteRequest extends HttpServlet {
    PreparedStatement st;
    PreparedStatement smt;
    Connection connection; 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        PrintWriter out = response.getWriter(); 
        HttpSession userSessions = request.getSession();
        
        
        String requestid = request.getParameter("requestid");
    
        try{
            connection = dbConnection.initializeDatabase();
            Statement stmt = connection.createStatement();
            st = connection.prepareStatement("DELETE FROM leavingrequest WHERE id="+requestid);
            st.executeUpdate();
            st.close();
            } catch (ClassNotFoundException | SQLException ex) {
                out.println(ex);
            }
            userSessions.setAttribute("requestsendStatus", "Request deleted succesfully");
            response.sendRedirect(request.getContextPath()+"/empDashboard.jsp");

        
    }
}
