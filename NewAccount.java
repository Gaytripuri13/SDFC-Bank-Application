import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/NewAccount")
public class NewAccount extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public NewAccount() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        Connection con = null;
        PreparedStatement ps = null;
        try {
            long AccountNumber = Long.parseLong(request.getParameter("AccountNumber"));
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            String confirm = request.getParameter("confirm");
            String gender = request.getParameter("gender");
            Double amount = Double.parseDouble(request.getParameter("amount"));
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            long mobile = Long.parseLong(request.getParameter("mobile"));
           

            if (!password.equals(confirm)) {
                out.println("Error: Password and Confirm Password do not match");
                return;
            }

            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "gaytri", "gaytri");

            ps = con.prepareStatement("INSERT INTO Account VALUES(?,?,?,?,?,?,?,?,?,?)");
            ps.setLong(1, AccountNumber);
            ps.setString(2, name);
            ps.setString(3, password);
            ps.setString(4, confirm);
            ps.setString(5, gender);
            ps.setDouble(6, amount);
            ps.setString(7, email);
            ps.setString(8, address);
            ps.setLong(9, mobile);
            ps.setString(10, "Active");

            int i = ps.executeUpdate();
            if (i > 0) {
            	 out.println("<script type='text/javascript'>");
            	    out.println("alert('Registration Successful!');");
            	    out.println("window.location.href = 'Login.html';"); // Redirect using JavaScript
            	    out.println("</script>");
            } else {
                out.println("Failed to insert user");
            }
        } 
         catch (Exception e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace(out);
        }
        }
    }

