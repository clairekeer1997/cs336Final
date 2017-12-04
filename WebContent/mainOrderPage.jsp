<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%ResultSet resultset =null;%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> reservation - JTSR Hotel Order System</title>


<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Datepicker - Default functionality</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $(document).ready(function () {

	    $("#datepicker").datepicker({
	        dateFormat: "yy-mm-dd",
	        minDate: 0,
	        onSelect: function (date) {
	            var date2 = $('#datepicker').datepicker('getDate');
	            date2.setDate(date2.getDate() + 1);
	            $('#datepicker1').datepicker('setDate', date2);
	            //sets minDate to dt1 date + 1
	            $('#datepicker1').datepicker('option', 'minDate', date2);
	        }
	    });
	    $('#datepicker1').datepicker({
	        dateFormat: "yy-mm-dd",
	        onClose: function () {
	            var dt1 = $('#datepicker').datepicker('getDate');
	            var dt2 = $('#datepicker1').datepicker('getDate');
	            //check to prevent a user from entering a date below date of dt1
	            if (dt2 <= dt1) {
	                var minDate = $('#datepicker1').datepicker('option', 'minDate');
	                $('#datepicker1').datepicker('setDate', minDate);
	            }
	        }
	    });
	});
  </script>
  
</head>

<body>
<font size = 6>Welcome to JTSR Hotels </font>
<br>
	<form method = "post" action = "paymentInfo.jsp">
	<center>
	<h1>Make Your Reservation</h1>
	<table>
	<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb", "JTSR","336HotelJTSR");
			
			Statement t = con.createStatement();
			String sqls = "SELECT h.Name\n" + "FROM Hotel h";
			ResultSet res = t.executeQuery(sqls);
	%>
	<tr><td>Select a Hotel: </td><td>
	<select name = "hotelSelection">
		<%  while(res.next()){ %>
			<option><%= res.getString(1)%></option>
		        <% } 
		        con.close();
		        %>
	</select>
	</td></tr>
	<%}
		catch(Exception e){
			e.printStackTrace();
		}
	%>
	
	<tr><td>Select room type: </td><td> <select name = "roomType">
										<option value = "standard">standard</option>
										<option value = "double">double</option>
										<option value = "deluxe">deluxe</option>
										<option value = "suite">suite</option></select></td></tr>
	
	<tr><td>Check in date: </td>
	<td> <input type="text" id="datepicker" name = "startDate"></td>
	
	<td>leaving date:</td>
	<td> <input type="text" id="datepicker1" name = "endDate"></td></tr>
	
	<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb", "JTSR","336HotelJTSR");
			
			Statement t = con.createStatement();
			String sqls = "SELECT s.sType\n" + "FROM Service s";
			ResultSet res = t.executeQuery(sqls);
	%>
	<tr><td>Service: </td><td>
	<select name = "serviceSelection">
		<%  while(res.next()){ %>
			<option><%= res.getString(1)%></option>
		        <% } 
		        con.close();
		        %>
	</select>
	</td></tr>
	<%}
		catch(Exception e){
			e.printStackTrace();
		}
	%>
	
	<tr><td> <input type = "submit" id = "paymentPage" value = "Go payment Info"></td></tr>
	</table>
	</center>
	</form>

</body>
</html>
