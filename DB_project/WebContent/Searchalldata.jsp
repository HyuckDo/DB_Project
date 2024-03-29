<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>조건 검색</title>
</head>
<body>
	<h2>검색 된 차량</h2>
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
	//조건 검색
	String[] data = new String[6];
	String add_data = "";
	
	String sql =  "SELECT DISTINCT VEHICLE.MName, VEHICLE.DMName, VEHICLE.Production_Date, f.Name, VEHICLE.Price, VEHICLE.Vehicle_Number "
					+ "FROM VEHICLE, "
					+ "(SELECT SELL.Vehicle_Number FROM SELL minus SELECT BUY.Vehicle_Number FROM BUY  minus SELECT H.Vehicle_number from HIDEN_LIST H)S, FUEL f, COLOR c, TRANSMISSION tr, CATEGORY ca "
					+ "WHERE VEHICLE.Vehicle_Number = S.Vehicle_Number "
					+ "AND VEHICLE.Fcode = f.Code ";
			

	data[0] = request.getParameter("Brand_Name");
	data[1] = request.getParameter("Model_Name");
	data[2] = request.getParameter("Category");
	data[3] = request.getParameter("Fuel");
	data[4] = request.getParameter("Transmission");
	data[5] = request.getParameter("Color");
	
	
	if(data[0] != "") { // 제조사
		
		add_data +=  "AND VEHICLE.Brand_Name = '" + data[0] + "' "; 
	
	}
	if(data[1] != "") { // 모델
		
		add_data +=  "AND VEHICLE.MName = '" + data[1] + "' "; 
	
	}
	if(data[2] != "") { // 카테고리
	
		add_data +=  "AND VEHICLE.Category = ca.Category AND ca.Category = '" + data[2] + "' "; 
	
	}
	if(data[3] != "") { // 연료
		
		add_data +=  "AND f.Name = '" + data[3] + "' "; 
			
	}
	if(data[4] != "") { // 변속기
	
		add_data +=  "AND VEHICLE.Tcode = tr.Code AND tr.Trasmission_Type = '" + data[4] + "' "; 
	}
	if(data[5] != "") { // 색
	
		add_data +=  "AND VEHICLE.Ccode = c.Code AND c.Name = '" + data[5] + "' "; 
	
	}
	
	sql = sql.concat(add_data);
	
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
	
	if(number == 1){
%>
	<script>
 		alert("차량이 없습니다.");
 		location.href="SearchVehicle.jsp";
 	</script>
<%	
	}
	
	
	
	rs.close();
	pstmt.close();
	conn.close();
	


%>	
	
	
	
	
</body>
</html>