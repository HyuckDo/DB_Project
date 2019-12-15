<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>유저가 구매한 차량 정보</title>
</head>
<body>
	<h2>구매한 차량</h2>
	<form action = "main.html" method = "POST">
   	
	<input type = "submit" value = "홈으로 가기"/>

	</form>
	
	<form action = "sell_buy_vehicle.jsp" method = "POST">
   	
   	Vehicle_Number : &nbsp; <input type = "text" name = "Vehicle_Number">&nbsp;
	<input type = "submit" value = "세부 정보 보기"/>
     
    </form>
    
    
<%
	
	//lab server
	String serverIP = "155.230.36.61";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "s2011097047";
	String pass = "2011097047";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
	
	Connection conn = null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	PreparedStatement pstmt;
	ResultSet rs;
	
%>

<%
    
 	  	//유저가 구매한 차량 정보
  //String sql = "SELECT COUNT(*) FROM BUY WHERE BUY.AccId = '" + user_ID +"'";
    String sql = "SELECT COUNT(*) FROM BUY WHERE BUY.AccId = '" + "sdlkjlk123" +"'";	
        		
   	pstmt = conn.prepareStatement(sql);
   	rs = pstmt.executeQuery();
    	
    		
   	while(rs.next()) {
		int count = rs.getInt(1);	
		if(count == 0){
				
			out.println("구매한 차량이 없습니다."); 
					
%> 

<br><br><br><br> 


<%
		}
   	}
	

//	sql = "SELECT * FROM BUY WHERE BUY.AccId = '" + user_ID +"'";
	sql = "SELECT * FROM BUY WHERE BUY.AccId = '" + "sdlkjlk123" +"'";
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	out.println("<table border=\"1\">");
		
	out.println("<th>" + "Number" + "</th>");
	out.println("<th>" + "Buy Number" + "</th>");
	out.println("<th>" + "Vehicle Number" + "</th>");
	out.println("<th>" + "Date" + "</th>");
	
	/*
	for(int i=1; i<= cnt; i++){
			
			out.println("<th>" + rsmd.getColumnName(i) + "</th>");
	}
	*/
	
	int number =1;
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + number + "</td>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(3) + "</td>");
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		Date mgrStartDate = rs.getDate(4);
		String strMSDate = sdfDate.format(mgrStartDate);
		out.println("<td>" + strMSDate + "</td>");
		out.println("</tr>");
			
		number++;
	}
	out.println("</table>");
				
		
    		
    		
    		
    		
   	rs.close();
  	pstmt.close();
  	conn.close();

%>	
	
	
	
	
</body>
</html>