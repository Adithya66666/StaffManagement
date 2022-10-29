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

@WebServlet(urlPatterns = {"/submitHours"})
public class submitHours extends HttpServlet {
    
    PreparedStatement st;
    PreparedStatement smt;
    Connection connection; 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException {
           PrintWriter out = response.getWriter(); 
           String starttime = request.getParameter("starttime");
           String endtime = request.getParameter("endtime");
           String location = request.getParameter("location");
           String type = request.getParameter("typeText");
           String userid = request.getParameter("userid");
           HttpSession sessions = request.getSession();
           
           out.println(type);
           
           if(null == type){
               //out.print(location+ " "+starttime+" "+endtime+type);
           }
           else switch (type) {
            case "none":
                try{
                    out.print(location+ " "+starttime+" "+endtime);
                    connection = dbConnection.initializeDatabase();
                    Statement stmt = connection.createStatement();
                    st = connection.prepareStatement("insert into hours(empid,location,start,end) values('"+userid+"','"+location+"','"+starttime+"','"+endtime+"')");
                    st.executeUpdate();
                    st.close();
                    sessions.setAttribute("houradd", "Time added successfully");
                } catch (ClassNotFoundException | SQLException ex) {
                    out.println(ex);
                    sessions.setAttribute("houradd", "Failed.");
                }

            case "time":
                try{
                    out.print(location+ " "+starttime+" "+endtime);
                    connection = dbConnection.initializeDatabase();
                    Statement stmt = connection.createStatement();
                    st = connection.prepareStatement("update hours set location='"+location+"',start='"+starttime+"',end='"+endtime+"' where empid='"+userid+"'");
                    st.executeUpdate();
                    st.close();
                    sessions.setAttribute("houradd", "Time updated successfully");
                } catch (ClassNotFoundException | SQLException ex) {
                    out.println(ex);
                    sessions.setAttribute("houradd", "Failed.");
                }
                break;
            default:
                //out.print(location+ " "+starttime+" "+endtime+type);
                break;
        }   
        response.sendRedirect(request.getContextPath()+"/viewEmployee.jsp?id="+userid);
    }
}
