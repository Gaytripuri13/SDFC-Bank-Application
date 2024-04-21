<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Deposit</title>
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
    Double amount = Double.parseDouble(request.getParameter("amount"));
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "gaytri", "gaytri");
    PreparedStatement selectPsmt = con.prepareStatement("SELECT amount FROM account WHERE AccountNumber = ?");
    selectPsmt.setLong(1, accountNumber);
    ResultSet rs = selectPsmt.executeQuery();

    double currentBalance = 0.0;
    if (rs.next()) {
        currentBalance = rs.getDouble("amount");
    }

   
    double newBalance = currentBalance + amount;

  
    PreparedStatement updatePsmt = con.prepareStatement("UPDATE account SET amount = ? WHERE AccountNumber = ?");
    updatePsmt.setDouble(1, newBalance);
    updatePsmt.setLong(2, accountNumber);
    int rowsUpdated = updatePsmt.executeUpdate();

    if (rowsUpdated > 0) {
      
        out.print("<h1 style='text-align: center;'>Hello " + name + ", here is your balance after deposite "+amount+"Rs.</h1>");
        out.print("<table border='1' style='margin: auto; text-align: center; font-size: 26px; width: 80%;'>");
        out.println("<tr><td>Customer Name</td><td>" + name + "</td></tr><br><br>");
        out.println("<tr><td>Account Number</td><td>" + accountNumber + "</td></tr>");
        out.println("<tr><td>Current Balance</td><td>" + newBalance + "</td></tr>");
        out.print("</table>");
    } else {
        out.println("<h1 style='text-align: center;'>Error: Failed to update balance</h1>");
    }

    out.print("</table>");

    con.close();
} catch (Exception e) {
    out.println("An error occurred: " + e.getMessage());
}
%>
</body>
</html>
