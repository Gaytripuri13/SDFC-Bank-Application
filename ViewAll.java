

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ViewAll
 */
@WebServlet("/ViewAll")
public class ViewAll extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewAll() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	

		
		
		
		
		
		// TODO Auto-generated method stub
		 try {
	            response.setContentType("text/html");
	            PrintWriter out = response.getWriter();
	            
	            
	            out.println("<!DOCTYPE html>");
	            out.println("<html lang=\"en\">");
	            out.println("<head>");
	            out.println("<link rel =icon href=images/logo.png>");
	            out.println("<title>Servlet Page</title>");
	            
	            out.println("<style>");
	            out.println("body {");
	            out.println("    background-image: url('images/background.jpeg');"); // Replace 'background.jpg' with the path to your background image
	            out.println("    background-position: top;");
	            out.println("    background-size: cover;");
	            out.println("    background-repeat: no-repeat;");
	            out.println("}");
	            out.println("</style>");
	            out.println("</head>");
	            out.println("<body>");
	            out.println("<h1>Here are the all custmers details</h1>");
	         
	            
	            out.println("</body>");
	            out.println("</html>");
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            Class.forName("oracle.jdbc.driver.OracleDriver");
	            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "gaytri", "gaytri");
	            java.sql.Statement st = con.createStatement(); // Cast to java.sql.Statement
	            ResultSet rs = st.executeQuery("select * from account"); // Use executeQuery method from java.sql.Statement
	            ResultSetMetaData rss = rs.getMetaData();
	            int n = rss.getColumnCount();
	            out.println("<table border='1'>");
	            for(int i=1; i<=n; i++) {
	                out.println("<td><font color='blue' size='3'><br>" + rss.getColumnName(i) + "</td>");
	            }
	            out.println("<tr>");
	            while(rs.next()) {
	                for(int i = 1; i <= n; i++) 
	                    out.println("<td><br>" + rs.getString(i) + "</td>");
	                out.println("</tr>");
	            }
	            out.println("</table></body></html>");
	            con.close();
	        } catch(Exception e) {
	            // Handle exceptions
	            e.printStackTrace();
	        }
	}

}
