<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>select</title>
</head>
<body> <center>
 <font size = 6>Your choice for Breakfast and Service </font></center>
 <br>
 <%
	String hotelId = request.getParameter("hotelSelection");
	session.setAttribute("h", hotelId);
	String roomType = request.getParameter("roomType");
	session.setAttribute("r", roomType);
	String sDate = request.getParameter("startDate");
	session.setAttribute("startDate", sDate);
	String eDate = request.getParameter("endDate");
	session.setAttribute("e", eDate);
	
%>

 <%
	  try{
		   Class.forName("com.mysql.jdbc.Driver");
		   Connection con = DriverManager.getConnection("jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb", "JTSR","336HotelJTSR");
		   Statement t = con.createStatement();
			if(request.getParameter("startDate").equals("") ||
			   request.getParameter("endDate").equals("")){			
				%>
				<script>
					alert("Please fill check in or check out date before select service.");
					window.location.href = "mainOrderPage.jsp";
				</script>
				<%
			}
			
		   String sqlbreakfast  = "SELECT Btype.bType\n" + "FROM Breakfast Btype\n" + "WHERE Btype.HotelID = '" + hotelId + "' " + " ORDER BY Btype.bType ASC";	
           ResultSet resBreakfast = t.executeQuery(sqlbreakfast);
 %>
	<form method="post" action="paymentInfo.jsp">
		<center>
			<h1> Select Breakfast Type</h1>
			     
		 <% int j=0;
            while(resBreakfast.next()){ 
	            String tempbreak = "breakfast" + j +"";
	            String num = "num"+j +"";
	            String bre = resBreakfast.getString(1);
         %>
            <br>
            <font size =5>Breakfast Type:<%=bre %></font>
              <input type="hidden"  name= <%= tempbreak %> value = <%=bre %>>
              <pre>Quantity: <input type ="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' name= <%= num %>></pre>
              <br><br>
            <% j++;
            }  %>
           </center>
  
     <%     String sqlservice = "SELECT Stype.sType\n" + "FROM Service Stype\n" + "WHERE Stype.HotelID = '" + hotelId + "' " + " ORDER BY Stype.sType ASC";
	        ResultSet resservice  =  t.executeQuery(sqlservice);
	  %>
	  
	  <center>
		    <h1> Select Service Type</h1> 
		          <%  int i = 0;
		          while(resservice.next()){
		        	String temp = "service" + i + "";
		        	String num = "number" + i + "";
		        	String sev = resservice.getString(1);%>
		            <br> 
		            <font size = 5> Service Type:  <%= sev %> </font>
		            <input type = "hidden" onkeypress='return event.charCode >= 48 && event.charCode <= 57' name = <%= temp %> value = <%= sev%>>
		            <pre>Quantity:<input type="text"  name= <%= num %>> </pre>
		            <br><br>
		          <% i++;
		          } %>
           </center>
		
	
<%     }
		  catch(Exception e){
		   e.printStackTrace();
	  }
 %>
<br><br>
	<center>
 		<input type = "Submit" name = "submit" value = "submit>">
 	</center>
 
	</form>
</body>

 <style>
 input[name = submit]{
 		height: 50px;
		wxidth: 100px;
		border: none;
    	font-size:24px;
 }

body {
    background-image: url("file:///Users/claireyou/git/CS336final/WebContent/WEB-INF/pic3.png");
    background-size:150% 100%;
}

 </style>
 <a href="LoginRegistration.jsp">Logout</a>
 </html>