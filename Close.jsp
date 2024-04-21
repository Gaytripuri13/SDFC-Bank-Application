<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Close Account</title>
</head>
<body>
    <%
        response.setContentType("text/html");
       
        long accountNumber = Long.parseLong(request.getParameter("AccountNumber"));
        String name = request.getParameter("name");
        String password = request.getParameter("password");

        Connection con = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "gaytri", "gaytri");
            
            // Verify account credentials
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Account WHERE accountNumber=? AND Name=? AND Password=?");
            ps.setLong(1, accountNumber);
            ps.setString(2, name);
            ps.setString(3, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Update account status to "inactive"
                PreparedStatement closePs = con.prepareStatement("UPDATE Account SET Status='inactive' WHERE AccountNumber=?");
                closePs.setLong(1, accountNumber);
                int rowsAffected = closePs.executeUpdate();
                
                if (rowsAffected > 0) {
                	 out.println("<script type='text/javascript'>");
             	    out.println("alert('Your Account Closed!');");
             	    out.println("window.location.href = 'home.html';"); // Redirect using JavaScript
             	    out.println("</script>");
                } else {
                    out.println("<h2>Error closing account. Please try again.</h2>");
                }
            } else {
                out.println("<h2>Invalid account credentials. Please check and try again.</h2>");
            }
        } catch (Exception e) {
            out.println("<h2>Error: " + e.getMessage() + "</h2>");
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    %>
</body>
</html>
