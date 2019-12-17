<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>판매중인 차량</title>
</head>
<body>
	<h2>판매중인 모든 차량</h2>
	<br><hr>
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
	<form action = "detail_vehicle.jsp" method = "POST">
   		
   		Vehicle Number : <input type = "text" name = "Vehicle_Number">
		
	<input type = "submit" value = "세부내용 검색하기"/>

	</form>



<br><br>
<%	
	//판매중인 모든 차량의 정보 출력
	String sql = "SELECT VEHICLE.MName, VEHICLE.DMName, VEHICLE.Production_Date, f.Name, VEHICLE.Price, VEHICLE.Vehicle_Number "
			+ "FROM VEHICLE, "
			+ "(SELECT SELL.Vehicle_Number FROM SELL minus SELECT BUY.Vehicle_Number FROM BUY)S, FUEL f "
			+ "WHERE VEHICLE.Vehicle_Number = S.Vehicle_Number "
			+ "AND VEHICLE.Fcode = f.Code";
	
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	out.println("<table border=\"1\">");

	
	out.println("<th>" + "Number" + "</th>");
	out.println("<th>" + "Model Name" + "</th>");
	out.println("<th>" + "Dtail Name" + "</th>");
	out.println("<th>" + "Production Date" + "</th>");
	out.println("<th>" + "Fuel" + "</th>");
	out.println("<th>" + "Price" + "</th>");
	out.println("<th>" + "Vehicle_Number" + "</th>");
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
		out.println("<td>" + rs.getString(2) + "</td>");
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		Date mgrStartDate = rs.getDate(3);
		String strMSDate = sdfDate.format(mgrStartDate);
		out.println("<td>" + strMSDate + "</td>");
		out.println("<td>" + rs.getString(4) + "</td>");
		out.println("<td>" + rs.getString(5) + "</td>");
		out.println("<td>" + rs.getString(6) + "</td>");
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