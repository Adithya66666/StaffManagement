
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
@WebServlet(urlPatterns = {"/createEmployee"})
public class createEmployee extends HttpServlet {
    PreparedStatement st;
PreparedStatement smt;
Connection connection; 
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        PrintWriter out = response.getWriter(); 
        HttpSession empCreateSession = request.getSession();
        
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            //int total = Integer.valueOf(request.getParameter("amount")); 
            String username = request.getParameter("username"); 
            String password = request.getParameter("password"); 
            String cpassword = request.getParameter("cpassword");
            
            int usernameCounter = 0; 
            
            try{
                connection = dbConnection.initializeDatabase();
                Statement stmt = connection.createStatement();
                String query = "SELECT username FROM employee;";
                ResultSet rs = stmt.executeQuery(query); 

                while(rs.next()){
                    String username_db = rs.getString("username");
                    if(username.equals(username_db)){
                        usernameCounter++;
                    }
                }
                
            }catch(SQLException |ClassNotFoundException e){}
            
            if(!password.equals(cpassword)){
                empCreateSession.setAttribute("empcreatestatus", "Failed. Passwords are not matched.");
                response.sendRedirect(request.getContextPath()+"/empSignUp.jsp");
            }
            else if(usernameCounter != 0){
                empCreateSession.setAttribute("empcreatestatus", "Failed. Username is already in use");
                response.sendRedirect(request.getContextPath()+"/empSignUp.jsp");
            }
            else{
                try{
                    connection = dbConnection.initializeDatabase();
                    Statement stmt = connection.createStatement();
                    st = connection.prepareStatement("insert into employee(fname,lname,email,username,password,type) values('"+fname+"','"+lname+"','"+email+"','"+username+"','"+password+"','emp')");
                    st.executeUpdate();
                    st.close();
                } catch (ClassNotFoundException | SQLException ex) {
                    out.println(ex);
                }
                empCreateSession.setAttribute("empcreatestatus", "Employee created succesfully");
                response.sendRedirect(request.getContextPath()+"/index.jsp");

            }
    }
}
