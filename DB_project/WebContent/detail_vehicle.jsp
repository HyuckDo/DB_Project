
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>차량 세부 정보</title>
</head>
<body>

<%
	//쿠키 값
	String user_id = request.getHeader("Cookie");
	
	if(user_id != null){
	   Cookie[] cookies = request.getCookies();
	   for(Cookie c:cookies)
	      if(c.getName().equals("ID")){
	         
	    	  user_id = c.getValue();
	      }
	}

%>
	<h2>차량 세부 정보</h2>
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

	<form action = "Buy.jsp" method = "POST">
   	
   	Vehicle Number : <input type = "text" name = "Vehicle_Number">&nbsp;
	<input type = "submit" value = "구매하기"/>

	</form>

	&nbsp;&nbsp;&nbsp;&nbsp;
<%



	String sql = "SELECT VEHICLE.Vehicle_Number, VEHICLE.Mileage, VEHICLE.MName, VEHICLE.DMName, VEHICLE.Brand_Name, VEHICLE.Category, VEHICLE.Price, VEHICLE.Production_Date, "
			+ "c.Name, f.Name, t.Trasmission_Type, VEHICLE.Engine_Displacement "
			+ "FROM VEHICLE, "
			+ "(SELECT SELL.Vehicle_Number FROM SELL minus SELECT BUY.Vehicle_Number FROM BUY)S, "
			+ "COLOR c, FUEL f, TRANSMISSION t "
			+ "WHERE VEHICLE.Vehicle_Number = S.Vehicle_Number "
			+ "AND VEHICLE.Ccode = c.Code AND VEHICLE.Fcode = f.Code AND VEHICLE.Tcode = t.Code "
			+ "AND VEHICLE.Vehicle_Number = '" + request.getParameter("Vehicle_Number") +"'";
			

	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	out.println("<table border=\"1\">");

	out.println("<th>" + "Number" + "</th>");
	out.println("<th>" + "Vehicle Number" + "</th>");
	out.println("<th>" + "Mileage" + "</th>");
	out.println("<th>" + "Model Name" + "</th>");
	out.println("<th>" + "Detail Name" + "</th>");
	out.println("<th>" + "Brand Name" + "</th>");
	out.println("<th>" + "Category" + "</th>");
	out.println("<th>" + "Price" + "</th>");
	out.println("<th>" + "Production Date" + "</th>");
	out.println("<th>" + "Color" + "</th>");
	out.println("<th>" + "Fuel" + "</th>");
	out.println("<th>" + "Trasmission" + "</th>");
	out.println("<th>" + "Engine Displacement" + "</th>");
	
	int number =1;
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + number + "</td>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getString(3) + "</td>");
		out.println("<td>" + rs.getString(4) + "</td>");
		out.println("<td>" + rs.getString(5) + "</td>");
		out.println("<td>" + rs.getString(6) + "</td>");
		out.println("<td>" + rs.getString(7) + "</td>");
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		Date mgrStartDate = rs.getDate(8);
		String strMSDate = sdfDate.format(mgrStartDate);
		out.println("<td>" + strMSDate + "</td>");
		out.println("<td>" + rs.getString(9) + "</td>");
		out.println("<td>" + rs.getString(10) + "</td>");
		out.println("<td>" + rs.getString(11) + "</td>");
		out.println("<td>" + rs.getString(12) + "</td>");
		out.println("</tr>");
			
		number++;

	}
	out.println("</table>");
	
	if(number == 1){
		
%>
	<script>
 		alert("차량이 없습니다. 정확한 차량의 정보를 입력해주세요.");
 		//location.href="main.html";
 		history.go(-1);
 	</script>
<%		
	}
	//옵션 출력
	sql = "SELECT a.Option_Name, m.Option_Classification "
			+ "FROM ADDED_OPTION a, VEHICLE, MAIN_OPTION m, "
			+ "(SELECT SELL.Vehicle_Number FROM SELL minus SELECT BUY.Vehicle_Number FROM BUY)S "
			+ "WHERE VEHICLE.Vehicle_Number = S.Vehicle_Number "
			+ "AND VEHICLE.MName = '" + request.getParameter("Model_Name") +"' "
			+ "AND VEHICLE.Production_Date = '" + request.getParameter("Production_Date") +"' "
			+ "AND VEHICLE.Price = '" + request.getParameter("Price") +"'"
			+ "AND S.Vehicle_Number = a.Vehicle_Number "
			+ "AND a.Option_Name = m.Option_Name";
	
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
%>
<br><br><br><br>
<%	
	out.println("<table border=\"1\">");

	out.println("<th>" + "Option" + "</th>");
	out.println("<tr>");
	
	while(rs.next()){
	
		out.println("<td>" + rs.getString(1) + "( " + rs.getString(2) + ")" + "</td>");
	

	}
	out.println("</tr>");
	out.println("</table>");
	
	rs.close();
	pstmt.close();
	conn.close();
	


%>	
	
	
	
	
</body>
</html>