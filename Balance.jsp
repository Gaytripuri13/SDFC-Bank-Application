<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Balance</title>
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
<%
try {
    long accountNumber = Long.parseLong(request.getParameter("AccountNumber"));
    String name = request.getParameter("name");
    String password = request.getParameter("password");
    
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "gaytri", "gaytri");
    PreparedStatement psmt = con.prepareStatement("SELECT amount FROM account WHERE AccountNumber=? AND password=?");
    psmt.setLong(1, accountNumber);
    psmt.setString(2, password);
    ResultSet rs = psmt.executeQuery();
    out.print("<h1 style='text-align: center;'>Hello " + name + ", here is your Account Details</h1>");
    out.print("<table border='1' style='margin: auto; text-align: center; font-size: 26px; width: 80%;'>");
    if (rs.next()) {
        long currentBalance = rs.getLong("amount");
        out.println("<tr><td>Customer Name</td><td>" + name + "</td></tr><br><br>");
        out.println("<tr><td>Account Number</td><td>" + accountNumber + "</td></tr>");
        out.println("<tr><td>Current Balance</td><td>" + currentBalance + "</td></tr>");
    } else {
        out.println("<tr><td colspan='2'>No data found for the provided account credentials.</td></tr>");
    }
    out.print("</table>");

    con.close();
} catch (Exception e) {
    out.println("An error occurred: " + e.getMessage());
}
%>
</body>
</html>
