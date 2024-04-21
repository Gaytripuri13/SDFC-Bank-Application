<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    
    <title>View Details</title>
    <link rel ="icon" href="images/logo.png">
<style>
body {
  background-image: url('images/background.jpeg');
  background-position: top;
  background-repeat: no-repeat;
  background-size: cover;
  overflow-x: hidden;
}
</style>
    
</head>
<body>
<div class="details">
<%
try {
    long AccountNumber = (long)request.getAttribute("AccountNumber");
    String name = request.getParameter("name");
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "gaytri", "gaytri");
    PreparedStatement ps = con.prepareStatement("SELECT AccountNumber, name, gender, amount, email, address, mobile, status FROM account WHERE AccountNumber=?");
    ps.setLong(1, AccountNumber);
    ResultSet rs = ps.executeQuery();
    
    out.println("<h1 style='text-align: center;color: Green;'>Welcome!!! " + name + "</h1>");

    out.println("<table border=1px > ");
    ResultSetMetaData rss = rs.getMetaData();
    int n = rss.getColumnCount();
    out.println("<tr>");
    for(int i=1; i<=n; i++) {
        out.println("<th><font color='blue' size='4'><br>&nbsp;&nbsp;&nbsp;" + rss.getColumnName(i) + "&nbsp;&nbsp;&nbsp;</th>");
    }
    out.println("</tr>");
    while(rs.next()) {
        out.println("<tr>");
        for(int i = 1; i <= n; i++) {
            out.println("<td ><br>&nbsp;&nbsp;&nbsp;&nbsp;" + rs.getString(i) + "&nbsp;&nbsp;&nbsp;</td>");
        }
        out.println("</tr>");
    }
    out.println("</table>");
    con.close();
} catch(Exception e) {
    // Handle exceptions
    e.printStackTrace();
}
%>
</div>
</body>
</html>
