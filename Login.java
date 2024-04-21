import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public Login() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
        	response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            Long AccountNumber = Long.parseLong(request.getParameter("AccountNumber"));
            String cname = request.getParameter("name");
            String password= request.getParameter("password");
            
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "gaytri", "gaytri");
           
            PreparedStatement psmt = con.prepareStatement("select name from  account where AccountNumber=? and password=? ");
            psmt.setLong(1, AccountNumber);
            psmt.setString(2, password);
            ResultSet rs = psmt.executeQuery();

            if(rs.next()) {
                request.setAttribute("AccountNumber", AccountNumber);
                request.setAttribute("name", cname);
                RequestDispatcher dispatcher = request.getRequestDispatcher("ViewDetails.jsp");
                dispatcher.forward(request, response);
            } else {
                out.println("<font color=red size=18>Login Failed!!");
            }

            
        } catch (Exception e) {
            System.out.print(e);
        }
    }
}
