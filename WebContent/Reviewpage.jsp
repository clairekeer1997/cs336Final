<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Reservations</title>
</head>
<body>	
	<center>
	<font size = 7 style="text-align:center">Reservation Details</font>
	</center>
	
	<br>
	<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb", "JTSR","336HotelJTSR");
			
			int invoiceNum = 0;
			invoiceNum = Integer.parseInt(request.getParameter("invoiceNum"));
			
			//get room resultset;
			Statement room = con.createStatement();
			String roomsql = "SELECT re.HotelID, re.RoomNo, re.inDate, re.outDate\n" + "FROM Reserves re\n" + "WHERE re.InvoiceNo = \"" + invoiceNum + "\"";
			ResultSet roomres = room.executeQuery(roomsql);
			
			//get breakfast resultset;
			Statement bf = con.createStatement();
			String bfsql = "SELECT DISTINCT bo.HotelID, bo.RoomNo, bo.BreakfastID, bo.bType\n" + "FROM bTypeOrdered bo\n" + "WHERE bo.InvoiceNo = \"" + invoiceNum + "\"";
			ResultSet bfres = bf.executeQuery(bfsql);
			
			//get service resultset;
			Statement sev = con.createStatement();
			String sevsql = "SELECT so.HotelID, so.RoomNo, so.ServiceID, so.sType\n" + "FROM sTypeOrdered so\n" + "WHERE so.InvoiceNo = \"" + invoiceNum + "\"";
			ResultSet sevres = sev.executeQuery(sevsql);
				
			 %>
			 <h1>History of Room Reservation</h1>
			 	<%int i = 0; 
			 	String hotelname1 = "";
			 	while(roomres.next()){	
			 		String hotelid = roomres.getString(1);
			 		String roomid = roomres.getString(2);
			 		String indate = roomres.getString(3);
			 		String outdate = roomres.getString(4);	
			 		
			 		if(i == 0){
						Statement h = con.createStatement();
						String sql = "SELECT Hotel.name FROM Hotel WHERE Hotel.HotelID = " + "'" + hotelid + "'";
						ResultSet s = h.executeQuery(sql);
						if(s.next()){
							hotelname1 = s.getString(1);
						}	
			 		}
			 	%>
				<form action = Commentpage.jsp >
					<font size = 5>
					Hotel: <%=  hotelname1 %> ,
					Room:  <%=  roomid %> ,
					CheckIn Date:  <%= indate %> ,
					CheckOut Date:  <%= outdate %> 
					</font><br>
					<input type = "hidden" name = hotelID1 value = <%=  hotelid %>>					
					<input type = "hidden" name = roomID1 value = <%=  roomid %>>					
					<input type = "hidden" name = inDate value = <%= indate %>>					 
					<input type = "hidden" name = outDate value = <%= outdate %>>
					<input type = "hidden" name = CommentType value = "room">
					<br>
					Rating:<input type = "text" name = rating> (Number from 1 to 10 only)
					<br>
					please write some comment here:				
					<br>
					<textarea name="paragraph_text" cols="50" rows="6"></textarea>
					<br>
					<input type = "Submit" value = "submit">
					<br>
					<br>
				</form>
				<% } %>
				
		     <h1>History of Breakfasts Ordered</h1> 
		     <% int j = 0;
		     String hotelname2 = "";
		     while(bfres.next()){ 
		    	 String hotelid2 = bfres.getString(1);
		    	 String roomid2 = bfres.getString(2);
		    	 String bfid = bfres.getString(3);
		    	 String bftype = bfres.getString(4);
			 		if(j == 0){
						Statement h2 = con.createStatement();
						String sql2 = "SELECT Hotel.name FROM Hotel WHERE Hotel.HotelID = " + "'" + hotelid2 + "'";
						ResultSet s2 = h2.executeQuery(sql2);
						if(s2.next()){
							hotelname2 = s2.getString(1);
						}	
			 		}
		     	%>
		     	<form action = Commentpage.jsp>
		     		<font size = 5>
					Hotel:  <%= hotelname2 %>  ,
					Room:   <%= roomid2 %>  ,
					Breakfast Type:  <%= bftype %>
					</font><br>
					<input type = "hidden" name = hotelID2 value = <%= hotelid2 %>>
					<input type = "hidden" name = roomID2 value = <%= roomid2 %>>
					<input type = "hidden" name = bfID value = <%= bfid %>>
					<input type = "hidden" name = bfType value = <%= bftype %>>
					<input type = "hidden" name = CommentType value = "br">
					<br>
					Rating:<input type = "text" name = rating> (Number from 1 to 10 only)
					<br>
					please write some comment here:				
					<br>
					<textarea name="paragraph_text" cols="50" rows="6"></textarea>
					<br>
					<input type = "Submit" value = "submit">
					<br>
					<br>
				</form>	
			 <% j++; } 
			 if(j == 0){%>
			 	No Breakfast history.
			 <%} %>

		     <h1>History of Services Ordered</h1>  	
		     	 <%	int k = 0;
		     	String hotelname3 = "";
		     	 while(sevres.next()){ 
		     	 String hotelid3 = sevres.getString(1);
		    	 String roomid3 = sevres.getString(2);
		    	 String sevid = sevres.getString(3);
		    	 String sevtype = sevres.getString(4);
		    	 
			 		if(k == 0){
						Statement h3 = con.createStatement();
						String sql3 = "SELECT Hotel.name FROM Hotel WHERE Hotel.HotelID = " + "'" + hotelid3 + "'";
						ResultSet s3 = h3.executeQuery(sql3);
						if(s3.next()){
							hotelname3 = s3.getString(1);
						}	
			 		}
		    	 %>
				<form action = Commentpage.jsp>
					<font size = 5>
					Hotel:  <%= hotelname3 %>  ,
					Room:   <%= roomid3 %>  ,
					Service Type:  <%= sevtype %>
					</font><br>
		
					<input type = "hidden" name = hotelID3 value = <%= hotelid3 %>>
					<input type = "hidden" name = roomID3 value = <%= roomid3 %>>
					<input type = "hidden" name = sevID value = <%= sevid %>>
					<input type = "hidden" name = sevType value = <%= sevtype %>>
					<input type = "hidden" name = CommentType value = "sev">
					<br>
					Rating:<input type = "text" name = rating> (Number from 1 to 10 only)
					<br>
					please write some comment here:				
					<br>
					<textarea name="paragraph_text" cols="50" rows="6"></textarea>
					<br>
					<input type = "Submit" value = "submit">
					<br>
					<br>
				</form>	
				<% k++;
				} 
				if(k == 0){%>	
				No Service History.
				<%} %>
		<%}
		catch(Exception e){
			e.printStackTrace();
		}
	%>

</body>
<style>
body {
    background-image: url("/cs336Final/WebContent/WEB-INF/pic3.png");
    background-size:100% 100%;
}
</style>
</html>