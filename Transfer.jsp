<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transfer</title>
</head>
<body>
<%
Connection con = null;
try {
   
    long sourceAccountNumber = Long.parseLong(request.getParameter("AccountNumber"));
    String name = request.getParameter("name");
    String password = request.getParameter("password");
    long destinationAccountNumber = Long.parseLong(request.getParameter("TAccountNumber"));
    double transferAmount = Double.parseDouble(request.getParameter("amount"));
    
   
    Class.forName("oracle.jdbc.driver.OracleDriver");
    con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "gaytri", "gaytri");
    con.setAutoCommit(false);
  
    PreparedStatement sourceSelectPsmt = con.prepareStatement("SELECT amount FROM account WHERE AccountNumber = ?");
    sourceSelectPsmt.setLong(1, sourceAccountNumber);
    ResultSet sourceRs = sourceSelectPsmt.executeQuery();
    
    double sourceCurrentBalance = 0.0;
    if (sourceRs.next()) {
        sourceCurrentBalance = sourceRs.getDouble("amount");
    } else {
        throw new Exception("Source account not found.");
    }
    
  
    if (sourceCurrentBalance < transferAmount) {
        throw new Exception("Insufficient balance in the source account.");
    }
    
 
    double sourceNewBalance = sourceCurrentBalance - transferAmount;
    PreparedStatement sourceUpdatePsmt = con.prepareStatement("UPDATE account SET amount = ? WHERE AccountNumber = ?");
    sourceUpdatePsmt.setDouble(1, sourceNewBalance);
    sourceUpdatePsmt.setLong(2, sourceAccountNumber);
    sourceUpdatePsmt.executeUpdate();
    
  
    PreparedStatement destinationSelectPsmt = con.prepareStatement("SELECT amount FROM account WHERE AccountNumber = ?");
    destinationSelectPsmt.setLong(1, destinationAccountNumber);
    ResultSet destinationRs = destinationSelectPsmt.executeQuery();
    
    double destinationCurrentBalance = 0.0;
    if (destinationRs.next()) {
        destinationCurrentBalance = destinationRs.getDouble("amount");
    } else {
        throw new Exception("Destination account not found.");
    }
    
    double destinationNewBalance = destinationCurrentBalance + transferAmount;
    PreparedStatement destinationUpdatePsmt = con.prepareStatement("UPDATE account SET amount = ? WHERE AccountNumber = ?");
    destinationUpdatePsmt.setDouble(1, destinationNewBalance);
    destinationUpdatePsmt.setLong(2, destinationAccountNumber);
    destinationUpdatePsmt.executeUpdate();
    
    con.commit(); 
    out.println("<script>");
    out.println("alert('Transfer successful! Your updated balance: " + sourceNewBalance + "');");
    out.println("window.location.href = 'ViewAll.html';"); 
    out.println("</script>");
} catch (Exception e) {
    // Handle exceptions and display error messages
	 out.println("<h1 style='text-align: center;'>Error: " + e.getMessage() + "</h1>");
	}
%>
</body>